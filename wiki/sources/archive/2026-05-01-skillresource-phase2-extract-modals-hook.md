---
description: "Extract modal orchestration flags from SkillResource.tsx into useSkillModals hook"
tags: ['research']
raw_file: "2026-05-01-SkillResource-Phase2-Extract-Modals-Hook.md"
created: 2026-05-17
---

# SkillResource Phase 2: Extract Modals Hook

## Why

- Modal flags scattered across SkillResource.tsx as loose `useState` calls. No single source of truth for orchestration.
- `disabledReviewModal` flag set in TimeLineWrapper, AssessmentComponent — passed prop-drilled. Race-prone.
- `expanded` flag co-mingled with header. Prop chain SkillResource → SkillResourceHeader → expand/collapse loop.
- AdditionalResources owns own modal state + 2 query loaders. Duplicate concern when other features need same modals.
- Refactor goal: consolidate orchestration flags into typed hook with discriminated union. Cuts prop drilling. Makes modal coordination testable.

## Modal Inventory

| Modal | File | Trigger | Props/Data | Close Behavior |
|---|---|---|---|---|
| Review Modal (Learnosity wrapper) | SkillResourceHeader.tsx:188 | Click skill-result-dropdown when `isReviewModalElegible` true (line 80, 95) | `lrnData` from previous attempt sessionId | Internal `setOpenModal(false)` |
| Digital Lesson Modal | DigitalLessonModal.tsx | AdditionalResources.tsx:38-46 `handleDigitalLessonButton` — sets local state + loads query | `digitalLessonsQueryRef` (PreloadedQuery), `visible`, `setVisible` | primereact `onHide` → `setVisible(false)` |
| Additional Lessons Modal | LessonsModal.tsx | AdditionalResources.tsx:48-57 `handleAdditionalLessonButton` — sets local state + loads query | `additionalLessonsQueryRef`, `visible`, `setVisible`, `customBranding` | primereact `onHide` → `setVisible(false)` |
| Skill Resource Info Modal | AboutTheSkill/SkillResourceModal.tsx | Inside AboutTheSkill component — generic dialog reusable | `header`, `fieldSets`, `show`, `setShow` | `onHide` → `setShow(false)` |
| Brain Break Modal | TEAME-177 | `useBrainBreak`/`useQualifyPlacement` (line 97, 114-128) — gated by `isEligible` + step | Internal context | Context-managed |
| Future Selves Modal | TEAME-223 | Loaded via `SkillResourceAvatarPanel` (line 53) when `isFutureSelfAvatarEnabled` flag on (line 103, 634) | Avatar selection | Context-managed |

Out-of-scope flags currently inside SkillResource.tsx:
- `expanded` / `setExpanded` (line 106) — sidebar expansion in header. Not a modal but orchestration noise.
- `learnosityPPKey` / `setLearnosityPPKey` (line 107) — remount key for PracticeProblems. Not modal.
- `disabledReviewModal` / `setDisabledReviewModal` (line 108) — governs Review Modal eligibility. **In scope.**

## Target Hook Shape

```ts
import { useCallback, useReducer } from 'react';

type ActiveModal =
  | { kind: 'none' }
  | { kind: 'review'; sessionId: string }
  | { kind: 'digitalLesson'; skillId: string }
  | { kind: 'additionalLessons'; skillId: string }
  | { kind: 'skillInfo'; header: string; fieldSets: FieldSet[] };

type ModalAction =
  | { type: 'open'; modal: ActiveModal }
  | { type: 'close' }
  | { type: 'setReviewDisabled'; disabled: boolean };

interface ModalState {
  active: ActiveModal;
  reviewDisabled: boolean;
}

interface UseSkillModalsResult {
  active: ActiveModal;
  reviewDisabled: boolean;
  open: (modal: Exclude<ActiveModal, { kind: 'none' }>) => void;
  close: () => void;
  setReviewDisabled: (disabled: boolean) => void;
  isOpen: (kind: ActiveModal['kind']) => boolean;
}

export function useSkillModals(): UseSkillModalsResult {
  const [state, dispatch] = useReducer(modalReducer, {
    active: { kind: 'none' },
    reviewDisabled: false,
  });

  const open = useCallback(
    (modal: Exclude<ActiveModal, { kind: 'none' }>) => dispatch({ type: 'open', modal }),
    [],
  );
  const close = useCallback(() => dispatch({ type: 'close' }), []);
  const setReviewDisabled = useCallback(
    (disabled: boolean) => dispatch({ type: 'setReviewDisabled', disabled }),
    [],
  );
  const isOpen = useCallback((kind: ActiveModal['kind']) => state.active.kind === kind, [state.active.kind]);

  return { active: state.active, reviewDisabled: state.reviewDisabled, open, close, setReviewDisabled, isOpen };
}

function modalReducer(state: ModalState, action: ModalAction): ModalState {
  switch (action.type) {
    case 'open':
      return { ...state, active: action.modal };
    case 'close':
      return { ...state, active: { kind: 'none' } };
    case 'setReviewDisabled':
      return { ...state, reviewDisabled: action.disabled };
  }
}
```

Note: AdditionalResources has its own internal `useQueryLoader` calls. Phase 2 step 3 (below) lifts those into hook so single useSkillModals owns query refs.

