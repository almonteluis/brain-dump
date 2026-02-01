---
description: React hooks are functions that let functional components use state and lifecycle features, replacing class components with a simpler composable pattern.
tags: #react #hooks #overview #functional-components
date: 2026-01-31
---

# Hooks Encapsulate Stateful Logic in Functional Components

React hooks are functions that let you "hook into" React state and lifecycle features from function components.

## Rules of Hooks

1. Only call hooks at the top level
2. Only call hooks from React functions
3. Use the exhaustive-deps ESLint rule
4. Name custom hooks with use prefix

## Hook Categories

| Category | Hooks | Purpose |
|----------|-------|---------|
| **State** | useState, useReducer | Manage state |
| **Effects** | useEffect, useLayoutEffect | Side effects |
| **Context** | useContext | Access context |
| **Performance** | useMemo, useCallback | Optimize renders |
| **Refs** | useRef, useImperativeHandle | DOM access |

## Related Notes

- [[use-state.md]] - Component state management
- [[use-effect.md]] - Side effects and lifecycle
- [[custom-hooks.md]] - Creating reusable hooks
