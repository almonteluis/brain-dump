---
description: Separation of data-fetching Container components from presentational UI components, and how React Hooks replaced this pattern
tags:
  - react
  - design/patterns
  - frontend
sources:
  - ContainerPresentational Pattern.md
created: 2026-04-16
updated: 2026-04-16
---

# Container/Presentational Pattern

**Source:** ContainerPresentational Pattern.md
**Date ingested:** 2026-04-16
**Type:** article

## Summary

The Container/Presentational pattern enforces separation of concerns in React by splitting components into two categories. Presentational components care about how data is shown -- they receive data through props, render the UI, and are typically stateless. Container components care about what data is shown -- they handle data fetching, state management, and pass data to presentational children. Container components usually contain no styling and do not render anything besides their presentational counterparts.

The article demonstrates this with a dog images example: a `DogImages` presentational component that maps over image URLs and renders `<img>` tags, paired with a `DogImagesContainer` class component that fetches images from an API in `componentDidMount` and passes them as props. The pattern promotes reusability (presentational components can be reused anywhere), testability (pure functions are easy to test), and clean separation between logic and view.

However, React Hooks have largely replaced this pattern. Custom hooks like `useDogImages` can encapsulate data-fetching logic, and any component can simply call `const dogs = useDogImages()` to get the data. This achieves the same separation of concerns with less boilerplate and no wrapper component. Modern React strongly favors hooks over container components, and the React Compiler can better optimize functional components with hooks than class lifecycles.

## Key Claims

- Presentational components receive data via props, render UI, and are typically stateless pure functions
- Container components handle data fetching and state management, passing data to presentational children
- React Hooks replaced the need for container components -- custom hooks can encapsulate the same logic with less boilerplate
- The pattern can be overkill in smaller applications even when using hooks
- The React Compiler can better optimize functional components and hooks than class-based container lifecycles

## Concepts Covered

- [[container-presentational-pattern]] -- Separating data logic (Container) from UI rendering (Presentational) in component architecture
- [[custom-hooks]] -- React hooks that encapsulate reusable stateful logic, replacing class-based container components
- [[separation-of-concerns]] -- Design principle of isolating data fetching from view rendering
- [[observer-pattern]] -- Related pattern for reactive data flow between components
- [[render-props-pattern]] -- Alternative pattern for sharing logic between components, also largely replaced by hooks
