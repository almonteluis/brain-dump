---
description: "Knowledge Graph-enhanced RAG for personalized learning — architecture pattern combining structured KG retrieval with LLM generation for adaptive tutoring. Maps to TTO's KG+LLM infrastructure phase."
tags:
  - knowledge-graph
  - rag
  - llm
  - personalized-learning
  - concept
  - tto
sources:
  - arXiv:2311.17696 (Dong et al., KG-RAG for Adaptive AI Tutoring)
  - Frontiers fcomp.2026.1777749 (Deng & Yuan, Multimodal KG + RAG ITS)
  - Parsnip Knowledge (parsnip.substack.com/p/knowledge)
created: 2026-05-15
updated: 2026-05-15
---

# KG-RAG for Personalized Learning

> Synthesis from research on Knowledge Graph-enhanced Retrieval-Augmented Generation for adaptive tutoring systems. Directly applicable to TTO's KG+LLM infrastructure build.

## The Problem: Why Plain RAG Fails for Education

Standard RAG = vector similarity search → chunk → feed to LLM. Works for Q&A, fails for education:

- **No concept relationships** — Vector search finds "similar text" but doesn't know fractions are a prerequisite for decimals
- **No learner state** — RAG is stateless; doesn't know what the student has mastered
- **No reasoning chains** — Can't trace "student struggled with X → missing prerequisite Y"

**KG-RAG fixes this by layering a knowledge graph on top of vector retrieval.**

## Architecture Pattern

```
┌─────────────────────────────────────────────────┐
│                  Student Interface               │
├─────────────────────────────────────────────────┤
│            Pedagogical Decision Engine           │
│         (what to teach, when to intervene)       │
│         ← Knowledge Tracing / Learner Model      │
├──────────┬──────────────────────────┬───────────┤
│   KG     │      Hybrid RAG          │   LLM     │
│  Layer   │      Retrieval           │  Layer    │
│          │                          │           │
│ Skills,  │  1. Graph traversal      │  Grounded │
│ prereqs, │     (KG-aware context)   │  response │
│ relation-│  2. Vector similarity    │  gen with │
│ ships    │     (semantic backup)    │  cited    │
│          │  3. Merge + rank         │  sources  │
│          │                          │           │
├──────────┴──────────────────────────┴───────────┤
│           Content / Curriculum Store             │
│     (textbooks, problems, lesson plans, etc.)    │
└─────────────────────────────────────────────────┘
```

### Retrieval Flow

1. **Learner state query** → Knowledge Tracing outputs current mastery per skill
2. **Graph traversal** → From current skill node, traverse prerequisite/related edges to find relevant context
3. **Vector similarity** → Parallel semantic search across curriculum content as fallback
4. **Merge + rank** → Combine graph-retrieved and vector-retrieved chunks, deduplicate, rank by relevance
5. **Grounded generation** → LLM generates response with KG context + curriculum sources attached

## Key Papers

