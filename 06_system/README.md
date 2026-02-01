---
description: System tools and automation scripts for vault operations including tree generation, description search, and health validation.
tags: ["system", "automation"]
---

# System Tools & Automation

This folder contains scripts and configuration for automating your Obsidian vault.

## Scripts

### vault-tree-generator.sh
**Purpose:** Layer 1 of progressive disclosure — generates file tree structure

**Usage:**
```bash
./vault-tree-generator.sh
```

**Output:**
- PARA-style folder structure (00-06 numbered folders)
- Root markdown files
- Gives agents a map before they start exploring

**When to use:**
- Automatically via Claude Code SessionStart hook
- Manually to check vault structure
- Before running complex vault operations

### vault-ops.sh
**Purpose:** Unified command interface for all vault operations

**Usage:**
```bash
./vault-obs.sh [command] [options]
```

**Commands:**
- `tree` — Show vault structure (calls vault-tree-generator.sh)
- `find "query"` — Search notes by YAML description (Layer 2)
- `outline [note]` — Show headings of a specific note (Layer 3)
- `process` — List all `#to-process` items in inbox
- `orphans` — Find notes with no incoming wiki-links
- `broken` — Find broken wiki-links in vault
- `validate` — Check YAML frontmatter and descriptions
- `edit [file]` — Process spatial edits `{instructions}` in files
- `help` — Show help message

**Examples:**
```bash
# Show structure
./vault-obs.sh tree

# Find notes about claims
./vault-obs.sh find "claim"

# Check outline of link template
./vault-obs.sh outline "00_inbox/Links/link-template.md"

# Process inbox
./vault-obs.sh process

# Validate vault health
./vault-obs.sh validate

# Edit a file with spatial instructions
./vault-obs.sh edit "01_thinking/notes/draft.md"

# List all files needing spatial edits
./vault-obs.sh edit --list

# Interactive mode - pick which files to edit
./vault-obs.sh edit --interactive
```

### Spatial Editing

**Documentation:** `spatial-edit.sh` (standalone) or `./vault-ops.sh edit`

**Purpose:** Edit markdown files using inline instructions in curly braces `{like this}`

**Core Idea:** Instead of interrupting your writing flow to explain what needs fixing, leave edit instructions right where they belong. The position IS the context.

**Workflow:**
1. Write your draft without stopping — don't interrupt flow
2. Do a quick read and drop `{thoughts}` wherever something feels off
3. Run `./vault-ops.sh edit` to process all edits at once
4. Review changes

**Example Inline Edits:**
```markdown
# Why Vaults Matter

Vaults give Claude memory {feels abstract}

Without persistent storage, Claude forgets everything between sessions {this is the key point, make it hit harder}

The solution is simple {don't say simple, show}
```

**After processing:**
```markdown
# Why Vaults Matter

Vaults give Claude persistent memory across sessions by storing context in files it can read and write

Without persistent storage, Claude starts fresh every conversation. You re-explain the same context, rebuild the same understanding, lose the compound effect of accumulated knowledge.

The solution: Store everything in markdown files that Claude can traverse
```

**Output Summary:**
```
processed 3 edits in why-vaults-matter.md:
1. "feels abstract" → added concrete mechanism
2. "make it hit harder" → expanded with specific pain points
3. "don't say simple" → replaced with direct statement
```

## Progressive Disclosure Layers

**When working with this vault, agents should follow this order:**

1. **Layer 1: File Tree** (`./vault-tree-generator.sh`)
   - See folder organization (PARA-style)
   - Understand what lives where
   - Decide which areas are relevant

2. **Layer 2: YAML Descriptions** (`./vault-obs.sh find "query"`)
   - Search descriptions before loading full files
   - Most decisions can be made at this level
   - Reduces context noise

3. **Layer 3: Outline** (`./vault-obs.sh outline "note"`)
   - Check headings to see if content is relevant
   - Understand note structure before reading

4. **Layer 4: Full Content** (read file)
   - Only load full file if all previous layers confirm relevance
   - Most notes never reach this layer — that's the point

## Hooks (Claude Code)

**Location:** `~/.claude/projects/obsidian-vault/hooks.json`

**Active Hooks:**
- **SessionStart:** Inject vault tree before agent starts
- **PreToolUse:**
  - Check YAML descriptions before reading
  - Block writes without YAML description
  - Suggest removing `#to-process` tag
