---
description: "Bug Fix Workflow with Claude Code"
tags: ['research', 'ai']
raw_file: "Bug Fix Workflow with Claude Code.md"
created: 2026-05-17
---

My standard loop for bug fixes. Claude Code does the investigation and execution, LazyGit handles the git hygiene, and there's an explicit recovery path for when I miss something pre-commit.

## The standard loop

1. **Investigate with Claude Code** — describe the bug + relevant context, let it explore the codebase
	1. Use Wispr Flow to describe the bug in the issue in detail. Then run the prop engineer cleanup function within [[Wispr Flow]], and we'll have a detailed prompt. Paste that into Claude Code and take it from there.
2. **Plan + iterate (at least once)** — never accept the first plan. Push back, refine, then approve.
	1. Yeah, Claude Code is right. What is the most important, least documented part of your loop that separates a good pushback from lazily making something shorter?

For a separate note I think a few things top of mind will be:

- Push back would be not understanding the particular issue at hand.
- I'm not looking at the right files, especially for UI issues. Please paste in screenshots.
- For bugs, for a timestamp, I think pasting in errors and asking it to detail, tell me, "Hey, run this function and tell me the outcome." I will let you know if this is right because just looking at the code is not enough for me.
---
1. **Execute** — Claude Code implements the changes
2. **Pre-commit checks** — see [[#Pre-commit checks]]
3. **Commit**
4. **Run simplify hook** — see [[#Simplify hook]]
5. **Push**
6. **Deploy to deer** and verify manually — see [[Marvin Local Frontend Dev & Test User Setup]]
---
## Pre-commit checks

Run prettier + lint **before** committing. This is now in my global CLAUDE.md so Claude Code does it automatically.

> [!gotcha] What I missed last round (TEAME-218) Committed and pushed without running prettier → GitHub Action failed → had to do the recovery dance below. Updating global CLAUDE.md was the response.

> [!warning] CLAUDE.md is a soft enforcement A CLAUDE.md instruction depends on Claude Code reading and respecting it on every run. A **real** pre-commit hook (husky, lefthook, simple-git-hooks) would _enforce_ it regardless of how the commit gets made. Consider adding one if this slips again — belt and suspenders.

-[] Run prettier, the linter, and tests, and always run the build before committing.

This is exactly what I need: create an Obsidian note with tags so I can drop this in and reference it later.
## Recovery: I forgot prettier and CI failed

When the action catches a formatting fail and the commit is already pushed:

1. Run prettier (or whatever lint command failed) locally
2. Stage the formatted file(s)
3. In LazyGit, create a fixup commit that auto-targets the commit you want to amend:
    - `4` — Commits panel
    - `F` — fixup
    - `F` — confirm / fixup into the target commit
4. This creates a `fixup!` commit that will autosquash on next interactive rebase (or you can let the workflow handle it depending on your setup)
5. `git push` (force-with-lease if needed since history changed)
6. Re-run CI

> [!note] Verify the keybindings Wrote down `4, F, F` from muscle memory. If LazyGit keybindings drift after an update, check `?` in-app to re-confirm.

## Simplify hook

After committing, run the simplify hook — takes the last commit and simplifies the logic where it can. If tests still pass after the simplification, fold the simplification into the original commit using the same fixup dance from above.

> [!todo] Document the simplify hook properly This note glosses over what the hook actually does, where it lives, and when to skip it. Worth its own note. → [[Simplify hook setup and usage]]


## Open questions / improvements

- [ ] Add a real pre-commit hook in addition to CLAUDE.md
- [ ] Write up the simplify hook in its own note
- [ ] Capture the "iterate on the plan" step better — what does a _good_ pushback on Claude Code's first plan look like? Pattern worth crystallizing.

## Related

- [[2026-05-05 BrainBreak Cooldown & Speculative Data Bugs]]
- [[Marvin Local Frontend Dev & Test User Setup]]
- [[Worktree Rebase Missed Flyway Migration Files]]
- TODO: [[Simplify hook setup and usage]]
- TODO: [[Claude Code investigation prompts]]
