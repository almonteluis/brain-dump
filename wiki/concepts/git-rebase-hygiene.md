---
description: Always fetch before rebasing — cached origin/main is stale until git fetch updates it
tags: [git, rebase, workflow, gotcha, concept]
sources: ["worktree-rebase-missed-flyway-migrations.md"]
created: 2026-05-05
updated: 2026-05-05
---

# Git Rebase Hygiene

Pattern for avoiding stale-remote rebases. `git rebase origin/main` uses your **local cached copy** of `origin/main`, which only updates when you run `git fetch`.

## The Problem

```bash
git rebase origin/main   # rebases against CACHED origin/main
```

If a teammate pushed commits after your last fetch, those commits literally aren't on your machine. Rebase can't pull in what it doesn't know about.

## The Fix

```bash
git fetch origin
git rebase origin/main
```

One-shot:

```bash
git pull --rebase origin main
```

## Sanity Check

Before blaming git or worktree setup:

1. `git log origin/main --oneline -20` — expected commits visible?
2. If no: didn't fetch. Remote has commits you don't.
3. If yes but files still missing: dig deeper (wrong target ref, feature branch only, etc.)

## Related

- [[worktree-rebase-missed-flyway-migrations]] — Gotcha: Flyway migrations missing after stale rebase
- [[git-worktrees-parallel-work]] — Worktree setup and best practices
