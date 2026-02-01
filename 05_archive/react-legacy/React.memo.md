---
description: Notes about React.memo.
tags: #react #performance #optimization #memoization #components
---

# React.memo

## Overview

## Usage



description: React.memo is a higher-order component that prevents unnecessary re-renders when props haven't changed, optimizing performance for functional components.
---

![[Explain the concept of "React.memo" component.]]

React.memo is a higher-order component that wraps functional components to prevent unnecessary re-renders.

## When to Use

Use React.memo when:
- Component renders the same output for the same props
- Component renders frequently with expensive calculations
- Component is pure (no side effects based on props)

## Example

```javascript
const ExpensiveComponent = React.memo(function ExpensiveComponent({ data }) {
  // Expensive calculation based on data
  const result = processData(data);
  return <div>{result}</div>;
});
```

React.memo will skip re-rendering if `data` prop hasn't changed, even if the parent re-renders.

