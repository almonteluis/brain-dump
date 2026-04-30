---
description: "Code splitting patterns for lazy loading JavaScript"
tags: [software-engineering, performance, optimization, react]
sources: [Code splitting.md]
created: 2026-04-09
updated: 2026-04-09
---

# Code Splitting

**Source:** raw/02_reference/software-engineer/frontend/Patterns/Code splitting.md
**Date ingested:** 2026-04-09
**Type:** technical reference

## Summary

Code splitting is an optimization technique that divides JavaScript bundles into smaller chunks loaded on-demand, reducing initial load times and enabling lazy loading.

## Key Claims

- Reduces initial bundle size significantly
- Enables lazy loading of components/routes
- Improves initial page load time
- Built into modern bundlers (webpack, Vite, Rollup)
- Works with dynamic imports

## Splitting Patterns

### Route-Based Splitting
```javascript
// Before: All routes in main bundle
import HomePage from "./pages/Home";

// After: Each route is a separate chunk
const HomePage = React.lazy(() => import("./pages/Home"));
```

### Component-Based Splitting
```javascript
const HeavyChart = React.lazy(() => import("./components/HeavyChart"));

function Dashboard() {
  return (
    <Suspense fallback={<LoadingSpinner />}>
      <HeavyChart />
    </Suspense>
  );
}
```

### Dynamic Imports
```javascript
const loadData = async () => {
  const module = await import("./heavyCalculation");
  const result = module.default(data);
  setResult(result);
};
```

## Comparison

| Pattern | Use Case | Load Time | Complexity |
|---------|----------|-----------|------------|
| Route | Page transitions | Initial | Low |
| Component | Large UI elements | On demand | Medium |
| Dynamic Import | Heavy computations | User action | High |

## Best Practices

1. Split at route level first
2. Identify large dependencies
3. Lazy load below-the-fold content
4. Use bundle analyzer to identify split points
5. Implement proper loading states with Suspense
6. Consider network conditions

## Common Pitfalls

- Missing Suspense wrapper causes errors
- Dynamic imports used immediately (defeats purpose)
- Over-splitting creates too many small chunks

## Concepts Covered

- [[code-splitting]]
- [[lazy-loading]]
- [[react-suspense]]
- [[performance-patterns]]
