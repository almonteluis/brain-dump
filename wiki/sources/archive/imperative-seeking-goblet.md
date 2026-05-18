---
description: "BrainBreak MVC Refactor Plan"
tags: ['research']
raw_file: "imperative-seeking-goblet.md"
created: 2026-05-17
---

# BrainBreak MVC Refactor Plan

## Context

The BrainBreak feature currently has state management split between the context provider (`brainBreakContext.tsx`) and a local reducer in the modal (`BrainBreakModalState.ts`). Business logic is scattered across `utils/brainBreakCooldown.ts` and `models/RecordingService.ts`. This makes the architecture hard to follow and test.

The goal is to refactor to a clean MVC pattern:
- **Model**: Data structures, state shape, and persistence logic
- **View**: Pure UI components with no business logic
- **Controller**: Business logic, state management, and orchestration

## Current Architecture Analysis

### Model Layer (src/models/)
- `BrainBreak.ts` - Types, constants, interfaces
- `RecordingService.ts` - Recording service with business logic mixed in

### View Layer (src/components/BrainBreak/)
- `BrainBreakModal.tsx` - Modal with embedded state management
- `BrainBreakModalState.ts` - Local reducer (should move to controller)
- `BrainBreakSurveySteps.tsx` - Presentational component
- `ConfidenceSlider.tsx`, `EmotionPicker.tsx` - UI components
- `BrainBreakTracker.tsx`, `BrainBreakCountdown.tsx` - UI components

### Controller Layer (src/contexts/)
- `brainBreakContext.tsx` - Provider with state + actions + side effects
- `brainBreakReducer.ts` - Provider state reducer

### Utilities (src/utils/)
- `brainBreakCooldown.ts` - Cooldown logic (pure functions, should be in controller)

## Recommended Structure (React Best Practices - No features/ folder)

Following React's official useReducer + Context pattern, organized within existing directories:

```
src/
├── contexts/brainBreak/             # State management (React best practices)
│   ├── index.ts                     # Public exports (Provider, hooks)
│   ├── BrainBreakStateContext.ts    # State context + useBrainBreakState hook
│   ├── BrainBreakActionsContext.ts  # Actions context + useBrainBreakActions hook
│   ├── BrainBreakProvider.tsx       # Combined provider with useReducer
│   ├── reducer.ts                   # Single combined reducer
│   ├── initialState.ts              # Initial state factory
│   └── actions.ts                   # Action type definitions
│
├── components/BrainBreak/           # UI components (existing location)
│   ├── index.ts                     # Barrel export
│   ├── BrainBreakModal.tsx          # Updated to use new hooks
│   ├── BrainBreakSurveySteps.tsx
│   ├── ConfidenceSlider.tsx
│   ├── EmotionPicker.tsx
│   ├── BrainBreakCountdown.tsx
│   ├── BrainBreakTracker.tsx
│   ├── BrainBreakHeader.tsx
│   ├── BrainBreakBackground.tsx
│   ├── BrainBreakIcon.tsx
│   ├── AnimatedParticles.tsx
│   └── questionsConfig.ts
│
├── custom-hooks/                    # Business logic hooks (existing location)
│   ├── useBrainBreakRecording.ts    # Updated to use new state hooks
│   ├── useBrainBreakNavigation.ts   # Updated to use new state hooks
│   └── useCooldown.ts               # Moved from utils/
│
├── models/                          # Types and constants (existing location)
│   ├── BrainBreak.ts                # Re-export for backward compat
│   ├── BrainBreak/
│   │   ├── types.ts                 # Consolidated types
│   │   └── constants.ts             # BRAIN_BREAK_*, COOLDOWN_CONFIG
│   └── RecordingService.ts          # Keep as-is
│
└── utils/
    └── brainBreakCooldown.ts        # Re-export from custom-hooks/useCooldown.ts
```

## Implementation Plan

