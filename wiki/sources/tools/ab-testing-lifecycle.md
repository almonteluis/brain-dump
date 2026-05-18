---
description: Complete A/B testing lifecycle — experiment design, accelerated code review, QA, LTS transition
tags:
  - source
  - ab-testing
  - feature-flags
  - unleash
  - qa
  - code/review
  - experimentation
sources:
  - Experiment Lifecycle, QA + Code Review.md
created: 2026-04-09
updated: 2026-04-09
---

# A/B Testing Lifecycle Guide

**Source:** `raw/00_inbox/work docs/Experiment Lifecycle, QA + Code Review.md`
**Date ingested:** 2026-04-09
**Type:** Process guide

## Summary

Three-stage A/B testing process: Design → In-Platform Testing → Long-Term Support (LTS). Emphasizes speed through containment — trade code quality for learning speed, then pay off debt with proper LTS implementation.

## The Three Stages

### Stage 1: Design Experiments (Before Code)

Product team validates ideas before engineering:
- User interviews
- HotJar / analytics review
- Figma prototypes with UseBerry recordings

**Goal:** Confidence before writing code.

---

### Stage 2: In-Platform A/B Testing

**Target cycle:** Implement → Review → Deploy → Analyze within **one week**.

#### 1. Label Everything
- **Jira ticket:** Labels `A/B Test` + `Automated Regression Checks Only`
- **Cleanup ticket:** Created upfront, linked, with deadline
- **Git branch:** `experiment/TEAM?-####-short-description`

#### 2. Feature Flag Containment
- Code only runs when flag is ON
- Flag defaults to OFF
- Can turn off in ~15 seconds via Unleash
- Flags auto-expire after 1-4 weeks

#### 3. Code Containment Rules
- All experiment code in `/frontend/src/experiments/[ticket-#]`
- Imports from experiments MUST be wrapped in feature flag
- **No new data mutations** — use `experiments_speculative_data` table for masking
- Must pass unit tests and Prettier

#### 4. Accelerated Code Review

**Review OUTSIDE experiments folder:**
- Is it clean, correct, concise?
- Is experiment code safely behind flag?
- Are data-mutating endpoints NOT passed through props?

**Inside experiments folder — ONLY check:**
- No imports of GraphQL endpoints that mutate non-experiment tables

**Do NOT check:**
- Code quality inside experiments folder
- Engineering best practices

**The deal:** Trade quality for speed, knowing code will be deleted soon.

#### 5. Accelerated QA

**QA checks:**
- Does flag-off case work? (Critical)
- Does rest of platform still work?
- Automated regression runs with flag OFF

**QA does NOT check:**
- Usability of experimental feature
- Whether experiment activates correctly

#### 6. Release Management
- Confirm flag configuration (audience, rollout, cutoff)
- Confirm ability to toggle off in demo
- No UAT needed

#### 7. After Release: Monitor and Decide
- Active flags logged to `#production-flags` Slack
- Only Release Management can turn flags ON
- PO and DevOps can turn flags OFF

**Decision:**
- **Winner?** Start building LTS version (keep experiment live)
- **Loser?** Kill experiment, delete code, close cleanup ticket

---

### Stage 3: Long-Term Support (LTS)

**The idea:** Build it for real. Full rigor, no shortcuts.

| Aspect | A/B Test | LTS |
|--------|----------|-----|
| **Code review** | Fast-tracked (containment only) | Full rigor |
| **QA** | Tests flag-off only | Tests everything |
| **Testing scope** | "Does it break anything?" | "Does it work correctly?" |
| **Flag behavior** | Default OFF | Default ON (shutoff if broken) |
| **Flag name** | `TEAME-###-description` | `LTS-shutoff-###-description` |
| **Lifetime** | 1 week – 3 months | ~3 months, then delete flag |

### LTS Process

1. **Engineers rebuild properly** — New code, not refactored experiment
2. **Full code review** — No shortcuts
3. **Full QA** — Usability testing, bug hunting, automation updates
4. **Release with inverted flag** — Exists to shut OFF if broken
5. **Monitor for months** — If stable, delete flag and old code

---

## The Deal

**A/B tests trade code quality for speed.** Accept technical debt because code will be deleted.

**LTS pays off that debt.** Build the permanent version properly.

Containment rules make this safe. Break them, break the system.

## Key Concepts

- [[feature-flags]] — Unleash integration
- [[experiment-containment]] — Isolating experimental code
- [[accelerated-review]] — Fast-track for experiments
- [[technical-debt]] — Conscious trade-off for speed
- [[lts-transition]] — Building permanent features
- [[experiment-speculative-data]] — Storing experiment data without core table mutations
- [[observability]] — Monitoring and logging for confident deployment
