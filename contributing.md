# Contributing

Thank you for helping curate this list. This is a **highly selective** list — the value comes from what is excluded, not just what is included.

## Entry format

Every entry must follow this exact format:

```
- [Name](url) - Description.
```

- Capital first letter in the description.
- Ends with a period.
- Description is objective, ≤ 20 words, and does not repeat the project name.
- No first-person language, no marketing tone.

## Quality bar

An entry earns a spot only if it passes **all** of the following:

- **Distinctive** — not redundant with an existing entry.
- **Verifiable** — link resolves, project is real, description is accurate.
- **Alive** — meaningful activity in the last 12 months, or canonical/foundational enough to be timeless (papers, primary sources).
- **Multi-agent** — has a real coordination or multi-agent dimension. Tools that just "use Claude" without any multi-agent story are out of scope.
- **English description** — entries in other languages are welcome, but the description must be in English.

## What gets rejected

- Tutorials, blog posts, and newsletter issues (unless they are canonical primary sources from Anthropic or a peer-reviewed venue).
- Marketing pages and landing pages with no technical depth.
- Dead or archived repos (no commits in 12+ months and no other signs of life).
- Paid-only resources without explicit disclosure.
- Projects with fewer than 50 GitHub stars, unless genuinely unique and verified active.
- Tools that orchestrate agents in general but have no documented Claude integration.
- Duplicate entries or entries already covered by a linked list in the Related Lists section.
- Entries whose descriptions contain "leverage", "robust", "comprehensive solution", "delve", or equivalent marketing language.

## Companion documents

This repository includes focused companion documents alongside the main README. Each follows the same entry format and quality bar:

- [SECURITY.md](SECURITY.md) — multi-agent attack surface, prompt injection, and trust boundary references.
- [pitfalls.md](pitfalls.md) — honest counter-perspectives and documented failure modes.

PRs that add entries to companion documents go through the same review as README additions.

## How to submit an addition

1. Fork the repository.
2. Add your entry in the correct section, maintaining alphabetical order within that section (except Foundational Reading, which is chronological).
3. Open a pull request with the title `Add [Name]` or `Add [Name] to [Section]`.
4. One entry per PR for significant additions. Small fixes (typos, dead links) can batch multiple changes.
5. Complete the PR checklist in the pull request template.

The maintainer aims to respond within 48 hours.

## How to report a problem

Use the **Remove entry** issue template for dead links, stale projects, or entries that no longer meet the quality bar.

## Code of conduct

See [code-of-conduct.md](code-of-conduct.md).
