---
description: Using git history to diagnose codebase health before reading code
tags: ["git", "codebase-analysis", "technical-debt", "metrics"]
created: 2026-04-09
updated: 2026-04-09
---

# Git Codebase Analysis

Five git commands that reveal where a codebase hurts before you open a single file. Diagnostic approach to understanding project health.

## The Five Commands

### 1. Churn Hotspots

```bash
git log --format=format: --name-only --since="1 year ago" | \
  sort | uniq -c | sort -nr | head -20
```

Most-changed files. High churn + nobody owns it = technical debt hotspot.

### 2. Bus Factor

```bash
git shortlog -sn --no-merges
```

Contributors by commit count. One person = 60%+? That's your bus factor.

### 3. Bug Clusters

```bash
git log -i -E --grep="fix|bug|broken" --name-only --format='' | \
  sort | uniq -c | sort -nr | head -20
```

Files with most bug-fix commits. Cross-reference with churn hotspots.

### 4. Velocity Trend

```bash
git log --format='%ad' --date=format:'%Y-%m' | sort | uniq -c
```

Commits by month. Declining = losing momentum. Spikes = batched releases.

### 5. Crisis Frequency

```bash
git log --oneline --since="1 year ago" | \
  grep -iE 'revert|hotfix|emergency|rollback'
```

Revert/hotfix count. Every few weeks = deploy fear.

## Risk Matrix

| Churn | Bugs | Risk | Action |
|-------|------|------|--------|
| High | High | 🔴 Critical | Don't touch without tests |
| High | Low | 🟡 Complex | Stable but complicated |
| Low | High | 🟡 Brittle | Rarely changed, breaks when touched |
| Low | Low | 🟢 Safe | Good to work with |

## Quick Diagnostic Script

```bash
#!/bin/bash
echo "=== CHURN HOTSPOTS ==="
git log --format=format: --name-only --since="1 year ago" | sort | uniq -c | sort -nr | head -10

echo "=== BUS FACTOR ==="
git shortlog -sn --no-merges | head -10

echo "=== BUG CLUSTERS ==="
git log -i -E --grep="fix|bug|broken" --name-only --format='' | sort | uniq -c | sort -nr | head -10

echo "=== VELOCITY (last 12 months) ==="
git log --format='%ad' --date=format:'%Y-%m' --since="12 months ago" | sort | uniq -c

echo "=== CRISIS PATTERNS ==="
git log --oneline --since="1 year ago" | grep -iE 'revert|hotfix|emergency|rollback' | wc -l
echo "revert/hotfix commits in last year"
```

## Related

- [[git-commands-before-reading-code]] — Source summary
- [[codebase-audit]] — Comprehensive audit methodology
- [[technical-debt-detection]] — Identifying debt patterns
- [[churn-analysis]] — Metrics and tooling

## Resources

- Original: https://piechowski.io/post/git-commands-before-reading-code/
- Microsoft Research: [Code churn predicts defects](https://www.microsoft.com/en-us/research/publication/use-of-relative-code-churn-measures-to-predict-system-defect-density/)
