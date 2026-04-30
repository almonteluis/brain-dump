---
description: "Research presentation on Relay fragment composition"
tags: [relay, presentation, research, leadership, fragments]
sources: ["Relay Fragment Research & Presentation.md"]
created: 2026-04-09
updated: 2026-04-09
---

# Relay Fragment Research & Presentation

**Source:** raw/01_thinking/notes/Relay Fragment Research & Presentation.md
**Date ingested:** 2026-04-09
**Type:** thinking note

## Summary

Research compilation for a team presentation on Relay fragments, gathering all vault resources related to fragment composition, data masking, and Relay patterns. The note serves as a knowledge base index and presentation outline for educating a team on proper Relay fragment usage.

## Key Claims

- Fragment composition mirrors React component composition, enabling isolated component development
- Each React component is responsible for fetching data dependencies of its direct children
- Fragments solve five key problems: colocation, type safety, data masking, single query efficiency, and local modification capability
- Common misconception that fragments cause duplicate queries is false — fragments compose into ONE query

## Entities Mentioned

- [[Relay Fragment Composition]] — Fragment composition mirrors React component composition
- [[fragment-references-relay]] — Opaque objects Relay uses to read data
- [[Data Masking in Relay]] — Components only see data they declare
- [[relay-graphql-fragments]] — Core fragment concepts and usage patterns
- [[relay-alias-directive]] — Using @alias for deduplicating data
- [[relay-query-refactoring-guide]] — Techniques for refactoring Relay queries

## Concepts Covered

- [[fragment-composition]] — How fragments compose across components
- [[Data Colocation]] — Data requirements live next to components that use them
- [[data-masking]] — Components can only access fields they explicitly declare
- [[Single Query Pattern]] — All fragments compose into one efficient network request
- [[Local Modification]] — Change component data needs without touching parents

## Presentation Outline

1. **The Problem (5 min)** — Data requirements scattered, type safety gaps, over/under-fetching
2. **Relay Fragments (10 min)** — What are fragments, composition pattern, data masking, type safety
3. **Our Codebase (10 min)** — Current state analysis, improvement opportunities
4. **Q&A (5 min)**

## Related

- [[relay-fragment-composition]]
- [[data-masking-in-relay]]
- [[relay-refactor]]
