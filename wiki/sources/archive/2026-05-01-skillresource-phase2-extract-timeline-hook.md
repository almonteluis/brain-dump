---
description: "Plan to extract timeline navigation logic from SkillResource.tsx god component into useSkillTimeline hook"
tags: ['research']
raw_file: "2026-05-01-SkillResource-Phase2-Extract-Timeline-Hook.md"
created: 2026-05-17
---

# SkillResource Phase 2: Extract Timeline Hook

## Why

- SkillResource.tsx 709 LOC. God component. Mix concerns: data fetch, experiment logging, timeline nav, render.
- Timeline state (`currentStep`) drilled prop through SkillResource into TimeLineWrapper. Setter scattered.
- TimeLineWrapper owns click handler, mutation, brain-break gate. No single owner of nav rules.
- Phase 1 extracted header. Phase 2 target: nav. Phase 3 target: experiment logging.
- Hook lets us unit-test timeline transitions without rendering Relay tree.
- Reuse possible: same nav rules needed in placement/diagnostic flows later.

## Current Timeline Logic Inventory

| Location | Behavior | State / Effects |
|---|---|---|
| `SkillResource.tsx:63-64` | `currentStep`, `setCurrentStep` props from parent | Lifted state — owned outside |
| `SkillResource.tsx:107` | `learnosityPPKey` state | Re-mount key for PracticeProblems on revisit |
| `SkillResource.tsx:108` | `disabledReviewModal` state | Toggled by step changes |
| `SkillResource.tsx:223-240` | useEffect: load previous session when step = SKILL_CHALLENGE on mount | reads `previousAttempts`, calls `loadPreviousSesssion`, sets `attemptInformation` |
| `SkillResource.tsx:114-128` | `useQualifyPlacement` x4 gated by `currentStep` | TEAME-177 placement qualifying side-effects |
| `SkillResource.tsx:635-643` | TimeLineWrapper render — passes setters | Prop drill |
| `SkillResource.tsx:649-701` | Step switch render (ABOUT/WORKED/PP/CHALLENGE) | Renders one of four bodies based on `currentStep` |
| `TimeLineWrapper.tsx:50-86` | `onClickHandler` — commit mutation, brain-break gate, set step | `commitTimelineEvent`, `setSkipNewActivityId`, `setLearnosityPPKey`, `setDisabledReviewModal`, `handleBrainBreakNavigation`, `setCurrentStep` |
| `TimeLineWrapper.tsx:29-33` | `timelinePlacementMap` | Maps step → BrainBreakPlacement |
| `TimeLineWrapper.tsx:122-150` | `items[]` MenuItem array | Step labels, icons, action codes |
| `TimeLineWrapper.tsx:152-160` | scroll listener → `isFixed` | sets `setExpanded(false)` on scroll, computes sticky header threshold |
| `utils/timelineHandler.ts` | `getTimelineButtonLabel`, `getTimelineButtonType` | pure |
| `utils/sanitizeBackendTimeline.ts` | strip orphan ActionTypeNode:5 | TEAMC-1001 workaround |
| `models/Timeline.ts` | `SkillResourceSteps` enum (numeric, ordered) | Step contract |

## Target Hook Shape

```typescript
// frontend/src/components/SkillResource/hooks/useSkillTimeline.ts

import { Dispatch, SetStateAction } from 'react';
import { SkillResourceSteps } from '../../../models/Timeline';
import { BrainBreakPlacement } from '../../../experiments/TEAME-177/BrainBreakModal/BrainBreakContext';

export interface UseSkillTimelineParams {
  currentStep: SkillResourceSteps | null;
  setCurrentStep: Dispatch<SetStateAction<SkillResourceSteps | null>>;
  skillId: string | undefined;
  userId: string | number | undefined;
  setSkipNewActivityId: Dispatch<SetStateAction<boolean>>;
  setDisabledReviewModal: Dispatch<SetStateAction<boolean>>;
  refetchLrnSession: () => void;
}

export interface UseSkillTimelineResult {
  currentStep: SkillResourceSteps | null;
  goToStep: (
    step: SkillResourceSteps,
    event?: React.MouseEvent | React.KeyboardEvent,
  ) => void;
  goNext: () => void;
  goPrev: () => void;
  isFirstStep: boolean;
  isLastStep: boolean;
  nextStep: SkillResourceSteps | null;
  prevStep: SkillResourceSteps | null;
  learnosityPPKey: number | null;
  resetLearnosityPPKey: () => void;
  placementForStep: (step: SkillResourceSteps) => BrainBreakPlacement | undefined;
  isFixed: boolean;
}

export const useSkillTimeline = (
  params: UseSkillTimelineParams,
): UseSkillTimelineResult;
```

## State Machine

Steps numeric-ordered enum (0..3). Forward-biased but free jump allowed.

```
[ABOUT_THE_SKILL:0] -> [WORKED_EXAMPLE:1] -> [PRACTICE_PROBLEMS:2] -> [SKILL_CHALLENGE:3]
        ^                    ^                       ^                       |
        |                    |                       |                       |
        +--- free jump (menu click) -----------------+-----------------------+
```

