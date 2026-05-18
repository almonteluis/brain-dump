---
description: "Pull six Relay ops out of SkillResource.tsx into single useSkillResourceQueries hook"
tags: ['research']
raw_file: "2026-05-01-SkillResource-Phase2-Extract-GraphQL-Hook.md"
created: 2026-05-17
---

# SkillResource Phase 2: Extract GraphQL Hook

## Why

- Component bloated. 709 LOC. Data fetch tangled with view, effects, logging, redux glue. Hard read.
- Tests painful. Cannot mock fetch without mounting whole tree. No isolation. Mock noise high.
- Reuse blocked. Sibling components (TimeLineWrapper, AssessmentComponent) refetch same data. Hook lets them share.

## Current Wiring

Note: file uses 3 visible Relay ops directly plus 1 mutation. Other 2 ops listed (timeline, successors, lessons, assessment-status mutation) live in child components today (TimeLineWrapper, AssessmentComponent) and pull up into hook as part of Phase 2. Verify import paths during step 1.

- **SkillResourceGetTimelineQuery**
  - Hook: `useLazyLoadQuery` (currently inside `TimeLineWrapper`, not in this file)
  - Invoked: child component, lifted up
  - Consumers: `TimeLineWrapper` step list, `currentStep` calc

- **SkillResourceGetSuccessorsQuery**
  - Hook: `useLazyLoadQuery` (child)
  - Invoked: post-pass flow (AssessmentComponent / next skill suggestion)
  - Consumers: next-skill nav, `sssAfterTakeAssessment` flow

- **SkillResourceGetLessonsQuery**
  - Hook: `useLazyLoadQuery` (child)
  - Invoked: AboutTheSkill / lesson list area
  - Consumers: lesson cards in AboutTheSkill panel

- **SkillResourceGetAssessmentStatusMutation**
  - Hook: `useMutation`
  - Invoked: AssessmentComponent submit path
  - Consumers: `setAttemptInformation`, `setCurrentStatus`, `previousAttempts` update

- **SkillResourceGetSupportSkillsSkillStatesQuery**
  - Hook: `useLazyLoadQuery<SkillResourceGetSupportSkillsSkillStatesQuery>`
  - Invoked: lines 170-180 of `SkillResource.tsx`
  - Consumers: `useEffect` lines 242-248 -> `setMediumRelevanceSupportSkills`, `setHighRelevanceSupportSkills`; passed to `AboutTheSkill` and `AssessmentComponent` (`essentialSkills` prop)

- **SkillResourceCreateTimelineEventMutation**
  - Hook: `useMutation` (child, TimeLineWrapper / AssessmentComponent path)
  - Invoked: timeline event creation on step transitions
  - Consumers: timeline refresh, audit trail

Also in file (out of scope for this hook, do NOT move):
- `AssignmentGetAssignmentStudentDashboardQuery` (lines 193-201) - cross-feature
- `SkillsPresignedURLsQuery` (lines 207-219) - parent-supplied preloaded ref
- `ExperimentsRecordExperimentsObservationMutation` (line 138) - experiments concern, separate hook later

## Target Hook Shape

```ts
import { useLazyLoadQuery, useMutation } from 'react-relay';
import type { SkillResourceGetTimelineQuery } from '@graphQLOperations/__generated__/SkillResourceGetTimelineQuery.graphql';
import type { SkillResourceGetSuccessorsQuery } from '@graphQLOperations/__generated__/SkillResourceGetSuccessorsQuery.graphql';
import type { SkillResourceGetLessonsQuery } from '@graphQLOperations/__generated__/SkillResourceGetLessonsQuery.graphql';
import type { SkillResourceGetAssessmentStatusMutation } from '@graphQLOperations/__generated__/SkillResourceGetAssessmentStatusMutation.graphql';
import type { SkillResourceGetSupportSkillsSkillStatesQuery } from '@graphQLOperations/__generated__/SkillResourceGetSupportSkillsSkillStatesQuery.graphql';
import type { SkillResourceCreateTimelineEventMutation } from '@graphQLOperations/__generated__/SkillResourceCreateTimelineEventMutation.graphql';

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
  assessmentStatus: {
    commit: ReturnType<typeof useMutation<SkillResourceGetAssessmentStatusMutation>>[0];
    inFlight: boolean;
  };
  createTimelineEvent: {
    commit: ReturnType<typeof useMutation<SkillResourceCreateTimelineEventMutation>>[0];
    inFlight: boolean;
  };
  refreshAll: () => void;
}

export function useSkillResourceQueries(
  args: UseSkillResourceQueriesArgs,
): UseSkillResourceQueriesResult {
  const { skillId, studentId, targetGroupId } = args;
  const [fetchKey, setFetchKey] = useState(0);

  const timeline = useLazyLoadQuery<SkillResourceGetTimelineQuery>(
    getTimeline,
    { skillId, studentId },
    { fetchPolicy: 'network-only', fetchKey },
  );

  const successors = useLazyLoadQuery<SkillResourceGetSuccessorsQuery>(
    getSuccessors,
    { skillId },
    { fetchPolicy: 'store-or-network', fetchKey },
  );

  const lessons = useLazyLoadQuery<SkillResourceGetLessonsQuery>(
    getLessons,
    { skillId },
    { fetchPolicy: 'store-or-network', fetchKey },
  );

  const supportSkills = useLazyLoadQuery<SkillResourceGetSupportSkillsSkillStatesQuery>(
    getSupportSkills,
    { skillId, studentId, targetGroupId },
    { fetchPolicy: 'network-only', fetchKey },
  );

  const [commitAssessmentStatus, assessmentInFlight] =
    useMutation<SkillResourceGetAssessmentStatusMutation>(getAssessmentStatus);
  const [commitTimelineEvent, timelineEventInFlight] =
    useMutation<SkillResourceCreateTimelineEventMutation>(createTimelineEvent);

  const refreshAll = useCallback(() => setFetchKey(k => k + 1), []);

  return {
    timeline,
    successors,
    lessons,
    supportSkills,
    assessmentStatus: { commit: commitAssessmentStatus, inFlight: assessmentInFlight },
    createTimelineEvent: { commit: commitTimelineEvent, inFlight: timelineEventInFlight },
    refreshAll,
  };
}
```

