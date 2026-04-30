---
description: Pub/sub pattern for notifying subscribers when events occur, with RxJS case study and React useSyncExternalStore
tags: [react, design-patterns, frontend]
sources: [Observer Pattern.md]
created: 2026-04-16
updated: 2026-04-16
---

# Observer Pattern

**Source:** Observer Pattern.md
**Date ingested:** 2026-04-16
**Type:** article

## Summary

The observer pattern enables objects (observers) to subscribe to another object (the observable) and receive notifications when events occur. An observable typically contains three parts: an `observers` array tracking subscribers, a `subscribe()` method to add observers, an `unsubscribe()` method to remove them, and a `notify()` method that iterates through all observers and passes data to each. The article implements this as an ES6 `Observable` class.

The demonstration uses a React app with a Button and Switch where user interactions (clicks, toggles) trigger `observable.notify()` with event data. Two observer functions -- `logger` (console logging with timestamps) and `toastify` (displaying toast notifications) -- are subscribed to the observable. When either UI element is activated, both observers receive the notification simultaneously, demonstrating decoupled event handling.

RxJS is presented as a major case study, combining the observer pattern with the iterator pattern and functional programming. RxJS allows creating observables from DOM events (e.g., `fromEvent(document, 'mousedown')`) and composing them with operators like `pipe`, `sample`, and `mapTo` to handle complex asynchronous event streams. The pattern enforces separation of concerns (observers handle data, observables monitor events) and the single-responsibility principle, though complex observers can cause performance issues when notifying many subscribers.

## Key Claims

- Observables maintain a list of subscribers and broadcast notifications to all of them when events occur
- The pattern enforces separation of concerns -- observers are not tightly coupled to the observable
- RxJS combines observer, iterator, and functional patterns for managing asynchronous event sequences
- Complex observers or large subscriber lists can cause performance issues during notification
- The pattern is particularly useful for asynchronous, event-based data like message boards or download completion

## Concepts Covered

- [[observer-pattern]] -- Behavioral pattern where observers subscribe to an observable and receive event notifications
- [[pub-sub]] -- Publish/subscribe communication model; observers subscribe to event channels
- [[useSyncExternalStore]] -- React 18 hook for subscribing to external stores, the modern React approach to observer-like patterns
- [[event-emitter]] -- Node.js implementation of the observer pattern for server-side event handling
- [[mediator-pattern]] -- Related pattern; mediators route messages between known components while observers broadcast to anonymous subscribers
