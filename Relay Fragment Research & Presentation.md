---
description: Research notes for Relay fragment presentation — all vault resources linked
tags: #leadership #relay #presentation #research
date: 2026-01-31
---

# Relay Fragment Research & Presentation

## Vault Knowledge Base

All relay fragment related notes from the vault:

### Core Concepts
- [[Relay Fragment Composition]] — Fragment composition mirrors React component composition, enabling isolated component development
- [[Fragment References]] — Opaque objects Relay uses to read data, enabling data masking and component isolation
- [[Data Masking in Relay]] — Components only see data they declare, preventing accidental coupling
- [[Relay GraphQL Fragments]] — Core fragment concepts and usage patterns

### Advanced Patterns
- [[relay-alias-directive]] — Using @alias for deduplicating data when fragment fields collide
- [[relay-query-refactoring-guide]] — Techniques for refactoring Relay queries and fragments

### Related Sessions
- [[session-2026-01-29-relay-fragments]] — Session notes on Relay fragments

### Inbox Items (To Process)
- [[Relay GraphQL Fragments]] — Link capture from inbox

## Key Insights

### The Golden Rule
> Each React component is responsible for fetching the data dependencies of its direct children — just as it has to know about its children's props to render them correctly.

### What Problems Do Fragments Solve?

1. **Colocation** — Data requirements live next to components that use them
2. **Type Safety** — Generated Flow/Typescript types enforce correct usage
3. **Data Masking** — Components can only access fields they explicitly declare
4. **Single Query** — All fragments compose into one efficient network request
5. **Local Modification** — Change component data needs without touching parents

### Common Misconceptions

| Misconception | Reality |
|---------------|----------|
| "Fragments = duplicate queries" | Fragments compose into ONE query |
| "Parents need to know child data" | Parents just spread child fragment, don't see child's fields |
| "Adding fields breaks everything" | Local changes propagate automatically via compiler |

## Presentation Outline

### Section 1: The Problem (5 min)
- Data requirements scattered from components
- Type safety gaps
- Over-fetching and under-fetching
- Tight coupling between parent/child data

### Section 2: Relay Fragments (10 min)
- What are fragments?
- Fragment composition pattern
- Data masking and isolation
- Type safety at compile time

### Section 3: Our Codebase (10 min)
- Current state analysis
- Opportunities for improvement
- Before/after examples from our code

### Section 4: Q&A (5 min)

## Next Actions

- [ ] Schedule presentation slot with team
- [ ] Audit 3 key components for fragment opportunities
- [ ] Prepare 2-3 before/after code examples