Transition rules:
- All transitions log `commitTimelineEvent` mutation EXCEPT into `SKILL_CHALLENGE`.
- Into `SKILL_CHALLENGE`: skip mutation, set `disabledReviewModal=true`, `setSkipNewActivityId(false)`, call `refetchLrnSession()`.
- Into `PRACTICE_PROBLEMS`: bump `learnosityPPKey` (force PP remount).
- ABOUT/WORKED/PP have brain-break placement gate. Modal MAY intercept transition.
- SKILL_CHALLENGE no placement gate.

## Step-by-Step Migration

1. Create `frontend/src/components/SkillResource/hooks/` dir.
2. Add `useSkillTimeline.ts` skeleton with types above. No logic yet.
3. Move `learnosityPPKey` state from SkillResource into hook.
4. Move `disabledReviewModal` state into hook (or accept setter — keep setter for now since TimeLineWrapper, AssessmentComponent, Header all read).
5. Move `timelinePlacementMap` constant from TimeLineWrapper into hook module scope.
6. Move `commitTimelineEvent` mutation init into hook.
7. Move `useBrainBreakNavigation` call into hook.
8. Implement `goToStep(step, event?)`:
   - mirror TimeLineWrapper `onClickHandler` body.
   - if no event passed, skip brain-break gate (programmatic nav).
9. Derive `nextStep`, `prevStep`, `isFirstStep`, `isLastStep` from enum order.
10. Implement `goNext`, `goPrev` as thin wrappers.
11. Move scroll listener (`isFixed`) into hook. Return `isFixed`.
12. Refactor `TimeLineWrapper` to consume hook. Drop local mutation, scroll effect, click handler. Keep render only.
13. Refactor `SkillResource.tsx`:
    - Replace local `learnosityPPKey` with hook value.
    - Pass `goToStep` (or full hook bag) into children needing nav (PracticeProblems, AssessmentComponent currently take `setCurrentStep`).
14. Adapter pass: where children expect `setCurrentStep: Dispatch<SetStateAction<...>>`, wrap `goToStep` to keep signature, or update child prop types in same PR.
15. Move `useQualifyPlacement` calls into hook (optional, Phase 2.5 if scope creeps).
16. Add unit tests under `__tests__/useSkillTimeline.test.tsx`.
17. Run `npm run relay`, lint, typecheck.
18. Manual smoke: each step transition + brain-break modal + revisit PP.

## Edge Cases

- Presigned URL race (`SkillResource.tsx:206-219`): Suspense throws Promise. Hook must NOT touch presigned URL state — keep that in component.
- TEAMB-2700 reverted: prior attempt to centralize step transitions broke session restoration. Mount effect at lines 223-240 must run BEFORE first paint of SKILL_CHALLENGE body. Keep mount effect at component level OR move into hook with same `[]` deps + `refetchLrnSession`/`loadPreviousSesssion` refs stable.
- TEAMB-2850 scroll position: `setExpanded(false)` on scroll resets header. Preserve current behavior — call setter from hook scroll listener.
- `learnosityPPKey` MUST change on PP-revisit only. Initial mount on PP step should not bump (avoid double-mount). Guard with ref tracking last-step.
- Brain-break gate skipped when `event` undefined — programmatic flows (e.g., post-assessment auto-advance) bypass modal. Document in JSDoc.
- `commitTimelineEvent` fires fire-and-forget. No await. Ensure no double-fire on rapid clicks — debounce or rely on idempotency.
- `setDisabledReviewModal(false)` on every non-CHALLENGE click — preserve. Header reads it.
- `SkillResourceSteps` enum is numeric. `(currentStep as number) + 1` arithmetic in TimeLineWrapper:104. Replace with explicit `nextStep` from hook to avoid silent breakage if enum reordered.
- `sanitizeBackendTimeline` lives in utils — orthogonal, do not touch.
- StrictMode double-invoke: scroll listener cleanup must remove same handler ref.

## Test Plan

- Unit: hook returns correct `nextStep`/`prevStep` for each enum value.
- Unit: `isLastStep` true only at SKILL_CHALLENGE.
- Unit: `goToStep(SKILL_CHALLENGE)` does NOT call `commitTimelineEvent`, DOES call `refetchLrnSession`, sets `disabledReviewModal=true`.
- Unit: `goToStep(PRACTICE_PROBLEMS)` bumps `learnosityPPKey`.
- Unit: brain-break gate invoked for ABOUT/WORKED/PP, skipped for CHALLENGE.
- Unit: programmatic `goToStep(step)` (no event) bypasses brain-break.
- Integration: render SkillResource, click each menu item, assert body switches.
- Regression: TEAMB-2700 — SKILL_CHALLENGE mount with prior attempts loads previous session.
- Regression: TEAMB-2850 — scroll past 275px sets fixed class, header collapses.
- Manual: brain-break modal appears at WORKED on real env with flag on.
- Manual: PP revisit after CHALLENGE re-mounts learnosity.

## Rollback

- Single-PR migration. Revert via `git revert <sha>`.
- Hook isolated to new file `hooks/useSkillTimeline.ts` — delete file, restore TimeLineWrapper + SkillResource diff, no schema/Relay changes.
- Feature flag NOT required — pure refactor, no user-facing behavior change.
- If brain-break regression detected post-merge: hotfix to inline `handleBrainBreakNavigation` call back into TimeLineWrapper while leaving rest of hook intact.
- Keep `utils/timelineHandler.ts` and `sanitizeBackendTimeline.ts` untouched — rollback boundary.
