---
description: JavaScript runtime optimization covering event loop, performance fundamentals, and optimization techniques
tags: ["source", "javascript", "performance", "event-loop", "optimization"]
sources: ["Runtime Optimization.md"]
created: 2026-04-09
updated: 2026-04-09
---

# Runtime Optimization

**Source:** raw/02_reference/software-engineer/frontend/Patterns/Runtime Optimization.md
**Date ingested:** 2026-04-09
**Type:** technical reference

## Summary

JavaScript runtime optimization involves understanding how the engine executes code and manages tasks. This knowledge is essential for writing performant applications.

## Key Claims

- Understanding the event loop is crucial for optimization
- Task scheduling with setTimeout/setInterval, requestAnimationFrame, requestIdleCallback
- Performance metrics include Time to Interactive, First Paint, and Layout thrashing

## Knowledge Points

- **Event Loop**: Call stack, Task queue, Microtask queue
- **Task Scheduling**: setTimeout/setInterval, requestAnimationFrame, requestIdleCallback
- **Performance Metrics**: Time to Interactive, First Paint, Layout thrashing

## Concepts Covered

- [[Event Loop]] — JavaScript concurrency model
- [[Call Stack]] — Function execution tracking
- [[Task Queue]] — Macro task scheduling
- [[Microtask Queue]] — Promise and mutation observer callbacks
- [[requestAnimationFrame]] — Synchronous with display refresh
- [[requestIdleCallback]] — Execute during browser idle time
- [[Layout Thrashing]] — Forced synchronous layout
