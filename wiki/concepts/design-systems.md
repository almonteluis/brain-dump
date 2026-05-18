---
description: Design systems — reusable component libraries with shared tokens, patterns, and documentation. The single source of truth for your org's UI.
tags:
  - design/systems
  - ui
  - components
  - architecture
  - concept
created: 2026-04-23
updated: 2026-05-17
---

# Design Systems

A design system is what happens when you get tired of three different teams shipping four different button styles and none of them match the Figma file. It's a shared component library with tokens, patterns, and documentation — the single source of truth for your org's UI.

## What's In It

| Layer | What | Examples |
|-------|------|---------|
| **Tokens** | Colors, spacing, typography, shadows | CSS variables, design tokens JSON |
| **Components** | Buttons, inputs, cards, modals | React components, Storybook stories |
| **Patterns** | Form validation, data tables, search | Compositions of components |
| **Documentation** | Usage guidelines, do's/don'ts | Storybook, Zeroheight, Notion |

## Why Bother

- **Consistency** — same UI language across products, no more "which blue are we using"
- **Speed** — build from parts, not from scratch
- **Quality** — tested, accessible components by default
- **Collaboration** — designers and developers share vocabulary instead of pointing fingers

## Architecture Patterns

1. **Monorepo package** — components as versioned npm packages
2. **Tailwind-based** — utility classes + component variants (see [[atomic-design]])
3. **Headless + Styled** — Radix/shadcn pattern — logic separate from visual
4. **Token-driven** — Figma tokens → code tokens via Style Dictionary

## Where They Rot

- **Premature abstraction** — building a system before understanding needs. You end up with 47 variants of a button nobody asked for.
- **Over-flexibility** — too many props/variants, becomes unwieldy
- **Documentation debt** — components without usage examples die fast
- **Version drift** — consumers stuck on old versions while the system moves on

## Related

- [[atomic-design]] — Component hierarchy methodology
- [[barrel-files]] — Why barrel exports hurt tree-shaking in component libraries
- [[design-system-builder]] — System design case study
- [[ui-component-libraries]] — 23 curated Tailwind CSS component libraries
- [[component-testing]] — Testing library patterns for components
- [[teame-169-color-definitions]] — Frontend color token update (Figma to code)
- [[dependency-injection-nodejs-typescript]] — Same family of patterns: design systems compose UI with shared abstractions, DI composes services with shared abstractions. Both are about decoupling consumers from concrete implementations
