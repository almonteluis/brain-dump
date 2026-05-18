---
description: Graphify AI coding assistant skill for building queryable knowledge graphs from code, docs, and media
tags:
  - graphify
  - knowledge-graph
  - ai/tools
  - claude/code
  - codebase/analysis
sources:
  - safishamsigraphify AI coding assistant skill (Claude Code
  - Codex
  - OpenCode
  - Cursor
  - Gemini CLI
  - GitHub Copilot CLI
  - OpenClaw
  - Factory Droid
  - Trae
  - Google Antigravity). Turn any folder of code
  - docs
  - papers
  - images
  - or videos into a queryable kno.md
created: 2026-04-30
updated: 2026-05-01
---

# Graphify Knowledge Graph Tool

**Source:** safishamsigraphify AI coding assistant skill...
**Date ingested:** 2026-04-30
**Type:** tool-doc

## Summary

Graphify is an AI coding assistant skill that turns any folder of code, docs, papers, images, or videos into a queryable knowledge graph. Runs via `/graphify` in Claude Code, Codex, Cursor, and 15+ other AI assistants. Uses three-pass extraction: AST (code), Whisper (video/audio), and Claude subagents (docs/images). Outputs interactive HTML, queryable JSON, and a plain-language audit report with god nodes and community clusters.

## Key Claims

- 71.5x fewer tokens per query vs reading raw files (on 52-file mixed corpus)
- Clustering is graph-topology-based using Leiden algorithm — no embeddings or vector DB needed
- Every relationship tagged EXTRACTED (from source), INFERRED (with confidence), or AMBIGUOUS
- Code processed locally via tree-sitter AST — no code leaves your machine
- Video/audio transcribed locally with faster-whisper
- Supports 25 languages via tree-sitter
- SHA256 cache means re-runs only process changed files

## Three-Pass Pipeline

1. **AST Pass** — Extracts classes, functions, imports, call graphs, docstrings from code (no LLM)
2. **Transcription Pass** — Video/audio transcribed locally with domain-aware prompt from god nodes
3. **Semantic Pass** — Claude subagents extract concepts, relationships, design rationale from docs/images

## Output Structure

```
graphify-out/
├── graph.html       # Interactive browser graph
├── GRAPH_REPORT.md  # God nodes, surprising connections, suggested questions
├── graph.json       # Persistent queryable graph
└── cache/           # SHA256 cache for incremental updates
```

## Key Commands

```bash
/graphify .                        # Run on current directory
/graphify ./raw --mode deep        # Aggressive INFERRED edge extraction
/graphify ./raw --update           # Re-extract only changed files
/graphify ./raw --directed         # Preserve edge direction
/graphify ./raw --wiki             # Build agent-crawlable wiki
/graphify query "what connects X to Y?"  # Query the graph
/graphify path "A" "B"             # Shortest path between nodes
/graphify explain "Concept"        # Plain-language explanation
graphify clone <github-url>        # Clone and graph any public repo
graphify merge-graphs g1.json g2.json  # Cross-repo graphs
graphify update ./src              # Code-only refresh (no LLM)
```

## Platform Support

| Platform | Install Command |
|----------|----------------|
| Claude Code | `graphify install` |
| Codex | `graphify install --platform codex` |
| Cursor | `graphify cursor install` |
| Gemini CLI | `graphify install --platform gemini` |
| GitHub Copilot CLI | `graphify install --platform copilot` |
| OpenClaw | `graphify install --platform claw` |
| Trae | `graphify install --platform trae` |

## Always-On vs Explicit Trigger

- **Always-on hook** (Claude Code, Codex, Gemini): Reads `GRAPH_REPORT.md` before file searches — gives assistant a map
- **Explicit commands** (`/graphify query`, `/graphify path`): Traverse `graph.json` hop-by-hop for precise navigation

## Team Workflow

1. One person runs `/graphify .` and commits `graphify-out/`
2. Teammates pull — their assistant reads `GRAPH_REPORT.md` immediately
3. Install post-commit hook (`graphify hook install`) for auto-rebuild on code changes
4. Run `/graphify --update` for doc/image changes

## Supported File Types

| Type | Extensions |
|------|------------|
| Code | .py, .ts, .js, .tsx, .go, .rs, .java, .c, .cpp, .rb, .cs, .kt, .php, .swift, .vue, .svelte, etc. |
| Docs | .md, .mdx, .html, .txt |
| Office | .docx, .xlsx |
| Papers | .pdf |
| Images | .png, .jpg, .webp, .gif |
| Video/Audio | .mp4, .mov, .mp3, .wav, etc. |

## Related Versions

- [[graphify-knowledge-graph-tool-v5]] — Graphify v0.5.0 update (same tool, newer version)

## Entities Mentioned

- [[Claude Code]] — primary supported platform
- [[Codex]] — OpenAI coding agent
- [[Cursor]] — AI code editor
- [[OpenClaw]] — self-hosted AI agent
- [[NetworkX]] — graph library
- [[Leiden algorithm]] — community detection
- [[tree-sitter]] — AST parser
- [[faster-whisper]] — local transcription

## Concepts Covered

- [[knowledge-graph-construction]] — multi-pass extraction pipeline
- [[codebase-understanding]] — structural + semantic analysis
- [[community-detection]] — Leiden clustering on graph topology
- [[incremental-graph-updates]] — SHA256 cache for efficient re-runs
- [[mcp-server]] — exposing graph.json as queryable MCP server
