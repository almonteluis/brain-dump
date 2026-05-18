---
description: SkillResource Phase 2 plan to extract step navigation state machine from SkillResource.tsx and TimeLineWrapper into useSkillTimeline hook with goToStep/goNext/goPrev API
tags:
  - source
  - refactor
  - react
  - hooks
  - timeline
  - state-machine
  - skill/resource
  - phase-2
  - work
  - marvin
sources:
  - 2026-05-01-SkillResource-Phase2-Extract-Timeline-Hook.md
created: 2026-05-03
updated: 2026-05-03
---

# SkillResource Phase 2 — Extract Timeline Hook

**Source:** `2026-05-01-SkillResource-Phase2-Extract-Timeline-Hook.md`
**Date ingested:** 2026-05-03
**Type:** Refactor plan
**Target file:** `frontend/src/components/SkillResource/hooks/useSkillTimeline.ts`

## Summary

Extract the step-navigation logic scattered across `SkillResource.tsx` (709 LOC) and `TimeLineWrapper.tsx` into a single `useSkillTimeline` hook. Owns `learnosityPPKey`, `disabledReviewModal`, `commitTimelineEvent` mutation, brain-break gate via `useBrainBreakNavigation`, scroll listener, and provides `goToStep` / `goNext` / `goPrev` API. State machine is a numeric-ordered enum (`SkillResourceSteps` 0..3) with forward bias and free-jump allowed via menu click. Phase 2 step #2 — lands after modals, before queries.

## Current Logic Inventory

| Location | Behavior | State |
|---|---|---|
| `SkillResource.tsx:63-64` | `currentStep`, `setCurrentStep` props | Lifted, owned outside |
| `SkillResource.tsx:107` | `learnosityPPKey` | PP remount key on revisit |
| `SkillResource.tsx:108` | `disabledReviewModal` | Toggled by step changes |
| `SkillResource.tsx:223-240` | useEffect: load previous session when step = SKILL_CHALLENGE on mount | reads `previousAttempts`, calls `loadPreviousSesssion` |
| `SkillResource.tsx:114-128` | `useQualifyPlacement` x4 gated by `currentStep` | TEAME-177 placement side-effects |
| `SkillResource.tsx:649-701` | Step switch render (ABOUT/WORKED/PP/CHALLENGE) | One of 4 bodies |
| `TimeLineWrapper.tsx:50-86` | `onClickHandler` — commit mutation, brain-break gate, set step | Multiple setters |
| `TimeLineWrapper.tsx:29-33` | `timelinePlacementMap` | Maps step → BrainBreakPlacement |
| `TimeLineWrapper.tsx:122-150` | `items[]` MenuItem array | Step labels, icons, action codes |
| `TimeLineWrapper.tsx:152-160` | scroll listener → `isFixed` | Sticky header threshold |
| `utils/timelineHandler.ts` | `getTimelineButtonLabel`, `getTimelineButtonType` | Pure |
| `utils/sanitizeBackendTimeline.ts` | strip orphan ActionTypeNode:5 | TEAMC-1001 workaround |
| `models/Timeline.ts` | `SkillResourceSteps` enum | Step contract |

## Target Hook API

```ts
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
  goToStep: (step: SkillResourceSteps, event?: React.MouseEvent | React.KeyboardEvent) => void;
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
```

## State Machine

```
[ABOUT_THE_SKILL:0] → [WORKED_EXAMPLE:1] → [PRACTICE_PROBLEMS:2] → [SKILL_CHALLENGE:3]
        ^                    ^                       ^
        |                    |                       |
        +--- free jump (menu click) -----------------+
```

**Transition Rules:**
- All transitions log `commitTimelineEvent` mutation EXCEPT into `SKILL_CHALLENGE`
- Into `SKILL_CHALLENGE`: skip mutation, set `disabledReviewModal=true`, `setSkipNewActivityId(false)`, call `refetchLrnSession()`
- Into `PRACTICE_PROBLEMS`: bump `learnosityPPKey` (force PP remount)
- ABOUT/WORKED/PP have brain-break placement gate. Modal MAY intercept transition.
- SKILL_CHALLENGE: no placement gate

## Migration Steps (18)

