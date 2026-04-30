---
tags: [ai, knowledge-management, second-brain, agents, clippings]
sources: ["Thread by @FarzaTV.md"]
created: 2026-04-29
updated: 2026-04-29
---

# Farzapedia: Personal Wikipedia for Agents

**Source:** Thread by @FarzaTV.md
**Date ingested:** 2026-04-29
**Type:** Twitter thread

## Summary

Farza (@FarzaTV) had an LLM ingest 2,500 entries from diary, Apple Notes, and iMessage to create a personal Wikipedia with 400 articles and backlinks. Built for his agent to crawl, not for human reading.

## Key Claims

- **400 articles** from 2,500 source entries: friends, startups, research, anime, impact analysis
- **Built for the agent:** Wiki structure with backlinks is easily crawlable by agents
- **RAG was "ass":** filesystem-based wiki with index.md entry point works better than vector RAG
- **Agent workflow:** Query → agent reads index.md → drills into specific pages for context
- **Auto-maintenance:** Adding new content auto-updates 2-3 related articles or creates new ones
- **Example query:** "Design landing page using recent inspirations" → agent pulls Philosophy (Studio Ghibli doc), Competitor (YC landing pages), and 1970s Beatles merch screenshots

## Entities Mentioned

- [[farzatv|FarzaTV]] — Creator of Farzapedia
- [[andrej-karpathy|Andrej Karpathy]] — Referenced ("room for an incredible new product")
- [[emmett-shear|Emmett Shear]] — Commented "This is very cool!"

## Concepts Covered

- [[agent-knowledge-base]] — Structured wiki for agent consumption
- [[personal-wiki]] — LLM-managed knowledge base from personal data
- [[rag-vs-structured]] — Filesystem wiki beats vector RAG for agent navigation
- [[auto-synthesis]] — Agent updates related articles when new content added
