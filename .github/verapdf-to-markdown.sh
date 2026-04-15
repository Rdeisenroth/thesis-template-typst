#!/usr/bin/env bash

set -uo pipefail

search_dir="${1:-.}"

format_int() {
    local value="${1:-0}"
    echo "$value" | rev | sed -E 's/(.{3})/\1,/g' | rev | sed 's/^,//'
}

format_size() {
    local bytes="${1:-0}"
    if command -v numfmt >/dev/null 2>&1; then
        numfmt --to=iec-i --suffix=B "$bytes"
    else
        echo "${bytes} B"
    fi
}

extract_failed_rules_markdown() {
    local json_file="$1"
    jq -r '
        [
            ..
            | objects
            | select(.status? == "failed")
            | select(.description? or .message? or .clause? or .specification?)
            | "- "
                + ((.specification // "Unknown specification")
                + (if .clause? then ", clause " + .clause else "" end)
                + (if .testNumber? then ", test " + (.testNumber | tostring) else "" end))
                + "\n  " + (.description // .message // "No description provided.")
                + (if .test? then "\n  Test: `" + .test + "`" else "" end)
        ]
        | unique
        | .[]
    ' "$json_file"
}

mapfile -d '' pdf_files < <(find "$search_dir" -maxdepth 1 -type f -name "*.pdf" -print0 | sort -z)

echo "# PDF/A Compliance Report"

if ((${#pdf_files[@]} == 0)); then
    echo "No PDF files found in the output directory."
    exit 0
fi

tmp_dir="$(mktemp -d)"
trap 'rm -rf "$tmp_dir"' EXIT

total_files=0
non_compliant_files=0
total_checks=0
failed_checks=0

overview_rows=""
detail_sections=""

for pdf_file in "${pdf_files[@]}"; do
    base_name="$(basename "$pdf_file")"
    json_file="$tmp_dir/${base_name}.pdfa-2b-compliance.json"
    text_file="$tmp_dir/${base_name}.pdfa-2b.txt"

    verapdf --format json --maxfailuresdisplayed 50 -f 2b "$pdf_file" >"$json_file" 2>/dev/null || true

    f_size="$(jq -r '.report.jobs[0].itemDetails.size // .report.jobs[0].item.size // 0' "$json_file")"
    f_passed_rules="$(jq -r '.report.jobs[0].validationResult[0].details.passedRules // 0' "$json_file")"
    f_failed_rules="$(jq -r '.report.jobs[0].validationResult[0].details.failedRules // 0' "$json_file")"
    f_passed_checks="$(jq -r '.report.jobs[0].validationResult[0].details.passedChecks // 0' "$json_file")"
    f_failed_checks="$(jq -r '.report.jobs[0].validationResult[0].details.failedChecks // 0' "$json_file")"
    f_statement="$(jq -r '.report.jobs[0].validationResult[0].statement // "No statement provided."' "$json_file")"
    f_compliant="$(jq -r '.report.jobs[0].validationResult[0].compliant // false' "$json_file")"

    status_label="PASS"
    if [[ "$f_compliant" != "true" ]]; then
        status_label="FAIL"
    fi

    total_files=$((total_files + 1))
    total_checks=$((total_checks + f_passed_checks + f_failed_checks))
    failed_checks=$((failed_checks + f_failed_checks))
    if [[ "$f_compliant" != "true" ]]; then
        non_compliant_files=$((non_compliant_files + 1))
    fi

    overview_rows+="| ${base_name} | ${status_label} | $(format_size "$f_size") | $(format_int "$f_failed_rules") | $(format_int "$f_failed_checks") | $(format_int "$f_passed_checks") |\n"

    detail_sections+="<details>\n"
    detail_sections+="<summary><strong>${base_name}</strong> (${status_label})</summary>\n\n"
    detail_sections+="${f_statement}\n\n"
    detail_sections+="| Metric | Value |\n"
    detail_sections+="| --- | --- |\n"
    detail_sections+="| File size | $(format_size "$f_size") |\n"
    detail_sections+="| Passed rules | $(format_int "$f_passed_rules") |\n"
    detail_sections+="| Failed rules | $(format_int "$f_failed_rules") |\n"
    detail_sections+="| Passed checks | $(format_int "$f_passed_checks") |\n"
    detail_sections+="| Failed checks | $(format_int "$f_failed_checks") |\n\n"

    if [[ "$f_compliant" != "true" ]]; then
        verapdf --format text --maxfailuresdisplayed 25 -f 2b "$pdf_file" >"$text_file" 2>/dev/null || true
        failed_rules_md="$(extract_failed_rules_markdown "$json_file")"
        if [[ -n "$failed_rules_md" ]]; then
            detail_sections+="Failed rule details:\n\n"
            detail_sections+="${failed_rules_md}\n\n"
        fi

        detail_sections+="Raw veraPDF output:\n\n"
        detail_sections+="\`\`\`text\n"
        detail_sections+="$(cat "$text_file")\n"
        detail_sections+="\`\`\`\n\n"
        detail_sections+="Reference:\n"
        detail_sections+="- https://docs.verapdf.org/cli/validation\n"
        detail_sections+="- https://github.com/veraPDF/veraPDF-validation-profiles\n\n"
    fi

    detail_sections+="</details>\n\n"
done

compliance_rate=$(( (total_files - non_compliant_files) * 100 / total_files ))

echo "## At a Glance"
echo "| Metric | Value |"
echo "| --- | --- |"
echo "| Status | $([[ $non_compliant_files -gt 0 ]] && echo "FAIL" || echo "PASS") |"
echo "| Files checked | $(format_int "$total_files") |"
echo "| Non-compliant files | $(format_int "$non_compliant_files") |"
echo "| Failed checks | $(format_int "$failed_checks") |"
echo "| Total checks | $(format_int "$total_checks") |"
echo "| Compliance rate | ${compliance_rate}% |"
echo

echo "## File Overview"
echo "| File | Status | Size | Failed Rules | Failed Checks | Passed Checks |"
echo "| --- | --- | ---: | ---: | ---: | ---: |"
printf "%b" "$overview_rows"
echo

echo "## File Details"
printf "%b" "$detail_sections"

if ((non_compliant_files > 0)); then
    exit 1
fi
