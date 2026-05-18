---
description: "Worktree Rebase Missed Flyway Migration Files"
tags: ['research']
raw_file: "Worktree Rebase Missed Flyway Migration Files.md"
created: 2026-05-17
---

## Symptom

Working on [[TEAME-218]] in a git worktree. Ran `git rebase origin/main` expecting to pull in all the latest changes from `main`. The rebase completed without conflicts, but Flyway migrations failed when starting the local stack — a couple of migration files were missing from the worktree.

Workaround: manually copied the missing migration files from the main Marvin clone into the worktree, and Flyway started working.

## Initial diagnosis (probably wrong)

> First instinct: the worktree was off in the root of my machine, far from the Marvin repo, and somehow that caused git to miss files during the rebase. Solution: keep worktrees inside the Marvin repo.

## Actual likely cause

> [!warning] Worktree location does not affect what `git rebase` pulls in Git worktrees share the same object database and refs as the main repo. It doesn't matter whether the worktree lives next to Marvin, inside it, or in `~/`. The rebase operates on commits, not on filesystem proximity.

The more likely cause: **`origin/main` was stale**.

`git rebase origin/main` rebases against the **local cached** copy of `origin/main`, which only updates when you run `git fetch`. If a teammate pushed migration files to `main` after my last fetch, those commits literally weren't on my machine yet — the rebase couldn't pull in what it didn't know about.

## What to actually do

Always fetch before rebasing:

```bash
git fetch origin
git rebase origin/main
```

Or in one shot:

```bash
git pull --rebase origin main
```

> [!tip] Sanity check before assuming anything If a rebase "missed" files, before blaming git or your worktree setup:
> 
> 1. `git log origin/main --oneline -20` — does it show the commits you expected?
> 2. If not, you didn't fetch. The remote has stuff you don't.
> 3. If yes but the files still aren't in your worktree, then dig deeper (wrong target ref, files only in a feature branch, etc.).

## Open: did the worktree-in-repo move actually fix anything?

Probably no — likely just coincidence that I've been fetching more reliably since. Worth verifying the next time I hit a rebase that should bring in DB migrations.

## Side note: worktrees inside vs. outside the repo

Either works for git, but there are tradeoffs:

- **Inside the repo** — IDE/file watchers may pick up worktree contents as part of the main project, search results get noisy, build tooling may walk into them.
- **Sibling directory** (e.g., `~/code/marvin-worktrees/teame-128/`) — cleaner separation, no tool confusion. Common pattern.

The location didn't cause this bug, so don't pick the location _because of_ this bug.

## Related

- [[Marvin – Local Frontend Dev & Test User Setup]]
- TODO: link to a "Git workflow / rebase hygiene" note if I write one
