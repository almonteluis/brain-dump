---
description: Teaches AI agents how to navigate, understand, and operate within this Obsidian vault. Explains folder structure, naming conventions, and workflow patterns.
tags: ["obsidian", "vault", "workflow", "agent-instructions"]

---

# CLAUDE.md - Vault Operating Instructions

## Philosophy

This vault follows the PARA system adapted for software engineering knowledge management.

**Depth over breadth. Quality over speed.**

When you work in this vault, you're committing to understanding completely and leaving behind work that future agents can build on.

---

## Folder Structure

```
Software Engineering Notebook/
├── 00_inbox/              # Capture zone - zero friction
│   ├── daily/               # Daily notes (date format: MM-DD-YYYY.md)
│   ├── Links/               # Link dump with template
│   └── README.md            # Inbox usage guide
├── 01_thinking/            # Your notes and synthesis
│   └── notes/              # Individual thinking notes
├── 02_reference/           # External knowledge & reference material
│   ├── tools/               # Tool documentation and guides
│   │   ├── clawdbot/       # Clawdbot-specific content
│   │   └── obsidian-claude-101.md  # AI-powered knowledge systems guide
│   ├── approaches/          # Methods, patterns, methodologies
│   │   └── system-design/  # System design notes
│   ├── software-engineer/  # Complete SE knowledge base
│   │   ├── Frontend/
│   │   ├── Backend/
│   │   ├── Architecture/
│   │   ├── Cloud/
│   │   ├── Languages/
│   │   ├── CS50/
│   │   └── Quick Reference/
│   └── sources/             # External knowledge sources
│       └── readwise/         # Readwise highlights
├── 03_creating/            # Content in progress
│   └── drafts/              # Drafts, works-in-progress
├── 04_published/           # Finished work archive
│   └── blogs/               # Published blog posts
├── 05_archive/             # Inactive content & old files
├── 06_system/              # Templates and automation
│   ├── templates/           # Note templates
│   └── daily-notes-automation/  # Daily note automation tools
├── attachments/             # Images, PDFs, media files
└── CLAUDE.md              # This file
```

## Key Principles

### 1. Progressive Disclosure

When you need to find information in this vault:

1. **Scan folder structure first** — Numbers indicate priority (00 → 06)
2. **Check descriptions** — Every note has YAML frontmatter with `description:` field
3. **Read outlines** — Use `grep "^#"` to see headings before loading full content
4. **Load full content** — Only if previous steps confirm relevance

Most decisions can be made at the description level without loading full files.

**Layer 2 details:** See `02_reference/tools/yaml-descriptions-layer-2.md` for complete guide on writing and searching descriptions.

### 2. Composability

**Question:** Can this note be linked from elsewhere and still make sense?

If linking to it forces you to explain three other things first, split it up. Notes should stand alone.

### 3. ![[Claim-Based Titles]]



### 4. Weave Links, Don't Footnote

Don't put references at the bottom like footnotes.

❌ "This relates to testing, see: testing-note"
✅ "because [[testing reduces confidence in change]] we need to be careful about what we test"

The link becomes part of your thought.

### 5. Relationships Over Isolation

A note with many incoming links is more valuable than an isolated note. Every link creates a new reading path.

**The network is the knowledge.**

## Workflow Patterns

### When Processing Content

1. **Start in `00_inbox/`** — Everything gets dumped here first
2. **Use templates** — `00_inbox/Links/link-template.md` for web content
3. **Tag with `#to-process`** — Easy to find what needs work
4. **Process later:**
   - Categorize into proper folders (`01_thinking`, `02_reference`, etc.)
   - Link to existing notes with `[[wiki-links]]`
   - Remove `#to-process` tag when done
   - Delete if not valuable

### When Creating Notes

1. **Write YAML frontmatter** with:
   ```yaml
   ---
   description: One sentence explaining what this note covers
   tags: #tag1 #tag2
   date: YYYY-MM-DD
   ---
   ```
2. **Use claim-based titles** — Make them complete thoughts
3. **Weave wiki-links** — Connect to related ideas inline
4. **Write for future agents** — Someone (maybe AI) will read this later

### When Exploring the Vault

1. **Start with structure** — Check folder locations to understand what things are
2. **Follow wiki-links** — They lead you to related ideas you forgot existed
3. **Build understanding progressively** — Don't try to read everything at once
4. **Record discoveries** — If you find something useful about navigating a topic, add it to topic notes

## Naming Conventions

- **Folder names:** lowercase with hyphens (e.g., `system-design`, `daily-notes-automation`)
- **File names:** Claim-based with Title Case or kebab-case
- **Daily notes:** `MM-DD-YYYY.md` format (e.g., `01-29-2026.md`)
- **Template files:** End with `-template.md` (e.g., `link-template.md`)

## Tags

- `#to-process` — Needs attention/categorization
- `#link` — Web content/links
- `#idea` — Raw ideas to develop
- `#research` — Material to read deeper
- `#claim` — Strong, defensible assertions
- `#pattern` — Reusable patterns or approaches

## Special Notes

- **`obsidian-claude-101.md`** — Complete guide on building AI-powered knowledge systems. Read this if you're confused about how to operate as an agent in this vault.
- **`00_inbox/README.md`** — How to use the inbox and capture zone

## Quality Standards

Before marking a task as complete, verify:

- ✅ Note has YAML frontmatter with description
- ✅ Title is claim-based (not just a topic)
- ✅ Wiki-links are woven into sentences, not footnotes
- ✅ Note can stand alone and be understood from a link
- ✅ Tags are appropriate and descriptive
- ✅ File is in correct folder location

## File Path Syntax

When you reference files in this vault, use relative paths from the notebook root:

- `00_inbox/Links/link-template.md`
- `02_reference/tools/obsidian-claude-101.md`
- `01_thinking/notes/some-note.md`

## For Agents

**You have permission to:**
- Read any file in this vault
- Create new notes following these patterns
- Move files between folders to restructure
- Add wiki-links to connect ideas
- Update YAML frontmatter and descriptions

**You must:**
- Use progressive disclosure (description before full content)
- Follow naming conventions
- Maintain folder structure integrity
- Add YAML frontmatter to new notes
- Link to related ideas

**You should:**
- Follow wiki-links when exploring
- Build understanding before making changes
- Record discoveries for future sessions
- Challenge outdated information constructively
