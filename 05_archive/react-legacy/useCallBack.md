---
description: useCallback is a React Hook that caches (memoizes) a function definition between re-renders. It's particularly useful for optimizing performance when passing callbacks to optimized child components that rely on reference equality to prevent unnecessary renders.
tags: ["hooks", "optimization", "performance", "react"]
---

# useCallback Hook

## Overview

## Memoization


> useCallback is a React Hook that caches (memoizes) a function definition between re-renders. It's particularly useful for optimizing performance when passing callbacks to optimized child components that rely on reference equality to prevent unnecessary renders.

#### Code Example:
```javascript
function ProductPage({ productId, referrer }) {
  // Basic useCallback
  const handleSubmit = useCallback((orderDetails) => {
    post('/product/' + productId + '/buy', {
      referrer,
      orderDetails,
    });
  }, [productId, referrer]); // Dependency array

  // With memo
  return (
    <MemoizedChild 
      onSubmit={handleSubmit}
    />
  );
}

// Usage with state updater
function TodoList() {
  const [todos, setTodos] = useState([]);
  
  const handleAddTodo = useCallback((text) => {
    setTodos(prev => [...prev, { id: Date.now(), text }]);
  }, []); // Empty dependency array when using updater pattern
}
```

#### Key Points:
* Only useful when passing callbacks to optimized child components (using memo)
* Takes two arguments: callback function and dependency array
* Returns memoized function that only changes if dependencies change
* Should be used with memo or custom hooks that expect stable callbacks
* Helps prevent infinite loops in [[useEffect]] dependencies

#### Common Use Cases:
* Optimizing child component re-renders
* Event handlers passed to memoized components
* Callbacks in dependency arrays of other hooks
* Custom hooks that return callbacks

#### When NOT to Use:
- Simple component renders
- Functions not passed as props
- Non-memoized components
- When function is only used internally
#### References:
* [React Official Docs - useCallback](https://react.dev/reference/react/useCallback)
* [Kent C. Dodds - When to useMemo and useCallback](https://kentcdodds.com/blog/usememo-and-usecallback)
* [Dan Abramov - A Complete Guide to useCallback](https://overreacted.io/a-complete-guide-to-usecallback/)