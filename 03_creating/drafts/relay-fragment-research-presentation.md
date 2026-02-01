---
description: Working note for Relay fragment research and presentation preparation - track progress, issues, and fixes
tags: #leadership #relay #presentation #work-in-progress
date: 2026-01-31
---

# Relay Fragment Research & Presentation

## Status
🚧 **In Progress** — Research phase

## Goal
Research how Relay's fragments benefit our codebase and present findings to the team.

## Vault Knowledge Base

Starting point — existing notes to draw from:

- [[Relay Fragment Composition]] — Fragment composition mirrors React component composition, enabling isolated component development
- [[Fragment References]] — Opaque objects Relay uses to read data, enabling data masking and component isolation
- [[Data Masking in Relay]] — Components only see data they declare, preventing accidental coupling
- [[Relay GraphQL Fragments]] — Core fragment concepts and usage patterns
- [[relay-alias-directive]] — Using @alias for deduplicating data

## Key Points to Cover

### What Problems Do Fragments Solve?

1. **Colocation** — Data requirements live next to components that use them
2. **Type Safety** — Generated Flow/Typescript types enforce correct usage
	1. For fragments must import fragment $key to pass to $ref. 
	2. This solves knowing which fragment is what without mixing them up
3. **Data Masking** — Components can only access fields they explicitly declare
4. **Single Query** — All fragments compose into one efficient network request
5. **Local Modification** — Change component data needs without touching parents

### Common Misconceptions

| Misconception | Reality |
|---------------|----------|
| "Fragments = duplicate queries" | Fragments compose into ONE query |
| "Parents need to know child data" | Parents just spread child fragment, don't see child's fields |
| "Adding fields breaks everything" | Local changes propagate automatically via compiler |

## Implementation Log

### 2026-01-31
- ✅ Created research note
- ✅ Linked existing vault content
- [x] Audit current codebase for fragment usage patterns {there none}
- [x] Identify components NOT using fragments that should {all components NOT using fragments}
- [ ] Gather performance metrics (before/after fragment adoption)
- [ ] Create presentation outline

## Questions to Answer

1. Where are we NOT using fragments but should be?
2. What's the performance impact of fragments vs manual queries?
3. How do we onboard new developers to fragment composition?
4. What are the common pitfalls and how do we avoid them?

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
	- {at first just pass any type into $ref}
	- {then run npm run relay then import the fragment query $key. Not sure if we need to use $data}

### Section 3: Our Codebase (10 min)
- Current state analysis
- Opportunities for improvement
- Before/after examples from our code

### Section 4: Q&A (5 min)

## Issues & Fixes

<!-- Track issues encountered and how you fixed them -->

## Next Actions

- [ ] Schedule presentation slot with team
- [ ] Audit 3 key components for fragment opportunities
- [ ] Prepare 2-3 before/after code examples
