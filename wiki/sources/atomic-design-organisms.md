---
description: "Atomic Design: Organisms are complex UI sections"
tags: [software-engineering, atomic-design, react, components]
sources: [Organisms.md]
created: 2026-04-09
updated: 2026-04-09
---

# Atomic Design: Organisms

**Source:** raw/02_reference/software-engineer/frontend/Patterns/Organisms.md
**Date ingested:** 2026-04-09
**Type:** technical reference

## Summary

Organisms are complex, distinct sections of an interface composed of molecules and atoms. They represent complete functional areas that can stand alone.

## Key Claims

- Organisms combine multiple [[molecules]] and [[atoms]]
- Represent distinct sections of an interface
- More complex but still reusable
- Usually context-specific
- Own state and side effects

## Common Organism Patterns

### Navigation Header
- Logo + Navigation menu + Search + User dropdown

### Dashboard Widget Section
- Multiple cards with charts, metrics, and lists

### Complex Forms
- Multi-field forms with validation
- Registration forms, checkout flows

### Data Tables
- Search + Table + Pagination + Actions

### Sidebar Navigation
- Profile card + Menu items + Footer actions

## State Management

Organisms often require complex state management:

```javascript
function useTableData(initialData) {
  const [data, setData] = useState(initialData);
  const [sorting, setSorting] = useState({ key: null, direction: 'asc' });
  const [filters, setFilters] = useState({});

  return { data, sorting, filters, setSorting, setFilters };
}
```

## Best Practices

- Break down into smaller components when possible
- Handle loading and error states
- Implement proper prop validation
- Consider accessibility
- Add responsive behavior
- Document component APIs
- Write comprehensive tests

## Concepts Covered

- [[atomic-design]]
- [[react-components]]
- [[state-management]]
- [[design-systems]]
