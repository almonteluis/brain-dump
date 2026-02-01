---
description: useEffect is a React hook for handling side effects like data fetching, subscriptions, or DOM manipulation, running after renders and optionally cleaning up before component unmount.
tags: ["UseEffect"]
---
#UseEffect 

> - [1 ] In React, `[[useEffect]]` is a hook that ==allows you to perform "side effects" within a functional component==, meaning actions that go beyond the standard rendering process, like fetching data from an API, setting up event listeners, updating the DOM directly, or managing subscriptions, ==essentially letting you interact with the outside world from within your component==; it is typically used to execute code after a component has rendered and can be controlled to run only when specific dependencies change using a dependency array.

## Key Points
```javascript
// 1. Basic Structure
useEffect(() => {
  // Effect code (runs after render)
  return () => {
    // Cleanup code (runs before next effect or unmount)
  };
}, [dependencies]); // Dependency array
```

``` jsx

// 2. Common Use Cases
// On Mount (ComponentDidMount)
useEffect(() => {
  // Runs once after initial render
}, []);


// On Update (ComponentDidUpdate)
useEffect(() => {
  // Runs on every render
});

// With Dependencies
useEffect(() => {
  // Runs when count changes
}, [count]);

// Cleanup (ComponentWillUnmount)
useEffect(() => {
  return () => {
    // Cleanup code
  };
}, []);
```

### Must Remember
- Handles side effects in functional components
- Runs after render
- Replaces lifecycle methods
- Cleanup function prevents memory leaks
- Empty dependency array = run once
- No dependency array = run every render
- Including dependencies prevents stale closures

[[UseEffect Detailed Examples]]
[[Common Patterns for useEffect]]

## Best Practices

### Dependencies
```javascript
// Include all values used from props/state
function Example({ id, query }) {
  useEffect(() => {
    fetchData(id, query);
  }, [id, query]); // Both dependencies required
}
```

### Cleanup
```javascript
useEffect(() => {
  const timer = setInterval(() => {
    // Do something
  }, 1000);

  return () => clearInterval(timer);
}, []);
```

### Performance
```javascript
// Avoid unnecessary re-renders
const memoizedCallback = useCallback(() => {
  doSomething(a, b);
}, [a, b]);

useEffect(() => {
  doSomething(memoizedCallback);
}, [memoizedCallback]);
```

### Error Handling
```javascript
useEffect(() => {
  try {
    // Effect code
  } catch (error) {
    // Handle errors
  }

  return () => {
    try {
      // Cleanup code
    } catch (error) {
      // Handle cleanup errors
    }
  };
}, []);
​​​​
```

[[useEffect]]
