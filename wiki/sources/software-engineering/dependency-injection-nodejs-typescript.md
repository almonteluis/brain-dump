---
description: Practical guide to dependency injection in Node.js without frameworks using factory functions and composition root
tags: [dependency-injection, typescript, nodejs, testing, architecture, solid]
sources: ["Dependency Injection in Node.js & TypeScript. The Part Nobody Teaches You.md"]
created: 2026-04-29
updated: 2026-04-29
---

# Dependency Injection in Node.js & TypeScript

**Source:** [[Dependency Injection in Node.js & TypeScript. The Part Nobody Teaches You]]
**Date ingested:** 2026-04-29
**Type:** tutorial

## Summary

Practical guide to dependency injection in Node.js without frameworks. Distinguishes DI (technique) from Dependency Inversion (SOLID principle). Shows manual DI via factory functions + composition root, when to graduate to containers like tsyringe.

## Key Claims

1. **DI ≠ Dependency Inversion**. DI is passing dependencies as arguments. Dependency Inversion is the principle that high/low-level modules should depend on abstractions.
2. **Module mocking is a code smell**. `jest.mock()`/`vi.mock()` are brittle — break on file renames, import-order dependent, type-unsafe, framework-locked.
3. **Manual DI**: Factory functions accepting interface-typed dependencies. Composition root wires everything together. Covers 90% of Node.js apps.
4. **Testing payoff**: Plain objects satisfying interfaces — no mock framework needed. Type-safe, portable across test runners, self-contained tests.
5. **Graduate to container** (tsyringe) at 20-30+ services with complex dependency graphs. tsyringe uses decorators + reflect-metadata.

## Entities Mentioned

- [[Petar Ivanov]] — Author (thetshaped.dev)
- [[tsyringe]] — Microsoft DI container for TypeScript
- [[InversifyJS]] — Alternative DI container

## Concepts Covered

- [[dependency-injection]] — Passing dependencies as parameters
- [[dependency-inversion]] — SOLID principle: depend on abstractions
- [[composition-root]] — Single entry point wiring all dependencies
- [[module-mocking]] — Framework-level mocking of import paths
- [[testability]] — Making code testable without mocking frameworks

## Related

- [[design-systems]] — Same family of patterns: DI composes services with shared abstractions, design systems compose UI with shared abstractions. Both decouple consumers from concrete implementations (graph confirmed via INFERRED Design Patterns ↔ DI edge).
- [[react-patterns]] — Component composition is dependency injection in disguise (props as injected deps).