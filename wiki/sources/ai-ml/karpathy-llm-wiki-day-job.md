---
description: 6-month report on implementing Karpathy's LLM Wiki pattern for AWS infrastructure management
tags:
  - source
  - article
  - llm-wiki
  - knowledge-management
  - ai/ml
source: https://tomnguyenit.medium.com/i-built-karpathys-llm-wiki-for-my-day-job-here-s-what-actually-works-0d4ec6d1e433
author: "[[tom-nguyen]]"
published: 2026-04-19
created: 2026-04-30
updated: 2026-04-30
---

# I Built Karpathy's LLM Wiki for My Day Job — Here's What Actually Works

A 6-month report from Tom Nguyen, a platform engineer running the LLM Wiki pattern on real AWS infrastructure — not a weekend project. 77 wiki pages, 30+ ingested sources, 13 custom AI skills.

## Source

- **URL:** https://tomnguyenit.medium.com/i-built-karpathys-llm-wiki-for-my-day-job-here-s-what-actually-works-0d4ec6d1e433
- **Author:** [[tom-nguyen]]
- **Published:** 2026-04-19
- **Type:** Blog post / Experience report

## Architecture

Three layers matching Karpathy's pattern:

1. **Raw sources** — Confluence exports, meeting transcripts, architecture docs. Immutable. AI reads but never touches.
2. **The wiki** — Obsidian vault with structured markdown. AI writes and maintains. Human reviews and browses.
3. **The schema** — `AGENTS.md` defining directory structure, frontmatter conventions, naming conventions, quality standards, and workflows.

Three operations: **Ingest**, **Query**, **Lint**.

## What Actually Works

### 1. The AI Remembers What You Forget

The wiki becomes external memory. The AI is the librarian. When asking "what's the deployment order for production changes?", the AI reads the wiki index, finds relevant pages, and gives exact answers synthesized from documents ingested months ago.

### 2. Cross-Referencing Is the Killer Feature

When ingesting a document about "PR review standards," the AI:
- Creates the main knowledge page
- Links it to existing "deployment workflow" page
- Links it to "change management" page
- Links it to "Terraform coding standards" page
- Updates the index

A human would never maintain these cross-references. The AI does it every time.

### 3. The Schema File Is Everything

`AGENTS.md` defines directory structure, frontmatter conventions, naming conventions, quality standards, and workflows. Without it, the AI produces inconsistent output. With it, every page follows the same pattern. The schema turns a chatbot into a disciplined wiki maintainer.

### 4. Specialized Skills Solve Real Problems

13 skills built to solve daily pain points:

| Skill | Problem Solved |
|-------|---------------|
| **AWS troubleshoot** | "Which account is this error from, and how do I investigate it?" |
| **Ticket tracker** | Tracking vulnerability remediation across 13 accounts |
| **PR review** | Reviewing changes across 3 repo layers with coding standards |
| **Knowledge ingestion** | Transforming any document into structured, interlinked wiki pages |
| **Error logging** | Preventing repeated mistakes by filing lessons into the wiki |

## What Doesn't Work

### 1. The AI Forgets to Use Its Own Wiki

The AI doesn't habitually check its own notes before answering. You have to build "check the knowledge base first" into every skill's instructions.

### 2. The AI Doesn't Track Its Own Mistakes

When an error is fixed, the AI doesn't automatically think "this is a reusable lesson, I should save it to the wiki." The human must explicitly say: "log this error as a knowledge note."

### 3. Index-Based Navigation Has a Ceiling

At 77 pages the index still works. But the ceiling is approaching. Sometimes the AI picks the wrong page because the one-line summary wasn't specific enough.

### 4. You Are the Quality Gate

The AI drafts; you approve. Caught issues include:
- Summaries that missed the key point
- Cross-links connecting unrelated concepts
- Pages duplicating existing content instead of updating it

## Addressing the Critics

**"It's just RAG with extra steps"** — No. RAG retrieves fragments and synthesizes on every query. The wiki pre-synthesizes once and keeps the synthesis current. Cross-references are already there. Contradictions have already been flagged.

**"It doesn't scale"** — Fair, but misses the point. The pattern works for personal and small-team knowledge bases (tens to low hundreds of pages). It's replacing the notebook you never maintain and the bookmarks you never organize.

## Practical Advice

1. **Start with the schema, not the wiki.** Write `AGENTS.md` first.
2. **Ingest one document at time.** Stay involved. Batch ingestion produces lower quality.
3. **Build skills early.** A wiki that powers specialized workflows is transformative.
4. **Accept that you're the editor-in-chief.** The AI proposes, you approve.
5. **Use Obsidian.** Graph view, backlinks, instant preview — best way to browse what the AI builds.

## Related

- [[karpathy-llm-wiki]] — Karpathy's original LLM Wiki pattern
- [[how-to-build-second-brain]] — AI-powered knowledge management
- [[second-brain-graphify-workflow]] — Graphify workflow for knowledge graphs
- [[llm-wiki-pattern]] — The LLM Wiki knowledge management pattern
- [[knowledge-compounding]] — Knowledge that compounds over time
- [[ai-librarian-pattern]] — AI as tireless librarian, human as curator
