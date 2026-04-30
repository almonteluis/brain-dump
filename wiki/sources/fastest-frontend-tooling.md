---
description: Christoph Nakazawa's 2026 frontend tooling stack with tsgo, Oxfmt, Oxlint, pnpm, and Vite
tags: [frontend, tooling, typescript, linting, formatting, vite]
sources: ["Fastest Frontend Tooling for Humans & AI.md"]
created: 2026-04-29
updated: 2026-04-29
---

# Fastest Frontend Tooling for Humans & AI

**Source:** [[Fastest Frontend Tooling for Humans & AI]]
**Date ingested:** 2026-04-29
**Type:** article

## Summary

Christoph Nakazawa's 2026 frontend tooling stack recommendations. Focus on fast feedback loops, strict guardrails, and tooling that guides LLMs to write better code. Advocates tsgo (TypeScript Go rewrite), Oxfmt, Oxlint, pnpm, Vite.

## Key Claims

1. **tsgo** — TypeScript's Go rewrite gives ~10x faster type checking. Caught errors JS implementation missed. Migrate via `@typescript/native-preview`.
2. **Oxfmt** — Prettier alternative with built-in import/Tailwind sorting. Falls back to Prettier for non-JS languages.
3. **Oxlint** — First Rust-based linter that runs ESLint plugins directly via NAPI-RS shim. Supports type-aware lint rules with `oxlint-tsgolint`.
4. **`@nkzw/oxlint-config`** — Strict config designed to guide LLMs: error-never-warn, prevent bugs (no `instanceof`), no debug code in prod, fast rules only.
5. **ts-node + nodemon + SWC** — Fastest Node.js server restart combo for development.
6. Still uses pnpm, Vite, React with React Compiler.

## Entities Mentioned

- [[Christoph Nakazawa]] — Author (cpojer)
- [[tsgo]] — TypeScript Go rewrite
- [[Oxc]] — Rust-based JS tooling (Oxfmt, Oxlint)
- [[Vite]] — Bundler/dev server
- [[React Compiler]] — Automatic memoization

## Concepts Covered

- [[typescript-go]] — Go rewrite of TypeScript compiler
- [[rust-tooling]] — Rust-based JS toolchain migration
- [[llm-guardrails]] — Lint configs that guide AI code generation