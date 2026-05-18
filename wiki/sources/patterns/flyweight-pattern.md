---
description: Sharing state across similar objects to conserve memory, using the flyweight structural design pattern
tags:
  - react
  - design/patterns
  - performance
  - frontend
sources:
  - Flyweight Pattern.md
created: 2026-04-16
updated: 2026-04-16
---

# Flyweight Pattern

**Source:** Flyweight Pattern.md
**Date ingested:** 2026-04-16
**Type:** article

## Summary

The flyweight pattern is a structural design pattern that conserves memory by sharing state across similar objects rather than creating new instances for each. The article demonstrates this with a library example: instead of creating a new `Book` instance for every copy of the same title, a factory function checks whether a book with the same ISBN already exists. If it does, the existing instance is reused; if not, a new one is created and cached in a `Map` keyed by ISBN. The result is that five book copies across three titles produce only three `Book` instances.

The pattern relies on separating intrinsic state (shared data like title, author, ISBN that is the same across all copies) from extrinsic state (unique data like sales count, availability that differs per copy). A factory function manages the shared instances via a cache (Map or Set), and a separate data structure tracks the per-copy extrinsic state.

The article notes that in JavaScript, prototypal inheritance can solve similar sharing problems naturally. With modern hardware having gigabytes of RAM, the flyweight pattern is less critical than in memory-constrained environments. However, it remains relevant when creating large numbers of similar objects that could exhaust available memory, such as in games, document editors, or data-heavy visualizations.

## Key Claims

- The flyweight pattern minimizes memory consumption by reusing existing instances for identical objects
- A Map or Set serves as the cache for shared instances, keyed by a unique identifier (e.g., ISBN)
- Intrinsic state (shared) is separated from extrinsic state (unique per instance)
- JavaScript's prototypal inheritance provides a natural mechanism for sharing behavior
- The pattern is less important with modern hardware but relevant for applications creating huge numbers of objects

## Concepts Covered

- [[flyweight-pattern]] -- Structural pattern sharing state across similar objects to reduce memory usage
- [[memoization]] -- Related caching technique; flyweight is essentially memoization applied to object creation
- [[prototypal-inheritance]] -- JavaScript's native mechanism for sharing behavior across object instances
