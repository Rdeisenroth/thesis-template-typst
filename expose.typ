#import "common/preamble-expose.typ": *

#show: doc => init(
  doc,
  darkmode: false,
  tudaexercise_options: (
    show-title: true,
  ),
)

// Expose template (max ~3 pages, one-column report style)
// Notes:
// - This file is intentionally comment-heavy so you can fill it step by step.
// - Keep the final exposé concise and convincing.
// - TODO(final): Verify total length is around 2-3 pages (absolute max: 3 pages).
// - TODO(final): Remove guidance comments that should not appear in your submitted version.

= Introduction
// Goal: Motivate your topic, provide background, and explain relevance.
// TODO(final): The introduction should quickly answer:
// 1) What is the topic/problem?
// 2) Why does it matter now?
// 3) What gap/opportunity are you addressing?
// Suggested target length: ~0.5-0.75 pages.

// Problem statement:
// - Describe the concrete problem domain in 3-5 sentences.
// - Name the central challenge your thesis addresses.

// Motivation and importance:
// - Explain practical or scientific impact.
// - Mention who benefits (research community, industry, users, etc.).
// - If possible, include one concrete motivating example.

// Context and background:
// - Define the key terms needed to understand the problem.
// - Briefly summarize current state/practice.
// - Avoid too much depth here; deep comparison belongs in related work.

// Optional mini-preview:
// - 1-2 sentences on your intended thesis direction.

[Write your introduction text here.]

= (Background &) Related Work
// Goal: Keep this short, but show early literature understanding.
// Hard requirement from your outline:
// - 5-6 papers as a starting point (excluding starter papers).
// TODO(final): Ensure your references include at least 5-6 non-starter papers.
// Suggested target length: ~0.5-0.75 pages.

// Reading strategy comments:
// - Prioritize very recent and most-cited foundational work.
// - Include both methods close to your idea and strong baselines.
// - Track each paper with: problem, method, assumptions, limitations.

// Relation-to-your-work comments:
// For each key paper (or grouped cluster), answer briefly:
// - What does this work solve well?
// - Where does it fall short for your thesis context?
// - How does your planned work differ (scope, method, data, evaluation, etc.)?

// Suggested writing pattern:
// - 1 short paragraph summarizing the field landscape.
// - 1 compact comparison paragraph/table-style prose.
// - 2-3 sentences explicitly positioning your thesis.

// Dummy citation example (replace with real sources while drafting): @typstAbout.

[Write your related work summary here.]

= 6 Weeks Milestone
// This is the most important section.
// Prompt: "What will I achieve until my mid-term presentation?"
// Goal: Define an MVP with clear, finished outcomes in first 6 weeks.
// Suggested target length: ~0.75-1.0 pages.

// Must-have qualities:
// - Very clear deliverables (what is done vs not done).
// - Realistic timeline (convincing but feasible).
// - Setup/read/implement all essentials needed for thesis success.

// Why this section matters (from your outline):
// - If things work: you already have solid groundwork and thesis risk is low.
// - If things fail: you still have enough time to pivot or rethink approach.

// TODO(final): Make milestone measurable using concrete outputs, e.g.:
// - code prototype running
// - dataset/pipeline prepared
// - baseline implemented
// - first evaluation results
// - documented risks and fallback option

== Week-by-week plan (first 6 weeks)
// Fill each week with concrete actions + expected outputs.
// Keep each bullet outcome-oriented (use done-criteria).

- Week 1: [topic familiarization, scope lock, detailed reading list]
- Week 2: [environment/setup, data access, tooling, reproducibility basics]
- Week 3: [baseline implementation or replication]
- Week 4: [first custom method/prototype iteration]
- Week 5: [initial experiments/evaluation + error analysis]
- Week 6: [MVP consolidation + mid-term presentation material]

== MVP definition (end of week 6)
// Define EXACT acceptance criteria for your mid-term milestone.
// Example structure:
// - Artifact: [what exists?]
// - Evidence: [what result proves progress?]
// - Documentation: [what is written and reproducible?]

- Artifact: [to be filled]
- Evidence: [to be filled]
- Documentation: [to be filled]

== Risks and fallback in first 6 weeks
// Add 2-4 key risks and one fallback strategy each.
// This demonstrates realism and planning maturity.

- Risk 1: [to be filled] -> Fallback: [to be filled]
- Risk 2: [to be filled] -> Fallback: [to be filled]

[Write your milestone narrative here.]

= Outlook
// Prompt: "What do you want to achieve after the milestone?"
// Goal: Describe post-milestone work, scope boundaries, and priorities.
// This should be less detailed than the 6-week milestone section.
// Suggested target length: ~0.4-0.6 pages.

// In-scope / out-of-scope comments:
// - In-scope: What you plan to complete before thesis submission.
// - Out-of-scope: What you explicitly do NOT promise.

// Further work comments:
// - List major follow-up tasks in priority order.
// - Mention what depends on milestone outcomes.
// - Keep this strategic; avoid week-level micro-planning.

== Planned work after milestone
- [Main objective 1]
- [Main objective 2]
- [Main objective 3]

== Scope boundaries
- In scope: [to be filled]
- Out of scope: [to be filled]

[Write your outlook text here.]

= Final Checklist (for draft polishing)
// Keep this list while drafting; remove or convert before final submission.

- TODO: Verify total length is around 2-3 pages (and never over 3 pages).
- TODO: Ensure one-column formatting remains unchanged in this template.
- TODO: Confirm 5-6 related-work papers are included (excluding starter papers).
- TODO: Check every section has a clear purpose and no placeholder text left.
- TODO: Ensure the 6-week milestone has measurable deliverables and acceptance criteria.
- TODO: Ensure the outlook is clearly lower detail than the milestone section.
- TODO: Run one final pass for clarity, grammar, and consistent terminology.

#bibliography("common/refs.bib")
