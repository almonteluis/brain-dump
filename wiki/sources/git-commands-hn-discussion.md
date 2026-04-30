---
description: HN discussion on git commands for codebase analysis — Jujutsu equivalents, signing workflows, and git forensic techniques
tags: ["source", "git", "codebase-analysis", "discussion", "hn"]
sources: ["Git commands I run before reading any code (piechowski.io).md"]
created: 2026-04-17
updated: 2026-04-17
---

# Git Commands for Codebase Analysis — HN Discussion

**Source:** `raw/Git commands I run before reading any code (piechowski.io).md`
**Date ingested:** 2026-04-17
**Type:** Hacker News discussion (210KB)

## Summary

HN discussion expanding on Ally Piechowski's git forensic commands for codebase analysis. Community contributed Jujutsu (`jj`) equivalents, discussed commit signing workflows, and debated git vs jj tradeoffs.

## Key Claims

1. **Jujutsu equivalents exist** for all five git forensic commands using `jj log` with revset language — more verbose but more powerful
2. **Commit signing with agents** — Agents committing on your behalf creates unsigned commits; `jj log -r 'mine() & ~signed()'` finds them
3. **Sign-on-push** is the recommended jj signing workflow for hardware security key users
4. **Git `log --diff-filter`** is underused for file-type analysis (added/modified/deleted/renamed)
5. **`git log --author`** with email variants catches more commits than name-based filtering

## Jujutsu Commands

| Git Purpose | Jujutsu Equivalent |
|-------------|-------------------|
| What changes most | `jj log` with file path template + sort/uniq |
| Who built this | `jj log` with author template + sort/uniq |
| Where bugs cluster | `jj log` with description regex for fix/bug/broken |
| Project velocity | `jj log` with timestamp format by month |
| Firefighting frequency | `jj log` with description regex for revert/hotfix |

## Concepts Covered

- [[git-codebase-analysis]] — Five git forensic commands
- [[ally-piechowski]] — Original article author

## Related

- [[git-commands-before-reading-code]] — Original Piechowski article reference
- [[git-workflow-guide]] — Git workflow conventions