## Step-by-Step Migration

1. Create folder `frontend/src/components/SkillResource/hooks/`. Add empty `useSkillResourceQueries.ts` and `index.ts` barrel.
2. Audit. Grep all 6 op names across `src/`. Record every callsite. Confirm child components hold timeline/successors/lessons/assessment-status/timeline-event ops. Save list in PR description.
3. Move op definitions. Ensure all 6 live under `graphQLOperations/SkillResource.ts` (consolidate if scattered). Run `npm run relay`. Commit generated types.
4. Build hook skeleton. Implement signature above. No consumers yet. `tsc --noEmit` clean.
5. Wire SkillResource.tsx. Replace lines 170-180 (`useLazyLoadQuery` for support skills) with `useSkillResourceQueries({ skillId, studentId, targetGroupId })`. Pull `supportSkills` from result. Effect at 242-248 unchanged.
6. Lift child queries one at a time. Start TimeLineWrapper. Pass `timeline` + `createTimelineEvent.commit` + `refreshAll` as props. Delete `useLazyLoadQuery` from child. Repeat for AssessmentComponent (successors, assessment-status mutation), AboutTheSkill (lessons).
7. Drop redundant useEffect bridge if hook can return derived support skill split via `useMemo`. Optional follow-up.
8. Re-run relay codegen. `npm run relay && npm run typecheck`.
9. Run unit + integration tests. Fix mocks.
10. Manual QA. Walk: About -> Worked Example -> Practice -> Skill Challenge -> Pass -> Successor. Verify no double network requests via DevTools Network tab.
11. Open PR. Reference Phase 1. Note Phase 3 (effects extraction) follows.

## Test Plan

- Unit. `useSkillResourceQueries.test.tsx`. Wrap in `RelayEnvironmentProvider` with `createMockEnvironment()`. Use `MockPayloadGenerator.generate` from `relay-test-utils` to feed each query. Assert returned shape.
- Mutation tests. `mockEnvironment.mock.resolveMostRecentOperation`. Verify `commit` callable. Verify `inFlight` flips.
- `refreshAll` test. Call hook, call `refreshAll()`, assert `mockEnvironment.mock.getAllOperations().length` increments for all 4 queries.
- Integration. Existing `SkillResource.test.tsx` should still pass with no mock changes once provider supplies all 6 ops. Add op names to `MockPayloadGenerator` resolver map.
- Snapshot. Confirm `AboutTheSkill` receives same `mediumSupportSkills` / `highSupportSkills` arrays pre vs post.
- Regression. Add e2e Playwright run for skill 213 happy path.

## Rollback

- Revert single PR. Hook isolated in new folder; consumer change is mechanical swap. `git revert <sha>` restores `useLazyLoadQuery` calls inline.
- Feature flag option: gate import behind `useFlag('phase-2-skill-resource-hook')`. Branch on flag, fall back to legacy inline calls. Remove flag once stable 1 week.
- Keep generated types untouched - rollback only touches component + new hook file.

## Open Questions

- Do timeline / successors / lessons / assessment-status / timeline-event ops actually exist as named GQL operations today? Verify by `grep -r "SkillResourceGetTimelineQuery" src/`. If not, are they fragments inside larger queries? Plan changes if so.
- `fetchPolicy` per query - which need `network-only` vs `store-or-network`? Current support-skills uses `network-only`. Confirm with backend cache TTL.
- Does `targetGroupId` belong as hook arg or read inside hook from redux? Pulling from arg keeps hook pure but couples caller to redux selector. Decide.
- Suspense boundary placement. Hook calls 4 lazy queries -> 4 suspends. Parent `<Suspense>` already wraps. Confirm UX waits for all vs streams.
- Should `refreshAll` bump one fetchKey for all queries, or per-query keys? Decide based on whether callers want partial refresh.
- Does `useCurrentSkillResult` overlap with `successors` data? Dedupe risk.
- TEAME-223 / TEAME-183 experiment ops - leave out of hook (correct), but verify no shared variables get stale.
