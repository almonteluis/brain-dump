---
description: Detailed spatial editing workflow documentation
tags:
  - tools
  - workflow
  - editing
  - claude/code
  - spatial-editing
  - productivity
sources:
  - spatial-editing-workflow.md
created: 2026-04-09
updated: 2026-04-09
---

# Vibe Note-Taking 101: Spatial Editing Workflow

**Source:** raw/02_reference/tools/spatial-editing-workflow.md
**Date ingested:** 2026-04-09
**Type:** workflow

## Summary

Spatial editing workflow — leave curly brace {instructions} directly in your draft where edits are needed, then run one /edit command to process all changes at once instead of copying text back and forth.

## Key Claims

- Traditional editing workflow breaks flow with constant context switching
- Spatial editing embeds instructions where they belong
- Position IS context — the comment knows where it lives
- Batch processing all edits at once is more efficient than one-by-one

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

The back and forth is annoying.

## The Solution: Spatial Editing

Instead of bringing text TO Claude, leave instructions WHERE they belong.

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

## The Workflow

1. **Write your draft without stopping** — Get ideas down, don't polish
2. **Do a quick read and drop `{thoughts}`** wherever something feels off
3. **Run `/edit`** — Process all changes at once
4. **Review changes** — The command outputs a summary

## Example Summary Output

```
processed 3 edits in why-vaults-matter.md:
1. "feels abstract" → added concrete mechanism
2. "make it hit harder" → expanded with specific pain points
3. "don't say simple" → replaced with direct statement
```

## Concepts Covered

- [[spatial-editing]] — Inline edit instruction pattern
- [[Vibe Note-Taking]] — AI-assisted writing workflow
- [[Batch Processing]] — Multiple edits at once
- [[Context Preservation]] — Position as context

## Related

- [[spatial-editing]]
- [[claude-code-workflows]]
- [[obsidian-claude-101]]
