---
description: Comprehensive JavaScript fundamentals reference covering async, objects, types, data structures, design patterns, and clean code from 33jsconcepts.com
tags: ["javascript", "frontend", "reference", "fundamentals"]
sources: ["Callbacks.md", "Promises.md", "async await.md", "Event Loop.md", "Prototypes & Object Creation.md", "this, call, apply & bind.md", "Factories & Classes.md", "Inheritance & Polymorphism.md", "IIFE & Namespaces.md", "Type Coercion.md", "Data Structures.md", "Algorithms & Big O.md", "localStorage & sessionStorage.md", "Design Patterns.md", "Clean Code.md"]
created: 2026-04-22
updated: 2026-04-22
---

# JavaScript Fundamentals Collection

**Source:** 15 articles from [33JS Concepts](https://33jsconcepts.com/) by Leonardo Maldonado
**Date ingested:** 2026-04-22
**Type:** Technical reference collection

Comprehensive JavaScript fundamentals covering the language from callbacks through clean code. Each source is a deep-dive tutorial with practical examples, common pitfalls, and best practices.

## Asynchronous JavaScript

### Callbacks

Functions passed as arguments to be invoked later. The foundation of all async JS — event handlers, timers, network requests all use callbacks.

**Key patterns:**
- Synchronous callbacks (Array.map, forEach) execute immediately
- Asynchronous callbacks (setTimeout, event listeners) execute later
- Error-first pattern: `callback(err, result)` is the Node.js convention

**Common pitfall:** Callback hell (deeply nested callbacks) — solved by Promises.

### Promises

Objects representing a value that doesn't exist yet. Three states: pending, fulfilled, rejected. Solve callback hell with `.then()` chaining.

**Key patterns:**
- `Promise.all()` — wait for all, fail fast on first rejection
- `Promise.allSettled()` — wait for all, never fail fast
- `Promise.race()` — first to settle wins
- `Promise.any()` — first to fulfill wins

**Best practice:** Always handle rejections with `.catch()` or try/catch with async/await.

### Async/Await

Syntactic sugar over Promises (ES2017). Makes async code read like synchronous code. 90%+ adoption rate per 2023 State of JS survey.

**Key patterns:**
- `async` functions always return Promises
- `await` pauses execution within async function only
- `try/catch` for error handling (cleaner than `.catch()`)
- `Promise.all()` with `await` for parallel execution

**Common pitfall:** Sequential `await` when operations could run in parallel — use `await Promise.all([p1, p2])`.

### Event Loop

JavaScript's mechanism for handling async on a single thread. Manages the call stack, task queue (macrotasks), and microtask queue.

**Key concepts:**
- **Call stack:** Where synchronous code executes (LIFO)
- **Macrotask queue:** setTimeout, setInterval, I/O callbacks
- **Microtask queue:** Promise.then(), queueMicrotask() — always runs before macrotasks
- Priority: Call stack → Microtasks → Macrotasks (that's why `Promise.resolve().then()` runs before `setTimeout(fn, 0)`)

**SE application:** Understanding execution order prevents race conditions in React effects and state updates.

## Objects & Prototypes

### Prototypes & Object Creation

Every JS object has an internal `[[Prototype]]` link forming the prototype chain. This is how objects inherit methods like `.toString()` without explicit definition.

**Key patterns:**
- `Object.create(proto)` — create object with specific prototype
- `new Constructor()` — creates instance, sets prototype, binds `this`
- Prototype chain lookup: own properties → prototype → prototype's prototype → null

**SE application:** Understanding prototypes is essential for debugging React component inheritance and class-based libraries.

### this, call, apply & bind

Five binding rules determine what `this` refers to: (1) Default binding (global/undefined in strict mode), (2) Implicit binding (object.method), (3) Explicit binding (call/apply/bind), (4) `new` binding, (5) Arrow functions (lexical `this` from enclosing scope).

**Key patterns:**
- `fn.call(obj, arg1, arg2)` — invoke with explicit `this`, individual args
- `fn.apply(obj, [args])` — invoke with explicit `this`, args as array
- `fn.bind(obj)` — return new function with permanently bound `this`
- Arrow functions inherit `this` from enclosing scope (cannot be rebound)

**Common pitfall:** Losing `this` when passing methods as callbacks — use `.bind()` or arrow functions.

### Factories & Classes

Two patterns for creating multiple similar objects. Factory functions return new objects; ES6 classes provide syntactic sugar over prototypes.

**Factory functions:** No `new` keyword, easier private variables via closure, flexible composition.
**ES6 classes:** Familiar OOP syntax, `extends` for inheritance, `super()` for parent access, private fields with `#`.

**SE application:** React components are essentially factory functions; understanding both patterns helps choose between HOC patterns and hooks.

### Inheritance & Polymorphism

Objects and classes can inherit behavior from parents. JavaScript uses prototypal inheritance (delegation) rather than classical inheritance (copying).

**Key patterns:**
- `class Child extends Parent` — ES6 inheritance
- Method overriding — redefine parent methods in child
- `super.method()` — call parent's version
- Polymorphism — same interface, different implementations

**Best practice:** Favor composition over inheritance. Use mixins or utility functions when sharing behavior across unrelated classes.

### IIFE & Namespaces

Immediately Invoked Function Expressions create private scope. The historical pattern for modules before ES6 modules.

**Key patterns:**
- IIFE: `(function() { /* private scope */ })()`
- Revealing module pattern: return public API from IIFE
- ES6 modules: `import`/`export` — each file is its own module scope
- Dynamic imports: `import('./module.js')` returns a Promise

**SE application:** Understanding IIFEs helps read legacy codebases; modern code should use ES6 modules exclusively.

## Types & Coercion

### Type Coercion

JavaScript automatically converts types in operations. `"5" + 3` gives `"53"` (string concat) but `"5" - 3` gives `2` (numeric subtraction).

**Key concepts:**
- **Implicit coercion:** `==` triggers type conversion; `===` does not
- **8 falsy values:** `false`, `0`, `-0`, `""`, `null`, `undefined`, `NaN`, `0n`
- **ToPrimitive:** Objects call `valueOf()` then `toString()` when coerced
- **`+` operator:** If either operand is string → string concat; otherwise → numeric

**Best practice:** Always use `===` (strict equality). Use `Boolean()` or `!!` for explicit boolean conversion.

## Data & Algorithms

### Data Structures

Arrays, Objects, Maps, Sets, Stacks, Queues, and Linked Lists. Choice of data structure impacts performance significantly.

**Key trade-offs:**
- **Array:** O(n) search, O(1) append — ordered, indexed
- **Object:** O(1) property access — unordered key-value
- **Map:** O(1) lookup, preserves insertion order, any key type
- **Set:** O(1) lookup, unique values only
- **Stack:** LIFO — undo systems, call stacks, DFS
- **Queue:** FIFO — task scheduling, BFS, event processing

### Algorithms & Big O

Big O notation describes how algorithm performance scales with input size.

**Key complexities:**
- O(1) — constant: hash lookup, array access by index
- O(log n) — logarithmic: binary search
- O(n) — linear: single loop, array.find
- O(n log n) — linearithmic: merge sort, quicksort (average)
- O(n²) — quadratic: nested loops, bubble sort

**SE application:** Choosing O(1) Map lookup over O(n) Array.find matters at scale — especially in React rendering loops.

### localStorage & sessionStorage

Web Storage APIs for persisting data in the browser. Both store strings only (use `JSON.stringify`/`parse` for objects).

**Key differences:**
- **localStorage:** Persists until explicitly cleared, shared across tabs, ~5-10MB
- **sessionStorage:** Cleared when tab closes, tab-specific, ~5-10MB

**API:** `setItem(key, value)`, `getItem(key)`, `removeItem(key)`, `clear()`

**Best practice:** Never store sensitive data. Handle `QuotaExceededError`. Use try/catch for `JSON.parse` on retrieved values.

## Patterns & Practices

### Design Patterns

Proven solutions to recurring problems. Key patterns in JavaScript:

- **Module** — Encapsulate private state, expose public API (ES6 import/export)
- **Singleton** — Single shared instance (use sparingly; often an anti-pattern)
- **Observer** — Pub/sub: notify listeners on state change (events, RxJS)
- **Factory** — Create objects without specifying exact class
- **Proxy** — Intercept and control access to objects (React Proxy, Vue reactivity)
- **Decorator** — Add behavior to objects dynamically (JS decorators proposal, HOCs)
- **Strategy** — Swap algorithms at runtime

### Clean Code

Principles for writing readable, maintainable code. Key rules:

- **Meaningful names:** `getUserAge()` not `getData()`
- **Small functions:** Do one thing, do it well, name says what it does
- **DRY** (Don't Repeat Yourself) — but not at the cost of clarity
- **Single Responsibility** — each function/module handles one concern
- **Avoid magic numbers** — use named constants
- **Comments explain why**, not what (code should explain what)

## Cross-References

- [[react-patterns]] — React-specific patterns building on JS fundamentals
- [[performance-patterns]] — Optimization using these fundamentals
- [[testing-patterns]] — Testing strategies for JS code
- [[big-o-complexity-cheatsheet]] — Detailed complexity tables for data structures and sorting
- [[clean-code-javascript]] — Ryan McDermott's Clean Code adapted for JavaScript
- [[event-handling-react-interviews]] — Event handling patterns in React
- [[observer-pattern]] — Deep dive on the Observer pattern
- [[design-patterns]] — [[flyweight-pattern]], [[render-props-pattern]], [[mediator-middleware-pattern]]
- [[modern-data-structures]] — Map, Set, WeakMap, TypedArrays

## Quick Reference

| Topic | Key Concept | Common Pitfall | Best Practice |
|-------|-------------|----------------|---------------|
| Callbacks | Functions as arguments | Callback hell, inversion of control | Use Promises or async/await |
| Promises | Future value representation | Unhandled rejections, sequential when parallel possible | `.catch()` always, `Promise.all()` for parallel |
| Async/Await | Syntactic sugar over Promises | Sequential awaits blocking parallel work | `await Promise.all()` for concurrent ops |
| Event Loop | Single-threaded async | Confusing microtask vs macrotask priority | Understand execution order for debugging |
| Prototypes | Delegation-based inheritance | Modifying `Object.prototype` | Use `Object.create()` or `class` |
| this | 5 binding rules | Losing `this` in callbacks | Arrow functions or `.bind()` |
| Factories/Classes | Object blueprints | Overusing inheritance hierarchies | Prefer composition |
| Type Coercion | Automatic type conversion | `==` surprises, falsy edge cases | Always use `===` |
| Data Structures | Time/space trade-offs | Using Array.find in hot paths | Map for O(1) lookups at scale |
| Big O | Algorithm scaling | O(n²) in production code | Profile before optimizing |
| Design Patterns | Reusable solutions | Over-engineering with patterns | Apply only when problem demands it |
| Clean Code | Readability principles | Over-abstracting, magic numbers | Small functions, meaningful names |
