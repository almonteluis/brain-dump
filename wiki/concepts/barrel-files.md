---
description: Why barrel files (index.ts/index.js) are anti-patterns that hurt tree-shaking
tags: ["javascript", "modules", "tree-shaking", "anti-pattern"]
sources: ["brainbreak-code-cleanup"]
created: 2026-04-11
updated: 2026-04-11
---

# Barrel Files

Barrel files (`index.ts`/`index.js`) re-export modules from a directory for cleaner import paths. According to Vercel React best practices, they are **anti-patterns**.

## What Are Barrel Files

```typescript
// components/BrainBreak/index.ts (barrel file)
export { BrainBreakModal } from './BrainBreakModal';
export { ConfidenceSlider } from './ConfidenceSlider';
export { EmotionPicker } from './EmotionPicker';
```

## Why They're Anti-Patterns

| Issue | Description |
|-------|-------------|
| **Tree-shaking issues** | Bundlers can't eliminate unused code through barrel re-exports |
| **Circular dependency risks** | Creates hidden dependency chains |
| **Unnecessary indirection** | Developers must open multiple files to trace imports |
| **Coupling between unrelated modules** | Imports become less explicit about origin |

## Vercel's Recommendation

According to Vercel's `bundle-barrel-imports` rule:

> **"Import directly, avoid barrel files."**

## Recommended Pattern

### Instead of Barrel Imports

```typescript
// ❌ From barrel (less explicit)
import { BrainBreakModal, ConfidenceSlider } from '../components/BrainBreak';

// ✅ Direct imports (more explicit)
import { BrainBreakModal } from '../components/BrainBreak/BrainBreakModal';
import { ConfidenceSlider } from '../components/BrainBreak/ConfidenceSlider';
```

### Benefits

1. **Better tree-shaking** — Bundlers see exact import paths
2. **Explicit dependencies** — Clear where each export comes from
3. **Easier navigation** — Go-to-definition works directly
4. **Reduced coupling** — Importer chooses what to use

## When Barrel Files Are Acceptable

- For very small, stable internal packages
- When you control both the barrel and all importers
- Public API surfaces (with tree-shaking verification)

## Related

- [[tree-shaking]] — Dead code elimination
- [[bundle-optimization]] — Reducing JavaScript bundle size
- [[TEAME-218 Code Cleanup - TEAME-177 (In-Platform Polling)]] — Real-world barrel file removal
