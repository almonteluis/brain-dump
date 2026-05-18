---
description: Synthesized quick-reference card for Unleash feature flagging — lifecycle diagram, 5-rule containment, FlagSwitch and ExperimentTracker code, decision tree for winner/loser
tags:
  - source
  - feature-flags
  - unleash
  - ab-testing
  - reference
  - reference
sources:
  - Feature Flagging One-Pager.md
created: 2026-05-03
updated: 2026-05-03
---

# Feature Flagging Quick Reference

**Source:** `Feature Flagging One-Pager.md`
**Date ingested:** 2026-05-03
**Type:** Quick-reference card

## Summary

Single-page quick-reference card that pulls together the Unleash workflow into reusable patterns: lifecycle diagram, 5-rule containment checklist, role responsibilities matrix, naming conventions table, code patterns for `FlagSwitch` (containment) and `ExperimentTracker` (logging), and a winner/loser decision tree. Distinguishes A/B Test, LTS, and Disabled flag states.

> **The Deal:** Trade code quality for speed in A/B tests. Pay it back in LTS.

## Lifecycle

```
STAGE 2: A/B Testing
Implementation → Accelerated CR → Accelerated QA → Release → Monitor (1 week target)
                                    │
                    ┌───────────────┴───────────────┐
                    ▼                               ▼
                 Winner                          Loser
                    │                               │
                    ▼                               ▼
              STAGE 3: LTS                    Delete Code
              Rebuild Full Rigor              Archive / Close
```

## 5-Rule Containment Checklist

| # | Rule | Why |
|---|---|---|
| 01 | Conditional rendering | Flag OFF = LTS behavior always |
| 02 | Remote configuration | Deactivate in minutes (15s polling) |
| 03 | Causal logging | Observations tied to variant |
| 04 | Data safety | Mask, don't mutate permanent tables |
| 05 | Auto-expiry | Flags expire 1–4 weeks; cleanup ticket |

## Roles

| Role | Enable | Disable | Responsibility |
|---|:---:|:---:|---|
| **Product Owner** | ✅ | ✅ | Creates flag; monitors data; decides winner/loser |
| **Release Mgmt** | ✅ (prod) | ✅ | Validates config; controls prod rollout |
| **DevOps** | ❌ | ✅ | Monitors `#production-flags`; can disable |
| **Developer** | ❌ | ❌ | Builds in `/experiments/`; records observations |
| **Code Reviewer** | — | — | Validates containment; checks data mutation |
| **QA** | — | — | Validates flag-off; runs regression |

## Naming Conventions

| Type | Pattern | Example |
|---|---|---|
| A/B Test | `TEAME-###-description` | `TEAME-177-brain-break` |
| LTS Shutoff | `LTS-shutoff-TEAME-###-description` | `LTS-shutoff-TEAME-123-new-ui` |
| Release Flag | `release-feature-name` | `release-new-onboarding` |

## Flag States

| State | Unleash Setting | UX |
|---|---|---|
| **A/B Test** | Variants control/treatment 50/50 | Random assignment |
| **LTS** | Default ON, shutoff flag exists | Everyone sees new |
| **Disabled** | No activation strategy | LTS behavior only |

## Code Patterns

### FlagSwitch (containment)

```tsx
<FlagSwitch
  flagId="TEAME-177-brain-break"
  default={<StandardExperience />}
  conditions={{
    control: <StandardExperience />,
    treatment: <BrainBreakExperience />,
  }}
/>
```

### ExperimentTracker (logging)

```tsx
<ExperimentTracker
  userId={`UserNode:${user.id}`}
  flagName="TEAME-177-brain-break"
  variantName={currentPlacement}
  useRealMutation={true}
/>

window.experimentTracker.recordObservation({
  observationType: 'button-clicked',
  observation: 1,
});
```

## Winner/Loser Decision Tree

```
Did the experiment move the metric?
├─ YES → Build LTS version (rebuild from scratch, full rigor)
│         Keep experiment live during LTS build
│         Retire experiment flag after LTS ships
└─ NO  → Delete experiment code
         Archive flag in Unleash
         Document learnings
         Close cleanup ticket
```

## Escape Hatch

**Broken in prod:**
1. Turn flag OFF in Unleash (15s propagation)
2. Post in `#production-flags`
3. Investigate with logs

**Containment rule broken:**
1. Stop the PR
2. Flag the violation
3. Don't merge until containment verified

## Key Claims

- 15-second polling → flags can be killed in minutes, not deploys
- Data safety rule (mask, don't mutate) prevents experiment data from contaminating LTS tables
- Auto-expiry enforces zombie flag cleanup; 1–4 week expiry creates the cleanup ticket automatically
- `FlagSwitch` is the containment mechanism; `ExperimentTracker` is the causal-logging mechanism
- Winner means rebuild from scratch — experiment code is throwaway by design

## Entities Mentioned

- [[unleash]] — Feature flag platform

## Concepts Covered

- [[ab-testing-lifecycle]] — Full lifecycle
- [[experiment-speculative-data]] — Mask-don't-mutate pattern
- [[telemetry]] — Observation logging
- [[lts-transition]] — Winner rebuild path

## Related

- [[unleash-feature-flags]] — Full Unleash guide
- [[unleash-local-development-setup]] — Local docker setup
- [[unleash-one-pager-product]] — Team CR/QA agreement
- [[unleash-release-flag-management-ab-lts]] — A/B vs LTS deep comparison
- [[ab-testing-logging-rollout]] — Logging rollout plan
