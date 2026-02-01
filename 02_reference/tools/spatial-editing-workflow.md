---
description: Spatial editing workflow — leave curly brace {instructions} directly in your draft where edits are needed, then run one /edit command to process all changes at once instead of copying text back and forth.
tags: ["workflow", "editing", "claude-code", "spatial-editing", "productivity"]
created: 2026-01-29
---

# Vibe Note-Taking 101: Spatial Editing Workflow

## The Problem

The normal editing workflow with Claude Code is tedious:

1. Read through your draft
2. Notice paragraph 3 needs work
3. Copy that paragraph
4. Paste to Claude with your comment
5. Scroll to paragraph 7
6. Copy that one too
7. Paste with another comment
8. Repeat...

**The back and forth is annoying.** Same problem when you have edits across multiple files that need to stay consistent.

## The Solution: Spatial Editing

Instead of bringing text TO Claude, leave instructions WHERE they belong.

Curly braces mark your `{thoughts and edit instructions}`.

Each comment applies to its surrounding text, or points somewhere else if you say so.

## Example

**Before (with {thoughts}):**

```markdown
# Why Vaults Matter

Vaults give Claude memory
{feels abstract}

Without persistent storage Claude forgets everything between sessions
{this is the key point, make it hit harder}

The solution is simple
{don't say simple, show}
```

**After (edited):**

```markdown
# Why Vaults Matter

Vaults give Claude persistent memory across sessions by storing context in files it can read and write

Without persistent storage Claude starts fresh every conversation, you re-explain the same context, rebuild the same understanding, lose the compound effect of accumulated knowledge

The solution: store everything in markdown files that Claude can traverse
```

## The Command

```bash
# Edit currently open file
/edit

# Edit specific file
/edit draft.md

# Edit multiple files
/edit draft.md notes.md
```

If you run `/edit` with nothing open, it searches your vault for `{thoughts}`:

```bash
rg "\{[^}]+\}" --type md -l
```

Then lets you pick which files to edit.

## The Workflow

1. **Write your draft without stopping** — Get ideas down, don't polish
2. **Do a quick read and drop `{thoughts}`** wherever something feels off
3. **Run `/edit`** — Process all changes at once
4. **Review changes** — The command outputs a summary

**Position IS context.** You don't need to explain what you're referring to because the comment knows where it lives.

## Example Summary Output

```
processed 3 edits in why-vaults-matter.md:
1. "feels abstract" → added concrete mechanism
2. "make it hit harder" → expanded with specific pain points
3. "don't say simple" → replaced with direct statement
```

[[spatial-editing-examples]]
[[claude-code-workflows]]
