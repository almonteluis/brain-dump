---
description: Atomic Design methodology breaks UI into five levels — atoms, molecules, organisms, templates, and pages — creating hierarchical component structure
tags: ["atomic-design", "react", "component-architecture", "design-systems", "concept"]
created: 2026-04-09
updated: 2026-04-09
sources: ["⚛️Atomic Design Methodology.md"]
---

# Atomic Design

A methodology for creating design systems by breaking interfaces into hierarchical component levels, from foundational elements to complete pages.

## The Five Levels

```
Atoms → Molecules → Organisms → Templates → Pages
```

### 1. Atoms
Basic building blocks — buttons, inputs, labels.
- Not useful alone
- Fundamental for larger components
- No state

### 2. Molecules
Functional groups of atoms.
- Example: Search bar (input + button + icon)
- Simple state possible
- Single purpose

### 3. Organisms
Complex sections composed of molecules and atoms.
- Example: Header, footer, navigation
- Own state and functionality
- Reusable across pages

### 4. Templates
Page layouts with content structure.
- Place organisms into layouts
- No real content
- Define spatial relationships

### 5. Pages
Specific template instances with real content.
- What users actually see
- Multiple pages per template
- Complete ecosystems

## File Structure

```
components/
├── atoms/
├── molecules/
├── organisms/
├── templates/
└── pages/
```

## State Management by Level

| Level | State |
|-------|-------|
| Atoms | Usually none |
| Molecules | Simple local state |
| Organisms | Complex state, side effects |
| Templates | Layout state |
| Pages | Page-specific state |

## Related

[[react]]
[[component-architecture]]
[[design-systems]]
[[atomic-design-methodology]] — Detailed methodology source
[[atomic-design-atoms]] — Atoms reference
[[atomic-design-molecules]] — Molecules reference
[[atomic-design-organisms]] — Organisms reference
[[atomic-design-templates]] — Templates reference
[[atomic-design-pages]] — Pages reference
