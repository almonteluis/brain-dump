---
description: Two-Context pattern for performant React state management with useReducer
tags: ["react", "context", "reducer", "performance", "state-management"]
created: 2026-04-09
updated: 2026-04-09
---

# State-Context-Reducer Pattern

Separating state and actions into two contexts for surgical re-renders and better component performance.

## The Problem

Single context with state + actions:
```typescript
const Context = createContext({ state, actions });

// Every state change re-renders ALL consumers
// Even those only using actions
```

## The Solution: Two Contexts

```typescript
const StateContext = createContext<State | null>(null);
const ActionsContext = createContext<Actions | null>(null);

function Provider({ children }) {
  const [state, dispatch] = useReducer(reducer, initialState);

  // Stable reference - dispatch never changes
  const actions = useMemo(() => ({
    showModal: () => dispatch({ type: 'show_modal' }),
    closeModal: () => dispatch({ type: 'close_modal' }),
  }), []);

  return (
    <StateContext.Provider value={state}>
      <ActionsContext.Provider value={actions}>
        {children}
      </ActionsContext.Provider>
    </StateContext.Provider>
  );
}
```

## Granular Hooks

```typescript
// Re-renders on any state change
export const useState = () => {
  const ctx = useContext(StateContext);
  if (!ctx) throw new Error('Must be used within Provider');
  return ctx;
};

// Never re-renders (stable reference)
export const useActions = () => {
  const ctx = useContext(ActionsContext);
  if (!ctx) throw new Error('Must be used within Provider');
  return ctx;
};

// Specific subscription
export const useIsModalOpen = () => {
  const state = useContext(StateContext);
  return state?.isModalOpen;
};
```

## Usage Patterns

```typescript
// Component only needs actions - ZERO re-renders
function ModalTrigger() {
  const { showModal } = useActions();
  return <button onClick={showModal}>Open</button>;
}

// Component needs specific state - targeted re-render
function ModalStatus() {
  const isOpen = useIsModalOpen();
  return <Badge>{isOpen ? 'Open' : 'Closed'}</Badge>;
}

// Component needs everything
function ModalController() {
  const state = useState();
  const actions = useActions();
  // ...
}
```

## Key Benefits

| Pattern | Re-render Behavior |
|---------|-------------------|
| Single context | All consumers on any state change |
| Two contexts | State consumers only |
| Granular hooks | Specific property changes only |

## Reducer Structure

```typescript
interface State {
  isModalOpen: boolean;
  currentPlacement: string | null;
  qualifiedPlacements: Record<string, boolean>;
}

type Action =
  | { type: 'show_modal'; payload: { placement: string } }
  | { type: 'close_modal' }
  | { type: 'qualify_placement'; payload: string };

function reducer(state: State, action: Action): State {
  switch (action.type) {
    case 'show_modal':
      return {
        ...state,
        isModalOpen: true,
        currentPlacement: action.payload.placement,
      };
    // ...
  }
}
```

## Backward Compatibility

Keep legacy hook working:
```typescript
export const useFeature = () => {
  const state = useState();
  const actions = useActions();
  return { ...state, ...actions };
};
```

## When to Use

✅ **Good for**:
- Complex state with many consumers
- Performance-critical UIs
- Shared feature state (auth, modals, etc.)

❌ **Overkill for**:
- Simple state (useState)
- Few consumers
- Local component state

## Related

- [[teame-218-brainbreak-refactor]] — Real-world implementation
- [[teame-218-brainbreak-postmortem]] — Full post-mortem with hook architecture
- [[brainbreak-context-cleanup-implementation]] — Cooldown DB migration plan
- [[two-context-pattern]] — React performance pattern
- [[use-reducer]] — Reducer fundamentals
- [[context-performance]] — Context optimization

## Resources

- [Separating Actions from State](https://stevekinney.com/courses/react-performance/separating-actions-from-state-two-contexts) — Steve Kinney
- [Performant React with Context](https://www.developerway.com/posts/how-to-write-performant-react-apps-with-context) — DeveloperWay
