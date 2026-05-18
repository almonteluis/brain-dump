---
description: Atomic Design breaks UI into five levels — atoms, molecules, organisms, templates, pages — so your component library has a spine instead of being a junk drawer.
tags:
  - atomic-design
  - react
  - component-architecture
  - design/systems
  - concept
created: 2026-04-09
updated: 2026-05-17
sources:
  - ⚛️Atomic Design Methodology.md
---

# Atomic Design

Atomic Design is Brad Frost's answer to "how do I organize 200 React components without losing my mind?" Break the interface into five levels — atoms, molecules, organisms, templates, pages — so every component has a clear place in the hierarchy. It's not rocket science. It's chemistry metaphors applied to CSS.

## The Five Levels

```
Atoms → Molecules → Organisms → Templates → Pages
```

### 1. Atoms
The raw materials — buttons, inputs, labels. Useless alone, foundational for everything else. No state, no logic, just "here's a styled thing."

### 2. Molecules
Functional groups of atoms wired together. A search bar is an input + button + icon. Still simple — maybe a little local state — but now it *does* something.

### 3. Organisms
Complex UI sections built from molecules and atoms. Headers, footals, navigation bars. These have real state, real side effects, and get reused across pages.

### 4. Templates
Page layouts with content structure but no real content. Place your organisms into spatial relationships. This is where you decide *where* things go before you know *what* they say.

### 5. Pages
Templates with real content. What users actually see. Multiple pages per template. The final product.

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

The pattern keeps complexity where it belongs. Atoms stay dumb. Organisms hold the brain. Pages just compose. It's the same separation-of-concerns idea behind [[backend-for-frontend]] — different scope, same principle. The open thread: atomic design assumes a *hierarchical* UI. What happens when your interface is spatial or non-linear? Then the five levels start feeling like shoe-horning.

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
