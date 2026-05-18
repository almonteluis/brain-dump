---
description: SkillResource Phase 2 plan to consolidate scattered modal flags into useSkillModals hook backed by reducer with discriminated union for mutual-exclusion modal orchestration
tags:
  - source
  - refactor
  - react
  - hooks
  - modals
  - skill/resource
  - phase-2
  - work
  - marvin
sources:
  - 2026-05-01-SkillResource-Phase2-Extract-Modals-Hook.md
created: 2026-05-03
updated: 2026-05-03
---

# SkillResource Phase 2 — Extract Modals Hook

**Source:** `2026-05-01-SkillResource-Phase2-Extract-Modals-Hook.md`
**Date ingested:** 2026-05-03
**Type:** Refactor plan
**Target file:** `frontend/src/components/SkillResource/hooks/useSkillModals.ts`

## Summary

Consolidate scattered modal orchestration flags inside `SkillResource.tsx` into a single `useSkillModals` hook backed by `useReducer`. State shape uses a **discriminated union** so only one modal can be active at a time. Cuts prop drilling for `disabledReviewModal` and absorbs the per-component `useState` + `useQueryLoader` calls in `AdditionalResources`. Phase 2 step that lands first because blast radius is local (Header + Timeline) and risk is low per the architecture overview risk map.

## Modal Inventory

| Modal | File | Trigger | Props/Data | Close |
|---|---|---|---|---|
| Review Modal (Learnosity wrapper) | `SkillResourceHeader.tsx:188` | Click skill-result-dropdown when `isReviewModalElegible` true | `lrnData` from previous attempt sessionId | `setOpenModal(false)` |
| Digital Lesson Modal | `DigitalLessonModal.tsx` | `AdditionalResources.tsx:38-46` `handleDigitalLessonButton` | `digitalLessonsQueryRef`, `visible`, `setVisible` | primereact `onHide` |
| Additional Lessons Modal | `LessonsModal.tsx` | `AdditionalResources.tsx:48-57` `handleAdditionalLessonButton` | `additionalLessonsQueryRef`, `visible`, `setVisible`, `customBranding` | primereact `onHide` |
| Skill Resource Info Modal | `AboutTheSkill/SkillResourceModal.tsx` | Inside `AboutTheSkill` — generic dialog | `header`, `fieldSets`, `show`, `setShow` | `onHide` |
| Brain Break Modal | TEAME-177 | `useBrainBreak` / `useQualifyPlacement`, gated by `isEligible` + step | Internal context | Context-managed |
| Future Selves Modal | TEAME-223 | `SkillResourceAvatarPanel` when `isFutureSelfAvatarEnabled` flag on | Avatar selection | Context-managed |

**Out-of-scope flags inside SkillResource.tsx:**
- `expanded` / `setExpanded` (line 106) — sidebar expansion, not modal
- `learnosityPPKey` / `setLearnosityPPKey` (line 107) — PP remount key
- `disabledReviewModal` / `setDisabledReviewModal` (line 108) — **In scope** (governs Review Modal eligibility)

## Target Hook Shape

```ts
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

interface UseSkillModalsResult {
  active: ActiveModal;
  reviewDisabled: boolean;
  open: (modal: Exclude<ActiveModal, { kind: 'none' }>) => void;
  close: () => void;
  setReviewDisabled: (disabled: boolean) => void;
  isOpen: (kind: ActiveModal['kind']) => boolean;
}
```

Reducer dispatches `open` (replaces active), `close`, `setReviewDisabled`.

## State Coordination Rules

- **Mutual exclusion**: Only one modal `active` at a time. Discriminated union enforces. Opening modal while another active replaces — no stack.
- **Review eligibility**: `reviewDisabled` flag + `previousAttempts.length > 0` + `previousAttempts[0].sessionId` (`SkillResourceHeader.tsx:45`). Hook owns flag. Eligibility check stays in header.
- **Body scroll lock**: primereact Dialog handles automatically. No manual lock needed.
- **Suspense boundaries**: Each modal wrapped in own `<Suspense>` (`AdditionalResources.tsx:60`). Hook does not own suspense. Render-time concern.
- **Brain Break + Future Selves**: Out of scope. Context-driven, gated by experiment flags. Leave as-is.

## Migration Steps (11)

