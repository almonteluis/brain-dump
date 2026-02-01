---
description: React.memo is a higher-order component that memoizes functional components using shallow prop comparison to prevent unnecessary re-renders.
tags: ["comparison", "interview", "memo", "memoization", "optimization", "performance", "props", "react", "rendering"]
---
#react #optimization #memo #performance #interview

> React.memo is a higher-order component (HOC) that memoizes a component to prevent unnecessary re-renders if its props haven't changed. It performs a shallow comparison of props to determine if a re-render is needed.

```javascript
// Basic Usage
const MemoizedComponent = React.memo(function MyComponent({ prop1, prop2 }) {
  return (
    <div>
## Overview
      <h1>{prop1}</h1>
      <h2>{prop2}</h2>
    </div>
  );
});

// Custom Comparison
const MemoizedWithComparison = React.memo(MyComponent, 
  (prevProps, nextProps) => {
    return prevProps.id === nextProps.id;
  }
);
```

## Example
#### Key Points:
* Only memoize components that re-render frequently with same props
* Uses shallow comparison by default (can provide custom comparison)
* Don't use for components that always render with different props
* Not a solution for components that rely on parent state/context changes

Additional Tags:
#memoization #props #comparison #rendering​​​​​​​​​​​​​​​​