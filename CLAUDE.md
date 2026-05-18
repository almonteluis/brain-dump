---
description: Vault-level configuration for Claude Code — LLM Wiki pattern with raw sources (gitignored) and synthesized wiki
tags:
  - system
  - claude/code
  - configuration
  - llm-wiki
created: 2026-04-06
updated: 2026-05-18
---

# CLAUDE.md

Vault-level configuration for Claude Code agents working in this Obsidian vault.

## Vault Identity

**Name:** Software Engineering Notebook
**Domain:** Software engineering knowledge management — patterns, tools, frameworks, AI research, and technical deep-dives
**Pattern:** LLM Wiki (raw → ingest → wiki)

## Git Structure

**Important:** `raw/` is gitignored. Only `wiki/`, `papers/`, `2026/`, `.claude/`, `.scripts/`, and config files are tracked.

## Directory Structure

```
raw/              → Unprocessed source materials (gitignored)
├── 2026-05-*.md  → Daily notes, captures, article extractions
└── papers/       → Extracted paper content (PDF++ highlights)

wiki/             → Processed, interlinked knowledge base (tracked)
├── index.md      → Entry point
├── log.md        → Processing history
├── active-projects.md → Active research/projects
├── Backlog.md    → Backlog items
├── completed-work.md → Completed work
├── _pending/     → Items pending processing
├── concepts/     → Atomic concepts (143 pages)
├── entities/     → People, organizations (26 pages)
├── synthesis/    → Synthesized knowledge
├── thinking/     → Thinking frameworks
├── reference/    → Reference materials
├── sources/      → Source pages with [[links]] to concepts
└── graphify-out/ → Knowledge graph (community detection)

papers/           → Academic papers PDFs (tracked)
├── *.pdf         → Original papers
└── *-extracted.md → Extracted markdown

2026/             → Daily notes archive (tracked)
└── 202605*.md    → Archived daily notes

.claude/          → Claude Code configuration (tracked)
├── commands/     → Slash commands
├── skills/       → Skill definitions
└── hooks/        → Session hooks

.scripts/         → Vault automation scripts (tracked)
├── firecrawl-*.sh → Web scraping
├── transcript-extract.sh → PDF extraction
├── fix-renamed-links.js → Link maintenance
└── vault-stats.sh → Stats
```

## LLM Workflow

1. **Capture** — Clip articles, write notes → `raw/`
2. **Ingest** — Manual or AI-assisted processing → `wiki/`
3. **Query** — Search `wiki/` via Obsidian or graphify
4. **Maintain** — Review `wiki/log.md` for processing history

## Wiki Structure

### concepts/
Atomic concepts extracted from sources. Each concept:
- Has YAML frontmatter with `description` and `tags`
- Links back to `[[source]]` pages
- May link to other concepts

### entities/
People, organizations, tools.

### sources/
Source pages that link to `[[concepts]]`. Pattern:
```
# Source Title

## Concepts
- [[concept-1]]
- [[concept-2]]
```

### synthesis/
Synthesized knowledge combining multiple sources.

### thinking/
Thinking frameworks and mental models.

### reference/
Reference materials for quick lookup.

## Key Paths

| Path                          | Purpose                                          |
| ----------------------------- | ------------------------------------------------ |
| `raw/`                        | Unprocessed daily notes, article captures        |
| `wiki/index.md`               | Entry point to knowledge base                    |
| `wiki/log.md`                 | Processing history and decisions                 |
| `wiki/active-projects.md`     | Active research/projects                         |
| `wiki/Backlog.md`             | Backlog items                                    |
| `wiki/graphify-out/`          | Knowledge graph with community detection         |
| `.claude/commands/`           | Slash commands for Claude Code                   |
| `.claude/skills/`             | Skill definitions                                |
| `.scripts/`                   | Vault automation scripts                         |

## Domain Tags

Primary tags for this knowledge base:
- `#software-engineering` — Core technical knowledge
- `#frontend` — React, Next.js, TypeScript, UI/UX
- `#backend` — APIs, databases, architecture
- `#ai-ml` — AI/ML patterns, LLMs, agent systems
- `#math-education` — Math learning, tutoring, CBL
- `#obsidian` — Vault management, note-taking workflows
- `#system` — Vault configuration and tooling

