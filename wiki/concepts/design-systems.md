---
description: Design systems — reusable component libraries with shared tokens, patterns, and documentation
tags: ["design-systems", "ui", "components", "architecture", "concept"]
created: 2026-04-23
---

# Design Systems

A design system is a collection of reusable components, guided by clear standards, that can be assembled to build any number of applications. It's the single source of truth for an organization's UI.

## Core Components

| Layer | What | Examples |
|-------|------|---------|
| **Tokens** | Colors, spacing, typography, shadows | CSS variables, design tokens JSON |
| **Components** | Buttons, inputs, cards, modals | React components, Storybook stories |
| **Patterns** | Form validation, data tables, search | Composition of components |
| **Documentation** | Usage guidelines, do's/don'ts | Storybook, Zeroheight, Notion |

## Benefits

- **Consistency** — Same UI language across products
- **Speed** — Build from parts, not from scratch
- **Quality** — Tested, accessible components by default
- **Collaboration** — Designers and developers share vocabulary

## Architecture Patterns

1. **Monorepo package** — Components as versioned npm packages
2. **Tailwind-based** — Utility classes + component variants (see [[atomic-design]])
3. **Headless + Styled** — Radix/shadcn pattern — logic separate from visual
4. **Token-driven** — Figma tokens → code tokens via Style Dictionary

## Common Pitfalls

- **Premature abstraction** — Building a system before understanding needs
- **Over-flexibility** — Too many props/variants, becomes unwieldy
- **Documentation debt** — Components without usage examples rot fast
- **Version drift** — Consumers stuck on old versions

## Related

- [[atomic-design]] — Component hierarchy methodology
- [[barrel-files]] — Why barrel exports hurt tree-shaking in component libraries
- [[design-system-builder]] — System design case study
- [[ui-component-libraries]] — 23 curated Tailwind CSS component libraries
- [[component-testing]] — Testing library patterns for components
- [[teame-169-color-definitions]] — Frontend color token update (Figma to code)
