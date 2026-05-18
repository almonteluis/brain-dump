---
description: TEAME-218 BrainBreak context refactoring using state-reducer pattern
tags:
  - work
  - react
  - marvin/frontend/brain-break
sources:
  - BrainBreak Context Refactoring Plan.md
  - BrainBreak Context Cleanup Implementation Plan.md
  - BrainBreak Code Cleanup Plan.md
created: 2026-04-09
updated: 2026-04-09
---

# TEAME-218: BrainBreak Context Refactoring

**Work Item:** TEAME-218
**Status:** ✅ Completed (March 18, 2026)
**Branch:** `TEAME-218-refactor`
**Sources:** Multiple planning documents

## Summary

Refactored BrainBreak feature from ad-hoc useState/refs to structured `state-context-reducer` pattern. Consolidated 5 useState calls into single useReducer, extracted types and reducer to separate files, implemented Two-Context pattern for surgical re-renders.

## Problem

Original implementation had:
- 5 separate `useState` calls
- 4 refs for mutable state (anti-pattern)
- All logic in single provider file
- Components re-rendered even when only needing actions

## Solution

### Architecture Changes

| Before | After |
|--------|-------|
| 5 useState calls | 1 useReducer |
| 4 refs | Moved to reducer state |
| Inline types | `src/models/BrainBreak.ts` |
| Inline reducer | `src/contexts/brainBreakReducer.ts` |
| Single context | Two-Context pattern (State + Actions) |
| Monolithic provider | Compound components |

### Two-Context Pattern

```typescript
const BrainBreakStateContext = createContext<BrainBreakState | null>(null);
const BrainBreakActionsContext = createContext<BrainBreakActions | null>(null);
```

**Benefits**:
- Components using only actions never re-render on state changes
- Stable action references via `useMemo`
- `dispatch` from `useReducer` has inherently stable reference

### Granular Hooks

```typescript
// Surgical re-renders: only subscribe to what's needed
const state = useBrainBreakState();     // Re-renders on any state change
const actions = useBrainBreakActions(); // Never re-renders
const { isModalOpen } = useBrainBreakState(); // Only re-renders on isModalOpen
```

### Backward Compatibility

Legacy hook still works:
```typescript
const { isModalOpen, showBrainBreak } = useBrainBreak(); // Old API
```

## Key Files

| File | Purpose |
|------|---------|
| `src/models/BrainBreak.ts` | Type definitions |
| `src/contexts/brainBreakReducer.ts` | Pure reducer logic |
| `src/contexts/brainBreakContext.tsx` | Provider + hooks |
| `src/components/BrainBreak/BrainBreakModal.tsx` | Self-contained modal |
| `src/components/BrainBreak/BrainBreakTracker.tsx` | Tracker component |

## Performance Improvements

- **Surgical re-renders**: Components only re-render when dependencies change
- **Stable references**: Actions don't cause re-renders
- **Memoized values**: Context values wrapped in `useMemo`

## Patterns Applied

- **Context + Reducer** — For complex state transitions
- **Two-Context** — Separate state and actions
- **Compound Components** — Modal/Tracker as composable units
- **Custom Hooks** — Granular subscription hooks

## References

- [Separating Actions from State](https://stevekinney.com/courses/react-performance/separating-actions-from-state-two-contexts)
- [Performant React with Context](https://www.developerway.com/posts/how-to-write-performant-react-apps-with-context)
- Vercel: `rerender-defer-reads`, `rerender-memo` patterns

## Related

- [[two-context-pattern]] — React performance pattern
- [[context-reducer-pattern]] — State management approach
- [[compound-components]] — UI composition pattern
- [[brainbreak]] — Feature documentation

## Timeline

- March 23: Initial refactoring plan
- March 24: Implementation plan
- March 25: Code cleanup plan
- March 18: ✅ Completed on branch `TEAME-218-refactor`
