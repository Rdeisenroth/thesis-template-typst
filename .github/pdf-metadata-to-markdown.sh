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

metadata_field() {
    local field="$1"
    local info_file="$2"
    awk -F': ' -v key="$field" '$1 == key {sub(/^ +/, "", $2); print $2}' "$info_file" | head -n 1
}

mapfile -d '' pdf_files < <(find "$search_dir" -maxdepth 1 -type f -name "*.pdf" -print0 | sort -z)

echo "# PDF Build Report"

if ((${#pdf_files[@]} == 0)); then
    echo "No PDF files found in the output directory."
    exit 0
fi

if ! command -v pdfinfo >/dev/null 2>&1; then
    echo "Could not collect metadata because 'pdfinfo' is not available."
    echo "Install poppler-utils in the build job to enable this report."
    exit 0
fi

tmp_dir="$(mktemp -d)"
trap 'rm -rf "$tmp_dir"' EXIT

total_files=0
total_pages=0
total_size=0
with_author=0
encrypted_files=0

overview_rows=""
detail_sections=""

for pdf_file in "${pdf_files[@]}"; do
    base_name="$(basename "$pdf_file")"
    info_file="$tmp_dir/${base_name}.pdfinfo.txt"

    if ! pdfinfo "$pdf_file" >"$info_file" 2>/dev/null; then
        continue
    fi

    pages="$(metadata_field "Pages" "$info_file")"
    author="$(metadata_field "Author" "$info_file")"
    creator="$(metadata_field "Creator" "$info_file")"
    producer="$(metadata_field "Producer" "$info_file")"
    pdf_version="$(metadata_field "PDF version" "$info_file")"
    page_size="$(metadata_field "Page size" "$info_file")"
    tagged="$(metadata_field "Tagged" "$info_file")"
    encrypted="$(metadata_field "Encrypted" "$info_file")"
    file_size_raw="$(stat -c%s "$pdf_file")"

    pages="${pages:-0}"
    author="${author:-n/a}"
    creator="${creator:-n/a}"
    producer="${producer:-n/a}"
    pdf_version="${pdf_version:-n/a}"
    page_size="${page_size:-n/a}"
    tagged="${tagged:-n/a}"
    encrypted="${encrypted:-n/a}"

    total_files=$((total_files + 1))
    total_pages=$((total_pages + pages))
    total_size=$((total_size + file_size_raw))

    if [[ -n "$author" && "$author" != "n/a" && "$author" != "" ]]; then
        with_author=$((with_author + 1))
    fi
    if [[ "$encrypted" == "yes" || "$encrypted" == "Yes" ]]; then
        encrypted_files=$((encrypted_files + 1))
    fi

    overview_rows+="| ${base_name} | $(format_int "$pages") | $(format_size "$file_size_raw") | ${author} | ${pdf_version} |\n"

    detail_sections+="<details>\n"
    detail_sections+="<summary><strong>${base_name}</strong></summary>\n\n"
    detail_sections+="| Metadata | Value |\n"
    detail_sections+="| --- | --- |\n"
    detail_sections+="| Pages | $(format_int "$pages") |\n"
    detail_sections+="| File size | $(format_size "$file_size_raw") |\n"
    detail_sections+="| Author | ${author} |\n"
    detail_sections+="| Creator | ${creator} |\n"
    detail_sections+="| Producer | ${producer} |\n"
    detail_sections+="| PDF version | ${pdf_version} |\n"
    detail_sections+="| Page size | ${page_size} |\n"
    detail_sections+="| Tagged | ${tagged} |\n"
    detail_sections+="| Encrypted | ${encrypted} |\n\n"
    detail_sections+="</details>\n\n"
done

if ((total_files == 0)); then
    echo "No readable PDF files found in the output directory."
    exit 0
fi

avg_pages=$((total_pages / total_files))

echo "## At a Glance"
echo "| Metric | Value |"
echo "| --- | --- |"
echo "| Files built | $(format_int "$total_files") |"
echo "| Total pages | $(format_int "$total_pages") |"
echo "| Average pages per file | $(format_int "$avg_pages") |"
echo "| Total output size | $(format_size "$total_size") |"
echo "| Files with author metadata | $(format_int "$with_author") / $(format_int "$total_files") |"
echo "| Encrypted files | $(format_int "$encrypted_files") |"
echo

echo "## File Overview"
echo "| File | Pages | Size | Author | PDF Version |"
echo "| --- | ---: | ---: | --- | --- |"
printf "%b" "$overview_rows"
echo

echo "## File Details"
printf "%b" "$detail_sections"
