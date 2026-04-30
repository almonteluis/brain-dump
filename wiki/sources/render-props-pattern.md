---
description: Passing JSX through function props for component reusability, largely replaced by hooks but still useful in specific cases
tags: [react, design-patterns, frontend]
sources: [Render Props Pattern.md]
created: 2026-04-16
updated: 2026-04-16
---

# Render Props Pattern

**Source:** Render Props Pattern.md
**Date ingested:** 2026-04-16
**Type:** article

## Summary

The render props pattern enables component reusability by passing JSX elements through a function prop. A render prop is a prop whose value is a function that returns a JSX element. The receiving component calls this function instead of implementing its own rendering logic, allowing the caller to control what gets rendered while the component handles data or behavior. Any prop that renders JSX is considered a render prop -- it does not need to be named `render`.

The article demonstrates progressive examples: a basic `Title` component that calls `props.render()`, a temperature converter where an `Input` component passes its internal value to child components via `props.render(value)`, and a children-as-a-function variant where `props.children(value)` replaces the named render prop. This pattern solves the same problems as Higher-Order Components (reusability, data sharing) while avoiding HOC issues like naming collisions and implicit props, since data flow is explicit in the function arguments.

However, React Hooks have largely replaced render props. The article shows Apollo Client's evolution from `<Mutation render={addMessage => ...}>` to `const [addMessage] = useMutation(ADD_MESSAGE)`, eliminating deeply nested "callback hell" from stacking multiple render prop components. Modern best practice favors hooks because they do not create new component boundaries, allow more direct state sharing, and enable better static analysis by the React Compiler. Render props remain valid but should prompt the question: could a custom hook achieve the same result more directly?

## Key Claims

- A render prop is any prop whose value is a function that returns JSX, not just one named `render`
- The pattern solves HOC problems like naming collisions and implicit props by making data flow explicit
- Children-as-a-function is a variant where `props.children` is used as the render prop
- Deeply nested render props create "callback hell" when multiple data sources are needed
- Hooks replace render props in most cases -- they avoid component boundary overhead and enable better compiler optimization

## Concepts Covered

- [[render-props-pattern]] -- Passing JSX through function props to decouple rendering from data/behavior logic
- [[custom-hooks]] -- Modern replacement for render props; encapsulate stateful logic without creating wrapper components
- [[higher-order-components]] -- Predecessor to render props for logic sharing; both largely replaced by hooks
- [[container-presentational-pattern]] -- Related pattern; render props also separate logic from presentation
- [[children-prop]] -- React's `props.children` can serve as a render prop when passed as a function