- **PostToolUse:**
  - Notify on CLAUDE.md updates
  - Notify on obsidian-claude-101.md updates
- **Stop:** Vault health check (optional)

## Integration

**Claude Code:**
- Hooks run automatically when working on vault files
- `.claude/projects/obsidian-vault/` project links vault to hooks

**Clawdbot:**
- Run `vault-ops.sh` commands manually or ask Levi to run them
- Scripts are executable and ready to use

**Obsidian:**
- Files sync via Syncthing to Mac
- Scripts can be run locally from Mac if needed
- YAML frontmatter and wiki-links work in Obsidian natively

## Workflows

### Universal Mining Framework
**Documentation:** `UNIVERSAL-MINING.md`

**Purpose:** Systematically extract maximum value from meetings, articles, and links.

**Core Principle:** All inputs reveal new reality. Update the vault to match.

**Two Mining Layers:**
- **Layer 1 (Explicit):** Ideas, frameworks, philosophies, decisions, status updates, blockers
- **Layer 2 (Implicit):** Embedded ideas, implied philosophies, decisions by omission, priorities

**Pre-Processing Checklist:**
1. Archive raw content
2. Create knowledge summary
3. Identify applicable frameworks
4. Extract specific ideas
5. Tag relevant projects
6. Record citations
7. Connect to existing knowledge
8. Identify action inspiration

**Quality Standards:**
- Read entire content (no skimming)
- Capture Layer 1 AND Layer 2 content
- State synchronization complete (vault reflects reality)
- Specific action inspiration identified
- Red flag checklist to verify completeness

### Daily Note Templates
**Documentation:** `templates/README.md`

**Purpose:** Consistent daily note-taking with two templates (full and quick).

**Templates:**
- **Full Template:** `templates/daily-note-template.md` — Comprehensive tracking
- **Quick Template:** `templates/daily-note-quick.md` — Minimal, fast check-ins

**Sections (Full Template):**
- 📋 What I Did Today (Work, Learning, Personal)
- 💡 Key Insights (from multiple sources)
- 🎯 Tomorrow's Focus (priorities)
- 📝 Notes & Thoughts (free-form)
- 🏃 Health & Self-Care (exercise, sleep, water, food, mental health)
- 📚 Reading / Content (what you consumed)
- 💭 Reflections (what went well, what could be better, learnings)

**Quick Start:**
```bash
# Copy template manually
cp "06_system/templates/daily-note-template.md" "00_inbox/daily/{{date}}.md"

# Or ask Levi to create
"Create a daily note for {{date}} using the {{full|quick}} template"
```

**When to use:**
- **Full template:** Comprehensive daily journals, detailed reviews, tracking health/habits
- **Quick template:** Busy days, minimal notes, quick check-ins

### Article Processing Pipeline
**Documentation:** `ARTICLE-WORKFLOW.md`

**Purpose:** Complete system for capturing, processing, and organizing articles into your knowledge vault.

**Template:** `templates/article-template.md`

**Pipeline:**
1. **Capture** → Save to `00_inbox/Links/` with `article-template.md`
2. **Process** → Extract insights, concepts, frameworks
3. **Integrate** → Move to `02_reference/sources/articles/`, create concept notes
4. **Retrieve** → Use `./vault-ops.sh find "topic"` to find when needed

**Quick commands:**
```bash
# Process backlog
./vault-ops.sh process

# Find articles by topic
./vault-ops.sh find "graphql"
```

**AI assistance:** Ask Levi to process articles automatically:
- "Process this article: [URL]"
- "Summarize and create vault note for [URL]"
- "Find articles about [topic]"

## Maintenance

**Regular tasks:**
```bash
# Process inbox
./vault-obs.sh process

# Validate vault health
./vault-obs.sh validate

# Check for orphan notes
./vault-obs.sh orphans

# Fix broken links
./vault-obs.sh broken
```

**Daily (5 min):**
- Check `00_inbox/Links/` for new articles
- Process 1-3 articles if backlog

**Weekly cleanup:**
- Archive old daily notes to `05_archive/`
- Review `#to-process` items in inbox
- Check for orphan notes and add links
- Run validation to ensure YAML frontmatter
- Review `02_reference/sources/articles/` and delete low-value content