### Phase 1: Create contexts/brainBreak/ Directory
```bash
mkdir -p src/contexts/brainBreak
```

### Phase 2: Migrate State Management to contexts/brainBreak/
**Files to create:**
- `src/contexts/brainBreak/initialState.ts` - Initial state factory
- `src/contexts/brainBreak/actions.ts` - Action type definitions
- `src/contexts/brainBreak/reducer.ts` - Combined reducer (modal + app state)
- `src/contexts/brainBreak/BrainBreakStateContext.ts` - State context + useBrainBreakState hook
- `src/contexts/brainBreak/BrainBreakActionsContext.ts` - Actions context + useBrainBreakActions hook
- `src/contexts/brainBreak/BrainBreakProvider.tsx` - Combined provider (new main provider)
- `src/contexts/brainBreak/index.ts` - Public exports

**Files to deprecate (keep for backward compat):**
- `src/contexts/brainBreakContext.tsx` - Re-export from brainBreak/ (mark deprecated)
- `src/contexts/brainBreakReducer.ts` - Re-export from brainBreak/ (mark deprecated)

### Phase 3: Update Models (types and constants)
**Files to create:**
- `src/models/BrainBreak/types.ts` - Consolidated types from BrainBreak.ts
- `src/models/BrainBreak/constants.ts` - BRAIN_BREAK_*, COOLDOWN_CONFIG, TIMING

**Files to update:**
- `src/models/BrainBreak.ts` - Re-export from BrainBreak/ subdirectory

### Phase 4: Migrate Business Logic Hooks
**Files to update:**
- `src/custom-hooks/useBrainBreakRecording.ts` - Update to use new state hooks
- `src/custom-hooks/useBrainBreakNavigation.ts` - Update to use new state hooks
- `src/custom-hooks/useCooldown.ts` - Move logic from `utils/brainBreakCooldown.ts`

**Files to update (backward compat):**
- `src/utils/brainBreakCooldown.ts` - Re-export from custom-hooks/

### Phase 5: Update Components
**Files to update:**
- `src/components/BrainBreak/BrainBreakModal.tsx` - Use new `useBrainBreakState()` and `useBrainBreakActions()` hooks, remove local reducer
- `src/components/BrainBreak/index.ts` - Export new provider and hooks

**Files to delete:**
- `src/components/BrainBreak/BrainBreakModalState.ts` - Logic merged into contexts/brainBreak/reducer.ts

### Phase 6: Update Main App Provider
**Files to update:**
- `src/main.tsx` or provider setup file - Update to use new `BrainBreakProvider` from `contexts/brainBreak/`

## Detailed File Mappings

### Model Layer
| Current | New | Content |
|---------|-----|---------|
| `models/BrainBreak.ts` | `models/BrainBreak/types.ts` | All interfaces: `BrainBreakState`, `BrainBreakActions`, `BrainBreakMeta`, `CooldownData`, etc. |
| `models/BrainBreak.ts` | `models/BrainBreak/constants.ts` | `BRAIN_BREAK_FLAG_NAME`, `BRAIN_BREAK_PLACEMENTS`, `COOLDOWN_CONFIG`, `BRAIN_BREAK_TIMING` |
| `models/RecordingService.ts` | `models/BrainBreak/recording.ts` | `BrainBreakRecordingInput`, `RecordingResult`, `ObservationQueueItem` |

### Controller Layer
| Source | New Controller | Logic Extracted |
|--------|----------------|-----------------|
| `contexts/brainBreakReducer.ts` | `controllers/brainBreak/reducer.ts` | Provider state + actions |
| `components/BrainBreak/BrainBreakModalState.ts` | `controllers/brainBreak/reducer.ts` | Modal state + actions (merge with above) |
| `utils/brainBreakCooldown.ts` | `controllers/brainBreak/useCooldown.ts` | `checkCooldownEligibility`, `saveCooldownData` |
| `custom-hooks/useBrainBreakRecording.ts` | `controllers/brainBreak/useRecording.ts` | Recording hook logic |
| `models/RecordingService.ts` | `controllers/brainBreak/useRecording.ts` | `recordBrainBreak`, `buildObservationQueue` |
| `contexts/brainBreakContext.tsx` | `controllers/brainBreak/useBrainBreakController.ts` | State management, actions, side effects |

