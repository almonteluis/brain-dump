---
description: Comprehensive React state management refactor plan — MVC pattern with useReducer + Context, split state/actions contexts
tags: [source, react, state-management, mvc, useReducer, context, refactoring]
sources: ["imperative-seeking-goblet.md"]
created: 2026-04-09
updated: 2026-04-09
---

# BrainBreak MVC Refactor Plan

**Source:** `raw/00_inbox/work docs/imperative-seeking-goblet.md`
**Date ingested:** 2026-04-09
**Type:** Refactoring guide

## Summary

Detailed plan for refactoring scattered React state management into a clean MVC pattern using React best practices: split State/Actions contexts, useReducer, custom hooks, and proper separation of concerns.

## The Problem

Current architecture has state management split across:
- Context provider (`brainBreakContext.tsx`)
- Local reducer in modal (`BrainBreakModalState.ts`)
- Business logic in `utils/brainBreakCooldown.ts`
- Recording logic in `models/RecordingService.ts`

Result: Hard to follow, hard to test.

## Target Architecture (MVC)

| Layer | Responsibility | Location |
|-------|---------------|----------|
| **Model** | Data structures, state shape, persistence | `models/` |
| **View** | Pure UI components, no business logic | `components/` |
| **Controller** | Business logic, state management, orchestration | `contexts/` |

## Recommended Structure

```
src/
├── contexts/brainBreak/             # State management
│   ├── index.ts                     # Public exports
│   ├── BrainBreakStateContext.ts    # State context + hook
│   ├── BrainBreakActionsContext.ts  # Actions context + hook
│   ├── BrainBreakProvider.tsx       # Combined provider
│   ├── reducer.ts                   # Single combined reducer
│   ├── initialState.ts              # Initial state factory
│   └── actions.ts                   # Action types
│
├── components/BrainBreak/           # UI components
├── custom-hooks/                    # Business logic hooks
└── models/BrainBreak/               # Types and constants
```

## State Consolidation

### Consolidated State Shape

```typescript
interface BrainBreakState {
  // Modal UI state (local to survey flow)
  modal: {
    step: 1 | 2;
    confidenceValue: number;
    emotionValue: EmotionPickerValue | null;
    showCountdown: boolean;
    countdown: number;
    isCountdownActive: boolean;
    pendingTransition: { type: 'step' | 'countdown'; delay: number } | null;
  };

  // App-level state (persistence, eligibility, tracking)
  app: {
    isModalOpen: boolean;
    showTracker: boolean;
    triggerPosition: { x: number; y: number } | null;
    currentPlacement: BrainBreakPlacement | null;
    hasSeenBrainBreak: boolean;
    isEligible: boolean;
    qualifiedPlacements: Record<BrainBreakPlacement, boolean>;
    cooldownData: CooldownData | undefined;
    userId: string | null;
  };
}
```

### Action Types (Discriminated Union)

```typescript
type BrainBreakAction =
  | { type: 'MODAL/SET_STEP'; payload: 1 | 2 }
  | { type: 'MODAL/SET_CONFIDENCE'; payload: number }
  | { type: 'MODAL/SET_EMOTION'; payload: EmotionPickerValue | null }
  | { type: 'MODAL/START_COUNTDOWN' }
  | { type: 'MODAL/TICK_COUNTDOWN' }
  | { type: 'MODAL/RESET' }
  | { type: 'APP/SHOW_MODAL'; payload: { position: Position; placement: BrainBreakPlacement; callback?: () => void } }
  | { type: 'APP/CLOSE_MODAL' }
  | { type: 'APP/MARK_AS_VIEWED' }
  | { type: 'APP/QUALIFY_PLACEMENT'; payload: BrainBreakPlacement }
  | { type: 'APP/SET_COOLDOWN_DATA'; payload: CooldownData | undefined }
  | { type: 'APP/RESET_STATE' };
```

## React Best Practices Applied

### 1. Split State and Dispatch into Separate Contexts

```typescript
const BrainBreakStateContext = createContext<BrainBreakState | null>(null);
const BrainBreakDispatchContext = createContext<Dispatch<BrainBreakAction> | null>(null);

export function BrainBreakProvider({ children }) {
  const [state, dispatch] = useReducer(brainBreakReducer, initialState);

  return (
    <BrainBreakStateContext value={state}>
      <BrainBreakDispatchContext value={dispatch}>
        {children}
      </BrainBreakDispatchContext>
    </BrainBreakStateContext>
  );
}
```

**Benefits:**
- Components that only dispatch don't re-render when state changes
- Components that only read state don't re-render when dispatch changes
- Granular subscription control

### 2. Custom Hooks for Context Consumption

```typescript
export function useBrainBreakState(): BrainBreakState {
  const context = useContext(BrainBreakStateContext);
  if (!context) throw new Error('Must be used within BrainBreakProvider');
  return context;
}

export function useBrainBreakDispatch(): Dispatch<BrainBreakAction> {
  const context = useContext(BrainBreakDispatchContext);
  if (!context) throw new Error('Must be used within BrainBreakProvider');
  return context;
}
```

### 3. Memoize Context Values

```typescript
export function BrainBreakProvider({ children }) {
  const [state, dispatch] = useReducer(brainBreakReducer, initialState);

  const stateValue = useMemo(() => ({
    // Selective state exposure
    isModalOpen: state.app.isModalOpen,
    step: state.modal.step,
    // ...
  }), [/* deps */]);

  const actions = useMemo(() => ({
    showBrainBreak: (position, callback, placement) => {
      dispatch({ type: 'APP/SHOW_MODAL', payload: { position, callback, placement } });
    },
    // ...
  }), []);

  return (
    <BrainBreakStateContext value={stateValue}>
      <BrainBreakActionsContext value={actions}>
        {children}
      </BrainBreakActionsContext>
    </BrainBreakStateContext>
  );
}
```

## Implementation Phases

| Phase | Work |
|-------|------|
| **1** | Create `contexts/brainBreak/` directory |
| **2** | Migrate state management to new contexts |
| **3** | Update models (types and constants) |
| **4** | Migrate business logic hooks |
| **5** | Update components to use new hooks |
| **6** | Update main app provider |

## Success Criteria

- [ ] All functionality works identically to before
- [ ] No imports break (backward compatibility)
- [ ] All tests pass
- [ ] TypeScript compilation succeeds
- [ ] Clear separation: Models have no UI, Views have no business logic
- [ ] Uses separate State/Actions contexts
- [ ] Custom hooks exported for consuming components
- [ ] Context values properly memoized

## Key Concepts

- [[mvc-pattern]] — Model-View-Controller separation
- [[useReducer]] — Complex state management
- [[split-contexts]] — Performance optimization pattern
- [[discriminated-unions]] — Type-safe actions
- [[custom-hooks]] — Encapsulate context consumption
