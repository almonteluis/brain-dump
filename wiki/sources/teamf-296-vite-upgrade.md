---
description: Vite upgrade from 4.4.5 to 5.4.21 with 55% build performance improvement — ESLint v9 blocked, v6/v7 next
tags: ["TEAMF-296", "vite", "upgrade", "build-performance", "eslint", "security"]
sources: ["TEAMF-296.md"]
created: 2026-04-30
updated: 2026-04-30
---

# TEAMF-296: Update Vite for Frontend

**Source:** TEAMF-296.md
**Date ingested:** 2026-04-30
**Type:** work-ticket
**Ticket:** TEAMF-296
**Project:** Team F - Performance & Scalability

## Summary

Upgraded Vite from 4.4.5 (2023) to 5.4.21 (latest 5.x), achieving 55% build performance improvement. ESLint v9 upgrade blocked by test failures and requires separate ticket. Next steps: upgrade to v6 then v7.

## Results

| Metric | Before | After | Change |
|--------|--------|-------|--------|
| Vite version | 4.4.5 | 5.4.21 | +1 major |
| Build time | 44.60s | 19.92s | **55% faster** |
| Tests | 132 passing | 132 passing | No regressions |
| Vulnerabilities | 28 | 10 | -18 |

## Completed

- Vite 4.4.5 to 5.4.21 upgrade
- All 132 tests passing
- Removed deprecated `splitVendorChunkPlugin`
- Security vulnerability reduction: 28 to 10

## Blocked: ESLint v9

- Test failures (`InvalidCharacterError` in jsdom)
- Rolled back to ESLint v8.57.1
- New ticket needed for ESLint v9 + vitest compatibility investigation
- Estimated effort: 2-4 hours

## Next Steps

1. Create separate ticket for ESLint v9 + vitest compatibility
2. Upgrade Vite from v5 to v6
3. Upgrade Vite from v6 to v7

## Context

- Security-related (moderate-level security alert via Dependabot)
- High priority for Team F - Performance & Scalability
- Sub-task TEAMF-297 created for QA

## Related

- [[vite-7-upgrade-plan]] — Pre-existing upgrade plan for v4 to v7
- [[vite-4-4-1-to-7-x-upgrade-gameplan]] — Detailed gameplan for full v7 upgrade
- [[vite-rollup-tree-shaking-guide]] — Related build optimization work

## Concepts Covered

- [[vite]] — Build tool and dev server
- [[build-performance]] — Measuring and improving build times
- [[security-vulnerabilities]] — Dependency update for security
- [[breaking-changes]] — Handling deprecated APIs across major versions
