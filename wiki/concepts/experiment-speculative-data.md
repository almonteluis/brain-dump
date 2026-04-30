---
description: Pattern for storing experiment-related transient data without mutating core application tables, using a dedicated speculative data store
tags: [pattern, experiment, ab-testing, data-masking, graphql, concept]
created: 2026-04-30
updated: 2026-04-30
sources: ["brainbreak-context-cleanup-implementation", "teame-177-in-platform-polling-cleanup", "ab-testing-lifecycle"]
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

## A/B Test Containment Rule

From [[ab-testing-lifecycle]]: **No new data mutations** — use `experiments_speculative_data` table for all experiment state. This is a critical containment rule.

## Related

- [[ab-testing-lifecycle]] — Full A/B testing lifecycle with containment rules
- [[data-masking]] — Relay pattern for hiding experiment data from non-experiment components
- [[brainbreak-context-cleanup-implementation]] — Cooldown data migration to speculative data table
