---
tags: [work, git, worktree, flyway, migrations, gotcha, teame-218]
sources: ["Worktree Rebase Missed Flyway Migration Files.md"]
created: 2026-05-05
updated: 2026-05-05
type: gotcha
ticket: TEAME-218
status: diagnosis-uncertain
---

# Worktree Rebase Missed Flyway Migration Files

**Source:** Worktree Rebase Missed Flyway Migration Files.md
**Date ingested:** 2026-05-05
**Type:** Gotcha / diagnosis

## Symptom

Working on [[teame-218-code-cleanup-lts-conversion]] in a git worktree. Ran `git rebase origin/main` expecting latest changes. Rebase completed without conflicts, but Flyway migrations failed on local stack — migration files missing from worktree.

**Workaround:** Manually copied missing migration files from main Marvin clone into worktree.

## Initial Diagnosis (Wrong)

Worktree was off in root of machine, far from Marvin repo. Thought location caused git to miss files during rebase.

## Actual Cause

**`origin/main` was stale.**

`git rebase origin/main` rebases against **local cached** copy of `origin/main`, which only updates on `git fetch`. If teammate pushed migration files after last fetch, rebase couldn't pull in unknown commits.

## Fix

Always fetch before rebasing:

```bash
git fetch origin
git rebase origin/main
```

Or one shot:

```bash
git pull --rebase origin main
```

## Sanity Check

Before blaming git or worktree setup:

1. `git log origin/main --oneline -20` — shows expected commits?
2. If no: didn't fetch. Remote has stuff you don't.
3. If yes but files still missing: dig deeper (wrong target ref, files only in feature branch).

## Worktree Location: Inside vs Outside Repo

| | Inside repo | Sibling directory |
|---|---|---|
| Git behavior | Same | Same (shares object DB) |
| IDE/file watchers | May pick up worktree contents | Clean separation |
| Search/build tools | May walk into worktrees | No tool confusion |
| Recommendation | Avoid | Preferred pattern |

Location didn't cause this bug. Don't pick location because of this bug.

## Entities Mentioned

- [[teame-218-code-cleanup-lts-conversion]] — Code cleanup / LTS conversion ticket

## Concepts Covered

- [[git-worktrees]] — Parallel development environments
- [[flyway]] — Database migration tool
- [[git-rebase]] — Rebase against stale remote refs
- [[git-fetch]] — Updating local cached remote refs

## Related

- [[marvin-local-frontend-dev-setup]] — Local dev runbook
- [[git-worktrees-parallel-work]] — Worktree setup guide
