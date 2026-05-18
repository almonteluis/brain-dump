---
description: Why NodeNext moduleResolution requires .js extensions in ES module imports — Matt Pocock explanation
tags: ["typescript", "esm", "nodejs", "modules"]
sources: ["Relative import paths need explicit file extensions in EcmaScript imports.md"]
created: 2026-04-21
updated: 2026-04-21
---

# ES Module Relative Import Paths

**Source:** Relative import paths need explicit file extensions in EcmaScript imports (totaltypescript.com)
**Author:** [[Matt Pocock]]
**Date ingested:** 2026-04-21
**Type:** Technical reference

## Summary

When using `moduleResolution: NodeNext` in TypeScript, relative import paths must include explicit `.js` file extensions — even though you're writing `.ts` files.

## The Error

```typescript
// ERROR: Relative import paths need explicit file extensions
// when '--moduleResolution' is 'node16' or 'nodenext'.
import { example } from "./foo";
```

## Wrong Fix

```typescript
// ERROR: An import path can only end with a '.ts' extension
// when 'allowImportingTsExtensions' is enabled.
import { example } from "./foo.ts";
```

## Correct Fix

```typescript
import { example } from "./foo.js";
```

## Why `.js` Extensions?

- `moduleResolution: NodeNext` tells TypeScript to conform strictly to the Node spec
- The Node spec requires `.js` extensions for all imports and exports
- This makes the same import path work in both Node and the browser
- Simplifies Node's module resolution — no guesswork needed

## Alternative

If you don't want `.js` extensions:

1. Use an external compiler (esbuild, Vite) to compile TypeScript
2. Set `moduleResolution: "Bundler"` instead of `"NodeNext"`

## Related

- [[npm-package-setup-guide]] — Full setup guide using NodeNext
- [[Matt Pocock]] — Total TypeScript author
