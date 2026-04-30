---
description: Centralized communication between components via a mediator object, with Express middleware as a case study
tags: [react, design-patterns, frontend]
sources: [MediatorMiddleware Pattern.md]
created: 2026-04-16
updated: 2026-04-16
---

# Mediator/Middleware Pattern

**Source:** MediatorMiddleware Pattern.md
**Date ingested:** 2026-04-16
**Type:** article

## Summary

The mediator pattern centralizes communication between components through a single mediator object, replacing direct many-to-many interactions with a simpler hub-and-spoke model. Instead of objects talking directly to each other (creating complex interdependencies), all communication flows through the mediator, which receives requests and forwards them to the appropriate recipients. The classic analogy is an air traffic controller coordinating pilots.

The article demonstrates the pattern with a chatroom example: a `ChatRoom` class acts as the mediator, and `User` instances send messages through the chatroom rather than communicating directly with each other. Each user holds a reference to the chatroom and calls `chatroom.logMessage(this, message)` when sending. The chatroom handles formatting and routing, keeping users decoupled from each other.

A real-world case study shows Express.js middleware as an implementation of this pattern. Middleware functions form a chain where each function receives the request, can modify it, and passes it to the next via `next()`. This creates a linear pipeline of processing steps between the incoming request and the outgoing response, with each middleware able to inspect and modify the request/response objects. The pattern simplifies many-to-many relationships between objects into manageable one-to-many flows through the central mediator.

## Key Claims

- The mediator replaces direct many-to-many communication with hub-and-spoke routing through a central point
- Components are decoupled from each other -- they only know about the mediator, not other components
- Express.js middleware is a real-world implementation: a chain of functions processing requests sequentially via `next()`
- The pattern is useful when a large number of components need to communicate in multidirectional ways
- In JavaScript, a mediator is often just an object literal or a function

## Concepts Covered

- [[mediator-pattern]] -- Behavioral pattern centralizing component communication through a single mediator object
- [[middleware]] -- Chain-of-processing pattern where each step receives, modifies, and forwards a request
- [[observer-pattern]] -- Related pub/sub pattern; mediators coordinate directly while observers broadcast to subscribers
- [[separation-of-concerns]] -- Mediators enforce this by keeping components unaware of each other
