---
description: "Atomic Design: Atoms are the smallest UI building blocks"
tags: [software-engineering, atomic-design, react, components]
sources: [Atoms.md]
created: 2026-04-09
updated: 2026-04-09
---

# Atomic Design: Atoms

**Source:** raw/02_reference/software-engineer/frontend/Patterns/Atoms.md
**Date ingested:** 2026-04-09
**Type:** technical reference

## Summary

Atoms are the smallest building blocks in Atomic Design methodology — fundamental UI elements that cannot be broken down further without losing meaning. They serve as the foundation for all higher-level components.

## Key Claims

- Atoms are the smallest building blocks (buttons, inputs, labels, icons)
- Atoms have no internal state
- They are not useful alone but fundamental for larger components
- Should be simple, single-purpose, and consistent

## Atom Categories

### Form Atoms
- Button, Input, Label, Checkbox, Radio

### Typography Atoms
- Text, Heading

### UI Elements
- Icon, Badge, Avatar, Spinner

### Layout Atoms
- Container, Row, Col, Divider

### Interactive Atoms
- Toggle, Progress

## Best Practices

- Keep atoms simple and single-purpose
- Maintain consistency in props patterns
- Use meaningful default values
- Include proper PropTypes/TypeScript types
- Consider accessibility
- Make components theme-aware
- Test each atom independently

## File Structure

```
/atoms
  /Button
    Button.jsx
    Button.test.jsx
    Button.styles.js
    index.js
```

## Concepts Covered

- [[atomic-design]]
- [[react-components]]
- [[design-systems]]
- [[component-architecture]]
