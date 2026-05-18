---
description: Atomic Design methodology for component hierarchies
tags:
  - source
  - react
  - atomic-design
  - component-architecture
  - design/systems
sources:
  - ⚛️Atomic Design Methodology.md
created: 2026-04-09
updated: 2026-04-09
---

# Atomic Design Methodology

**Source:** raw/02_reference/software-engineer/frontend/Patterns/⚛️Atomic Design Methodology.md
**Date ingested:** 2026-04-09
**Type:** Architecture methodology

## Summary

Atomic Design breaks down UI into five distinct levels: Atoms, Molecules, Organisms, Templates, and Pages. This methodology creates a hierarchical component structure from foundational elements to complete pages.

## The Five Levels

### 1. Atoms
Basic building blocks — buttons, inputs, labels. Individual components not useful alone but fundamental for building larger components.

### 2. Molecules
Groups of atoms forming functional units. Example: a form molecule includes label, input, and submit button atoms.

### 3. Organisms
Complex UI components composed of molecules and/or atoms. Larger sections like header, footer, or navigation bar. Can have their own state and functionality.

### 4. Templates
Page-level objects placing components into layouts. Articulate the design's underlying content structure. Usually consist of groups of organisms.

### 5. Pages
Specific instances of templates with real representative content. Serve as ecosystems displaying different template renders.

## React Implementation

```tsx
// Atoms
const Button = ({ onClick, children }) => <button onClick={onClick}>{children}</button>;
const Input = ({ id, type, onChange }) => <input id={id} type={type} onChange={onChange} />;
const Label = ({ htmlFor, children }) => <label htmlFor={htmlFor}>{children}</label>;

// Molecules
const Form = ({ onSubmit }) => (
  <form onSubmit={onSubmit}>
    <Label htmlFor="email">Email:</Label>
    <Input id="email" type="email" />
    <Button type="submit">Submit</Button>
  </form>
);

// Organisms
const Header = () => (
  <header>
    <Search onChange={noop} />
    <NavMenu items={[]} />
  </header>
);

// Templates
const MainTemplate = ({ children }) => (
  <>
    <Header />
    <Content>{children}</Content>
  </>
);

// Pages
const HomePage = () => (
  <MainTemplate>
    <h2>My Form</h2>
    <p>Welcome to the application.</p>
  </MainTemplate>
);
```

## Key Considerations

- **Component Categorization:** Organize into atoms/molecules/organisms/templates/pages in file structure
- **State Management:** Atoms/molecules may not hold state; organisms/templates might need to
- **Documentation:** Use Storybook for living style guide

## Entities Mentioned

- [[react-patterns]] — UI component library
- [[Storybook]] — Component documentation tool

## Concepts Covered

- [[atomic-design]] — Hierarchical component methodology
- [[component-categorization]] — Organizing by complexity level
- [[design-systems]] — Structured component libraries
