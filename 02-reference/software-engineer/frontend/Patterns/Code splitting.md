---
description: Notes about Code splitting.
---


description: Code splitting improves React application performance by dividing JavaScript bundles into chunks that load on-demand, reducing initial load times and enabling lazy loading.
tags: [javascript, performance, optimization, fundamentals, priority/2, react, loading-strategy, webpack]
---

# Code Splitting

Parent: [[👨‍💻JavaScript Roadmap]]

Introduction:
Code splitting is an optimization technique that allows you to split your JavaScript bundle into smaller chunks, loading code only when needed. This improves initial load time and application performance.

Knowledge Points:

- [[Dynamic Imports]]

  - import() syntax
  - Route-based splitting
  - Component-based splitting

- [[Bundle Analysis]]

  - Webpack bundle analyzer
  - Performance budgets
  - Chunk optimization

- [[Lazy Loading]]
  - React.lazy()
  - Suspense integration
  - Error boundaries

## Essential Concepts

- [[Code splitting]]

  - Dynamic imports
  - Chunk generation
  - Load-time optimization

- [[Route-Based Splitting]]

  - Page-level code splitting
  - Route configuration
  - Prefetching strategies

- [[Component-Level Splitting]]

  - Lazy loading components
  - Loading boundaries
  - Performance metrics

- [[Advanced Splitting Patterns]]
  - Micro-frontends
  - Module federation
  - Shared dependencies

## Definition

> Code splitting is a technique in React and JavaScript that allows you to split your code into various bundles which can then be loaded on demand or in parallel, improving application performance by reducing the initial bundle size.

## Key Points

- Reduces initial bundle size
- Enables lazy loading of components/routes
- Improves initial page load time
- Built into Create React App
- Supported by modern bundlers (webpack, Vite)
- Works with dynamic imports

## How Code Splitting Works

### 1. Route-based Splitting

```javascript
// Before splitting
import HomePage from "./pages/Home";
import AboutPage from "./pages/About";

// After splitting
const HomePage = React.lazy(() => import("./pages/Home"));
const AboutPage = React.lazy(() => import("./pages/About"));
```

### 2. Component-based Splitting

```javascript
// Before splitting
import HeavyChart from "./components/HeavyChart";

// After splitting
const HeavyChart = React.lazy(() => import("./components/HeavyChart"));

function Dashboard() {
  return (
    <Suspense fallback={<LoadingSpinner />}>
      <HeavyChart />
    </Suspense>
  );
}
```

### 3. Dynamic Imports

```javascript
// On-demand loading
const loadData = async () => {
  const module = await import("./heavyCalculation");
  const result = module.default(data);
  setResult(result);
};
```

## Best Practices

1. Split at route level first
2. Identify large dependencies
3. Lazy load below-the-fold content
4. Use bundle analyzer to identify split points
5. Implement proper loading states
6. Consider network conditions

## Common Pitfalls

```javascript
// Example 1: Missing Suspense wrapper
const LazyComponent = React.lazy(() => import("./Component"));
// ❌ Will throw error
return <LazyComponent />;

// ✅ Correct usage
return (
  <Suspense fallback={<Loading />}>
    <LazyComponent />
  </Suspense>
);

// Example 2: Incorrect dynamic import
// ❌ Still included in main bundle
const Component = import("./Component");

// ✅ Correct dynamic import
const Component = React.lazy(() => import("./Component"));
```

## Splitting Patterns Comparison

| Pattern        | Use Case           | Load Time   | Complexity |
| -------------- | ------------------ | ----------- | ---------- |
| Route          | Page transitions   | Initial     | Low        |
| Component      | Large UI elements  | On demand   | Medium     |
| Dynamic Import | Heavy computations | User action | High       |

## Visual Diagrams

### 1. Bundle Splitting Process

```
Before Splitting:
[main.js (2MB)]

After Splitting:
[main.js (500KB)]
  ├─[home.chunk.js (300KB)]
  ├─[about.chunk.js (400KB)]
  └─[dashboard.chunk.js (800KB)]
```

### 2. Loading Timeline

```
[Initial Load]     [On Demand]       [User Action]
main.js ──────►    route.chunk.js    feature.chunk.js
                   ├─ Suspense
                   └─ Fallback
```

### 3. Code Splitting Decision Tree

```
Is it a route? ──Yes──► Route-based splitting
     │
     No
     │
Is it large? ──Yes──► Component splitting
     │
     No
     │
User action? ──Yes──► Dynamic import
```

## Personal Notes Section

### Understanding Checklist

- [ ] I can identify when to use code splitting
- [ ] I understand the difference between route and component splitting
- [ ] I can implement [[Suspense]] boundaries correctly
- [ ] I know how to analyze bundle size
- [ ] I can handle loading states properly

### Practice Area

```

```
