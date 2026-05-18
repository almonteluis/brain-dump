---
tags:
  - work
  - marvin/frontend/brain-break
  - bug/fix
  - root-cause-analysis
sources:
  - remaining brain break tickets.md
created: 2026-05-04
updated: 2026-05-04
---
# Remaining Brain Break Tickets — Debug Session

**Source:** remaining brain break tickets.md
**Date ingested:** 2026-05-05
**Type:** Work notes / debug session

## Summary

Voice memo capturing debugging session for two remaining Brain Break tickets. Includes live testing on dev environment (`deer`), database manipulation, root cause analysis, and proposed fixes. Also answers from Sam about time zone handling and screenshots.

## Key Claims

- Two tickets remain: (1) cooldown period on day 11 not serving as brain-break modal, (2) TEAME-287 speculative data `created` column being updated instead of `modified` on repeat brain break experiences.
- Deployed frontend to `deer` environment, tested with user ID 364, manipulated `last_completed` dates in database.
- **Bug A (critical):** `parseDate` function in `brain-break-cooldown.ts:29` splits on `-` only, but recorder saves full ISO timestamp (`2026-04-25T10:51:00.000Z`). Split produces `[2026, 04, 25T10]` — invalid date parsing.
- **Bug B (logic):** Off-by-one in cooldown eligibility calculation.
- **Bug C (time-of-day):** `parseDate` strips to midnight local time, so a user completing at 3pm won't be eligible until after 3pm 10 days later. Should be calendar-day-based.
- Placement assignments happen during cooldown period — wasted compute. Should guard placement generation while in cooldown.
- Time zone for assigned placements: uses user's `ActiveTimeZone` from `user.ts` — machine-local, not unified UTC.

## Proposed Fixes

1. **Robust date parsing:** Use `new Date(data.lastCompletedDate)` directly, normalize to midnight for day counting.
2. **Calendar-day-based cooldown:** Not time-of-day based.
3. **Guard placement generation:** Skip assignment during cooldown period.

## Entities Mentioned

- [[Maria]] — QA, asked about reverse score questions
- [[Sam]] — asked about time zone and screenshots
- [[Maya]] — merged GraphQL + hot chocolate changes

## Concepts Covered

- [[cooldown-system]] — cooldown logic, date parsing, eligibility
- [[speculative-data]] — active modal role `created` vs `modified` column bug
- [[graphql-mutations]] — brain break completion stored via mutation
- [[database-testing]] — manipulating test user data in dev environment

## Related Work

- [[brainbreak-lts-cooldown-speculative-bugs]] — Refined write-up of same debug session with fixes and QA table
- [[teame-287-speculative-data-created-bug]] — TEAME-287 speculative data bug
- [[teame-268-brain-brake-retry-cooldown]] — related cooldown ticket
- [[teame-277-brain-break-two-minute-trigger]] — related brain break ticket
- [[qa-fe-automation-local-workflow]] — workflow used during this debug session
- [[BB being open in 2 sessions via different browser]]