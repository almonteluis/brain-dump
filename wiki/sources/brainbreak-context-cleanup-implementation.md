---
description: Step-by-step implementation plan for moving BrainBreak cooldown data from localStorage to database using experimentsSpeculativeData GraphQL infrastructure
tags: [source, brainbreak, localstorage, graphql, cooldown, react, relay, work]
sources: ["BrainBreak Context Cleanup Implementation Plan.md"]
created: 2026-04-30
updated: 2026-04-30
---

# BrainBreak Context Cleanup Implementation Plan

**Source:** `BrainBreak Context Cleanup Implementation Plan.md`
**Date ingested:** 2026-04-30
**Type:** work-doc

## Summary

Detailed 9-task implementation plan for migrating BrainBreak cooldown tracking from browser `localStorage` to persistent database storage via the existing `experimentsSpeculativeData` GraphQL infrastructure. Eliminates cross-device sync issues and localStorage dependencies while preserving same-day prevention and 10-day cooldown logic.

## Key Claims

- `localStorage` is insufficient for cross-device cooldown tracking — a student switching devices bypasses cooldown
- The existing `experimentsSpeculativeData` GraphQL mutation/query infrastructure can be reused for cooldown persistence
- Cooldown logic should live in `businessLogicService/brainBreakCooldown.ts`, not in React components
- `createCooldownData` replaces `saveCooldownData` — returns data instead of writing to storage
- `checkCooldownEligibility` now accepts `CooldownData | undefined` instead of `Storage`

## Implementation Tasks

| Task | File | Description |
|------|------|-------------|
| 1 | `src/contexts/brainBreakContext.tsx` | Update `BrainBreakDataLoader` `onHydrated` callback to accept and extract cooldown data from GraphQL payload |
| 2 | `src/contexts/brainBreakContext.tsx` | Update `BrainBreakProvider` `onHydrated` handler to dispatch cooldown data to reducer |
| 3 | `src/models/BrainBreakConfig.ts` + `src/contexts/brainBreakContext.tsx` | Update `hydrate_from_db` action type and reducer case to include `cooldownData` |
| 4 | `src/businessLogicService/brainBreakCooldown.ts` | Refactor `checkCooldownEligibility` to accept `CooldownData`; replace `saveCooldownData` with `createCooldownData`; remove `COOLDOWN_DATA_KEY` |
| 5 | `src/contexts/brainBreakContext.tsx` | Update imports and usage of cooldown functions (`checkCooldownEligibility`, `createCooldownData`) |
| 6 | `src/models/BrainBreakConfig.ts` + `src/contexts/brainBreakContext.tsx` | Update `mark_as_viewed` action type and reducer case to store cooldown data |
| 7 | `src/contexts/brainBreakContext.tsx` | Add `useMutation` for `recordExperimentSpeculativeData` to persist cooldown data on brain break completion |
| 8 | `src/contexts/brainBreakContext.tsx` | Update inline comments to reflect localStorage → state change |
| 9 | — | Type check, run tests, manual verification |

## Verification Checklist

- [ ] Brain break modal shows when eligible (no cooldown)
- [ ] Same-day prevention works (cannot trigger twice same day)
- [ ] 10-day cooldown works (cannot trigger within 10 days)
- [ ] Completion count increments in DB
- [ ] Cooldown data persists across page refreshes
- [ ] No localStorage calls remain in cooldown logic

## Entities Mentioned

- [[BrainBreak]] — Student-facing survey modal for self-efficacy and emotional state
- [[experimentsSpeculativeData]] — GraphQL table for experiment-related transient data
- [[BrainBreakDataLoader]] — Component that fetches speculative data from DB and hydrates state
- [[BrainBreakProvider]] — React context provider for brain break state management

## Concepts Covered

- [[state-context-reducer-pattern]] — Two-context pattern for React state management
- [[relay]] — GraphQL data fetching with `usePreloadedQuery`, `useQueryLoader`, `useMutation`
- [[cooldown-system]] — Time-based eligibility gating with same-day prevention
- [[localstorage-to-database-migration]] — Moving client-side state to persistent storage
- [[experiment-speculative-data]] — Pattern for storing experiment-related transient data without mutating core tables

## Related

- [[brainbreak-code-cleanup]] — Barrel file removal and reducer naming cleanup
- [[teame-218-brainbreak-postmortem]] — Full post-mortem with 7 refactoring iterations
- [[teame-177-in-platform-polling-cleanup]] — Predecessor ticket (TEAME-177) that this plan replaces
