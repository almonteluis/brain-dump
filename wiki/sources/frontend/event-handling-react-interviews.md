---
description: React synthetic event system covering mouse, input, form, focus, and keyboard events with interview-focused guidance
tags: [react, events, interviews, frontend]
sources: [Event Handling in React Interviews.md]
created: 2026-04-16
updated: 2026-04-16
---

# Event Handling in React Interviews

**Source:** Event Handling in React Interviews.md
**Date ingested:** 2026-04-16
**Type:** article

## Summary

This article from greatfrontend.com covers React's synthetic event system, which wraps native browser events into a standardized `SyntheticEvent` object for cross-browser consistency and performance. Unlike vanilla JavaScript where listeners are attached to individual elements, React uses event delegation -- events are attached to the root of the React application rather than each element, improving performance by reducing the number of event listeners.

The article provides detailed coverage of five event categories: mouse events (onClick, onMouseEnter/Leave, onMouseOver/Out with the key distinction that Enter/Leave do not bubble while Over/Out do), input events (onChange vs onInput -- React's onChange fires on every keystroke unlike the native DOM change event), form events (onSubmit requires `event.preventDefault()` in SPAs), focus events (onFocus/onBlur, with CSS `:focus` preferred over JavaScript for styling), and keyboard events (onKeyDown preferred over deprecated onKeyPress, use `event.key` over deprecated `event.keyCode`).

Event interception patterns include `event.stopPropagation()` to prevent bubbling (useful for nested click handlers like dropdowns) and `event.preventDefault()` to stop default browser behavior (essential for form submissions). Best practices for interviews include using `useCallback` for memoizing handlers to avoid excessive re-renders, preferring `onChange` over `onInput`, and using CSS pseudo-classes (`:hover`, `:focus`) instead of JavaScript event handlers when possible.

## Key Claims

- React uses event delegation at the root rather than attaching listeners to individual elements
- `SyntheticEvent` wraps native events; access the original via `event.nativeEvent`
- React's `onChange` fires on every keystroke, unlike the native DOM change event which fires on blur
- `onMouseEnter`/`onMouseLeave` do not bubble; `onMouseOver`/`onMouseOut` do bubble
- `onKeyPress` is deprecated; use `onKeyDown` instead. Use `event.key` over deprecated `event.keyCode`

## Concepts Covered

- [[synthetic-events]] -- React's cross-browser event wrapper that normalizes native browser events into a consistent interface
- [[event-delegation]] -- Performance optimization where a single listener at the root handles events from all child elements
- [[debouncing]] -- Recommended for performance-sensitive events like onScroll to limit handler invocation rate
- [[accessibility]] -- onClick should only be on interactive elements (buttons, links, inputs) for screen reader support
- [[event-propagation]] -- Bubbling and capturing phases in the DOM; controllable via stopPropagation
