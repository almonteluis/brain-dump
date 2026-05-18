---
description: "Building a code search engine with Turso"
tags: ['research']
source: "https://turso.tech/blog/building-a-code-search-engine-with-turso?utm_source=changelog-news"
raw_file: "Building a code search engine with Turso.md"
created: 2026-05-17
---

Register now for early access to the new Turso Cloud. [Join the private beta](https://turso.tech/private-beta)

![Cover image for Building a code search engine with Turso](https://turso.tech/_next/image?url=%2Fimages%2Fblog%2Fbuilding-a-code-search-engine-with-turso%2Fcover.png&w=3840&q=100)

I've been building tools for coding agents recently, and one pattern keeps showing up: you need to search code by meaning, not just by text. When an agent asks "where is authentication handled?", you sit your ass on the frame of your chair watching it stupidly grep a bunch of files when you know, deep down, your brain would do better. You could say at this point that the model Framemogged you, and spiked your cortisol levels.

What you actually want is to find the function definitions and structs that *implement* authentication. This is a vector search problem. You embed code chunks, embed the query, and find the closest matches by cosine similarity. The typical setup involves an external vector database, an embeddings API, and some glue to keep them in sync. But with [Turso](https://turso.tech/), you can do this with a single SQLite file, fully local, with no API keys.

To solve this problem for myself, I built [codemogger](https://github.com/glommer/codemogger), and released it as OSS in the hopes that it is also useful to others. It's a code indexer and search engine for AI agents, and the entire thing runs on top of Turso's native vector and full-text search. In this post I want to walk through how it works and what Turso features make it possible, so you can build similar things yourself.

It works fully locally as a CLI and MCP, and can even be used as an SDK to power existing projects!

## The Database Schema

The core of codemogger is three tables in a single `.db` file. Code gets parsed into chunks (functions, structs, classes, impl blocks) via tree-sitter, and each chunk is stored with its embedding:

```sql
CREATE TABLE IF NOT EXISTS codebases (
    id          INTEGER PRIMARY KEY AUTOINCREMENT,
    root_path   TEXT NOT NULL UNIQUE,
    name        TEXT NOT NULL DEFAULT '',
    indexed_at  INTEGER NOT NULL DEFAULT 0
);

CREATE TABLE IF NOT EXISTS chunks (
    id              INTEGER PRIMARY KEY AUTOINCREMENT,
    codebase_id     INTEGER NOT NULL REFERENCES codebases(id),
    file_path       TEXT NOT NULL,
    chunk_key       TEXT NOT NULL UNIQUE,
    language        TEXT NOT NULL,
    kind            TEXT NOT NULL,
    name            TEXT NOT NULL DEFAULT '',
    signature       TEXT NOT NULL DEFAULT '',
    snippet         TEXT NOT NULL,
    start_line      INTEGER NOT NULL,
    end_line        INTEGER NOT NULL,
    file_hash       TEXT NOT NULL,
    indexed_at      INTEGER NOT NULL,
    embedding       vector8(384),
    embedding_model TEXT DEFAULT ''
);
```

The `embedding` column is a `vector8(384)`: a 384-dimensional vector stored in int8 quantized form. In Turso, vectors are first-class column types. You write them with `vector8()` or `vector32()` and query them with `vector_distance_cos()`. There's nothing to install, no extension to load, no separate process to run.

## Storing Embeddings

Embeddings are generated locally using `all-MiniLM-L6-v2`, a small transformer model (~22MB, quantized, runs on CPU), but it is possible to provide your own embeddings function. That is especially valuable when using it in SDK mode. Each code chunk gets turned into a 384-dimensional vector and stored with Turso's `vector8()` function, which quantizes the float32 values down to int8:

```sql
UPDATE chunks
SET embedding = vector8(?), embedding_model = ?
WHERE chunk_key = ?
```

Using `vector8` instead of `vector32` cuts storage from 1,536 bytes per vector down to 395. For a codebase with 40,000 chunks, that's about 44MB saved on embeddings alone. The accuracy tradeoff is negligible for code search.

## Vector Search

When you search for "authentication middleware", the query gets embedded with the same model, and Turso finds the closest chunks by cosine distance:

```sql
SELECT chunk_key, file_path, name, kind, signature, snippet,
       start_line, end_line,
       vector_distance_cos(embedding, vector8(?)) AS distance
FROM chunks
WHERE embedding IS NOT NULL
ORDER BY distance ASC
LIMIT 10
```

That's it. One query, one table, one file. The result set comes back with actual function definitions and struct declarations that semantically match your query, ranked by relevance.

On an Apple M2, searching 40,000 chunks from the TypeScript compiler takes about 240ms. Searching 750 files from the Turso codebase takes 35ms. These are full scans since the datasets are small enough to not need an approximate nearest neighbor index.

## Full-Text Search

Vector search is great for natural language queries ("where does error handling happen?"), but sometimes you know the exact name you're looking for. You want `BTreeCursor`, and you want the definition, not every file that mentions it.

Turso has native FTS with BM25 scoring and configurable field weights. Codemogger creates a per-codebase FTS table and weights function names 5x higher than signatures:

```sql
CREATE TABLE IF NOT EXISTS fts_1 (
    chunk_id    INTEGER NOT NULL REFERENCES chunks(id) ON DELETE CASCADE,
    name        TEXT NOT NULL DEFAULT '',
    signature   TEXT NOT NULL DEFAULT ''
);

CREATE INDEX IF NOT EXISTS idx_fts_1 ON fts_1
    USING fts (name, signature)
    WITH (
        tokenizer = 'default',
        weights = 'name=5.0, signature=3.0'
    );
```

Then searching is a single query with `fts_match()` and `fts_score()`:

```sql
SELECT chunk_id, fts_score(name, signature, ?) AS score
FROM fts_1
WHERE fts_match(name, signature, ?)
ORDER BY score DESC
LIMIT 10
```

Keyword search across 40,000 chunks runs in 1-4ms. That's 25x to 370x faster than grepping (I got my clanker to go benchmark this), and you get back definitions, not lines.

## Hybrid Search

The best results come from combining both. Codemogger uses Reciprocal Rank Fusion (RRF) to merge vector and FTS results:

```typescript
// score(chunk) = 0.4 / (60 + rank_fts) + 0.6 / (60 + rank_vec)
```

Vector results get 60% weight, FTS gets 40%. A chunk that ranks high in both systems gets the best combined score. This works well without needing to normalize the different score scales (BM25 scores have a completely different range than cosine distances).

## The SDK

If you want to build something similar, the SDK is the interesting part. It has no model dependency. You bring your own embedding function:

```typescript
import { CodeIndex } from "codemogger";

const db = new CodeIndex({
  dbPath: "./my-project.db",
  embedder: async (texts: string[]): Promise<number[][]> => {
    // Use any embedding model: local HuggingFace, OpenAI, Cohere, etc.
    return yourEmbedFunction(texts);
  },
  embeddingModel: "your-model-name",
});

// Index a codebase (incremental, only re-processes changed files)
const result = await db.index("/path/to/project");
console.log(\`${result.chunks} chunks from ${result.files} files in ${result.duration}ms\`);

// Semantic search
const results = await db.search("authentication middleware", {
  mode: "semantic",
  limit: 10,
  includeSnippet: true,
});

for (const r of results) {
  console.log(\`${r.filePath}:${r.startLine} [${r.kind}] ${r.name} (score: ${r.score})\`);
}

// Keyword search
const exact = await db.search("BTreeCursor", {
  mode: "keyword",
  limit: 5,
});

await db.close();
```

The `embedder` function takes a batch of strings and returns a batch of vectors. That's the whole interface. You can swap models without changing anything else. The SDK handles chunking, incremental indexing (files tracked by SHA-256 hash), stale data cleanup, and the FTS/vector hybrid search.

This design is possible because Turso gives you vector search and FTS in a single embedded database. You're not coordinating between a relational store for metadata, a vector database for embeddings, and a search engine for text. It's all in one file, one connection, one set of SQL queries.

## Where to go from here?

Codemogger is one specific thing (a code search engine for agents), but the pattern generalizes. Anything that needs semantic search over structured content can use the same approach:

- **Documentation search**: chunk docs by section, embed them, search by meaning
- **Log analysis**: embed log entries, find similar errors across time
- **Codebase Q&A**: combine code search with an LLM for "explain this function" workflows
- **Local RAG**: index your notes, papers, or any text corpus and retrieve relevant passages

The key property is that it's all local. One `.db` file, no network calls for search, no external services to manage. You can copy the file, back it up, version it, or ship it to another machine. That's the SQLite model, extended with the vector and text search primitives that these workloads need.

If you want to try codemogger, it's at [github.com/glommer/codemogger](https://github.com/glommer/codemogger). If you want to build your own version of this for a different use case, grab [Turso](https://turso.tech/) and start with `vector8()` and `fts_match()`.

Share article
