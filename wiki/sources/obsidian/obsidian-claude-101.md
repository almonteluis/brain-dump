---
description: Obsidian and Claude Code integration guide
tags:
  - tools
  - obsidian
  - claude/code
  - vault
  - knowledge-management
  - progressive/disclosure
  - agent
sources:
  - obsidian-claude-101.md
created: 2026-04-09
updated: 2026-04-09
---

# Obsidian + Claude Code 101: Context Engineering

**Source:** raw/02_reference/tools/obsidian-claude-101.md
**Date ingested:** 2026-04-09
**Type:** guide

## Summary

Comprehensive guide to building AI-powered knowledge systems using Obsidian and Claude Code. Covers progressive disclosure, spatial editing, meeting transcript mining, and building tools for thought.

## Key Claims

- A vault is just markdown files that link to each other — the network is the knowledge
- Progressive disclosure with 4 layers (file tree → YAML → outline → content) reduces context noise
- Spatial editing with `{thoughts}` in curly braces enables batch processing of edits
- Meeting transcripts should be mined, not summarized — extract ideas, frameworks, decisions
- Yapping is work — recorded conversations become structured knowledge systems

## Progressive Disclosure: 4 Layers

### Layer 1: File Tree
Session start hook injects full file tree before Claude touches anything.

### Layer 2: YAML Descriptions
Every note has one-sentence description in frontmatter YAML.

### Layer 3: Outline
Check headings with `grep "^#"` before loading full content.

### Layer 4: Full Content
Only load if all previous layers confirm relevance.

## Core Principles

1. **Composability** — Can this note be linked from elsewhere and still make sense?
2. **Claim-Based Titles** — "Quality is the hard part" not "Thoughts on quality"
3. **Relationships Over Isolation** — The network is the knowledge
4. **Weave Links, Don't Footnote** — Links become part of sentences

## Spatial Editing Workflow

**Problem:** Traditional editing breaks flow with constant context switching.

**Solution:** Leave `{thoughts}` in curly braces where edits are needed:
```markdown
Vaults give Claude memory {feels abstract}
```

Then run `/edit` to process all changes at once.

## Mining Meeting Transcripts

**This is mining, not summarizing.**

Hunt for:
- Feature ideas ("wouldn't it be cool if...")
- Frameworks and philosophies
- Decisions made
- Status updates
- Action items and blockers

**Quality standard:** 1-hour meeting → 20+ files created or modified.

## Cornell Notes Framework (Adapted)

- **`/reduce`** — Extract claims from raw content
- **`/reflect`** — Find connections, update MOCs
- **`/reweave`** — Update old notes with new connections
- **`/recite`** — Verify descriptions enable retrieval
- **`/review`** — Health checks: broken links, orphans
- **`/rethink`** — Challenge system assumptions
- **`/orchestrate`** — Chain all phases
- **`/learn`** — Request further research

## Concepts Covered

- [[progressive-disclosure-in-practice]] — Four-layer content navigation
- [[spatial-editing]] — Inline edit instructions
- [[Claim-Based Titles]] — Note naming convention
- [[Wiki Links]] — Knowledge graph connections
- [[Meeting Transcript Mining]] — Exhaustive extraction
- [[Tools for Thought]] — Self-engineering knowledge systems
- [[PARA]] — Projects, Areas, Resources, Archive

## Related

- [[sessionstart-tree-hook]]
- [[yaml-descriptions-layer-2]]
- [[layer-3-heading-standards]]
- [[spatial-editing-workflow]]
