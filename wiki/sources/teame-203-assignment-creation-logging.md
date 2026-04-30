---
description: Experimental logging of how teachers create assignments to identify intentional usage patterns and curriculum alignment strategies
tags: ["TEAME-203", "telemetry", "logging", "experiments", "assignment-creation", "graphql"]
sources: ["TEAME-203.md", "Working status of 203.md"]
created: 2026-04-30
updated: 2026-04-30
---

# TEAME-203: Experimental Logging of Teacher Assignment Creation

**Source:** TEAME-203.md, Working status of 203.md
**Date ingested:** 2026-04-30
**Type:** work-ticket
**Ticket:** TEAME-203
**Status:** Partially complete

## Summary

Log telemetry data when teachers create assignments to identify intentional usage patterns vs "set it and forget it" usage. Goal: understand what patterns in assignments and curriculum alignment strategies teachers use.

## What Was Implemented

### Completed Fields

| Field | Status | Notes |
|-------|--------|-------|
| `assignment_created` event marker | Done | Basic event tracking |
| `student_count` | Done | Total students assigned |
| `assignment_method_skill` | Done | Skill vs pathway assignment method |
| `skill_type_target` | Done | Target skill flag (units page only) |
| `skill_code` | Done | Skill identifier passed |

### Partially Implemented

| Field | Status | Notes |
|-------|--------|-------|
| `curriculum_id` / `roadmap_id` | Partial | Stored in Redux slice, working on units page only. Skills page not supported. |
| `target_id` | Partial | Treated as unit ID, units page only, not tested on skills page |
| `class_id` | Partial | Available from `input.classIds[0]` but not fully hooked up |

### Not Implemented

| Field | Status | Blocker |
|-------|--------|---------|
| `skill_type_support` | Not done | All skills currently treated as target regardless of unit/roadmap relationship |
| `unit_continuity` | Not done | Requires comparing current unit with previous assignment; performance concerns on local |
| `unit_id` | Not done | Requires backend lookup from Skill |

## Key Technical Details

- Uses `experiments_observations` table for storage
- Not behind a feature flag (logging for existing feature)
- Units page has roadmap context baked in; skills page has different query without roadmap association
- Support skills can belong to multiple units, making unit continuity tracking complex
- Redux site IDs are in `SiteNode:123` format, requiring `split(':')[1]` + `parseInt`

## SQL Verification (from Working status)

```sql
-- Confirmed observations in experiments_observations table
375 17 "assignment_creation_patterns" "control" "student_count" 23 17 "2026-02-11 17:07:49.859876+00"
376 17 "assignment_creation_patterns" "control" "assignment_method_skill" 1 17 "2026-02-11 17:07:49.859909+00"
377 17 "assignment_creation_patterns" "control" "skill_type_target" 1 17 "2026-02-11 17:07:49.86325+00"
378 17 "assignment_creation_patterns" "control" "assignment_created" 1 17 "2026-02-11 17:07:49.859859+00"
379 17 "assignment_creation_patterns" "control" "class_id" 1 17 "2026-02-11 17:07:49.876855+00"
380 17 "assignment_creation_patterns" "control" "skill_code" 659 17 "2026-02-11 17:07:49.877822+00"
```

## Related

- [[teame-246-assignment-creation-logging]] — Related follow-up work on readiness score tracking
- [[telemetry-integration]] — General telemetry patterns
- [[graphql-schema-evolution]] — Adding fields for tracking

## Concepts Covered

- [[telemetry]] — Event tracking and observation logging
- [[redux]] — State management for roadmap/curriculum context
- [[graphql]] — Querying skill and unit relationships