### View Layer
| Current | New | Changes |
|---------|-----|---------|
| `components/BrainBreak/BrainBreakModal.tsx` | `views/brainBreak/BrainBreakModal.tsx` | Remove `useReducer`, accept all state/props from controller |
| `components/BrainBreak/BrainBreakModalState.ts` | **DELETE** | Logic merged into controller reducer |
| `components/BrainBreak/BrainBreakSurveySteps.tsx` | `views/brainBreak/BrainBreakSurveySteps.tsx` | Move only, no changes |
| `components/BrainBreak/ConfidenceSlider.tsx` | `views/brainBreak/ConfidenceSlider.tsx` | Move only, no changes |
| `components/BrainBreak/EmotionPicker.tsx` | `views/brainBreak/EmotionPicker.tsx` | Move only, no changes |
| `components/BrainBreak/BrainBreakCountdown.tsx` | `views/brainBreak/BrainBreakCountdown.tsx` | Move only, no changes |
| `components/BrainBreak/BrainBreakTracker.tsx` | `views/brainBreak/BrainBreakTracker.tsx` | Move only, no changes |
| `components/BrainBreak/AnimatedParticles.tsx` | `views/brainBreak/AnimatedParticles.tsx` | Move only, no changes |
| `components/BrainBreak/BrainBreakBackground.tsx` | `views/brainBreak/BrainBreakBackground.tsx` | Move only, no changes |
| `components/BrainBreak/BrainBreakHeader.tsx` | `views/brainBreak/BrainBreakHeader.tsx` | Move only, no changes |
| `components/BrainBreak/BrainBreakIcon.tsx` | `views/brainBreak/BrainBreakIcon.tsx` | Move only, no changes |
| `components/BrainBreak/questionsConfig.ts` | `views/brainBreak/questionsConfig.ts` | Move only, no changes |

## State Consolidation

### Current Split State
**Provider State (brainBreakReducer.ts):**
```typescript
interface BrainBreakProviderState {
  isModalOpen: boolean;
  showTracker: boolean;
  triggerPosition: { x: number; y: number } | null;
  currentPlacement: BrainBreakPlacement | null;
  hasSeenBrainBreak: boolean;
  isEligible: boolean;
  qualifiedPlacements: Record<BrainBreakPlacement, boolean>;
  navigationCallback: (() => void) | null;
  countdownListener: (() => void) | null;
  cooldownData: CooldownData | undefined;
  userId: string | null;
}
```

**Modal State (BrainBreakModalState.ts):**
```typescript
interface BrainBreakModalState {
  step: 1 | 2;
  confidenceValue: number;
  emotionValue: EmotionPickerValue | null;
  showCountdown: boolean;
  countdown: number;
  isCountdownActive: boolean;
  pendingTransition: { type: 'step' | 'countdown'; delay: number } | null;
}
```

### Consolidated State (Following React Best Practices)
```typescript
interface BrainBreakState {
  // Modal UI state (local to the survey flow)
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

## Verification Steps

1. **Build verification:**
   ```bash
   npm run build
   ```

2. **Test verification:**
   ```bash
   npm test -- --testPathPattern=BrainBreak
   ```

3. **Type check:**
   ```bash
   npx tsc --noEmit
   ```

4. **Manual verification:**
   - BrainBreak modal opens correctly
   - Survey steps function (confidence → emotion)
   - Countdown displays and completes
   - Cooldown prevents same-day repeat
   - Placement qualification works
   - Recording sends observations

## Backward Compatibility

The existing `src/components/BrainBreak/index.ts` will be preserved as a compatibility layer:

```typescript
// src/components/BrainBreak/index.ts
/** @deprecated Import from 'views/brainBreak' instead */
export { BrainBreakModal } from '../../views/brainBreak/BrainBreakModal';
/** @deprecated Import from 'views/brainBreak' instead */
export { BrainBreakTracker } from '../../views/brainBreak/BrainBreakTracker';
// ... etc

