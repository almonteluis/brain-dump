---
description: Database schema for A/B testing — flag history, observations, and speculative data tables for experiment analytics
tags: [source, database, schema, ab-testing, feature-flags, analytics]
sources: ["Experiments - Technical Documentation.md"]
created: 2026-04-09
updated: 2026-04-09
---

# Experiment Database Schema

**Source:** `raw/00_inbox/work docs/Experiments - Technical Documentation.md`
**Date ingested:** 2026-04-09
**Type:** Technical schema

## Summary

Three-table schema for tracking feature flag experiments: flag history (user assignments), observations (metrics), and speculative data (cross-session persistence).

## Schema Overview

| Table | Purpose |
|-------|---------|
| `experiments_flag_history` | Track which users saw which flag variants |
| `experiments_observations` | Log experiment metrics and events |
| `experiments_speculative_data` | Persist user data across sessions for experiments |

---

## experiments_flag_history

Tracks user assignments to flag variants over time.

| Column | Type | Not Null | Default | Description |
|--------|------|----------|---------|-------------|
| `id` | integer | ✓ | | Primary key |
| `user_id` | integer | ✓ | | FK to users.id |
| `flag_name` | varchar | ✓ | | Feature flag identifier |
| `variant_name` | varchar | ✓ | | Assigned variant (control/treatment) |
| `created_by_id` | integer | ✓ | | FK to users.id |
| `created_on` | timestamptz | ✓ | now() | Assignment timestamp |

### Indexes

| Name | Unique | Columns | Use Case |
|------|--------|---------|----------|
| `experiments_flag_history_pkey` | ✓ | id | |
| `experiments_flag_history_user_id_flag_name_created_on_idx` | | user_id, flag_name, created_on | Reconstruct experimental state at a given time |

**Use case:** Analytics tracking existing metrics across multiple experiment lifecycles. Enables segmenting analyses by when users were in test conditions.

---

## experiments_observations

Stores experiment-agnostic metrics for QuickSight dashboards.

| Column | Type | Not Null | Description |
|--------|------|----------|-------------|
| `id` | integer | ✓ | Primary key |
| `user_id` | integer | ✓ | FK to users.id |
| `flag_name` | varchar | ✓ | Feature flag identifier |
| `variant_name` | varchar | ✓ | Variant at time of observation |
| `observation_type` | varchar | ✓ | Type of metric (see below) |
| `observation` | numeric | ✓ | The measured value |
| `created_by_id` | integer | ✓ | FK to users.id |
| `created_on` | timestamptz | ✓ | now() |

### Indexes

| Name | Columns | Use Case |
|------|---------|----------|
| `experiments_observations_flag_name_observation_type_idx` | flag_name, observation_type | Filter data for experiment metric comparison across variants |

### Observation Types

| Type | Value Pattern | Analysis |
|------|---------------|----------|
| **Clicked button** | 1 (count) | Sum per user |
| **Passed test** | 0/1 (boolean) | Mean per user |
| **Time to complete** | Seconds (float) | Median per user |
| **Student-reported affect** | Likert scale | Distribution analysis |

**Dashboard usage:** Filter by flag_name → observation_type, compare histograms (sums, medians, means) across variants.

---

## experiments_speculative_data

Persists user data across sessions for features that may not be permanent.

| Column | Type | Not Null | Default | Description |
|--------|------|----------|---------|-------------|
| `id` | integer | ✓ | | Primary key |
| `user_id` | integer | ✓ | | FK to users.id |
| `flag_name` | varchar | ✓ | | Feature flag identifier |
| `variant_name` | varchar | ✓ | | Assigned variant |
| `payload` | jsonb | ✓ | {} | Arbitrary experiment data |
| `created_by_id` | integer | ✓ | | FK to users.id |
| `created_on` | timestamptz | ✓ | now() | |
| `modified_by_id` | integer | | | FK to users.id |
| `modified_on` | timestamptz | | | |

### Indexes

| Name | Unique | Columns | Use Case |
|------|--------|---------|----------|
| `experiments_speculative_data_pkey` | ✓ | id | |
| `experiments_speculative_data_flag_name_idx` | | flag_name | Analytics access by experiment |
| `experiments_speculative_data_user_id_flag_name_variant_name_idx` | ✓ | user_id, flag_name, variant_name | Enforce uniqueness; load all experiment data for one user |

**Use case:** Persist UI state, partial progress, or temporary preferences that shouldn't go to permanent tables during experiments.

---

## Variant Name Mapping

Unleash variant conventions → Database storage:

| Unleash State | Stored Value | Notes |
|---------------|--------------|-------|
| Toggle OFF | `control` | Not returned by Unleash; remapped from NULL |
| Toggle ON, single/no variant | `treatment` | Unleash returns "disabled"; remapped |
| Toggle ON, multiple variants | Variant name | Preserved as-is |

**Result:** All flag states have a `variant_name` string identifying the test condition.

## Key Concepts

- [[experiment-tracking]] — Analytics infrastructure
- [[flag-variants]] — Control vs treatment assignment
- [[observation-types]] — Metric categorization
- [[speculative-data]] — Cross-session experiment persistence
