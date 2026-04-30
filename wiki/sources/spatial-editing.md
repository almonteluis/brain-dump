---
description: "Spatial editing workflow for inline edit instructions"
tags: [tools, workflow, editing, claude, spatial-editing, productivity]
sources: [spatial-editing.md]
created: 2026-04-09
updated: 2026-04-09
---

# Spatial Editing

**Source:** raw/02_reference/tools/spatial-editing.md
**Date ingested:** 2026-04-09
**Type:** workflow

## Summary

Spatial editing workflow — leave inline edit instructions in curly braces for Claude to process. Position IS context.

## Key Claims

- Curly braces mark thoughts and edit instructions
- Each comment applies to its surrounding text
- Context travels with the text — no need to explain what you're referring to
- Process all edits at once with `/edit` command

## The Problem

Traditional editing workflow breaks flow:
1. You're writing, something feels off
2. You stop writing
3. Switch to Claude, explain the issue
4. Paste the text
5. Wait for response
6. Copy back
7. Repeat

Every context switch costs momentum.

## The Solution

**Curly braces mark your thoughts and edit instructions.**

```markdown
Vaults give Claude memory {feels abstract}

Without persistent storage, Claude forgets everything between sessions {this is the key point, make it hit harder}

The solution is simple {don't say simple, show}
```

After running `/edit`:

```markdown
Vaults give Claude persistent memory across sessions by storing context in files it can read and write

Without persistent storage, Claude starts fresh every conversation. You re-explain the same context, rebuild the same understanding, lose the compound effect of accumulated knowledge.

The solution: Store everything in markdown files that Claude can traverse
```

## Workflow

1. **Write your draft without stopping** — Don't interrupt flow
2. **Do a quick read** and drop `{thoughts}` wherever something feels off
3. **Run `/edit`** — Let Claude process all the edits at once
4. **Review changes**

## The Command

From within Obsidian (via shell command or plugin):

```bash
# Currently open file
/edit

# Specific file
/edit draft.md

# Multiple files
/edit draft.md notes.md
```

From terminal:

```bash
# Using vault-ops.sh
./vault-ops.sh edit "01_thinking/notes/draft.md"

# List all files needing edits
./vault-ops.sh edit --list

# Interactive mode - pick which files to edit
./vault-ops.sh edit --interactive

# Direct script
./06_system/spatial-edit.sh "01_thinking/notes/draft.md"
```

## Types of Instructions

| Instruction | What it does |
|-------------|--------------|
| `{tighten}` | Make more concise |
| `{expand}` | Add more detail |
| `{be more specific}` | Replace vague with concrete |
| `{show, don't tell}` | Add example or demonstration |
| `{this needs evidence}` | Add support/proof |
| `{connect to [[concept]]}` | Add wiki-link |
| `{too passive}` | Make voice more active |
| `{reorder for impact}` | Rearrange for better flow |
| `{split this}` | Break into multiple sentences |
| `{this contradicts earlier point}` | Flag inconsistency |

## Why It Works

**Context travels with the text.**

You don't need to explain what you're referring to because the comment knows where it lives. The instruction is positioned right next to the text it applies to.

This is spatial editing — context is baked into position.

## Output Format

After processing, you get a summary:

```
processed 3 edits in why-vaults-matter.md:
1. "feels abstract" → added concrete mechanism
2. "make it hit harder" → expanded with specific pain points
3. "don't say simple" → replaced with direct statement
```

## Concepts Covered

- [[spatial-editing]] — Position-based edit instructions
- [[Curly Braces]] — Edit marker syntax
- [[Batch Editing]] — Processing multiple edits at once
- [[Context Preservation]] — Location as context

## Related

- [[Spatial Edit Implementation]]
- [[obsidian-claude-101]]
- [[spatial-editing-workflow]]
