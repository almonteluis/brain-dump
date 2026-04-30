---
description: Comprehensive Git cheatsheet covering setup, file operations, branching, merging, remote repositories, and advanced commands
tags: ["source", "git", "cheatsheet", "reference", "version-control"]
sources: ["Git Checksheet.md"]
created: 2026-04-09
updated: 2026-04-09
---

# Git Cheatsheet

**Source:** raw/02_reference/software-engineer/Quick Reference/Cheatsheets/Git Checksheet.md
**Date ingested:** 2026-04-09
**Type:** reference

## Summary

Quick reference to the most common Git commands for version control, from basic setup to advanced operations.

## Setup and Configuration

```bash
git init                          # Initialize new repository
git clone <url>                   # Clone remote repository
git config --global <setting>     # Configure global settings
git config --list                 # Show configuration summary
```

## File Operations

```bash
git status                        # Show working tree status
git add <file(s)>                 # Stage files
git commit -m "message"           # Commit changes
git diff                          # Show differences
```

## Branching and Merging

```bash
git branch                        # List branches
git branch <name>                 # Create branch
git checkout <branch>             # Switch branch
git merge <branch>                # Merge branch
git rebase <branch>               # Rebase branch
```

## Remote Repositories

```bash
git remote                        # List remotes
git remote add <name> <url>       # Add remote
git fetch <remote>                # Fetch updates
git pull <remote> <branch>        # Pull changes
git push <remote> <branch>        # Push changes
```

## Commit History

```bash
git log                           # Show commit history
git log --oneline                 # Condensed history
git log --graph                   # Show branching history
```

## Stashes

```bash
git stash save "message"          # Save changes temporarily
git stash list                    # List stashes
git stash apply <stash>           # Apply stash
```

## Advanced Commands

```bash
git cherry-pick <commit>          # Apply specific commit
git bisect start                  # Begin bisect session
git rebase -i                     # Interactive rebase
git reflog                        # Show reference log
```

## Concepts Covered

- [[Git]] — Version control system
- [[Branching]] — Parallel development
- [[Merging]] — Combining branches
- [[Rebasing]] — Rewriting commit history
- [[Stashing]] — Temporary change storage
- [[Remote Repositories]] — Collaboration

## Related

- [[tmux-cheatsheet]] — Tmux terminal multiplexer commands
