---
description: Complete production-ready NPM package setup — Git, TypeScript, Prettier, Vitest, GitHub Actions, Changesets by Matt Pocock
tags: ["npm", "typescript", "tooling", "publishing"]
sources: ["How To Create An NPM Package 1.md"]
created: 2026-04-21
updated: 2026-04-21
---

# NPM Package Setup Guide

**Source:** How To Create An NPM Package (totaltypescript.com)
**Author:** [[Matt Pocock]]
**Date ingested:** 2026-04-21
**Type:** Technical guide

## Summary

Complete production-ready NPM package setup from empty directory. Covers every step: Git initialization, package.json configuration, TypeScript with strict settings, Prettier formatting, Vitest testing, GitHub Actions CI, and Changesets for versioning and publishing.

## Key Claims

1. **Use `moduleResolution: NodeNext`** — Requires `.js` extensions in imports for ESM compatibility. Explained in [[es-module-relative-imports]].

2. **`files: ["dist"]`** — Only publish the compiled output, not source or config files. `README.md`, `package.json`, and `LICENSE` are included by default.

3. **Changesets over `npm version`** — Changesets manages versioning and changelogs across packages, better for monorepos.

4. **CI script chains everything** — `npm run build && npm run check-format && npm run test`

5. **Vitest over Jest** — Better ESM and TypeScript support out of the box.

## Toolchain Stack

| Tool | Purpose | Config |
|------|---------|--------|
| Git | Version control | `.gitignore` (node_modules, dist) |
| TypeScript | Type safety + compilation | `tsconfig.json` (NodeNext, strict) |
| Prettier | Code formatting | `.prettierrc` |
| Vitest | Unit testing | `vitest run` for CI, `vitest` for dev |
| GitHub Actions | CI pipeline | `.github/workflows/ci.yml` |
| Changesets | Versioning + publishing | `.changeset/config.json` |

## Key tsconfig Options

```json
{
  "compilerOptions": {
    "module": "NodeNext",
    "moduleResolution": "NodeNext",
    "outDir": "dist",
    "rootDir": "src",
    "declaration": true,
    "declarationMap": true,
    "strict": true,
    "noUncheckedIndexedAccess": true,
    "noImplicitOverride": true,
    "verbatimModuleSyntax": true,
    "isolatedModules": true
  }
}
```

## package.json Essential Fields

```json
{
  "name": "unique-package-name",
  "version": "1.0.0",
  "type": "module",
  "main": "dist/index.js",
  "files": ["dist"],
  "scripts": {
    "build": "tsc",
    "test": "vitest run",
    "dev": "vitest",
    "format": "prettier --write .",
    "check-format": "prettier --check .",
    "ci": "npm run build && npm run check-format && npm run test"
  }
}
```

## Concepts Covered

- [[es-module-relative-imports|ES Module Imports]] — Why `.js` extensions are required
- [[barrel-files|Barrel Files]] — Export pattern via `src/index.ts`
- Semantic versioning — Major.Minor.Patch
- ESM vs CommonJS — `"type": "module"` for modern packages

## Related

- Demo repo: [mattpocock/tt-package-demo](https://github.com/mattpocock/tt-package-demo)
- [[cursor-rules-ai-development|Matt Pocock's Cursor Rules]] — Same author's AI coding guidelines
