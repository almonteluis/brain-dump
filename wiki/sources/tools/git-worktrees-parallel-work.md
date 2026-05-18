---
description: Guide to setting up git worktrees for parallel ticket work with isolated Claude Code sessions
tags:
  - source
  - git
  - worktree
  - workflow
  - claude/code
  - parallel-development
sources:
  - Git Worktrees Setup for Parallel Ticket Work.md
created: 2026-04-09
updated: 2026-04-09
---

# Git Worktrees for Parallel Development

**Source:** `raw/00_inbox/process/Git Worktrees Setup for Parallel Ticket Work.md`
**Date ingested:** 2026-04-09
**Type:** Workflow guide

## Summary

Set up git worktrees to work on multiple tickets simultaneously, each with its own isolated Claude Code session.

## Directory Structure

```
~/Documents/Development/Work/
├── marvin/                    # Main repo
├── marvin-ticket-A/           # Worktree for ticket A
├── marvin-ticket-B/           # Worktree for ticket B
└── marvin-ticket-C/           # Worktree for ticket C
```

## Creating Worktrees

### For Existing Remote Branch

```bash
cd /path/to/main/repo
git worktree add ../marvin-TICKET-123 origin/TICKET-123-branch-name
```

### For New Branch

```bash
cd /path/to/main/repo
git worktree add ../marvin-TICKET-123 -b TICKET-123-branch-name main
```

## Starting Claude Code Sessions

```bash
cd ../marvin-TICKET-123
claude --session-name "TICKET-123 - Description"
```

## Managing Worktrees

| Action | Command |
|--------|---------|
| List all | `git worktree list` |
| Remove | `git worktree remove ../marvin-TICKET-123` |
| Prune stale | `git worktree prune` |

## Example Workflow

```bash
# Create worktree for new ticket
git worktree add ../marvin-TEAMB-2671 -b TEAMB-2671-branch main

# Navigate and start Claude
cd ../marvin-TEAMB-2671
claude --session-name "TEAMB-2671 - Weekly Snapshot Update"

# In another terminal, work on another ticket
cd ../marvin-TEAMB-2529
claude --session-name "TEAMB-2529 - Language Tweaks"
```

## Best Practices

1. **Naming:** Use `marvin-<TICKET-NUMBER>` for consistency
2. **Session names:** Always use `--session-name` with ticket number + description
3. **Cleanup:** Remove worktrees after merging PRs
4. **Resume:** Use `/resume` to see sessions across all worktrees in same repo
5. **Docker:** Copy `.env` and Docker files for separate instances per worktree
6. **Fetch before rebase:** `git rebase origin/main` uses cached remote — run `git fetch origin` first. See [[worktree-rebase-missed-flyway-migrations]] for gotcha with Flyway migrations.
7. **Worktree location:** Inside vs outside repo doesn't affect git behavior (same object DB). Outside = cleaner IDE/tool separation.

## Key Concepts

- [[git-worktrees]] — Parallel development environments
- [[isolated-sessions]] — Separate Claude Code contexts
- [[session-management]] — Resuming work across worktrees
