---
description: Per-workflow terminal layouts bound to a single shortcut, eliminating the working-memory cost of context switching
tags: [workflow, terminal, productivity, concept]
created: 2026-05-17
source: "[[daily note for friday]]"
---

# Spatial terminal layouts as context-switch elimination

A three-pane terminal layout — editor on the left, AI assistant top-right, dev service bottom-right — keyed to a single shortcut, pointed at the right directory, with the first command already running. You stop thinking about *how to get where you need to be* and just land there.

The problem it solves: context switching between repos and workflows isn't just annoying, it burns working memory. When you jump from Marvin (dev repo) to the QA automation repo, you have to remember the directory path, which tmux session you were in, how to connect to the database, what command starts the test runner. Each micro-decision is trivial. Stack five of them and you've lost the thread of what you were actually trying to do.

The pattern: one keybind per workflow. Dev layout points to Marvin with the three-pane config. QA layout points to the test repo with a different startup command. The spatial consistency is the thing — your brain stops navigating and starts operating. Same way a musician doesn't think about where their hands are on the fretboard after enough reps.

The right pane does the heavy lifting for flexibility: NeoVim for deep edits, LazyGit for quick commits, or Claw Code for AI-assisted work. Swap the tool, keep the spatial map.

This is [[context-engineering]] for the physical workspace — reduce the tokens your brain spends on navigation and spend them on the actual problem. The same principle behind [[progressive-disclosure]] but applied to your terminal real estate.

## Related Concepts
- [[context-engineering]]
- [[progressive-disclosure]]
- [[qa-fe-automation-layout]]
