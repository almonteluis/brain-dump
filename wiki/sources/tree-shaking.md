---
description: "Tree shaking for dead code elimination in JavaScript bundles"
tags: [software-engineering, performance, optimization, bundling]
sources: [Tree Shaking.md]
created: 2026-04-09
updated: 2026-04-09
---

# Tree Shaking

**Source:** raw/02_reference/software-engineer/frontend/Patterns/Tree Shaking.md
**Date ingested:** 2026-04-09
**Type:** technical reference

## Summary

Tree shaking is a dead code elimination technique that removes unused code from JavaScript bundles. It analyzes import/export statements to determine which code is actually used.

## Key Claims

- Eliminates dead/unused code automatically
- Requires ES modules (import/export syntax)
- Works at build time
- Reduces bundle size by 20-40%
- Most effective with proper module structure

## How It Works

```javascript
// math.js
export const sum = (a, b) => a + b;
export const multiply = (a, b) => a * b;

// app.js - only imports sum
import { sum } from './math';

// After tree shaking: only sum is included in bundle
// multiply is "shaken off" like dead leaves
```

## Requirements

- ES6 module syntax (import/export)
- Static imports (no dynamic requires)
- Side-effect free modules
- Production build mode

## Side Effects

Code with side effects may prevent tree shaking:

```javascript
// May prevent tree shaking
import './styles.css';

// Fix: Configure sideEffects in package.json
{
  "sideEffects": ["*.css", "*.scss"]
}
```

## Best Practices

1. Use ES6 modules exclusively
2. Import only what you need
3. Avoid importing entire libraries
4. Mark side effects properly
5. Use production builds

## Common Issues

```javascript
// ❌ Imports everything
import * as _ from 'lodash';
import _ from 'lodash';

// ✅ Imports only used functions
import get from 'lodash/get';
import map from 'lodash/map';
```

## Concepts Covered

- [[tree-shaking]]
- [[dead-code-elimination]]
- [[bundle-optimization]]
- [[es-modules]]
