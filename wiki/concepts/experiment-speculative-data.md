---
description: Pattern for storing experiment-related transient data without mutating core application tables, using a dedicated speculative data store
tags:
  - pattern
  - experiments
  - ab-testing
  - data/masking
  - graphql
  - concept
created: 2026-04-30
updated: 2026-05-05
sources:
  - brainbreak-context-cleanup-implementation
  - teame-177-in-platform-polling-cleanup
  - ab-testing-lifecycle
  - brainbreak-lts-cooldown-speculative-bugs.md
---

# Experiment Speculative Data

Pattern for storing experiment-related transient data without mutating core application tables. A dedicated table (`experiments_speculative_data`) stores flag-scoped data that can be discarded when experiments end.

## Purpose

- **No core table mutations** during A/B tests — keeps experiment code safely isolated
- **Easy cleanup** — delete speculative rows when experiment ends
- **Cross-device persistence** — unlike localStorage, works across browsers and devices
- **Flag-scoped** — each row tied to a specific experiment flag and variant

## Schema Pattern

```graphql
type ExperimentsSpeculativeData {
  id: ID!
  userId: ID!
  flagName: String!
  variantName: String!
  payload: String  # JSON-encoded experiment-specific data
  createdAt: DateTime!
  updatedAt: DateTime!
}
```

## Usage in BrainBreak

```typescript
// Save cooldown data on completion
commitCooldownMutation({
  variables: {
    input: {
      userId: user.id,
      flagName: BRAIN_BREAK_FLAG_NAME,
      variantName: 'last_completed',
      payload: JSON.stringify({
        lastCompletionDate: newCooldownData.lastCompletionDate,
        completionCount: newCooldownData.completionCount,
      }),
    },
  },
});
```

## Known Bugs

### TEAME-287: `created` column updated instead of `modified`

From [[brainbreak-lts-cooldown-speculative-bugs]] and [[teame-287-speculative-data-created-bug]]:

When a student hits BrainBreak more than once, the `created` column on the active modal row gets bumped instead of `modified`. The original creation timestamp is lost.

**Root cause:** Insert/update logic in the GraphQL mutation or backend service doesn't distinguish between create and update operations on the speculative data table.

**Fix direction:** Ensure `created` is set only on insert, `modified` on update.

## A/B Test Containment Rule

From [[ab-testing-lifecycle]]: **No new data mutations** — use `experiments_speculative_data` table for all experiment state. This is a critical containment rule.

## Assignment Creation Logging — TEAME-203 (2026-05-17)

From [[Working status of 203]]: Concrete fields being captured in the speculative data store when teachers assign work:

| Field | Status | Notes |
|-------|--------|-------|
| `skill_code` | ✅ Done | Supported on both Units and Skills pages |
| `student_count` | ✅ Done | Supported on both pages. Should class size be added for comparison? |
| `assignment_method` (skill vs pathway) | ✅ Done | Supported on both pages |
| `curriculum / roadmap` | ⚠️ Partial | Only Units page — Skills page **not supported** (see [[data-asymmetry-units-skills]]) |
| `skill_type` (target vs support) | ⚠️ Partial | Currently treats all skills as "target" regardless of roadmap relationship |
| `target_id` | ⚠️ Partial | Found the query, treating as unit ID, only Units page |
| `unit_continuity` | ❌ Deferred | Needs separate query comparing last assignment — performance concerns, better as separate ticket |

Key insight: roadmap/curriculum data is only available on the Units page. The Skills page uses a different GraphQL query with no roadmap association. This is the [[data-asymmetry-units-skills]] pattern in action — assignment metadata completeness depends on which page the teacher used.

Source: [[Working status of 203]]

## Related

- [[state-management]] — Speculative data writes are a state-management problem in disguise (graph confirmed via INFERRED edge). See [[speculative-data-as-state-machine]] for state-machine refactor proposal addressing TEAME-287.
- [[speculative-data-as-state-machine]] — Synthesis: state-machine framing for speculative data writes; Path A/B/C for fixing TEAME-287
- [[ab-testing-lifecycle]] — Full A/B testing lifecycle with containment rules
- [[data-masking]] — Relay pattern for hiding experiment data from non-experiment components
- [[brainbreak-context-cleanup-implementation]] — Cooldown data migration to speculative data table
