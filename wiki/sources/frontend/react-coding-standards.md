---
description: React coding standards covering TypeScript usage, hooks, naming conventions, ES6+ patterns, and tooling
tags:
  - react
  - typescript
  - code/standards
  - frontend
  - hooks
  - marvin/frontend/redux
sources:
  - React.md
created: 2026-04-30
updated: 2026-04-30
---

# React Coding Standards

**Source:** React.md
**Date ingested:** 2026-04-30
**Type:** guide

## Summary

Internal React development guidelines advocating functional components with hooks, TypeScript usage, Redux for global state, and strict naming conventions. Emphasizes KISS, SRP, and DRY principles with ES6+ syntax.

## Key Claims

- TypeScript should be used; JavaScript only for justified reasons
- Use functional components with hooks; avoid class components
- Use Redux for global state management; Context API for partial sections only
- Do not use indexes as key props; use Fragments instead of unnecessary divs
- Minimize state variables; use `useMemo` and `React.memo` to avoid unnecessary re-renders
- Keep logic separate from presentation (custom hooks, Redux)
- Components should be small, simple, and readable; refactor if not
- Avoid inline styling unless justified
- Import order: React → external libraries → local files
- Use camelCase for folders/variables/functions; PascalCase for components, interfaces, types, enums
- Use `can`, `is`, `has` prefixes for booleans; `use` prefix for hooks

## Entities Mentioned

- [[React]] — UI library
- [[TypeScript]] — type system
- [[Redux]] — global state management
- [[Context API]] — React built-in state sharing
- [[ESLint]] — linter
- [[Prettier]] — code formatter

## Concepts Covered

- [[react-functional-components]] — hooks over classes
- [[react-state-management]] — Redux vs Context API
- [[react-performance]] — useMemo, React.memo, minimizing re-renders
- [[react-naming-conventions]] — PascalCase, camelCase, hook prefixes
- [[es6-patterns]] — template literals, destructuring, arrow functions, spread/rest
