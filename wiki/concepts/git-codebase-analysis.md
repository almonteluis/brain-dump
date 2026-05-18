---
description: Using git history to diagnose codebase health before reading code
tags:
  - git
  - codebase/analysis
  - technical-debt
  - metrics
created: 2026-04-09
updated: 2026-04-09
---

# Git Codebase Analysis

Five git commands that reveal where a codebase hurts before you open a single file. Diagnostic approach to understanding project health.

## The Five Commands

### 1. Churn Hotspots [[churn hotspot]]

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

| Churn | Bugs | Risk        | Action                              |
| ----- | ---- | ----------- | ----------------------------------- |
| High  | High | 🔴 Critical | Don't touch without tests           |
| High  | Low  | 🟡 Complex  | Stable but complicated              |
| Low   | High | 🟡 Brittle  | Rarely changed, breaks when touched |
| Low   | Low  | 🟢 Safe     | Good to work with                   |

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

---
thoughts:
where's that? Okay I've run this command. These are my initial thoughts using the git codebase analyzer based on the note that I say.

1. I ran these commands and the first one was churn hotspots. These are pretty much the most changed files, high churn plus nobody owns it equals technical debt hotspot. Those files are:
    - SCSS file
    - schema Graph QL file
    - deploy all Yaml
    - admin Python that we got baseline initial sequel
    - skill resource component page on the front endThat's my department.
2. The second command was bus factor, which I don't know anything about but pretty much contributors by commit count. The top three are Fizzle, Maya, and Fede so if any of those three individuals get hit by a bus we are losing a lot of knowledge from this corp.
3. The next one I ran was bug clusters, files with most bug fix commits. The first two are extensions that, as CSS and schema Graph QL, both turn up in the turn hotspot output but it's unrelated. Everything else is front-end related and I guess because I'm in the folder it gave me all that but I'm gonna run it on my own. We get a dashboard with the Graph QL operation so that has a lot of tweaking, editing, a lot of bugs within the dashboard graphic URL operations. I'm looking at the dashboard header component, which also popped up earlier. The skill resource component is a common bug infested. Oh no, we could refactor that component to be less, I wanted so much then. The dashboard header then we got the dashboard page, which is for fixed bugs and broken commits. The student single skill component, dashboard list header, and then a report hub modal at the live crisis frequency. I think this is the last one. This is for reverb, or no, this is a velocity commits by month. Means the cloning equals mom losing momentum, spikes equal batch release. It looks like it seems like, alright so this April concluded so we have 71 commits in the past month. March we had 148. February we had 101 commits. January we had 103, kind of all over the place. Crisis patterns, any commits that have revert rollback hotfix, we had 27 of those in the past year. That's what I've seen after running these commands. 

1: Most-changed file
45 frontend/src/components/SkillResource/SkillResource.tsx
3:fix|bug|broken
21 frontend/src/components/SkillResource/SkillResource.tsx