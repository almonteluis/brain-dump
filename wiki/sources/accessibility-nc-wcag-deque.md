---
tags: [accessibility, wcag, deque, axe, work]
sources: ["Accessibility.md"]
created: 2026-04-29
updated: 2026-04-29
---

# Accessibility at New Classrooms

**Source:** Accessibility.md
**Date ingested:** 2026-04-29
**Type:** Work documentation

## Summary

WCAG 2.1 AA accessibility requirements for federally-funded schools. Covers Deque axe tooling, licensing, and CLI linter setup.

## Key Claims

- **Target:** WCAG 2.1 AA level for all federally-funded school contracts
- **Work tracked:** [PP-304](https://newclassrooms.atlassian.net/browse/PP-304)
- **Approach:** Gradual remediation of issues identified by Deque tooling

### Deque Tools

- **Licensing:** $1,350/yr per license. Contact Jackie or Steve
- **Paid support:** 50 hours budgeted at $220/hr
- **License management:** [axe.deque.com/user-access](https://axe.deque.com/user-access)

### axe DevTools Linter (CLI)

- API key from [axe.deque.com/settings](https://axe.deque.com/settings)
- Download: [axe DevTools Linter Connector](https://docs.deque.com/linter/4.0.0/en/downloads#axe-devtools-linter-connector)
- Config file `.axe.yaml`:
  ```yaml
  tags:
    - wcag2a
  ```
- Note: `wcag21aa` tag produces no results (should be target)
- Run:
  ```bash
  axe-linter-connector-linux --api-key "$AXE_API_KEY" --config .axe.yaml \
    -s . -d . --local --url https://axe-linter.deque.com/
  ```
- Output: `axe-linter-report.json` with issues array

## Entities Mentioned

- [[deque|Deque]] — Accessibility testing tools vendor
- [[jackie|Jackie]] — License contact
- [[steve|Steve]] — License contact

## Concepts Covered

- [[wcag-2-1-aa]] — Web Content Accessibility Guidelines level AA
- [[axe-linter]] — Command-line accessibility scanning
- [[accessibility-remediation]] — Gradual issue fixing approach
