---
description: Tool-specific notes and configurations — MCP servers, QMD, saved resources, quick references
tags: #clawdbot #tools #mcp #qmd
date: 2026-01-25
---

# TOOLS.md - Local Notes

Skills define *how* tools work. This file is for *your* specifics — the stuff that's unique to your setup.

## What Goes Here

Things like:
- Camera names and locations
- SSH hosts and aliases  
- Preferred voices for TTS
- Speaker/room names
- Device nicknames
- Anything environment-specific

## Examples

```markdown
### Cameras
- living-room → Main area, 180° wide angle
- front-door → Entrance, motion-triggered

### SSH
- home-server → 192.168.1.100, user: admin

### TTS
- Preferred voice: "Nova" (warm, slightly British)
- Default speaker: Kitchen HomePod
```

## Why Separate?

Skills are shared. Your setup is yours. Keeping them apart means you can update skills without losing your notes, and share skills without leaking your infrastructure.

---

Add whatever helps you do your job. This is your cheat sheet.

---

## MCP Servers

### Z.ai Vision MCP Server (`zai-mcp-server`)
**Purpose:** Image/video analysis with GLM-4.6V model

**Config:** `~/clawd/config/mcporter.json`

**Key Tools:**
- `ui_to_artifact` - UI → code, prompts, specs, descriptions
- `extract_text_from_screenshot` - OCR (code, terminal, docs)
- `diagnose_error_screenshot` - Error analysis + fixes
- `understand_technical_diagram` - Architecture, flow, UML, ER
- `analyze_data_visualization` - Charts, graphs, dashboards
- `ui_diff_check` - Compare two UIs
- `analyze_image` - General image understanding
- `analyze_video` - Video (≤8MB, MP4/MOV/M4V)

**Usage:**
```bash
mcporter call zai-mcp-server.ui_to_artifact(image_source="path", output_type="code", prompt="...")
mcporter call zai-mcp-server.extract_text_from_screenshot(image_source="path", prompt="...")
```

**Pricing:** 1/7th cost of Sonnet, 3x usage quota

### QMD - Local Document Search
**Purpose:** Search markdown vaults with BM25 + vector embeddings + reranking

**Install Path:** `/home/ubuntu/.bun/bin/qmd`
**Index:** `~/.cache/qmd/index.sqlite`
**Models:** `~/.cache/qmd/models/` (embeddinggemma-300M, qwen3-reranker)

**Quick Reference:**
```bash
export PATH="$HOME/.bun/bin:$PATH"
qmd search "Relay fragments" -c obsidian     # BM25 keyword search
qmd vsearch "how to deploy"                   # Semantic search (embeddings required)
qmd query "authentication patterns"            # Hybrid + reranking (best quality)
qmd status                                   # Check embedding progress
```

**Collections:**
- `obsidian` — Full Software Engineering Notebook (628 files)

**Notes:** BM25 search works immediately. Embeddings take ~1-2 hours to generate for large vaults.

## Saved Resources

> **Location:** All markdown resources moved to `/home/ubuntu/clawd/obsidian-vault/Software Engineering Notebook/` for Obsidian sync

### React Patterns
- **Airbnb React Style Guide (full)**: `obsidian-vault/Software Engineering Notebook/airbnb-react-style-guide.md`
- **Quick Reference Summary**: `obsidian-vault/Software Engineering Notebook/airbnb-react-patterns-summary.md`
- **React Bits Index**: `obsidian-vault/Software Engineering Notebook/react-bits-index.md`
- **React Bits Summary**: `obsidian-vault/Software Engineering Notebook/react-bits-summary.md`

Use these for:
- Component structure and best practices
- Naming conventions and prop handling
- Accessibility guidelines
- Common anti-patterns to avoid
- Presentational vs Container pattern
- setState async behavior and functional setState
- React Fragments for multiple element returns
- Performance optimization with PureComponent
- State mutation anti-patterns

### GraphQL Workshop (ASP.NET Core + Relay)
- **Full Workshop Guide**: `obsidian-vault/Software Engineering Notebook/fullstack-graphql-workshop.md`
- **Detailed Summary**: `obsidian-vault/Software Engineering Notebook/graphql-workshop-summary.md`

Use these for:
- Hot Chocolate GraphQL server patterns
- DataLoader for N+1 query optimization
- Connection pattern for pagination
- Relay.js client patterns (fragments, mutations, optimistic updates)
- Distributed GraphQL architecture
- CQRS + DDD with GraphQL
- Schema evolution and Open Telemetry

### Obsidian Vault
- **Location:** `/home/ubuntu/clawd/obsidian-vault/Software Engineering Notebook/`
- **Documentation:** `BOOTSTRAP.md` — Contains vault path and resource list
- Use in code: `const OBSIDIAN_VAULT = "/home/ubuntu/clawd/obsidian-vault/Software Engineering Notebook/";`

### Relay Query Refactoring
- **Query Refactoring Guide**: `obsidian-vault/Software Engineering Notebook/relay-query-refactoring-guide.md`

Use this for:
- Converting multiple `useLazyLoadQuery` to single query + fragments
- Understanding fragment keys and data masking
- Hook comparison (useLazyLoadQuery vs usePreloadedQuery vs useQueryLoader)
- Fragment arguments for dynamic data fetching
- Migration checklist and testing strategies
- Performance impact analysis (2+ requests → 1 optimized request)

### Relay ESLint Rules
- **ESLint Rules Guide**: `obsidian-vault/Software Engineering Notebook/relay-eslint-rules-guide.md`

Use this for:
- Understanding `relay/unused-fields` rule — Error when queried fields aren't used
- Understanding `relay/must-colocate-fragment-spreads` rule — Error when fragments aren't co-located
- How rules work together to enforce proper fragment usage
- Real-world examples showing what triggers errors and how to fix them
- Relationship: `must-colocate` + `unused-fields` = optimal data fetching
