---
description: Unleash feature flag hierarchy, naming conventions, and lifecycle management for controlled rollouts
tags: [source, feature-flags, unleash, devops, rollout]
sources: ["How to Use Unleash.md"]
created: 2026-04-09
updated: 2026-04-09
---

# Unleash Feature Flag Guide

**Source:** `raw/00_inbox/work docs/How to Use Unleash.md`
**Date ingested:** 2026-04-09
**Type:** Tool guide

## Summary

Comprehensive guide to Unleash feature flag hierarchy, naming conventions, and lifecycle management for controlled rollouts and A/B testing.

## Hierarchy

```
Projects (one for Roadmaps)
└── Environments (development, QA, production)
    └── Flags (enable/disable features)
        ├── Constraints (target specific users)
        └── Variants (flavors of altered experience)
```

## Naming Conventions

### A/B Test Flags

Format: `TEAMX-####-short-description`

Examples:
- `TEAME-124-square-icon`
- `TEAMX-####-short-description`

### LTS (Long-Term Support) Flags

Inverted logic: LTS feature is default, old experience is flagged.

Format: `TEAMX-####-LTS-shutoff-description`

Example:
- `TEAME-123456-LTS-shutoff-new-skill-challenges`

## Lifecycle

### 1. Creation

Flags created via [Unleash admin interface](https://app.unleash-hosted.com/sign-in) when flexibility is needed to toggle without redeployment.

Driven by PM-led design efforts identifying experiments to run.

### 2. Active Use

During experiment:
- Flag turned ON for test audience
- Data collected
- Rollout adjusted for different user proportions

### 3. Retirement

Every flag reaches end-of-life:

| Outcome | Action |
|---------|--------|
| **Experiment failed** | Remove code, delete flag, close cleanup ticket |
| **Experiment successful** | Build LTS version, release under LTS flag |

### LTS Transition

1. Remove experimental code and flag references
2. Engineer feature properly for maintainability
3. Release under LTS-shutoff flag (default ON)
4. Monitor for ~3 months
5. If stable: delete flag, feature becomes permanent

**Recommendation:** Archive old flags in Unleash rather than deleting for audit trail.

## A/B Test vs LTS Comparison

See [[unleash-release-flag-management-ab-lts]] for detailed comparison of A/B Test and LTS release patterns including timelines, code review requirements, and rollout strategies.

## Key Concepts

- [[feature-flag-hierarchy]] — Projects → Environments → Flags → Variants
- [[naming-conventions]] — TEAMX-#### format
- [[flag-lifecycle]] — Create → Use → Retire
- [[lts-transition]] — From experiment to permanent feature
