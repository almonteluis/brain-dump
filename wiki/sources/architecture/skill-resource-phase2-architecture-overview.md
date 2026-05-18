---
description: Plan to split 709 LOC SkillResource god component into Container + View + 3 hooks
tags:
  - refactor
  - react
  - skill/resource
  - phase-2
  - architecture
  - wiki
sources:
  - 2026-05-01-SkillResource-Phase2-Architecture-Overview.md
created: 2026-05-01
updated: 2026-05-01
---

# SkillResource Phase 2 — Architecture Overview

**Source:** 2026-05-01-SkillResource-Phase2-Architecture-Overview.md
**Date ingested:** 2026-05-01
**Type:** Refactor plan
**Source file:** `frontend/src/components/SkillResource/SkillResource.tsx`

## Summary

SkillResource.tsx is a 709 LOC god component that mixes data fetching, experiment logging, timeline navigation, and rendering. Phase 2 splits it into a Container + View pair plus three focused hooks: `useSkillResourceQueries`, `useSkillTimeline`, and `useSkillModals`. Bug ratio target drops from 47% (21/45 commits) to <15% over six months. Migration is sequenced low-risk → high-risk: Modals → Timeline → Queries → telemetry → container/view split → optional context provider.

## Current State

- 709 LOC in one file. Mixes everything.
- GraphQL fetch tangle: `useLazyLoadQuery` for support skills + assignments, `usePreloadedQuery` for presigned URLs wrapped in try/catch Suspense rethrow (lines 170-219).
- Presigned URL Suspense-throw hack swallows real errors (lines 206-219).
- Timeline/step orchestration + `useQualifyPlacement` placement gates scattered (lines 113-128).
- Skill challenge bootstrap effect loads previous session on mount (lines 223-240).
- Modal/UI flags: `expanded`, `disabledReviewModal`, `learnosityPPKey`, `weeklyGoalOverrideData` mixed with data state (lines 106-110).
- Experiment soup: TEAME-177 brain break, TEAME-183 skill 213 logging, TEAME-223 future self, PP-435 weekly goal, skill-resource-access variant (lines 31-53, 97-111, 295-422).
- Observation logging effects: skill_access, pass_fail x3 flags, minutes-to-pass, future-self score (lines 307-597). 290 LOC of telemetry.
- Variant resolution split: sync via Redux effect + async via `<SkillVariantFetcher>` Suspense fallback (lines 295-305, 622-631).
- Render block mixes header, sidebar timeline, 4 step branches, Suspense boundary, presigned URL error fallback (lines 602-707).
- 18 props on component. Heavy prop-drill from parent.

## Target Architecture

```
SkillResource/
├── SkillResource.tsx                  (barrel export, 5 LOC)
├── SkillResourceContainer.tsx         (~120 LOC: wires hooks, owns state, no JSX layout)
├── SkillResourceView.tsx              (~150 LOC: pure layout + step switch, props in/out)
└── hooks/
    ├── useSkillResourceQueries.ts     (~80 LOC: support skills, assignments, presigned URLs, lrn session)
    ├── useSkillTimeline.ts            (~60 LOC: step gates, qualify placements, skill challenge bootstrap)
    └── useSkillModals.ts              (~50 LOC: expanded, disabledReviewModal, learnosityPPKey, weekly goal override)
```

```
           ┌──────────────────────────┐
           │  SkillResourceContainer  │
           │  ─ owns variant + flags  │
           │  ─ composes 3 hooks      │
           └──────────┬───────────────┘
                      │
        ┌─────────────┼──────────────┬──────────────────┐
        ▼             ▼              ▼                  ▼
 ┌────────────┐ ┌──────────┐  ┌────────────┐    ┌───────────────┐
 │ useSkill   │ │ useSkill │  │ useSkill   │    │ experiments/  │
 │ Resource   │ │ Timeline │  │ Modals     │    │ telemetry     │
 │ Queries    │ │          │  │            │    │ (own hooks)   │
 └────────────┘ └──────────┘  └────────────┘    └───────────────┘
                      │
                      ▼
           ┌──────────────────────────┐
           │   SkillResourceView      │
           │  ─ pure presentational   │
           │  ─ Header + Timeline +   │
           │    step switch           │
           └──────────────────────────┘
```

## Migration Order

1. Extract `useSkillModals.ts`. Pure UI state. Zero blast radius. Land first.
2. Extract `useSkillTimeline.ts`. Move qualify-placement calls + skill challenge bootstrap effect. Behavior-preserving.
3. Extract `useSkillResourceQueries.ts`. Move 3 GraphQL hooks + presigned URL Suspense-rethrow. Add proper error boundary.
4. Split telemetry into `useSkillResourceObservations.ts` (still inside container, separate file). Cleans 290 LOC of effects.
5. Split container/view. Move JSX to `SkillResourceView.tsx`. Container shrinks to wiring.
6. Replace 18 prop-drill with context provider for `studentStateInfo`/`previousAttempts` shared state (optional, post-Phase 2).

## Risk Map

| Concern              | Current LOC | Target LOC | Blast radius                          | Risk   |
| -------------------- | ----------- | ---------- | ------------------------------------- | ------ |
| Modal/UI state       | ~25         | ~50        | Local. Header + timeline only.        | Low    |
| Timeline gates       | ~40         | ~60        | Brain break + practice problem entry. | Low    |
| GraphQL queries      | ~80         | ~80        | Suspense boundary. Presigned URL hack.| Medium |
| Observation logging  | ~290        | ~150       | Experiment metrics. Silent breakage.  | High   |
| Variant resolution   | ~30         | ~40        | Redux-vs-Suspense fallback split.     | Medium |
| Render layout split  | ~110        | ~150       | All step branches.                    | Medium |

## Success Criteria

- SkillResource.tsx drops 709 → <10 LOC (barrel only).
- Container <150 LOC. View <200 LOC. No hook >100 LOC.
- Cyclomatic complexity per file <10.
- Test coverage on extracted hooks ≥80%. Container ≥60%.
- Bug commit ratio (bugs/total) drops 21/45 = 47% → <15% over next 6 months.
- Zero net behavior change. All experiment observations still fire with same payload.
- Presigned URL error path returns proper Error boundary instead of try/catch swallow.
- Prop count on container drops 18 → <8 (rest via context).

## Key Claims

- God components inflate bug rate. Splitting by concern (data/orchestration/UI) cuts bug ratio.
- Three-hook split keeps each unit testable in isolation under `RelayEnvironmentProvider` with mock environment.
- Migration is safer when sequenced from low-blast (modals) to high-blast (telemetry).
- Presigned URL Suspense rethrow swallows errors — `<ErrorBoundary>` recovery is the proper fix.

## Concepts Covered

- [[react-useeffect-patterns]] — eliminating effects for derived state
- [[state-context-reducer-pattern]] — discriminated union state
- [[rules-of-hooks]] — top-level unconditional hook calls
- [[fragment-composition]] — Relay data colocation
- [[graphql-over-fetching]] — query consolidation
- [[experiment-speculative-data]] — telemetry separation
- [[lambda-service-pattern]] — backend layer reference

## Related Plans

- [[skill-resource-phase2-extract-graphql-hook]]
- [[skill-resource-phase2-extract-timeline-hook]]
- [[skill-resource-phase2-extract-modals-hook]]
