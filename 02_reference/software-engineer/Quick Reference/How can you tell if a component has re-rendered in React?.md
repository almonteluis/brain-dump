---
description: Detect React component re-renders using React DevTools Profiler, console logs in render, or the useTraceUpdate hook to track component updates.
tags: ["debugging", "interview", "performance", "react", "rendering"]
---

# Detecting Re-renders

## Techniques

#react #debugging #performance #rendering #interview

> To detect component re-renders in React, you can use several debugging techniques such as the React DevTools profiler, console.log in the component body, or custom hooks. Understanding when components re-render is crucial for optimizing performance and preventing unnecessary renders.

#### Code Example:
```javascript
// Using console.log
function DetectRender({ value }) {
  console.log('Component rendered:', value);
  return <div>{value}</div>;
}

// Using custom hook
function useRenderCount() {
  const count = useRef(0);
  useEffect(() => {
    count.current++;
    console.log('Render count:', count.current);
  });
  return count.current;
}

// Using both
function TrackedComponent({ data }) {
  const renderCount = useRenderCount();

  return (
    <div>
      <p>Render count: {renderCount}</p>
      <p>Data: {data}</p>
    </div>
  );
}
```

#### Key Points:
* React DevTools Profiler shows render timings and reasons
* Components re-render when props or state change
* [[useEffect]] runs after each render
* [[React.memo]] can prevent unnecessary re-renders​​​​​​​​​​​​​​​​