---
description: "Robert C. Martin's Clean Code principles adapted for JavaScript with practical bad/good examples"
tags: [software-engineering, javascript, clean-code, best-practices, coding-standards]
sources: [ryanmcdermottclean-code-javascript Clean Code concepts adapted for JavaScript.md]
created: 2026-04-22
updated: 2026-04-22
---

# Clean Code JavaScript

**Source:** ryanmcdermottclean-code-javascript Clean Code concepts adapted for JavaScript.md
**Date ingested:** 2026-04-22
**Type:** guide

## Summary

A comprehensive guide adapting Robert C. Martin's *Clean Code* principles to JavaScript. Covers 11 major areas with concrete bad/good code examples: variables, functions, objects and data structures, classes, SOLID principles, testing, concurrency, error handling, formatting, and comments. The guide emphasizes that these are guidelines, not rigid rules, and that code quality improves through iterative review rather than perfect first drafts.

## Key Claims

- The most important rule in software engineering: functions should do one thing
- Limit function arguments to 2 or fewer; use destructured objects for more parameters
- Avoid side effects — functions should take values in and return values out
- Favor functional programming (map, filter, reduce) over imperative loops
- Prefer composition over inheritance; use inheritance only for "is-a" relationships
- Testing is more important than shipping — aim for 100% coverage of statements and branches
- Use Promises and async/await over callbacks for cleaner asynchronous code
- Comments are an apology, not a requirement — good code mostly documents itself
- Don't argue over formatting — use automated tools and be consistent

## Major Sections

### Variables
- Use meaningful, pronounceable, and searchable names
- Use the same vocabulary for the same type of variable
- Use explanatory variables and avoid mental mapping
- Don't add unneeded context (e.g., `car.carMake` -> `car.make`)
- Use default parameters instead of short-circuiting

### Functions
- 2 or fewer arguments (use destructured objects for more)
- Functions should do one thing (single level of abstraction)
- Remove duplicate code via abstraction
- Don't use flags as function parameters
- Avoid side effects; clone objects/arrays when mutating
- Don't write to global functions (extend via ES6 classes)
- Encapsulate conditionals in named functions
- Avoid negative conditionals

### Objects and Data Structures
- Use getters and setters for encapsulation, validation, and lazy loading
- Make objects have private members via closures

### Classes
- Prefer ES2015/ES6 classes over ES5 plain functions
- Use method chaining (return `this`)
- Prefer composition over inheritance

### SOLID Principles
- **SRP:** A class should have only one reason to change
- **OCP:** Open for extension, closed for modification
- **LSP:** Subtypes must be substitutable for their base types
- **ISP:** Don't force clients to depend on interfaces they don't use
- **DIP:** Depend on abstractions, not concrete implementations (use DI)

### Testing
- Single concept per test
- Use a good coverage tool alongside a testing framework

### Concurrency
- Use Promises, not callbacks
- Use async/await over Promise chains

### Error Handling
- Don't ignore caught errors or rejected promises
- Use `console.error`, `notifyUserOfError`, `reportErrorToService`

### Formatting
- Use consistent capitalization
- Keep function callers and callees vertically close

### Comments
- Only comment business logic complexity
- Don't leave commented-out code (use version control)
- Don't write journal comments (use git log)
- Avoid positional markers

## Concepts Covered

- [[airbnb-react-patterns]] — complementary JavaScript coding standards
- [[why-we-banned-useeffect]] — related theme of clean React patterns
- [[container-presentational-pattern]] — clean separation of concerns in components
- [[component-testing]] — testing practices aligned with clean code principles
- [[event-handling-react-interviews]] — practical application of clean function design

## Cross-References

- [[airbnb-react-patterns]] — Airbnb's JavaScript/React style guide
- [[why-we-banned-useeffect]] — clean code applied to React effects
- [[container-presentational-pattern]] — separation of concerns pattern
- [[fallow-dead-code-detection]] — practical tool for removing dead code (a clean code principle)
- [[dsa-learning-journey]] — algorithmic thinking paired with clean code practices
- [[designing-component-apis]] — clean API design for React components
