---
description: "Atomic Design: Molecules are functional component groups"
tags: [software-engineering, atomic-design, react, components]
sources: [Molecules.md]
created: 2026-04-09
updated: 2026-04-09
---

# Atomic Design: Molecules

**Source:** raw/02_reference/software-engineer/frontend/Patterns/Molecules.md
**Date ingested:** 2026-04-09
**Type:** technical reference

## Summary

Molecules are functional groups of atoms that work together as a unit. They represent the simplest composite components that provide real functionality to users.

## Key Claims

- Molecules combine multiple [[atoms]] into functional groups
- Serve a single purpose/functionality
- Reusable across different contexts
- More complex than atoms but still relatively simple
- Can have simple local state

## Common Molecule Patterns

### Form Controls
- SearchBar (Input + Button + Icon)
- FormField (Label + Input + Error text)

### Navigation Elements
- MenuItem (Icon + Text)
- Breadcrumb (Links + Separators)

### Card Components
- Card (Image + Heading + Text)
- ProfileCard (Avatar + Name + Role)

### Interactive Components
- Dropdown (Button + Menu list)
- Alert (Icon + Text + Close button)
- Toast (Icon + Message with auto-dismiss)

## Best Practices

- Keep molecules focused on single responsibility
- Maintain consistent prop patterns
- Use proper TypeScript/PropTypes
- Write unit tests
- Make components accessible
- Consider responsive design
- Document usage examples

## Composition Pattern

```jsx
function ComposableMolecule({ leftComponent, rightComponent, children }) {
  return (
    <div className="molecule">
      {leftComponent}
      <div className="content">{children}</div>
      {rightComponent}
    </div>
  );
}
```

## Concepts Covered

- [[atomic-design]]
- [[react-components]]
- [[component-composition]]
- [[design-systems]]
