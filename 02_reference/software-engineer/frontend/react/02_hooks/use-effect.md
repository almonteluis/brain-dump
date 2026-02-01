---
description: useEffect handles side effects in functional components with dependency-based execution control and cleanup support, replacing class lifecycle methods.
tags: #react #hooks #use-effect #side-effects #lifecycle
date: 2026-01-31
---

# useEffect Handles Side Effects After Renders

useEffect is React's answer to side effects in functional components — data fetching, subscriptions, DOM manipulation.

## Dependency Array Patterns

| Pattern | Behavior |
|---------|----------|
| `useEffect(() => {}, [])` | Runs once on mount |
| `useEffect(() => {}, [dep])` | Runs when dep changes |
| `useEffect(() => {})` | Runs every render |

## Data Fetching Pattern

```javascript
useEffect(() => {
  let mounted = true;

  const fetchData = async () => {
    const data = await fetch(url);
    if (mounted) setData(data);
  };

  fetchData();
  return () => { mounted = false; };
}, [url]);
```

## Related Notes

- [[../01_fundamentals/component-lifecycle.md]] - Lifecycle comparison
- [[hooks-best-practices.md]] - Common patterns
