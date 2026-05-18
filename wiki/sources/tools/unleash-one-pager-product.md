---
description: Confluence team one-pager for Unleash workflow including local server setup, accelerated code review/QA protocol, and per-experiment release management checklist
tags:
  - source
  - feature-flags
  - unleash
  - code/review
  - qa
  - releases
  - work
  - product
sources:
  - Edit - Unleash One Pager - PRODUCT.md
created: 2026-05-03
updated: 2026-05-03
---

# Unleash One Pager — PRODUCT

**Source:** `Edit - Unleash One Pager - PRODUCT.md`
**Date ingested:** 2026-05-03
**Type:** Team agreement / process doc

## Summary

PRODUCT-space Confluence one-pager covering the full feature flag lifecycle: local server setup, flag creation, import, frontend connection, **accelerated code review** protocol, **accelerated QA** scope, and **per-experiment release management** checklist. The accelerated CR/QA section is the team's contract for what reviewers and QA inspect (and explicitly skip) inside `/experiments/`.

## Local Server + Flag Creation

Same docker compose flow as [[unleash-local-development-setup]]. Flag creation:

1. **Projects → default**
2. **Add new feature flag**
3. Name (e.g. `TEAME-177-brain-break`)
4. Type = `Experiment` for A/B
5. Add variants with weights

Frontend connect:

```
VITE_UNLEASH_URL=http://localhost:4242/api/frontend
VITE_UNLEASH_CLIENT_KEY=YOUR_KEY
```

API key needs **frontend** scope. Restart dev server after `.env` change.

## Accelerated Code Review

Focus on **risk containment**, not engineering quality inside `/experiments/`.

| What Reviewers Inspect | How |
|---|---|
| Changes **OUTSIDE** `/experiments/` | Reviewed as LTS code — clear, concise, correct |
| Files importing from `/experiments/` | Verify imports are guarded behind feature flag |
| Code **INSIDE** `/experiments/` | Check ONLY for non-experiment table mutations |
| Code quality inside experiments | **NOT inspected** for quality or correctness |

Containment checklist:
- [ ] All experiment code in `/experiments/[ticket-#]/`
- [ ] Uses `FlagSwitch` for conditional rendering
- [ ] No imports outside feature-flagged context

## Accelerated QA

**TEST:**
- Default (flag-off) behavior works
- Automated regression suites pass
- Non-experimental functionality unaffected

**SKIP:**
- Usability of experimental feature
- Correct experiment activation
- Feature completeness

## Per-Experiment Release Management

Validate flag configuration — no UAT of feature itself.

- [ ] Right audiences targeted
- [ ] Rollout plan defined (tier-based per Program Success)
- [ ] Cutoff date set
- [ ] Experiment hidden when flag off
- [ ] Rollback procedure documented
- [ ] PM has monitoring plan

## Key Claims

- Accelerated CR/QA is a team agreement — quality bar inside `/experiments/` is intentionally lowered to ship faster
- LTS code outside `/experiments/` retains full review rigor
- Per-experiment release management replaces traditional UAT — focuses on flag config validity not feature correctness
- Ticket-#-prefixed flag naming maps every experiment to a Jira ticket for traceability

## Entities Mentioned

- [[unleash]] — Feature flag platform

## Concepts Covered

- [[ab-testing-lifecycle]] — Full experiment lifecycle
- [[code-review]] — Containment-focused review
- [[release-management]] — Per-experiment validation gates

## Related

- [[unleash-feature-flags]] — Hierarchy and naming
- [[unleash-local-development-setup]] — Local server tutorial
- [[feature-flagging-quick-reference]] — Quick reference card
- [[ab-testing-lifecycle]] — Experiment lifecycle
- [[experiment-database-schema]] — Backing schema
- [[unleash-release-flag-management-ab-lts]] — A/B vs LTS
