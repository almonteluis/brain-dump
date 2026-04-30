---
description: Git best practices for coherent commits, clear history, and effective collaboration
tags: [source, git, workflow, commit-messages, best-practices]
sources: ["KeepingHistoryClean.md"]
created: 2026-04-09
updated: 2026-04-09
---

# Git Workflow Guide

**Source:** `raw/00_inbox/work docs/KeepingHistoryClean.md`
**Date ingested:** 2026-04-09
**Type:** Workflow guide

## Summary

Guidelines for maintaining clean, coherent Git history through proper commit organization and message formatting.

## Coherent Commits

A commit should address a **single topic**.

### DO
- Include related changes: parameter addition, implementation, comment updates, unit tests, calling code updates
- Squash review changes into relevant commits (push *then* squash)

### DON'T
- Mix linting/formatting with functional changes
- Include unrelated refactoring
- Include temporary debugging changes
- Merge commits (use `git rebase` instead)

### Why Coherence Matters

Mixed-topic commits make it difficult to:
- Focus code review on important changes
- Understand code history when debugging
- Revert only undesirable parts

---

## Commit Message Format

### Structure

```
Subject line (50 chars max, no period, imperative mood)

Body wrapped at 72 characters. Explain what and why, not how.
Bullet lists with asterisks are appropriate.

(PROD-1234, FOO-5678)
```

### Rules

| Rule | Example |
|------|---------|
| Separate subject from body | Blank line between |
| Limit subject to 50 chars | `Prevent search engines from indexing` |
| Capitalize subject | `Add user authentication` ✓ |
| No period in subject | `Add auth` ✓ (not `Add auth.`) |
| Imperative mood | "When applied, this commit will **Add auth**" |
| Wrap body at 72 chars | Hard wrap for readability |
| Include Jira issue | `(PROD-2627)` at end of subject |

### Examples

**Simple:**
```
Prevent search engines from indexing the site (PROD-2627)
```

**With list:**
```
Fix book sync issue in sync_lessons (PROD-2585, FOO-1234)

* Books have to be synced before lesson_books
* Fail fast if lessons or books fail to sync
* Helpful message if FK error detected
```

**With detailed body:**
```
Load schools along with cohorts in student editor (PROD-2448)

Loading the student editor was slow because the page would do O(cohorts)
queries. Using the ORM properly to preload that data speeds up the
page load significantly.
```

---

## Commit Often, Perfect Later

### Workflow

1. **Commit frequently** on topic/personal branches
   - Save progress as you work
   - Push to remote for recovery safety
   - Easier to find which change caused issues (`git bisect`)

2. **Rewrite history when done**
   - Squash related commits
   - Remove fixup commits
   - Rewrite commit messages for PR

3. **Keep formatting separate**
   - Do formatting changes in separate commits
   - Do them *before* functional changes
   - Makes PR diffs readable

### Reset Commit Date

Long-lived branches may have stale commit dates. Update before pushing:

```bash
git commit --amend --reset-author --no-edit
```

---

## Key Concepts

- [[coherent-commits]] — Single topic per commit
- [[commit-messages]] — Clear, imperative, with context
- [[history-rewriting]] — Squash and refine before PR
- [[rebase-over-merge]] — Linear history preference
