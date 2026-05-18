---
description: SkillResource Phase 2 plan to extract 6 Relay GraphQL operations from 709 LOC SkillResource component into single useSkillResourceQueries hook with refresh and isolation
tags:
  - source
  - refactor
  - react
  - relay
  - graphql
  - hooks
  - skill/resource
  - phase-2
  - work
  - marvin
sources:
  - 2026-05-01-SkillResource-Phase2-Extract-GraphQL-Hook.md
created: 2026-05-03
updated: 2026-05-03
---

# SkillResource Phase 2 — Extract GraphQL Hook

**Source:** `2026-05-01-SkillResource-Phase2-Extract-GraphQL-Hook.md`
**Date ingested:** 2026-05-03
**Type:** Refactor plan
**Source file:** `frontend/src/components/SkillResource/SkillResource.tsx`
**Target file:** `frontend/src/components/SkillResource/hooks/useSkillResourceQueries.ts`

## Summary

Pull six Relay operations out of `SkillResource.tsx` into a single `useSkillResourceQueries` hook. Today data fetch is tangled with view, effects, logging, and Redux glue across a 709 LOC file. Tests cannot mock fetch without mounting the entire tree. Sibling components (`TimeLineWrapper`, `AssessmentComponent`) refetch the same data — the hook lets them share. Hook returns timeline, successors, lessons, support skills, plus `commit` + `inFlight` for two mutations and a `refreshAll`.

## Six Operations Pulled Up

| Op | Hook | Currently In | Consumers |
|---|---|---|---|
| `SkillResourceGetTimelineQuery` | `useLazyLoadQuery` | TimeLineWrapper (child) | Step list, `currentStep` calc |
| `SkillResourceGetSuccessorsQuery` | `useLazyLoadQuery` | child | Next-skill nav, `sssAfterTakeAssessment` |
| `SkillResourceGetLessonsQuery` | `useLazyLoadQuery` | child | AboutTheSkill lesson cards |
| `SkillResourceGetAssessmentStatusMutation` | `useMutation` | AssessmentComponent | `setAttemptInformation`, `setCurrentStatus`, `previousAttempts` |
| `SkillResourceGetSupportSkillsSkillStatesQuery` | `useLazyLoadQuery` | SkillResource.tsx:170-180 | `mediumRelevanceSupportSkills`, `highRelevanceSupportSkills` |
| `SkillResourceCreateTimelineEventMutation` | `useMutation` | child | Timeline event creation |

**Out of scope** (do not move):
- `AssignmentGetAssignmentStudentDashboardQuery` (lines 193-201) — cross-feature
- `SkillsPresignedURLsQuery` (lines 207-219) — parent-supplied preloaded ref
- `ExperimentsRecordExperimentsObservationMutation` (line 138) — separate experiments hook later

## Target Hook Shape

```ts
interface UseSkillResourceQueriesArgs {
  skillId: string;
  studentId: string;
  targetGroupId: string;
}

interface UseSkillResourceQueriesResult {
  timeline: SkillResourceGetTimelineQuery['response'];
  successors: SkillResourceGetSuccessorsQuery['response'];
  lessons: SkillResourceGetLessonsQuery['response'];
  supportSkills: SkillResourceGetSupportSkillsSkillStatesQuery['response'];
  assessmentStatus: { commit, inFlight };
  createTimelineEvent: { commit, inFlight };
  refreshAll: () => void;
}
```

Internal: `fetchKey` state bumped by `refreshAll` is passed into all four `useLazyLoadQuery` calls — single key forces all four to re-fetch.

Per-query `fetchPolicy`:
- `timeline`, `supportSkills` → `network-only`
- `successors`, `lessons` → `store-or-network`

## Migration Steps (11)

