---
description: Notes about Best Practices for Hooks.
---


description: Best practices for using React hooks properly, covering dependency management, cleanup patterns, and common pitfalls to avoid.
tags:
  - react
  - hooks
---

### Rules of Hooks
* Only call hooks at the top level
* Only call hooks from React functions
* Use the exhaustive-deps ESLint rule
* Name custom hooks with 'use' prefix

### Performance Optimization
* Use dependencies array correctly
* Memoize callbacks with useCallback
* Memoize expensive computations with [[useMemo]]
* Avoid premature optimization

### Common Patterns
```tsx
// Conditional effects
useEffect(() => {
  if (condition) {
    // Effect code
  }
}, [condition]);

// Async effects
useEffect(() => {
  let isSubscribed = true;

  const fetchData = async () => {
    const result = await api.getData();
    if (isSubscribed) {
      setData(result);
    }
  };

  fetchData();

  return () => {
    isSubscribed = false;
  };
}, []);
```​​​​​​​​​​​​​​​​