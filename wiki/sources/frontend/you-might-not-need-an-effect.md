---
description: React documentation on removing unnecessary Effects and using better patterns
tags: ["source", "react", "useEffect", "best-practices", "performance"]
sources: ["You Might Not Need an Effect – React.md"]
created: 2026-04-09
updated: 2026-04-09
---

# You Might Not Need an Effect

**Source:** raw/You Might Not Need an Effect – React.md
**Original:** https://react.dev/learn/you-might-not-need-an-effect
**Date ingested:** 2026-04-09
**Type:** official documentation
**Status:** ⚠️ Source file appears truncated (incomplete capture)

## Summary

React's official guide on identifying and removing unnecessary Effects. Effects are an escape hatch from the React paradigm for synchronizing with external systems—not for data transformation or handling user events.

## Key Claims

- Effects are for external system synchronization (non-React widgets, network, browser DOM)
- If no external system is involved, you shouldn't need an Effect
- Removing unnecessary Effects makes code easier to follow, faster, and less error-prone
- Modern frameworks provide more efficient data fetching than writing Effects directly

## When You DON'T Need Effects

### 1. Transforming Data for Rendering

❌ **Avoid:** State + Effect for derived data
```jsx
// 🔴 Avoid: redundant state and unnecessary Effect
const [fullName, setFullName] = useState('');
useEffect(() => {
  setFullName(firstName + ' ' + lastName);
}, [firstName, lastName]);
```

✅ **Do:** Calculate during render
```jsx
// ✅ Good: calculated during rendering
const fullName = firstName + ' ' + lastName;
```

**Why:** Avoids extra render passes with stale values and prevents state variables from getting out of sync.

### 2. Handling User Events

❌ **Avoid:** Using Effects to respond to user actions

✅ **Do:** Handle in event handlers (onClick, onSubmit)

**Why:** By the time an Effect runs, you don't know what the user did. Event handlers know exactly what happened.

### 3. Caching Expensive Calculations

❌ **Avoid:** State + Effect to cache computations

✅ **Do:** Use `useMemo` for expensive calculations (>1ms)
```jsx
const visibleTodos = useMemo(
  () => getFilteredTodos(todos, filter),
  [todos, filter]
);
```

**Note:** React Compiler will automatically memoize in many cases, eliminating manual `useMemo`.

## When You DO Need Effects

- Synchronizing with external systems (jQuery widgets, browser APIs)
- Fetching data (though framework data fetching is preferred)
- Connecting to non-React code

## Concepts Covered

- [[react-effects]] — Escape hatch for external synchronization
- [[derived-state]] — Computing values from props/state without Effects
- [[useMemo]] — Caching expensive pure calculations
- [[event-handlers]] — Proper place for user event logic
- [[react-rendering]] — Render cycle and state updates
- [[react-compiler]] — Auto-memoization coming to React

## Related

- [[react-patterns]] — React best practices from Airbnb
- [[performance-patterns]] — Frontend optimization patterns
- [[relay]] — Data fetching with automatic caching

## See Also

- Official React docs: [Thinking in React](https://react.dev/learn/thinking-in-react#step-3-find-the-minimal-but-complete-representation-of-ui-state)
- React Compiler: [Auto-memoization](https://react.dev/learn/react-compiler)
