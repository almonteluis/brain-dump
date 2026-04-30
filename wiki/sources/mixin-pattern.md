---
description: Adding reusable functionality to objects without inheritance, a legacy pattern replaced by HOCs and hooks in React
tags: [react, design-patterns, frontend]
sources: [Mixin Pattern.md]
created: 2026-04-16
updated: 2026-04-16
---

# Mixin Pattern

**Source:** Mixin Pattern.md
**Date ingested:** 2026-04-16
**Type:** article

## Summary

A mixin is an object that adds reusable functionality to another object or class without using inheritance. Mixins cannot be used on their own -- their sole purpose is to inject methods and properties into a target. The article demonstrates this with a `Dog` class that starts with only a `name` property, then uses `Object.assign(Dog.prototype, dogFunctionality)` to add `bark`, `wagTail`, and `play` methods from a mixin object onto the Dog prototype. Every new Dog instance automatically gains these capabilities.

Mixins themselves can use inheritance through `__proto__` or `Object.assign`. The article shows an `animalFunctionality` mixin with `walk` and `sleep` methods, which is assigned to `dogFunctionality` as its prototype. This allows dog-specific mixins to inherit general animal behavior. A real-world example is the browser `Window` interface, which implements properties from `WindowOrWorkerGlobalScope` and `WindowEventHandlers` mixins (e.g., `setTimeout`, `indexedDB`).

In React (pre-ES6), mixins were commonly used to add functionality to components via `React.createClass({ mixins: [...] })`. The React team explicitly discouraged mixins in a 2016 blog post ("Mixins Considered Harmful") because they add unnecessary complexity, create implicit dependencies, and make components hard to maintain. The recommendation shifted to Higher-Order Components (HOCs), which were themselves largely replaced by React Hooks. Modifying an object's prototype is also considered bad practice due to the risk of prototype pollution and uncertainty about function origins.

## Key Claims

- Mixins add functionality to classes without inheritance via `Object.assign` on the prototype
- Mixins themselves can inherit from other mixins using `__proto__` or `Object.assign`
- The React team discourages mixins due to complexity, implicit dependencies, and maintenance difficulty
- HOCs and then Hooks replaced mixins as the preferred way to share component logic
- Modifying prototypes via mixins risks prototype pollution and unclear function origins

## Concepts Covered

- [[mixin-pattern]] -- Adding methods to objects or prototypes without inheritance using Object.assign
- [[higher-order-components]] -- Pattern that replaced mixins in React for sharing component logic
- [[custom-hooks]] -- Modern replacement for both mixins and HOCs for sharing stateful logic
- [[prototypal-inheritance]] -- JavaScript's inheritance mechanism that mixins leverage via prototype assignment
- [[render-props-pattern]] -- Another logic-sharing pattern from the same era as HOCs