## Skills

Available Claude Code skills (invoke via `[[skill:name]]`):

### Vault Management
- `obsidian-markdown` — Create/edit Obsidian Flavored Markdown
- `json-canvas` — Create/edit JSON Canvas files
- `obsidian-bases` — Create/edit Obsidian Bases
- `skill-creator` — Create new skills
- `systematic-debugging` — Debug before fixing

### Git Workflow
- `git-worktrees` — Isolated feature branches

### Development
- `compress` — Compress natural language
- `preserve` — Preserve context

## Commands

Available Claude Code commands (invoke via `/command-name`):

### Daily Workflow
- `/daily-review` — Daily review
- `/thinking-partner` — Thinking partner
- `/weekly-synthesis` — Weekly synthesis

### Content Processing
- `/inbox-processor` — Process inbox items
- `/de-ai-ify` — Remove AI jargon
- `/download-attachment` — Download attachments
- `/add-frontmatter` — Add YAML frontmatter
- `/research-assistant` — Research assistance

### Development
- `/pragmatic-review` — Pragmatic code review
- `/pull-request` — Create PR
- `/init-bootstrap` — Initialize CLAUDE.md
- `/upgrade` — Upgrade claudesidian
- `/release` — Release management
- `/create-command` — Create new command
- `/install-claudesidian-command` — Install shell command

### Knowledge Graph
- `/graphify-marvin` — Query Marvin knowledge graph

## MCP Tools

Available MCP servers:

### Chrome DevTools
- `mcp__chrome-devtools__*` — Browser automation, debugging, performance analysis

### Zai MCP
- `mcp__zai-mcp-server__*` — Image analysis, UI understanding

### Web
- `mcp__web-reader__webReader` — Fetch and convert URLs to markdown
- `mcp__4_5v_mcp__analyze_image` — Advanced AI vision analysis

## Project Conventions

### YAML Frontmatter
All notes should have YAML frontmatter:
```yaml
---
description: Brief one-line summary of content
tags: ["tag1", "tag2"]
created: YYYY-MM-DD
---
```

### Naming Conventions
- **Files:** `kebab-case.md` (lowercase with hyphens)
- **Daily notes:** `YYYY-MM-DD.md` in `raw/` or `2026/`

### Wiki-Links
Use `[[filename]]` for internal links.
- `[[note]]` → displays as "note"
- `[[note|Display Text]]` → displays as "Display Text"

### Tags
- `#session/log` — Session log entries
- `#wiki` — Processed wiki pages
- `#source` — Source pages
- `#concept` — Concept pages
- Category tags: `#system`, `#reference`, `#thinking`

## Architecture Decisions

### 1. Gitignored Raw Sources
`raw/` is gitignored. Only processed `wiki/` content is tracked. This keeps the repo clean and focused on synthesized knowledge.

### 2. Wiki-First Structure
Primary navigation happens through `wiki/index.md`, not the raw folder.

### 3. Source-Concept Linking
Source pages link to concept pages via `[[wikilinks]]`. Concepts link back to sources.

### 4. Knowledge Graph
Graphify runs on `wiki/` to generate community detection and relationship mapping at `wiki/graphify-out/`.

### 5. Progressive Processing
Process raw sources into wiki concepts for long-term value.

## Obsidian Plugins

Active plugins:
- **colored-tags** — Tag visualization
- **lazy-plugins** — Lazy plugin loading
- **notebook-navigator** — Notebook navigation
- **omnisearch** — Full-text search
- **papers** — Academic paper management
- **pdf-plus** — PDF annotation
- **surfing** — Surfing between notes
- **templater-obsidian** — Template system

## Recent Sessions

Check `wiki/log.md` for recent processing activity.

## Getting Started

1. **Capture:** Add content to `raw/` (daily notes, article captures)
2. **Process:** Extract concepts, create source pages in `wiki/sources/`
3. **Link:** Connect sources to concepts via `[[wikilinks]]`
4. **Query:** Use Obsidian search or graphify for navigation

## Related

- [[wiki/index]] — Wiki entry point
- [[wiki/log]] — Processing history
- [[wiki/active-projects]] — Active research/projects
- [[.claude/commands/README]] — Commands documentation
