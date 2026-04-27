---
description: Quick reference card for feature flagging with Unleash
tags: ["feature-flags", "unleash", "ab-testing", "reference"]
created: 2025-03-05
---

# Feature Flagging with Unleash — Quick Reference

> **The Deal:** Trade code quality for speed in A/B tests. Pay it back in LTS.

---

## The Lifecycle

```
┌─────────────────────────────────────────────────────────────────────────────┐
│                              STAGE 2: A/B Testing                           │
│  Implementation → Accelerated CR → Accelerated QA → Release → Monitor       │
│                                   (1 week target)                          │
└─────────────────────────────────────────────────────────────────────────────┘
                                    │
                    ┌───────────────┴───────────────┐
                    ▼                               ▼
              ┌─────────────┐                 ┌─────────────┐
              │   Winner    │                 │    Loser    │
              └──────┬──────┘                 └──────┬──────┘
                     │                               │
                     ▼                               ▼
              ┌─────────────┐                 ┌─────────────┐
              │  STAGE 3    │                 │    Delete   │
              │    LTS      │                 │    Code     │
              │  Rebuild    │                 │   Archive   │
              │ Full Rigor  │                 │   Close     │
              └─────────────┘                 └─────────────┘
```

---

## Containment Checklist (5 Rules)

| #   | Rule                      | Why It Matters                                 |
| --- | ------------------------- | ---------------------------------------------- |
| 01  | **Conditional rendering** | Flag OFF = LTS behavior always                 |
| 02  | **Remote configuration**  | Deactivate in minutes (15s polling)            |
| 03  | **Causal logging**        | Observations tied to variant                   |
| 04  | **Data safety**           | Mask, don't mutate permanent tables            |
| 05  | **Auto-expiry**           | Flags expire 1–4 weeks; cleanup ticket created |

---

## Accelerated Code Review

**Review everything OUTSIDE `/experiments/`** → Full rigor (clean, correct, concise)

**Inside `/experiments/`** → Check ONLY:

- [ ] All code in `/experiments/[ticket-#]/`
- [ ] Imports guarded behind feature flag
- [ ] No hardcoded variant names
- [ ] **No mutations to non-experiment tables**

**Do NOT check inside `/experiments/`:** Code quality, style, best practices — that's the deal.

---

## Accelerated QA

**TEST:**
- [ ] Flag OFF behavior works
- [ ] Automated regression passes
- [ ] Non-experimental functionality unaffected
- [ ] Observations appear in database

**SKIP:**
- Experimental feature usability
- Experiment activation correctness
- Feature completeness

---

## Roles

| Role | Can Enable Flags | Can Disable Flags | Responsibilities |
|------|:----------------:|:-----------------:|-------------------|
| **Product Owner** | ✅ | ✅ | Creates flag; monitors data; decides winner/loser |
| **Release Mgmt** | ✅ (production) | ✅ | Validates config; controls production rollout |
| **DevOps** | ❌ | ✅ | Monitors `#production-flags`; can disable |
| **Developer** | ❌ | ❌ | Builds in `/experiments/`; records observations |
| **Code Reviewer** | — | — | Validates containment; checks data mutation |
| **QA** | — | — | Validates flag-off behavior; runs regression |

---

## Naming Conventions

| Type         | Pattern                             | Example                        |
| ------------ | ----------------------------------- | ------------------------------ |
| A/B Test     | `TEAME-###-description`             | `TEAME-177-brain-break`        |
| LTS Shutoff  | `LTS-shutoff-TEAME-###-description` | `LTS-shutoff-TEAME-123-new-ui` |
| Release Flag | `release-feature-name`              | `release-new-onboarding`       |

---

## Flag States

| State | Unleash Setting | User Experience |
|-------|-----------------|-----------------|
| **A/B Test** | Variants: control/treatment, 50/50 rollout | Random assignment |
| **LTS** | Default ON, shutoff flag exists | Everyone sees new feature |
| **Disabled** | No activation strategy | LTS behavior only |

---

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

// Record observations
window.experimentTracker.recordObservation({
  observationType: 'button-clicked',
  observation: 1,
});
```

---

## Decision Tree: Winner or Loser?

```
Did the experiment move the metric?
│
├─ YES → Build LTS version (rebuild from scratch, full rigor)
│         Keep experiment live during LTS build
│         Retire experiment flag after LTS ships
│
└─ NO  → Delete experiment code
         Archive flag in Unleash
         Document learnings
         Close cleanup ticket
```

---

## Escape Hatch

**Something broken?**
1. Turn flag OFF in Unleash (takes 15 seconds to propagate)
2. Post in `#production-flags`
3. Investigate with logs

**Rule broken?**
1. Stop the PR
2. Flag the violation to the team
3. Don't merge until containment is verified

---

*Questions? See the full guide: [[feature-flagging-experiment-logging-guide]]*
