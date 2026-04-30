---
description: Event tracking, logging, and observation patterns for understanding user behavior and system performance
tags: ["telemetry", "logging", "analytics", "observability", "concept"]
created: 2026-04-30
updated: 2026-04-30
sources: ["teame-203-assignment-creation-logging", "teame-246-assignment-creation-logging"]
---

# Telemetry

Telemetry is the automated collection and transmission of data from applications to understand user behavior, system performance, and feature usage.

## Patterns

### Event-Based Tracking

Log discrete events with context:

```
event: assignment_created
timestamp: 2026-02-11T17:07:49Z
user_id: 17
experiment: assignment_creation_patterns
variant: control
observations:
  - student_count: 23
  - skill_code: "MATH-7-01"
  - assignment_method: skill
```

### Observation Tables

Store in structured tables like `experiments_observations`:
- `experiment_name` — Which experiment/tracking group
- `variant` — A/B test variant
- `observation_key` — What was measured
- `observation_value` — The measurement
- `user_id` — Who triggered it

## Frontend Integration Patterns

1. **Track at action point** — Log when user performs action (e.g., clicks "Create Assignment")
2. **Extract from mutation input** — Pull IDs directly from GraphQL mutation variables
3. **Backend lookups** — Query related data (curriculum, roadmap, unit) from backend
4. **Redux state** — Read context from application state (current page, filters, selections)

## Common Pitfalls

- **Over-fetching for telemetry** — Don't fetch heavy data just for logging; pass what you already have
- **Page-specific context** — Some data only available on certain pages (e.g., roadmap ID on units page but not skills page)
- **Performance impact** — Additional queries for telemetry can slow down user actions
- **Ambiguous field names** — "Target" can mean target group, target skill, or unit target; be precise

## Related

- [[teame-203-assignment-creation-logging]] — Assignment creation telemetry implementation
- [[teame-246-assignment-creation-logging]] — Readiness score tracking extension
- [[experiments-observations]] — Database table pattern for event storage
- [[graphql-schema-evolution]] — Adding telemetry fields to existing types
