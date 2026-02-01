---
description: React is a UI library not a framework, using components as functions, JSX as syntax sugar for createElement calls, and virtual DOM for efficient reconciliation.
tags: #react #fundamentals #components #jsx #virtual-dom
date: 2026-01-31
---

# React is a UI Library Not a Framework

React is a free, open-source JavaScript library for building user interfaces (UI) and single-page applications. It focuses on the view layer only, leaving architecture and state management decisions to developers.

## Key distinction: Library vs Framework

A **framework** (like Angular) provides a complete structure with opinions about routing, state management, HTTP calls, and more. React is a **library** that only handles rendering UI — you choose the rest of the stack.

## Mental Model: Functions All the Way Down

- A React component is just a function
- Components containing other components are functions calling other functions
- Props are the function's arguments

## Related Notes

- [[component-lifecycle.md]] - Class and functional component lifecycle
- [[react-events.md]] - Event handling and forms
