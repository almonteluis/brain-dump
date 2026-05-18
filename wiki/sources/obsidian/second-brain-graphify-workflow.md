---
description: Combined second-brain and graphify workflow for Obsidian vault knowledge management
tags: [system, workflow, second-brain, graphify, knowledge-management]
sources: [second-brain-workflow.md]
created: 2026-04-30
updated: 2026-04-30
---

# Second Brain + Graphify Workflow

**Source:** second-brain-workflow.md
**Date ingested:** 2026-04-30
**Type:** guide

## Summary

Defines the integrated pipeline using `second-brain` (ingest, query, lint) and `graphify` (knowledge graph, community clusters) tools for this Obsidian vault. Raw captures flow through ingestion to structured wiki, then graphify builds a navigable knowledge graph on top.

## Key Claims

- Graphify should ONLY run on `wiki/`, never on `raw/` — raw contains duplicates, dead links, half-notes
- Ingestion cleans raw sources before graph processing
- Weekly routine: dump → ingest → graphify → lint

## Pipeline

```
raw/ (captures, messy)
  ↓ /second-brain-ingest
wiki/ (structured, frontmatter, tags)
  ↓ /graphify
graphify-out/ (visual graph, god nodes, clusters)
```

## Capture Categories

| Category | Examples |
|----------|----------|
| Code patterns | Reusable hooks, components, CSS tricks |
| Bug archaeology | Error + root cause + fix |
| Library evals | Tried X vs Y, decision + why |
| API gotchas | Endpoint quirks, auth flows |
| Performance notes | Benchmarks, render optimizations |
| Design system | Components, tokens, a11y patterns |
| Talk/book notes | Conferences, books, podcasts |
| PR learnings | Patterns spotted, mistakes to avoid |
| System design | Architecture decisions, tradeoffs |
| Tooling configs | Dotfiles, CLI workflows, editor setups |
| Incidents | Postmortems, deploy failures |
| Prompts that work | LLM prompts for coding tasks |
| Testing strategies | Flaky test fixes, coverage patterns |
| Security notes | Vulns, fixes, auth patterns |

## Tool Selection Guide

| Need | Tool |
|------|------|
| Process article into wiki note | `second-brain-ingest` |
| What do I know about X? | `second-brain-query` |
| How does X connect to Y? | `graphify path/query` |
| Knowledge clusters? | `graphify` report |
| Contradictions/orphans? | `second-brain-lint` |

## Weekly Routine

1. Dump captures into `raw/00_inbox/`
2. Run `/second-brain-ingest` to process queue
3. Run `/graphify` on `wiki/` to update graph
4. Run `/second-brain-lint` to check health

## Concepts Covered

- [[second-brain-pattern]] — three-folder PKM system
- [[graphify]] — knowledge graph generation tool
- [[llm-wiki-pattern]] — this vault's raw → wiki → graph pipeline
- [[progressive-processing]] — priority order for ingesting sources
