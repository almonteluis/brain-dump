---
tags: [feature-flags, unleash, ab-testing, releases, work]
sources: ["Unleash Release Flag Management.md"]
created: 2026-04-29
updated: 2026-04-29
---

# Unleash Release Flag Management: A/B Test vs LTS

**Source:** Unleash Release Flag Management.md
**Date ingested:** 2026-04-29
**Type:** Work documentation

## Summary

Quick reference for two release patterns using Unleash feature flags: A/B Tests (experimentation) and LTS Releases (permanent features with kill switches).

## Key Claims

### A/B Test Releases

- **Flag starts OFF** — turns feature ON for test groups
- **PO creates flag** using ticket name, with automatic shutoff date
- **Expedited code review + QA**
- **Deploy same-day** if possible — code live but invisible
- **Safety check:** Release Management turns ON briefly to verify no platform breakage
- **Roll out:** Carmen (internal test) → 50% early adopters → full or kill
- **Duration:** 1 week to 3 months max (hard deadline)
- **End state:** Kill it or make it LTS

### LTS Releases (Long-Term Support)

- **Flag starts ON** (feature hidden) — turning OFF shows the feature
- **Flag name:** `LTS-shutoff-<ticket>-<description>`
- **No automatic shutoff** — may stay for months
- **Full code review + full QA** (not expedited)
- **Test both states:** feature ON and OFF
- **Timeline:** Deploy → 1 week (expand) → 1 week (everyone) → ~3 months (delete flag)

### Comparison

| | A/B Test | LTS |
|---|---|---|
| Flag does what? | Turns feature ON | Turns feature OFF |
| Who gets it first? | Small test group | Everyone (hidden for late adopters) |
| Code review | Fast-tracked | Full rigor |
| Duration | 1 week – 3 months | ~3 months, then archive |
| End state | Kill or make LTS | Permanent feature, no flag |

## Concepts Covered

- [[ab-testing]] — Controlled experiment with user groups
- [[lts-release]] — Permanent feature with kill switch
- [[feature-flag-lifecycle]] — Creation → deployment → rollout → cleanup
- [[release-management]] — Coordination between PO, engineers, QA, release team