// NEW: Import controllers from their location
export { useBrainBreakController } from '../../controllers/brainBreak';
```

## Risks and Mitigation

| Risk | Mitigation |
|------|------------|
| Import path breakage | Maintain re-export compatibility layer |
| State management bugs | Comprehensive test coverage before/after |
| Type errors | Incremental migration with tsc checks at each phase |
| Lost functionality | Feature parity checklist in verification |

## React Best Practices (from React.dev via Context7)

### 1. Split State and Dispatch into Separate Contexts
The recommended pattern to optimize performance and prevent unnecessary re-renders:

```typescript
// Two separate contexts - following React 2025 best practices
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
- Components that only need to dispatch don't re-render when state changes
- Components that only read state don't re-render when dispatch reference changes
- Granular subscription control

### 2. Custom Hooks for Context Consumption
Export custom hooks instead of raw context:

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
Use `useMemo` and `useCallback` to prevent unnecessary re-renders:

```typescript
export function BrainBreakProvider({ children }) {
  const [state, dispatch] = useReducer(brainBreakReducer, initialState);

  // Memoize state value
  const stateValue = useMemo(() => ({
    hasSeenBrainBreak: state.hasSeenBrainBreak,
    isEligible: state.isEligible,
    // ... other state
  }), [/* deps */]);

  // Memoize actions (or use dispatch directly)
  const actions = useMemo(() => ({
    showBrainBreak: (position, callback, placement) => {
      dispatch({ type: 'SHOW_MODAL', payload: { position, callback, placement } });
    },
    // ... other actions
  }), [/* deps */]);

  return (
    <BrainBreakStateContext value={stateValue}>
      <BrainBreakActionsContext value={actions}>
        {children}
      </BrainBreakActionsContext>
    </BrainBreakStateContext>
  );
}
```

### 4. Single Reducer vs Multiple Reducers
For BrainBreak's case with split state (provider + modal), React recommends:
- **Option A**: Single combined reducer (simpler, but larger)
- **Option B**: Keep separate reducers, compose providers (more modular)

Given BrainBreak's complexity, **Option A (single reducer)** is recommended but with clear state organization:

```typescript
interface BrainBreakState {
  // Modal UI state (local to modal)
  modal: {
    step: 1 | 2;
    confidenceValue: number;
    emotionValue: EmotionPickerValue | null;
    showCountdown: boolean;
    countdown: number;
    isCountdownActive: boolean;
    pendingTransition: { type: 'step' | 'countdown'; delay: number } | null;
  };

  // Provider/app-level state
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

### 5. File Structure Pattern (Existing Directories)
Following React's TaskApp example, organized in existing directories:

```
src/
├── contexts/brainBreak/             # NEW: Split context pattern
│   ├── index.ts                     # Public exports
│   ├── BrainBreakStateContext.ts    # State context + useBrainBreakState hook
│   ├── BrainBreakActionsContext.ts  # Actions context + useBrainBreakActions hook
│   ├── BrainBreakProvider.tsx       # Combined provider
│   ├── reducer.ts                   # Single combined reducer
│   ├── initialState.ts              # Initial state
│   └── actions.ts                   # Action type definitions
│
├── components/BrainBreak/           # EXISTING: UI components
│   ├── BrainBreakModal.tsx          # UPDATED: Use new hooks
│   └── ...
│
├── custom-hooks/                    # EXISTING: Business logic
│   ├── useBrainBreakRecording.ts    # UPDATED
│   ├── useBrainBreakNavigation.ts   # UPDATED
│   └── useCooldown.ts               # NEW (from utils/)
│
└── models/BrainBreak/               # EXISTING: Consolidated types
    ├── types.ts
    └── constants.ts
