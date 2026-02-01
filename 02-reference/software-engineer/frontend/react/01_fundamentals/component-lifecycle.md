---
description: React component lifecycle covers class component mounting, updating, and unmounting phases, plus functional component lifecycle with useEffect hooks replacing lifecycle methods.
tags: #react #lifecycle #hooks #class-components #use-effect
date: 2026-01-31
---

# Component Lifecycle in React

React components go through three phases during their existence: **mounting**, **updating**, and **unmounting**.

## Class Component Lifecycle Methods

| Phase | Methods | Use Case |
|-------|---------|----------|
| **Mounting** | constructor, render, componentDidMount | Initial setup, API calls |
| **Updating** | render, componentDidUpdate | Respond to prop/state changes |
| **Unmounting** | componentWillUnmount | Cleanup, remove listeners |

## Functional Component Lifecycle with useEffect

| Class Method | useEffect Equivalent |
|--------------|---------------------|
| componentDidMount | useEffect(() => {}, []) |
| componentDidUpdate | useEffect(() => {}, [dep]) |
| componentWillUnmount | return cleanup function |

## Related Notes

- [[react-core-concepts.md]] - React fundamentals and mental models
- [[../02_hooks/use-effect.md]] - useEffect patterns
