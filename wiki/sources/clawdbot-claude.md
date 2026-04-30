---
description: "Vault operating instructions for Claude"
tags: [clawdbot, claude, vault, obsidian, workflow, agent-instructions, para]
sources: [clawdbot/CLAUDE.md]
created: 2026-04-09
updated: 2026-04-09
---

# CLAUDE.md - Vault Operating Instructions

**Source:** raw/02_reference/tools/clawdbot/CLAUDE.md
**Date ingested:** 2026-04-09
**Type:** guide

## Summary

Teaches AI agents how to navigate, understand, and operate within the Obsidian vault. Explains PARA folder structure, naming conventions, and workflow patterns.

## Key Claims

- This vault follows PARA system adapted for software engineering knowledge management
- Depth over breadth. Quality over speed.
- Progressive disclosure: scan structure → check descriptions → read outlines → load content
- The network is the knowledge — relationships between notes matter more than individual notes

## Folder Structure (PARA)

```
Software Engineering Notebook/
├── 00_inbox/              # Capture zone - zero friction
│   ├── daily/               # Daily notes (MM-DD-YYYY.md)
│   ├── Links/               # Link dump with template
│   └── README.md            # Inbox usage guide
├── 01_thinking/            # Your notes and synthesis
│   └── notes/              # Individual thinking notes
├── 02_reference/           # External knowledge & reference
│   ├── tools/               # Tool documentation
│   │   ├── clawdbot/       # Clawdbot-specific content
│   │   └── obsidian-claude-101.md
│   ├── approaches/          # Methods, patterns
│   ├── software-engineer/  # Complete SE knowledge base
│   └── sources/             # External sources
├── 03_creating/            # Content in progress
│   └── drafts/              # Works-in-progress
├── 04_published/           # Finished work archive
├── 05_archive/             # Inactive content
├── 06_system/              # Templates and automation
│   ├── templates/           # Note templates
│   └── daily-notes-automation/
├── attachments/             # Images, PDFs, media
└── CLAUDE.md              # This file
```

## Key Principles

### 1. Progressive Disclosure

When finding information:
1. **Scan folder structure first** — Numbers indicate priority (00 → 06)
2. **Check descriptions** — Every note has YAML with `description:` field
3. **Read outlines** — Use `grep "^#"` to see headings before loading content
4. **Load full content** — Only if previous steps confirm relevance

### 2. Composability

**Question:** Can this note be linked from elsewhere and still make sense?

If linking to it forces you to explain three other things first, split it up.

### 3. Claim-Based Titles

Stop naming notes like topics. Start naming them like claims.

❌ "Thoughts on AI slop"
✅ "Quality is the hard part"

### 4. Weave Links, Don't Footnote

❌ "This relates to quality, see: testing-note"
✅ "because [[testing reduces confidence in change]] we need to be careful"

### 5. Relationships Over Isolation

A note with many incoming links is more valuable than an isolated note.

**The network is the knowledge.**

## Workflow Patterns

### When Processing Content

1. **Start in `00_inbox/`** — Everything gets dumped here first
2. **Use templates** — `00_inbox/Links/link-template.md` for web content
3. **Tag with `#to-process`** — Easy to find what needs work
4. **Process later:**
   - Categorize into proper folders
   - Link to existing notes with `[[wiki-links]]`
   - Remove `#to-process` tag when done

### When Creating Notes

1. **Write YAML frontmatter** with description, tags, date
2. **Use claim-based titles**
3. **Weave wiki-links**
4. **Write for future agents**

## Naming Conventions

- **Folder names:** lowercase with hyphens
- **File names:** Claim-based with Title Case or kebab-case
- **Daily notes:** `MM-DD-YYYY.md`
- **Template files:** End with `-template.md`

## Tags

- `#to-process` — Needs attention/categorization
- `#link` — Web content/links
- `#idea` — Raw ideas to develop
- `#research` — Material to read deeper
- `#claim` — Strong, defensible assertions
- `#pattern` — Reusable patterns

## Quality Standards

Before marking a task complete:
- ✅ Note has YAML frontmatter with description
- ✅ Title is claim-based
- ✅ Wiki-links are woven into sentences
- ✅ Note can stand alone
- ✅ Tags are appropriate
- ✅ File is in correct folder

## For Agents

**You have permission to:**
- Read any file
- Create new notes following patterns
- Move files between folders
- Add wiki-links
- Update YAML frontmatter

**You must:**
- Use progressive disclosure
- Follow naming conventions
- Maintain folder structure
- Add YAML frontmatter to new notes
- Link to related ideas

## Concepts Covered

- [[PARA]] — Projects, Areas, Resources, Archive
- [[progressive-disclosure-in-practice]] — Layered navigation
- [[Claim-Based Titles]] — Note naming
- [[Wiki Links]] — Knowledge graph
- [[Vault Workflow]] — Content processing

## Related

- [[obsidian-claude-101]]
- [[yaml-descriptions-layer-2]]
- [[layer-3-heading-standards]]