```

### 6. Provider Implementation Example

```typescript
// src/contexts/brainBreak/BrainBreakProvider.tsx
import { useReducer, useMemo } from 'react';
import { BrainBreakStateContext, BrainBreakActionsContext } from './contexts';
import { brainBreakReducer } from './reducer';
import { createInitialState } from './initialState';

interface BrainBreakProviderProps {
  children: React.ReactNode;
  userId: string | null;
  isEligible: boolean;
}

export function BrainBreakProvider({ children, userId, isEligible }: BrainBreakProviderProps) {
  const [state, dispatch] = useReducer(
    brainBreakReducer,
    createInitialState(isEligible, userId)
  );

  // Memoize actions to prevent unnecessary re-renders
  const actions = useMemo(() => ({
    showBrainBreak: (position: Position, callback?: () => void, placement?: BrainBreakPlacement) => {
      dispatch({ type: 'APP/SHOW_MODAL', payload: { position, callback, placement } });
    },
    closeModal: () => dispatch({ type: 'APP/CLOSE_MODAL' }),
    markAsViewed: () => dispatch({ type: 'APP/MARK_AS_VIEWED' }),
    qualifyPlacement: (placement: BrainBreakPlacement) => {
      dispatch({ type: 'APP/QUALIFY_PLACEMENT', payload: placement });
    },
    setConfidence: (value: number) => dispatch({ type: 'MODAL/SET_CONFIDENCE', payload: value }),
    setEmotion: (value: EmotionPickerValue | null) => dispatch({ type: 'MODAL/SET_EMOTION', payload: value }),
    submitConfidence: () => dispatch({ type: 'MODAL/SUBMIT_CONFIDENCE' }),
    startCountdown: () => dispatch({ type: 'MODAL/START_COUNTDOWN' }),
    tickCountdown: () => dispatch({ type: 'MODAL/TICK_COUNTDOWN' }),
    resetModal: () => dispatch({ type: 'MODAL/RESET' }),
  }), []);

  // Memoize state to allow selective subscription
  const stateValue = useMemo(() => ({
    // App state
    isModalOpen: state.app.isModalOpen,
    showTracker: state.app.showTracker,
    triggerPosition: state.app.triggerPosition,
    currentPlacement: state.app.currentPlacement,
    hasSeenBrainBreak: state.app.hasSeenBrainBreak,
    isEligible: state.app.isEligible,
    qualifiedPlacements: state.app.qualifiedPlacements,
    cooldownData: state.app.cooldownData,
    userId: state.app.userId,
    // Modal state
    step: state.modal.step,
    confidenceValue: state.modal.confidenceValue,
    emotionValue: state.modal.emotionValue,
    showCountdown: state.modal.showCountdown,
    countdown: state.modal.countdown,
    isCountdownActive: state.modal.isCountdownActive,
    pendingTransition: state.modal.pendingTransition,
  }), [state]);

  return (
    <BrainBreakStateContext.Provider value={stateValue}>
      <BrainBreakActionsContext.Provider value={actions}>
        {children}
      </BrainBreakActionsContext.Provider>
    </BrainBreakStateContext.Provider>
  );
}
```

## Success Criteria

- [ ] All BrainBreak functionality works identically to before
- [ ] No imports break in consuming code (backward compatibility)
- [ ] All tests pass
- [ ] TypeScript compilation succeeds
- [ ] Clear separation: Models have no UI, Views have no business logic, Controllers orchestrate
- [ ] Uses separate State/Actions contexts for performance optimization
- [ ] Custom hooks exported for consuming components
- [ ] Context values properly memoized with useMemo/useCallback