1. Create `hooks/` folder with empty `useSkillResourceQueries.ts` + `index.ts` barrel.
2. Audit. Grep all 6 op names across `src/`. Record callsites in PR description.
3. Move op definitions. Consolidate under `graphQLOperations/SkillResource.ts`. Run `npm run relay`. Commit generated types.
4. Build hook skeleton with signature above. `tsc --noEmit` clean.
5. Wire SkillResource.tsx — replace lines 170-180 with hook call. Effect at 242-248 unchanged.
6. Lift child queries one at a time. Start TimeLineWrapper. Pass `timeline` + `commit` + `refreshAll` props. Repeat for AssessmentComponent + AboutTheSkill.
7. Drop redundant `useEffect` bridge if hook returns `useMemo`-derived support skill split.
8. Re-run relay codegen.
9. Run unit + integration tests. Fix mocks.
10. Manual QA — full step walk: About → Worked → Practice → Challenge → Pass → Successor. DevTools Network: no double requests.
11. Open PR. Reference Phase 1. Note Phase 3 (effects extraction) follows.

## Test Plan

- **Unit**: `useSkillResourceQueries.test.tsx` wrapped in `RelayEnvironmentProvider` with `createMockEnvironment()`. `MockPayloadGenerator.generate` from `relay-test-utils` per query. Assert returned shape.
- **Mutation**: `mockEnvironment.mock.resolveMostRecentOperation`. Verify `commit` callable. Verify `inFlight` flips.
- **`refreshAll`**: call hook, call `refreshAll()`, assert `mockEnvironment.mock.getAllOperations().length` increments by 4.
- **Integration**: existing `SkillResource.test.tsx` should pass once provider supplies all 6 ops. Add to `MockPayloadGenerator` resolver map.
- **Snapshot**: `AboutTheSkill` receives same `mediumSupportSkills` / `highSupportSkills` arrays pre vs post.
- **Regression**: e2e Playwright run for skill 213 happy path.

## Rollback

- Revert single PR. Hook is isolated in new folder.
- Optional feature flag: gate import behind `useFlag('phase-2-skill-resource-hook')`. Branch on flag, fall back to legacy inline calls. Remove flag after 1 week stable.
- Generated types untouched.

## Open Questions

- Do `timeline` / `successors` / `lessons` / `assessment-status` / `timeline-event` ops actually exist as named GraphQL operations today? Or are they fragments inside larger queries? Verify by grep first.
- `fetchPolicy` per query — confirm with backend cache TTL whether `network-only` vs `store-or-network` is right.
- Does `targetGroupId` belong as hook arg or read inside hook from Redux? Pulling from arg keeps hook pure but couples caller to Redux selector.
- Suspense boundary — 4 lazy queries → 4 suspends. Parent `<Suspense>` wraps. Confirm UX waits for all vs streams.
- Should `refreshAll` bump one fetchKey or per-query keys? Decide based on partial-refresh need.
- Does `useCurrentSkillResult` overlap with `successors` data? Dedupe risk.

## Key Claims

- 6-op extraction enables sibling components to share data instead of refetching
- Single `fetchKey` for `refreshAll` is sufficient if callers do not need partial refresh
- Mock environment + `MockPayloadGenerator` is the test isolation strategy
- Generated Relay types decouple hook from raw schema — rollback only touches caller + new hook file
- Phase 2 GraphQL extraction is **medium risk** per Phase 2 architecture overview risk map (Suspense boundary + presigned URL hack interaction)

## Entities Mentioned

- [[relay]] — GraphQL client
- [[hot-chocolate-graphql]] — Backend GraphQL framework

## Concepts Covered

- [[fragment-composition]] — Hook returns shape for child consumption
- [[graphql-over-fetching]] — Consolidated ops cut over-fetching
- [[render-as-you-fetch]] — `useLazyLoadQuery` pattern
- [[react-useeffect-patterns]] — Replace effect bridges with `useMemo`
- [[rules-of-hooks]] — Top-level unconditional hook calls

## Related Plans

- [[skill-resource-phase2-architecture-overview]] — Parent plan, container/view + 3-hook decomposition
- [[skill-resource-phase2-extract-modals-hook]] — Modals refactor (lower risk, lands first)
- [[skill-resource-phase2-extract-timeline-hook]] — Timeline state machine extraction
