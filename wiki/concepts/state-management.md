---
description: State management — patterns for handling application state in React, from local to global
tags: ["react", "state", "redux", "relay", "zustand", "concept"]
created: 2026-04-23
---

# State Management

State management is how an application stores, updates, and shares data across components. The key insight: not all state is the same. Choosing the right tool for each type of state prevents over-engineering.

## State Categories

| Type | Scope | Persistence | Tool |
|------|-------|-------------|------|
| **UI state** | Component-local | Session | `useState`, `useReducer` |
| **Shared UI** | Cross-component | Session | Context, Zustand |
| **Server state** | Async, cached | Varies | Relay, React Query, SWR |
| **URL state** | Global | Bookmarkable | Router params |
| **Form state** | Local/section | Session | Controlled components, Formik |

## Decision Framework

```
Is it server data?
  → Yes: Use Relay (GraphQL) or React Query (REST)
  → No: Is it shared across components?
    → Yes: How many consumers?
      → 2-3 nearby: Lift state / Context
      → Many / distant: Zustand or Redux
    → No: useState / useReducer
```

## Common Solutions

### Local State
```tsx
const [isOpen, setIsOpen] = useState(false);
```
Best for: Toggle states, form inputs, component-specific data.

### Context + Reducer — see [[state-context-reducer-pattern]]
```tsx
const [state, dispatch] = useReducer(reducer, initialState);
```
Best for: Medium-complexity shared state, form wizards, multi-step flows.

### Redux
Best for: Large apps with serializable state, time-travel debugging, middleware needs.
See [[redux-vs-relay]] for the Redux vs Relay decision.

### Relay
Best for: GraphQL-backed apps where server state is the primary concern.
See [[relay]] for the full framework overview.

### Zustand
Best for: Lightweight global state without boilerplate. Popular for React Native and smaller apps.

## Anti-Patterns

- **Global everything** — Not all state needs to be global
- **Prop drilling** — Passing state through 5+ component layers
- **Duplicate state** — Storing the same data in multiple places
- **Derived state in state** — Computing values that could be `useMemo`
- **Server state in Redux** — Use a dedicated data fetching library instead

## Related

- [[state-context-reducer-pattern]] — Two-Context pattern for performant React state
- [[redux-vs-relay]] — Architecture comparison for state management
- [[data-colocation]] — Keeping data near where it's used
- [[nc-frontend-architecture]] — Production Redux + Relay + Context architecture
- [[brainbreak-mvc-refactor]] — Migrating from useState to Redux for traceability