## State Coordination Rules

- **Mutual exclusion**: Only one modal `active` at a time. Discriminated union enforces it. Opening modal while another active replaces, no stack.
- **Review eligibility**: `reviewDisabled` flag + `previousAttempts.length > 0` + `previousAttempts[0].sessionId` (SkillResourceHeader.tsx:45). Hook owns flag. Eligibility check stays in header.
- **Body scroll lock**: primereact Dialog handles automatically. No manual lock needed.
- **Suspense boundaries**: Each modal wrapped in own `<Suspense>` (AdditionalResources.tsx:60). Hook does not own suspense. Render-time concern.
- **Brain Break + Future Selves**: Out of scope. Context-driven, gated by experiment flags. Leave as-is.

## Step-by-Step Migration

1. Create `frontend/src/components/SkillResource/hooks/useSkillModals.ts`. Add `useReducer` + types from above. Export hook.
2. Add unit test `useSkillModals.test.ts` — reducer transitions for each action. RTL `renderHook`.
3. In SkillResource.tsx: replace `const [disabledReviewModal, setDisabledReviewModal] = useState(false)` (line 108) with `const { reviewDisabled, setReviewDisabled, ... } = useSkillModals()`.
4. Update prop names cascading down: `disabledReviewModal` → `reviewDisabled`. Touches SkillResourceHeader props (line 25), TimeLineWrapper props, AssessmentComponent props.
5. Lift AdditionalResources internal `openDigitalLessonModal` + `openAdditionalLessonModal` state into hook. AdditionalResources receives `active`, `open`, `close` from parent via prop or context.
6. Lift `useQueryLoader` calls from AdditionalResources.tsx:26-27 into hook. Hook owns `digitalLessonsQueryRef` + `additionalLessonsQueryRef`. `open()` triggers correct loader.
7. Move Review Modal `openModal` state out of SkillResourceHeader.tsx:40 into hook. Header reads `active.kind === 'review'` and `reviewDisabled` flag.
8. Run typecheck: `bun run typecheck`. Fix prop signatures.
9. Run Relay codegen: `bun run relay`. Verify generated types still match.
10. Run unit + integration tests. Fix any prop-drill regressions.
11. Manual QA: open each modal in dev. Confirm mutual exclusion, escape key close, focus return.

## Test Plan

- **Unit**: reducer transitions (`open` from `none`, `open` over existing, `close`, `setReviewDisabled`).
- **Hook test** (RTL `renderHook`): verify `isOpen('review')` flips correctly after `open({ kind: 'review', sessionId: 'x' })`.
- **Integration**: render SkillResource with mock skill state. Click skill-result-dropdown → review modal opens. Click outside → closes. Open digital lesson → review modal cannot open simultaneously.
- **Regression**: replay TEAMB-2735 ephemeral message bug + TEAMB-2733 dropdown phase 3. Both touch review modal eligibility.
- **Mock**: `@relay/test-utils` MockPayloadGenerator for query loaders. `MockEnvironment` for AdditionalResources tests.
- **A11y**: jest-axe scan rendered modal. No critical violations.

## Accessibility

- **Focus trap**: primereact Dialog provides. Verify after refactor — past PRs broke trap when `closable` flag toggled (TEAMB-2700 revert).
- **Escape key**: primereact handles. Confirm `onHide` fires `close()` action.
- **`aria-modal`**: primereact sets `role="dialog"` + `aria-modal="true"`. No manual override.
- **Focus return**: confirm focus returns to trigger button after close. Currently broken on review modal close in some flows — fix during extraction.
- **`ariaCloseIconLabel`**: LessonsModal.tsx:56 sets it. DigitalLessonModal.tsx:42 missing — add during refactor.
- **Skip link**: not required, single-modal-at-a-time.
- **Color contrast**: existing styles. Out of scope.

## Rollback

- Revert single commit: `git revert <sha>`. Hook + caller updates in same commit so atomic.
- Feature flag fallback: wrap migration step 3-7 in `useFlag('skill-resource-modals-hook')` boolean. If on, use hook. If off, use legacy `useState`. Tear out flag after 2 weeks stable.
- Backout file: keep `SkillResource.tsx.bak` in PR description as escape hatch for first 48h post-merge.
- Watch metrics: bug rate on SkillResource (target <15% via Phase 2 plan), Sentry error count tagged `component:skill-resource-modals`.

## Open Questions

- Does Brain Break context need to participate in mutual exclusion? Current code lets it overlap. Confirm UX intent.
- Future Selves panel (TEAME-223) — modal or inline panel? Code says `SkillResourceAvatarPanel`, suggests inline. Verify before deciding scope.
- SkillResourceModal in AboutTheSkill is generic and reused. Lift its state into useSkillModals or leave self-contained? Recommend leave — no orchestration overlap.
- AdditionalResources `active`/`tabActive` button states (line 35-36) — UI-only, not modal state. Leave in component.

## Related Plans

- [[2026-05-01-SkillResource-Phase2-Architecture-Overview]]
- [[2026-05-01-SkillResource-Phase2-Extract-GraphQL-Hook]]
- [[2026-05-01-SkillResource-Phase2-Extract-Timeline-Hook]]
