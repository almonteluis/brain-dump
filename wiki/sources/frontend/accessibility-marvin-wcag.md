---
description: WCAG 2.1 AA accessibility goals for Marvin including Deque axe-DevTools tooling, CLI linter setup with API key, and SpeechStream third-party library
tags: [source, accessibility, wcag, axe, deque, marvin, work]
sources: ["Accessibility - Marvin.md"]
created: 2026-05-03
updated: 2026-05-03
---

# Accessibility — Marvin (WCAG 2.1 AA)

**Source:** `Accessibility - Marvin.md`
**Date ingested:** 2026-05-03
**Type:** Work documentation

## Summary

Marvin targets **WCAG 2.1 AA** to satisfy federally-funded school requirements and to broaden student access. Work tracked under epic **PP-304**. Tooling is Deque's axe-DevTools (linter, browser extension, paid support). Licensing $1,350/yr per seat with limited pool — Jackie or Steve manage. SpeechStream provides built-in accessibility tools embedded in the frontend.

## Tooling — Deque axe-DevTools

### Licensing

- $1,350/yr per seat, limited pool
- Cover frontend devs + some QA/floating
- 50 hours of paid support budgeted at $220/hr — use it
- License management at [axe.deque.com/user-access](https://axe.deque.com/user-access)
- Some sub-products are free or just need an API key

### Linter (CLI)

API key from [axe.deque.com/settings](https://axe.deque.com/settings) provisioned with `axe DevTools Linter` target.

Config file `marvin/frontend/.axe.yaml`:

```yaml
tags:
  - wcag2a
```

> **Note:** The team should be using `wcag21aa` but it produces no results — sticking with `wcag2a`.

Run:

```bash
axe-linter-connector-linux --api-key "$AXE_API_KEY" --config .axe.yaml \
    -s . -d . --local --url https://axe-linter.deque.com/
```

Output: `axe-linter-report.json` with issues array. Each issue has `engineId`, `ruleId`, `severity`, `type`, `primaryLocation` (filePath + textRange).

Summarize via `jq`:

```bash
jq -r '.issues | .[] | .primaryLocation.message' < axe-linter-report_a.json \
    | sort | uniq -c | sort -n
```

## SpeechStream

Third-party JavaScript library embedded in the frontend providing accessibility tools (screen-reader-style features, presumably text-to-speech for student content).

## Key Claims

- Federal funding requirement drives WCAG compliance — not optional
- `wcag21aa` linter tag does not produce results today — temp workaround uses `wcag2a` (lower bar)
- Deque linter integrates into CI via JSON output + `jq` aggregation for reporting
- Paid support budget exists ($11k/yr) and team should not hesitate to use it

## Entities Mentioned

- [[axe-deque]] — Accessibility tooling vendor (axe DevTools, axe Linter)
- [[wcag-2-1]] — WCAG 2.1 AA standard
- [[speechstream]] — Embedded frontend accessibility library

## Concepts Covered

- [[accessibility]] — Web accessibility patterns
- [[ci-linting]] — Static analysis in pipeline

## Related

- [[accessibility-nc-wcag-deque]] — Existing accessibility ingest (NC-side)
- [[nc-tech-stack-overview]] — Where Marvin sits in stack
