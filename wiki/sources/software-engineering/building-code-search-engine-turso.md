---
tags:
  - turso
  - sqlite
  - vector-search
  - code/search
  - agent
  - clippings
sources:
  - Building a code search engine with Turso.md
created: 2026-04-29
updated: 2026-04-29
---

# Building a Code Search Engine with Turso

**Source:** Building a code search engine with Turso.md
**Date ingested:** 2026-04-29
**Type:** Technical guide

## Summary

Glauber Costa built Codemogger — a local code indexer and search engine for AI agents using Turso (SQLite with native vector and full-text search). Single `.db` file, no external services.

## Key Claims

- **Problem:** Agents grep files for "where is authentication handled?" when semantic search would find implementations
- **Solution:** Vector search + full-text search hybrid in single SQLite file via Turso

### Database Schema

- Three tables: `codebases`, `chunks`, `fts_`
- `embedding` column: `vector8(384)` — 384-dim int8 quantized vectors (first-class column type in Turso)
- Chunking via tree-sitter: functions, structs, classes, impl blocks

### Vector Search

- Local embeddings: `all-MiniLM-L6-v2` (~22MB, CPU)
- Query: `vector_distance_cos(embedding, vector8(?))`
- 40K TypeScript compiler chunks → 240ms search on Apple M2
- 750 files → 35ms search

### Full-Text Search

- Native FTS with BM25 scoring and configurable weights
- Function names weighted 5× higher than signatures
- Keyword search: 1-4ms (25-370× faster than grep)

### Hybrid Search

- Reciprocal Rank Fusion (RRF): `0.4/(60 + rank_fts) + 0.6/(60 + rank_vec)`
- Vector 60% weight, FTS 40%

### SDK Design

- Bring your own embedder: any model (HuggingFace, OpenAI, Cohere)
- Incremental indexing: SHA-256 hash tracking, only changed files re-processed
- Modes: semantic, keyword, hybrid

## Entities Mentioned

- [[glauber-costa|Glauber Costa]] — Author, Turso/codemogger creator

## Concepts Covered

- [[turso]] — SQLite with native vector and FTS
- [[vector-search]] — Semantic code search via embeddings
- [[hybrid-search]] — RRF combining vector + keyword results
- [[code-chunking]] — Tree-sitter parsing into semantic units
- [[int8-quantization]] — Reduces vector storage from 1,536 bytes to 395 per vector
- [[local-rag]] — No-network retrieval for agents
