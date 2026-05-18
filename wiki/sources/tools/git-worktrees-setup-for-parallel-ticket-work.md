---
description: "Guide to setting up git worktrees for parallel ticket work with isolated Claude Code sessions"
tags: ['research']
raw_file: "Git Worktrees Setup for Parallel Ticket Work.md"
created: 2026-05-17
---

## Overview
Set up git worktrees so you can work on multiple tickets simultaneously, each with its own isolated Claude Code session.

## Current State
- Main repo: `/Users/lalmonte/Documents/Development/Work/marvin`
- Current branch: `main`
- No existing worktrees

## Setup Plan

### 1. Create a worktrees directory structure
Worktrees are typically created as siblings to your main repo or in a dedicated directory.

**Recommended structure:**
```
~/Documents/Development/Work/
├── marvin/                    # Main repo (current)
├── marvin-ticket-A/           # Worktree for ticket A
├── marvin-ticket-B/           # Worktree for ticket B
└── marvin-ticket-C/           # Worktree for ticket C
```

### 2. Creating a new worktree for a ticket

**For an existing remote branch:**
```bash
cd /Users/lalmonte/Documents/Development/Work/marvin
git worktree add ../marvin-TICKET-123 origin/TICKET-123-branch-name
```

**For a new branch for a ticket:**
```bash
cd /Users/lalmonte/Documents/Development/Work/marvin
git worktree add ../marvin-TICKET-123 -b TICKET-123-branch-name main
```

### 3. Starting a Claude Code session in a worktree
```bash
cd ../marvin-TICKET-123
claude --session-name "TICKET-123 - Description"
```

### 4. Managing worktrees

**List all worktrees:**
```bash
git worktree list
```

**Remove a worktree when ticket is done:**
```bash
git worktree remove ../marvin-TICKET-123
```

**Prune stale worktrees:**
```bash
git worktree prune
```

### 5. Example Workflow

```bash
# Create worktree for a new ticket
git worktree add ../marvin-TEAMB-2671 -b TEAMB-2671-branch main

# Navigate to it
cd ../marvin-TEAMB-2671

# Start Claude with a named session
claude --session-name "TEAMB-2671 - Weekly Snapshot Update"

# In another terminal, work on another ticket
cd ../marvin-TEAMB-2529
claude --session-name "TEAMB-2529 - Language Tweaks"
```

## Tips

1. **Naming convention:** Use `marvin-<TICKET-NUMBER>` for consistency
2. **Session naming:** Always use `--session-name` with ticket number and description
3. **Clean up:** Remove worktrees after merging PRs to keep things tidy
4. **Session picker:** Use `/resume` to see sessions across all worktrees in the same repo
5. Use cargo to import`.env` and docker related files so you can spin up separate docker instances for each worktree.

## Documentation Reference
https://code.claude.com/docs/en/common-workflows#run-parallel-claude-code-sessions-with-git-worktrees
