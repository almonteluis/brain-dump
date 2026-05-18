---
tags:
  - work
  - marvin/frontend/brain-break
  - lts
  - bug/fix
  - root-cause-analysis
  - teame-287
created: 2026-05-05
updated: 2026-05-05
---

# BrainBreak LTS — Cooldown & Speculative Data Bugs

**Date ingested:** 2026-05-05
**Type:** Refined debug write-up / sprint notes

## Summary

Structured write-up of two remaining bugs blocking BrainBreak LTS conversion. Root cause analysis, manual QA results on deer, proposed fixes with code, and next steps checklist.

## Open Tickets

### 1. Cooldown not surfacing modal on day 11

Parser splits ISO timestamp on `-`, maps to `Number`. Day chunk swallows rest of string (`25T10:51:00.000Z`), produces `NaN`. Invalid date → fail open → modal surfaces. QA flagged this.

Plan: revert yesterday's no-op fix, ship Fix A + Fix B together.

### 2. [[teame-287-speculative-data-created-bug]] — Speculative data updates `created` instead of `modified`

On repeat BrainBreak, `created` column bumped instead of `modified`. Quick fix.

### 3. Screenshots for docs

Three screenshots needed while in deer: first question, second question, final cube transition.

## Deploy & PR Status

- Rebased onto `main` via `deploy all`
- Pushed to GitHub
- `fixup!` commit reworded + squashed
- All checks green: frontend, GraphQL, backend
- Frontend deployed to **deer**

## Manual QA on Deer

Test user: `user.id 364`. Walking `lastCompletedDate` backward.

|`lastCompletedDate`|Days ago|Expected|Actual|
|---|---|---|---|
|Apr 29|6|No modal|Baseline|
|Apr 25|10|No modal|No modal ✅ (state looked weird)|
|Apr 26|9|No modal|**Modal appeared 🐛**|

State inconsistency observed: Redux `hasSeenBrainBreak: false`, store `hydrated: true`, but no cooldown data visible on slice. Rehydration path issue beyond parser bug.

> **Follow-up idea:** Skip placement fetch during cooldown. ~10 days wasted compute per student.

## Sam's Questions

**Q1: Time zone for hash location?**
Assigned placements hash (`userId + date`) likely reads machine time, not unified. BrainBreak context uses `user.activeTimezone` from `user.ts` — that's fine.

**Q2: Screenshot for docs?**
Capturing while in deer for ticket 1.

## Root Cause Analysis

### Data flow

1. User completes BrainBreak
2. `brainBreakRecorder.ts:199` → `lastCompleted = new Date().toISOString()` → persisted via GraphQL mutation
3. Next login: `BrainBreakContext` hydrates → extracts cooldown data → checks eligibility

### Bug A: Broken day parser

**Location:** `src/business-logic/service/brain-break/cooldown.ts:29`

```ts
const [year, month, date] = data.lastCompletedDate.split('-').map(Number)
const lastCompletion = new Date(year, month - 1, date)
```

Assumes `YYYY-MM-DD`, recorder writes full ISO string.

**Trace with `'2026-04-25T10:51:00.000Z'`)**:

```
.split('-')             → ['2026', '04', '25T10:51:00.000Z']
.map(Number)            → [2026, 4, NaN]
new Date(2026, 3, NaN)  → Invalid Date
```

Invalid date → fail open → modal surfaces.

### Bug B: Time-of-day boundary vs calendar-day

Recorder writes full timestamp. User completing at 3pm not eligible until after 3pm ten days later. Should be calendar-day arithmetic.

## Proposed Fixes

### Fix A: Robust ISO parsing

```ts
const lastCompletedRaw = new Date(data.lastCompletedDate)
if (isNaN(lastCompletedRaw.getTime())) return true // fail open on bad data

const lastCompletion = new Date(
  lastCompletedRaw.getFullYear(),
  lastCompletedRaw.getMonth(),
  lastCompletedRaw.getDate(),
)
```

### Fix B: Calendar-day arithmetic

Normalize "now" to midnight, then diff. Calendar-day base.

**Decision:** Ship both in same commit. Tightly coupled — Fix A alone leaves off-by-hours edge.

## Next Steps

- [x] Revert yesterday's no-op fix
- [x] Implement Fix A + Fix B in `cooldown.ts`
- [x] Unit test: full ISO string into parser
- [x] Unit test: 3pm → next-day-3pm boundary
- [x] Investigate rehydration weirdness (separate from parser)
- [x] Knock out [[teame-287-speculative-data-created-bug]]
- [x] Capture three screenshots, send to Sam
- [x] Reply to Sam: flag machine-time suspicion on hash location

## Entities Mentioned

- [[Sam]] — asked about timezone and screenshots
- [[Maya]] — merged GraphQL changes

## Concepts Covered

- [[cooldown-system]] — parser bug, calendar-day arithmetic
- [[experiment-speculative-data]] — TEAME-287 `created`/`modified` bug
- [[graphql-mutations]] — brain break completion persistence
- [[redux-rehydration]] — state inconsistency on deer

## Related

- [[remaining-brain-break-tickets]] — Earlier voice memo covering same debug session
- [[qa-fe-automation-local-workflow]] — Workflow used for manual QA
- [[teame-268-brain-brake-retry-cooldown]] — Related cooldown ticket
- [[teame-287-speculative-data-created-bug]] — TEAME-287 details