1. Create `useSkillModals.ts` with `useReducer` + types above.
2. Add unit test `useSkillModals.test.ts` — reducer transitions for each action via RTL `renderHook`.
3. In SkillResource.tsx replace `const [disabledReviewModal, setDisabledReviewModal] = useState(false)` with hook call.
4. Cascade prop name `disabledReviewModal` → `reviewDisabled` through SkillResourceHeader, TimeLineWrapper, AssessmentComponent.
5. Lift AdditionalResources internal `openDigitalLessonModal` + `openAdditionalLessonModal` state into hook. AdditionalResources receives `active`, `open`, `close` from parent.
6. Lift `useQueryLoader` calls from AdditionalResources.tsx:26-27 into hook. Hook owns `digitalLessonsQueryRef` + `additionalLessonsQueryRef`. `open()` triggers correct loader.
7. Move Review Modal `openModal` state out of SkillResourceHeader.tsx:40 into hook.
8. Run `bun run typecheck`. Fix prop signatures.
9. Run `bun run relay`. Verify generated types still match.
10. Run unit + integration tests.
11. Manual QA — open each modal in dev. Confirm mutual exclusion, escape key, focus return.

## Accessibility

- **Focus trap**: primereact Dialog provides. Verify after refactor — past PRs broke trap when `closable` flag toggled (TEAMB-2700 revert).
- **Escape key**: primereact handles. Confirm `onHide` fires `close()` action.
- **`aria-modal`**: primereact sets `role="dialog"` + `aria-modal="true"`. No manual override.
- **Focus return**: confirm focus returns to trigger button after close. Currently broken on review modal close in some flows — fix during extraction.
- **`ariaCloseIconLabel`**: `LessonsModal.tsx:56` sets it. `DigitalLessonModal.tsx:42` missing — add during refactor.

## Test Plan

- Reducer unit: `open` from `none`, `open` over existing, `close`, `setReviewDisabled`
- Hook (RTL `renderHook`): `isOpen('review')` flips after `open({ kind: 'review', sessionId: 'x' })`
- Integration: render SkillResource with mock skill state. Click skill-result-dropdown → review opens. Click outside → closes. Open digital lesson → review cannot open simultaneously
- Regression: replay TEAMB-2735 ephemeral message bug + TEAMB-2733 dropdown phase 3 (both touch review modal eligibility)
- A11y: jest-axe scan rendered modal. No critical violations

## Rollback

- Revert single commit: hook + caller updates atomic
- Feature flag fallback: wrap migration steps 3-7 in `useFlag('skill-resource-modals-hook')`. Tear out flag after 2 weeks
- Backout file: keep `SkillResource.tsx.bak` in PR description first 48h post-merge
- Watch metrics: bug rate on SkillResource (target <15% via Phase 2 plan), Sentry error count tagged `component:skill-resource-modals`

## Open Questions

- Does Brain Break context need to participate in mutual exclusion? Current code lets it overlap. Confirm UX intent.
- Future Selves panel (TEAME-223) — modal or inline panel? Code says `SkillResourceAvatarPanel`, suggests inline. Verify before deciding scope.
- SkillResourceModal in AboutTheSkill is generic and reused. Lift state into hook or leave self-contained? Recommend leave — no orchestration overlap.
- AdditionalResources `active` / `tabActive` button states — UI-only, not modal state. Leave in component.

## Key Claims

- Discriminated union enforces mutual exclusion at the type system level — no runtime check needed
- `useReducer` over `useState` because modal opening is a state transition with multiple action types, not a primitive value flip
- Lifting `useQueryLoader` into the hook collapses orchestration + data loading into one owner
- Phase 2 modals = lowest blast radius, lands first per architecture risk map
- TEAMB-2700 revert evidence: focus trap regression is a real risk — explicit a11y test required

## Entities Mentioned

- [[primereact]] — Dialog component library
- [[learnosity]] — Review modal source

## Concepts Covered

- [[state-context-reducer-pattern]] — Discriminated union state
- [[react-useeffect-patterns]] — Avoiding scattered `useState`
- [[rules-of-hooks]] — Top-level unconditional hook calls
- [[accessibility]] — Focus trap, aria-modal, escape key

## Related Plans

- [[skill-resource-phase2-architecture-overview]]
- [[skill-resource-phase2-extract-graphql-hook]]
- [[skill-resource-phase2-extract-timeline-hook]]