1. Create `frontend/src/components/SkillResource/hooks/`
2. Add `useSkillTimeline.ts` skeleton — types only, no logic
3. Move `learnosityPPKey` state from SkillResource into hook
4. Move `disabledReviewModal` state into hook (or keep setter — header reads it)
5. Move `timelinePlacementMap` constant from TimeLineWrapper into hook module scope
6. Move `commitTimelineEvent` mutation init into hook
7. Move `useBrainBreakNavigation` call into hook
8. Implement `goToStep(step, event?)` — mirror TimeLineWrapper `onClickHandler` body. **If no event, skip brain-break gate (programmatic nav).**
9. Derive `nextStep`, `prevStep`, `isFirstStep`, `isLastStep` from enum order
10. Implement `goNext`, `goPrev` as thin wrappers
11. Move scroll listener (`isFixed`) into hook
12. Refactor `TimeLineWrapper` to consume hook. Drop local mutation, scroll effect, click handler. Render only.
13. Refactor `SkillResource.tsx` — replace local `learnosityPPKey` with hook value. Pass `goToStep` (or full hook bag) into children needing nav.
14. Adapter pass — where children expect `setCurrentStep: Dispatch<SetStateAction<...>>`, wrap `goToStep` to keep signature, OR update child prop types in same PR.
15. Move `useQualifyPlacement` calls into hook (optional, Phase 2.5 if scope creeps)
16. Add unit tests under `__tests__/useSkillTimeline.test.tsx`
17. Run `npm run relay`, lint, typecheck
18. Manual smoke — each step transition + brain-break modal + revisit PP

## Edge Cases

- **Presigned URL race** (`SkillResource.tsx:206-219`): Suspense throws Promise. Hook MUST NOT touch presigned URL state — keep in component.
- **TEAMB-2700 reverted**: prior attempt to centralize step transitions broke session restoration. Mount effect at lines 223-240 MUST run before first paint of SKILL_CHALLENGE body. Keep mount effect at component level OR move into hook with same `[]` deps + stable refs.
- **TEAMB-2850 scroll position**: `setExpanded(false)` on scroll resets header. Preserve current behavior.
- **`learnosityPPKey` MUST change on PP-revisit only**. Initial mount on PP step should not bump (avoid double-mount). Guard with ref tracking last-step.
- **Brain-break gate skipped when `event` undefined** — programmatic flows (post-assessment auto-advance) bypass modal. Document in JSDoc.
- **`commitTimelineEvent` fires fire-and-forget**. No await. Ensure no double-fire on rapid clicks — debounce or rely on idempotency.
- **`SkillResourceSteps` is numeric**. `(currentStep as number) + 1` arithmetic in TimeLineWrapper:104 — replace with explicit `nextStep` from hook to avoid silent breakage if enum reordered.
- **`sanitizeBackendTimeline`** lives in utils — orthogonal, do not touch.
- **StrictMode double-invoke**: scroll listener cleanup must remove same handler ref.

## Test Plan

- Unit: `nextStep` / `prevStep` correct for each enum value
- Unit: `isLastStep` true only at SKILL_CHALLENGE
- Unit: `goToStep(SKILL_CHALLENGE)` does NOT call `commitTimelineEvent`, DOES call `refetchLrnSession`, sets `disabledReviewModal=true`
- Unit: `goToStep(PRACTICE_PROBLEMS)` bumps `learnosityPPKey`
- Unit: brain-break gate invoked for ABOUT/WORKED/PP, skipped for CHALLENGE
- Unit: programmatic `goToStep(step)` (no event) bypasses brain-break
- Integration: render SkillResource, click each menu item, assert body switches
- Regression: TEAMB-2700 — SKILL_CHALLENGE mount with prior attempts loads previous session
- Regression: TEAMB-2850 — scroll past 275px sets fixed class, header collapses
- Manual: brain-break modal appears at WORKED on real env with flag on
- Manual: PP revisit after CHALLENGE re-mounts learnosity

## Rollback

- Single-PR migration. Revert via `git revert <sha>`.
- Hook isolated to new file — delete file, restore TimeLineWrapper + SkillResource diff. No schema/Relay changes.
- Feature flag NOT required — pure refactor, no user-facing behavior change.
- If brain-break regression: hotfix to inline `handleBrainBreakNavigation` call back into TimeLineWrapper.

## Key Claims

- Numeric enum + arithmetic step calc is fragile — explicit `nextStep` from hook removes silent reorder risk
- Programmatic-vs-user navigation distinction (event presence) gates brain-break — wrong here breaks UX
- Phase 2 timeline = medium risk per architecture overview risk map
- TEAMB-2700 revert is precedent that centralizing step transitions has historically broken session restoration — mount effect timing matters
- `useBrainBreakNavigation` already encapsulates brain-break logic — hook just wraps + sequences

## Entities Mentioned

- [[learnosity]] — PP remount key context

## Concepts Covered

- [[state-context-reducer-pattern]] — State machine via reducer
- [[react-useeffect-patterns]] — Mount effect timing constraints
- [[rules-of-hooks]] — Top-level unconditional hook calls
- [[key-based-remount]] — `learnosityPPKey` pattern

## Related Plans

- [[skill-resource-phase2-architecture-overview]]
- [[skill-resource-phase2-extract-graphql-hook]]
- [[skill-resource-phase2-extract-modals-hook]]
- [[teame-218-brainbreak-postmortem]] — Brain break navigation history
