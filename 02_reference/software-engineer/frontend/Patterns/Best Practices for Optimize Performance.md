---
description: Notes about Best Practices for Optimize Performance.
tags: ["best-practices", "debounce", "optimization", "performance", "performance-optimization", "react"]
---

## Best Practices

### Avoiding Re-renders
```javascript
// Use fragments to avoid extra DOM nodes
function Component() {
  return (
    <>
      <Child1 />
      <Child2 />
    </>
  );
}

// Keep component state as local as possible
function ParentComponent() {
  const [localState, setLocalState] = useState();
  return <ChildComponent localState={localState} />;
}
```

### Event Handlers
```javascript
function OptimizedComponent() {
  // Memoize handlers that are passed as props
  const handleClick = useCallback(() => {
    // Handle click
  }, []); // Empty deps if no dependencies

  return <button onClick={handleClick}>Click me</button>;
}
```

### Data Structure Optimization
```javascript
// Use proper keys for lists
function GoodList({ items }) {
  return (
    <ul>
      {items.map(item => (
        <li key={item.id}>{item.name}</li>
      ))}
    </ul>
  );
}

// Use indexed objects for O(1) lookups
const itemsById = useMemo(() => {
  return items.reduce((acc, item) => {
    acc[item.id] = item;
    return acc;
  }, {});
}, [items]);
```

### Debouncing and Throttling
```javascript
function SearchComponent() {
  const debouncedSearch = useCallback(
    debounce((query) => {
      // Perform search
    }, 300),
    []
  );

  return (
    <input 
      onChange={(e) => debouncedSearch(e.target.value)} 
    />
  );
}
```

### Web Workers for Heavy Computation
```javascript
function HeavyComputation() {
  const [result, setResult] = useState(null);

  useEffect(() => {
    const worker = new Worker('worker.js');
    worker.onmessage = (e) => {
      setResult(e.data);
    };
    return () => worker.terminate();
  }, []);
}
```

### [[Bundle optimization]]
```javascript
// Dynamic imports
const importComponent = async () => {
  const { default: Component } = await import('./Component');
  return Component;
};
```

