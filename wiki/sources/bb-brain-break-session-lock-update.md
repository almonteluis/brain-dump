---
description: Updated implementation notes for brain break cross-browser session lock — client-side hardening with preflight rejection, ownership verification, and shorter heartbeat
tags: ["brain-break", "session-lock", "TOCTOU", "react", "cross-browser", "useBrainBreakSessionLock"]
sources: ["BB being open in 2 sessions via different browser.md"]
created: 2026-04-30
updated: 2026-04-30
---

# BB Brain Break Session Lock — Implementation Update

**Source:** `BB being open in 2 sessions via different browser.md`
**Date ingested:** 2026-04-30
**Type:** implementation-note

## Summary

Follow-up notes on the brain break cross-browser session lock implementation. QA discovered the brain break modal could be submitted on the same day via 2 different browser tabs. This document captures the client-side hardening applied and remaining caveats.

## The Problem

- Brain break modal open and could be submitted same day via 2 different browser tabs
- QA reproduction used 2 separate browsers
- Chromebook users are mostly within Chrome browser, so same-browser `localStorage` approach would cover many cases
- Full cross-browser, cross-device support requires network round-trips that are too slow

## Implementation Changes

### Client-Side Hardening in `useBrainBreakSessionLock.ts`

1. **Unified acquisition/renewal path:** Fresh server read, upsert, then ownership verification before treating lock as ours
2. **Safe visibility restore:** No longer does blind fire-and-forget upsert
3. **Shorter heartbeat:** Renews every 30s instead of every 60s (may need to drop to 10s or 5s)

### Test Coverage Added

`useBrainBreakSessionLock.test.tsx` now covers:
- Preflight rejection
- Post-write ownership verification
- Safe visibility re-entry
- Shorter heartbeat cadence

## Verification

- `npm test -- --run src/custom-hooks/useBrainBreakSessionLock.test.tsx` passed
- Targeted `eslint` passed on touched files
- Full `npx tsx --noEmit` still failing on pre-existing unrelated error in `IndividualReportAssessmentPlayer.tsx`

## Important Caveat

This meaningfully tightens the [[cross-browser TOCTOU window]] and fixes visibility/heartbeat issues, but a blind upsert still cannot give a true mutual-exclusion guarantee. Full elimination of the race condition still needs backend CAS (compare-and-swap) support. The same-browser `localStorage` race remains best-effort only.

## Related

- [[bb-cross-browser-session-lock]] — Main TEAME-218 implementation documentation
- [[cross-browser-toctou-window]] — TOCTOU window analysis
- [[teame-218-brainbreak-postmortem]] — Post-mortem analysis

## Concepts Covered

- [[toctou]] — Time-of-check to time-of-use race condition
- [[distributed-locking]] — Client-side mutual exclusion patterns
- [[react-hooks]] — useRef patterns for avoiding stale closures in async operations
