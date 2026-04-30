---
description: "Orphan notes finder report and analysis"
tags: [tools, obsidian, vault-maintenance, orphans, wiki-links, knowledge-graph]
sources: [obsidian-orphan-finder-report.md]
created: 2026-04-09
updated: 2026-04-09
---

# Obsidian Vault Orphan Finder Report

**Source:** raw/02_reference/tools/obsidian-orphan-finder-report.md
**Date ingested:** 2026-04-09
**Type:** audit report

## Summary

Report from running the orphan finder script on the vault. Found that 243 notes had no incoming links, meaning React/Relay resources were disconnected from the knowledge graph.

## Key Findings

- **Total Markdown Files:** 243
- **Orphans Found:** 243 notes with NO incoming links
- **Problem:** Newly saved resources were floating independently

## Top 10 Orphans (By Isolation)

1. `relay-query-refactoring-guide` — 0 outgoing links (completely isolated)
2. `react-bits-summary`
3. `Untitled 1`
4. `airbnb-react-style-guide`
5. `graphql-workshop-summary`
6. `relay-main`
7. `fullstack-graphql-workshop`
8. `Untitled 2`
9. `airbnb-react-patterns-summary`
10. `relay-eslint-rules-guide`

## Solution: Hub Note

Create a **"React & GraphQL Resources"** note linking all guides:

```markdown
# React & GraphQL Resources

## Core Patterns
- [[airbnb-react-style-guide]]
- [[airbnb-react-patterns-summary]]
- [[react-bits-summary]]

## GraphQL & Relay
- [[relay-main]]
- [[relay-query-refactoring-guide]]
- [[relay-eslint-rules-guide]]

## Full Workshop
- [[fullstack-graphql-workshop]]
- [[graphql-workshop-summary]]
```

## Script Location

- **Main script:** `/home/ubuntu/clawd/scripts/find_obsidian_orphans.py`
- **Quick check:** `/home/ubuntu/clawd/scripts/quick_orphan_check.py`

## Concepts Covered

- [[Orphan Notes]] — Notes with no incoming links
- [[Knowledge Graph]] — Connected vs isolated notes
- [[Hub Notes]] — Central connection points
- [[Vault Health]] — Maintenance and connectivity

## Related

- [[obsidian-claude-101]]
- [[vault-wide-connections-synthesis]]