### 1. KG-RAG for Adaptive AI Tutoring (Dong et al., 2024/2025)
- **arXiv:** [2311.17696](https://arxiv.org/abs/2311.17696) | Published ICEIT 2025
- **The most directly relevant paper.** Exact architecture for what TTO is building.
- Results: **35% increase in assessment scores** (n=76, p<0.001)
- Three retrieval paths: (a) KG traversal from learner's current position, (b) semantic similarity as fallback, (c) merge + rank
- Grounds every LLM response in verified domain knowledge
- KG stores: concepts, prerequisite edges, learning resources, assessment items
- **Full text:** `raw/02_reference/papers/kg-rag-adaptive-tutoring-dong-2024.md`

### 2. Multimodal KG + RAG for ITS (Deng & Yuan, Feb 2026)
- **DOI:** [10.3389/fcomp.2026.1777749](https://www.frontiersin.org/journals/computer-science/articles/10.3389/fcomp.2026.1777749/full)
- Automatic KG construction from multimodal content (textbooks, videos, slides)
- Addresses the "expert bottleneck" — AI builds KG, humans validate
- Three-level architecture: knowledge extraction → KG fusion → RAG-grounded Q&A
- Relevant because TTO has multimodal content (Learnosity items, lesson plans, videos)

### 3. Microsoft GraphRAG (Foundational)
- **Docs:** [microsoft.github.io/graphrag](https://microsoft.github.io/graphrag/)
- Pipeline: Ingest → Extract entities/relationships → Build graph → Leiden community detection → Community summaries → Grounded query
- Not education-specific but the backbone tech Parsnip and others build on
- **FastGraphRAG** = cheaper alternative using spaCy/NLTK for entity extraction instead of LLM calls

### 4. Parsnip Knowledge (Andrew Mao & Dan Sosa, Feb 2026)
- **Source:** [parsnip.substack.com/p/knowledge](https://parsnip.substack.com/p/knowledge)
- Two-part system: Map Builder (KG) + GPS (personalized tutor)
- "Theory of mind" = learner position tracked on graph
- Grounded generation: graph structure + trusted sources → minimal hallucination
- Domain-agnostic, interpretable by design, human-in-the-loop

## Graph RAG vs Vector RAG vs Hybrid

| | Vector RAG | Graph RAG | Hybrid |
|---|---|---|---|
| **Best for** | Broad semantic search, unstructured Q&A | Structured reasoning, prerequisites, multi-hop | Production systems |
| **Context quality** | "Find similar paragraphs" | "Find prerequisites → related concepts → resources" | Both paths, ranked |
| **Explainability** | Low (similarity scores) | High (graph path is visible) | High |
| **Build cost** | Low (embed & go) | High (need KG) | Medium (if KG exists) |
| **Hallucination risk** | Moderate | Low (grounded in graph) | Low |

**For TTO: Hybrid.** KG already exists (skill map + 6yr data). Graph traversal as primary retrieval, vector search as fallback.

## Microsoft GraphRAG Pipeline (Reference)

| Step | What Happens |
|---|---|
| **1. Ingest** | Raw text → chunk into TextUnits |
| **2. Extract** | LLM extracts entities + relationships from each chunk |
| **3. Build Graph** | Entities as nodes, relationships as edges |
| **4. Community Detection** | Leiden algorithm clusters entities into hierarchical communities |
| **5. Summarize** | LLM generates summary per community |
| **6. Query** | Graph traversal + community summaries → grounded context for LLM |

## TTO Implementation Mapping

| Component | TTO Status | What's Needed |
|---|---|---|
| **Knowledge Graph** | ✅ Skill map exists (~6yr data, prerequisite edges) | Connect to RAG pipeline; validate graph integrity |
| **Learner Model** | ✅ BKT + decay data | Wire KT output into retrieval queries |
| **Curriculum Store** | ✅ Learnosity items, lesson plans | Embed content for vector fallback path |
| **RAG Layer** | ❌ Not built | Build hybrid retrieval (graph traversal + vector search) |
| **LLM Generation** | ⚠️ Research phase | Grounded generation with KG context + citations |
| **Content Generation** | ❌ Not built | Parsnip-style "GPS" — personalized problems/explanations from KG position |

### Parsnip → TTO Feature Mapping

| Parsnip Concept | TTO Equivalent | Implementation |
|---|---|---|
| Map Builder | TTO skill map | Graph already built — connect to RAG |
| Theory of Mind | Knowledge tracing | Learner state drives which KG nodes to retrieve |
| GPS System | Path gen + content delivery | Graph traversal from learner position → next skills → resources |
| Grounded Generation | LLM feedback tied to curriculum | RAG pulls from KG + curriculum store, LLM generates with citations |

### Key Insight: TTO's Head Start

Parsnip built their KG from scratch for cooking (unstructured domain). TTO has a **head start** — the skill map + 6 years of interaction data means the KG is already built. The gap is the **RAG layer on top**. Parsnip partnership could accelerate this if they provide the "GPS" layer; TTO provides the domain KG + learner data.

## Related Concepts

- [[knowledge-graph-education]] — Educational KG construction, relationship types, KT integration
- [[its-llm-architecture]] — Modular ITS + LLM pattern (ITS retains control)
- [[knowledge-tracing]] — Mastery estimation operating on KG-defined skills
- [[deep-knowledge-tracing]] — DLKT vs BKT for the learner model component
- [[skill-tree-competency-structure]] — DAG formalization for prerequisite validation
- [[competitive-landscape-research-implementation]] — Competitor analysis (ALEKS, Math Academy, Prodigy)

## Open Questions

- **KG schema**: Should TTO adopt Parsnip's KG format or extend existing skill map format?
- **Entity extraction**: What counts as a "node" in TTO's KG — skills only, or also concepts, strategies, misconceptions?
- **Retrieval ranking**: How to weight graph-path relevance vs vector similarity when they disagree?
- **Latency**: Graph traversal + LLM generation in real-time during a tutoring session — what's acceptable?
- **Evaluation**: How to measure KG-RAG quality vs plain RAG vs no-RAG for TTO's specific use case?
- **Cold start**: New skills added to curriculum — vector search fallback until graph edges are validated?

## Why This Matters for TTO

TTO's KG+LLM infrastructure phase (Operation Endgame) needs exactly this architecture. The skill map is the KG. Knowledge tracing provides learner state. The missing piece is the RAG layer that connects them to an LLM for grounded, personalized content generation. Building this unlocks:
1. Personalized explanations grounded in the student's actual skill position
2. Teacher-facing dashboards that show *why* a recommendation was made (graph path is explainable)
3. Generative content that's tied to verified curriculum, not free-associating LLM output
4. Foundation for Three-Ring mastery system in Phase 2 (rings map directly to KG regions)
