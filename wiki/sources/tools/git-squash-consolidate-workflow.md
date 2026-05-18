---
description: "Git Squash & Consolidate Workflow"
tags: ['research']
raw_file: "Git Squash & Consolidate Workflow.md"
created: 2026-05-17
---

My approach for cleaning up commit history during interactive rebases. Heavy LazyGit usage. Goal as I currently practice it: minimize commits per file, ideally one commit per file.

> [!question] Audit me Documenting this partly to get it critiqued. The "one commit per file" goal in particular might be the wrong goal — see [[#Audit, open question on the goal]] at the bottom.

## Easy case: file changed in only a couple of commits

When my changes to a file live in just one or two commits (e.g., `cooldown.ts` today):

1. Identify the original commit for that file
2. In LazyGit, fixup the later commit(s) into the original
3. Take the most up-to-date commit message and replace/append onto the original message so the consolidated commit reflects the final state of the change

Outcome: one commit per file, message describes the finished change.

## Hard case: file touched across many commits, with merge conflicts

When a file has been edited across many commits (e.g., `ContactsProvider.tsx` today), squashing naturally introduces merge conflicts. The technique:

1. Run the interactive rebase. Hit the merge conflict on commit `C` that touches the file
2. Notice that commit `C` _also_ touches files unrelated to the current conflict
3. In LazyGit, build a **custom patch** (`Ctrl+P`) containing just the unrelated files from commit `C`
4. Move that patch into an earlier commit — specifically, the one those files actually belong to (the "original" commit for _those_ files)
5. Commit `C` now only contains the file with the actual conflict — much smaller scope to resolve
6. Resolve the remaining conflict and continue the rebase
7. Continue squashing/fixing up as planned

**The core move:** before resolving a conflict, extract anything that doesn't belong to that file out of the conflicting commit using a custom patch. The squash that follows is then between commits that genuinely belong together.

> [!note] LazyGit specifics worth verifying Ctrl+P opens the custom patch options. Building the patch happens inside a commit's file list. The "move patch to earlier commit" action is what reassigns those files. If keybindings drift after a LazyGit update, check `?` in-app.

## Today's run (TEAME-218)

- **`cooldown.ts`** — easy case, clean. Squashed into the original commit, rewrote the message to cover Fix A + Fix B.
- **`ContactsProvider.tsx`** — hard case. Used the custom-patch dance on a couple of conflicted commits to extract files that didn't belong, then squashed. Worked, but felt heavier than I'd want for a routine rebase.

## Audit, open question on the goal

The technique above is fine. The thing I want to interrogate is the goal it serves.

**Goal as I currently practice it:** one commit per file.

**Goal that's more standard (and maybe what I actually want):** one commit per _logical change_.

These overlap a lot but aren't identical:

|Situation|One-per-file says|One-per-logical-change says|
|---|---|---|
|A bug fix that touches a component, its hook, and its test|3 commits|1 commit|
|Two unrelated bug fixes in the same file|1 commit|2 commits|
|A refactor that touches 12 files|12 commits|1 commit|

The standard practice (and what most reviewers prefer) is the logical-change column.

**My current symptom:** when I find myself fighting merge conflicts to consolidate same-file commits, that's often because the commits I'm forcing together were actually _independent logical changes that happened to touch the same file_. The rebase friction is real signal — git is telling me they belong apart.

**Test I want to start applying:**

> Could someone read this commit's message alone and understand why it exists, without needing context from its neighbors? If yes → atomic logical change, keep it. If the only honest description is "this is the changes-to-cooldown.ts commit" → smell, the commit doesn't have its own reason for being.

**Counter-argument I'd want to consider:** is there a reason "one per file" serves _me_ well even if reviewers prefer logical units? Maybe it makes my own `git log -- path/to/file.ts` cleaner, or makes blame easier? Worth thinking through before changing the practice.

## To revisit

- [ ] Try one-commit-per-logical-change as the goal on the next ticket. See if rebase friction drops.
- [ ] If logical-change wins, the custom-patch dance becomes a tool for surgical history fixes rather than a regular part of the workflow.
- [ ] Either way: keep the LazyGit custom-patch technique documented — it's genuinely useful even with a different goal.

## Related

- [[Bug Fix Workflow with Claude Code]]
- [[2026-05-05 BrainBreak Cooldown & Speculative Data Bugs]]
- [[Pushback Patterns for Claude Code]]
