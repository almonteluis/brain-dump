---
description: Five git commands that diagnose codebase health before opening any files
tags: ["git", "codebase-analysis", "technical-debt", "diagnostics"]
sources: ["The Git Commands I Run Before Reading Any Code.md"]
created: 2026-04-09
updated: 2026-04-09
---

# The Git Commands I Run Before Reading Any Code

**Source:** The Git Commands I Run Before Reading Any Code.md (raw, deleted)
**Author:** [[Ally Piechowski]]
**Date ingested:** 2026-04-09
**Type:** Technical reference

## Summary

Five git commands that reveal where a codebase hurts before you open a single file. Identifies churn hotspots, bus factor risks, bug clusters, team momentum, and crisis patterns.

## The Five Commands

### 1. What Changes the Most (Churn Hotspots)

```bash
git log --format=format: --name-only --since="1 year ago" | \
  sort | uniq -c | sort -nr | head -20
```

**Reveals**: 20 most-changed files. Top of list = files people warn about.

**Interpretation**:
- High churn + nobody wants to own it = technical debt hotspot
- High churn alone = may just be active development
- Microsoft Research (2005): churn metrics predict defects better than complexity metrics

**Action**: Cross-reference with bug hotspot command.

---

### 2. Who Built This (Bus Factor)

```bash
git shortlog -sn --no-merges
```

**Reveals**: Contributors ranked by commit count.

**Red flags**:
- One person = 60%+ of commits (bus factor = 1)
- Top contributor not active in 6+ months
- 30 contributors historically, 3 active now

**Caveat**: Squash-merge workflows compress authorship. Check merge strategy first.

---

### 3. Where Do Bugs Cluster

```bash
git log -i -E --grep="fix|bug|broken" --name-only --format='' | \
  sort | uniq -c | sort -nr | head -20
```

**Reveals**: Files with most bug-fix commits.

**High-risk files**: Appear on BOTH churn list AND bug list
- Keep breaking
- Keep getting patched
- Never get properly fixed

**Dependency**: Requires decent commit message discipline.

---

### 4. Is This Project Accelerating or Dying

```bash
git log --format='%ad' --date=format:'%Y-%m' | sort | uniq -c
```

**Reveals**: Commit count by month, entire repo history.

**Patterns to look for**:
| Pattern | Meaning |
|---------|---------|
| Steady rhythm | Healthy |
| 50% drop in one month | Someone left |
| Declining curve (6-12 mo) | Losing momentum |
| Periodic spikes | Batched releases vs continuous shipping |

**Team data, not code data**: Shows when "we lost our second senior engineer."

---

### 5. How Often Is the Team Firefighting

```bash
git log --oneline --since="1 year ago" | \
  grep -iE 'revert|hotfix|emergency|rollback'
```

**Reveals**: Revert and hotfix frequency.

**Normal**: Handful per year
**Warning**: Every couple of weeks
**Crisis**: Frequent reverts

**Root causes**:
- Unreliable tests
- Missing staging environment
- Hard rollbacks

**Zero results**: Either stable, or nobody writes descriptive commits.

## Usage Workflow

```bash
# 2 minutes to get diagnostic picture
cd new-codebase

# Run all five commands
git log --format=format: --name-only --since="1 year ago" | sort | uniq -c | sort -nr | head -20
git shortlog -sn --no-merges
git log -i -E --grep="fix|bug|broken" --name-only --format='' | sort | uniq -c | sort -nr | head -20
git log --format='%ad' --date=format:'%Y-%m' | sort | uniq -c
git log --oneline --since="1 year ago" | grep -iE 'revert|hotfix|emergency|rollback'
```

## Cross-Reference Strategy

| Churn Hotspot | Bug Hotspot | Risk Level |
|--------------|-------------|------------|
| High | High | 🔴 Critical — Don't touch without tests |
| High | Low | 🟡 Complex but stable |
| Low | High | 🟡 Brittle, rarely changed |
| Low | Low | 🟢 Safe to work with |

## Related

- [[codebase-audit]] — Comprehensive audit methodology
- [[technical-debt-detection]] — Identifying debt patterns
- [[churn-analysis]] — Metrics and tooling
- [[bus-factor]] — Team risk assessment

## Entities

- [[Ally Piechowski]] — Author, consultant
- [[Microsoft Research]] — 2005 churn/defect correlation study

## Resources

- Original: https://piechowski.io/post/git-commands-before-reading-code/
- Follow-up: [How I Audit a Legacy Rails Codebase](https://piechowski.io/post/how-i-audit-a-legacy-rails-codebase/)
- Study: [Microsoft Research on code churn and defects](https://www.microsoft.com/en-us/research/publication/use-of-relative-code-churn-measures-to-predict-system-defect-density/)
