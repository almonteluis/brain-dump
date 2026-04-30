---
description: Merged knowledge graph of BrainBreak feature across frontend, backend, and Lambda infrastructure — 303 nodes, 416 edges, 39 communities
tags: ["brain-break", "knowledge-graph", "architecture", "TEAME-218", "graphify", "new-classrooms"]
sources: ["BrainBreak Knowledge Graph Analysis.md"]
created: 2026-04-28
updated: 2026-04-28
---

# BrainBreak Knowledge Graph Analysis

**Source:** `BrainBreak Knowledge Graph Analysis.md`
**Date ingested:** 2026-04-28
**Type:** Architecture analysis via knowledge graph

## Summary

Merged 3 [[graphify]] outputs into a single cross-repo graph:

| Source | Path | Nodes | Focus |
|---|---|---|---|
| BrainBreak corpus | `frontend/graphify-out-brainbreak/` | ~150 | Feature-specific code |
| Frontend codebase | `frontend/graphify-out/` | ~100 | Full React app |
| Full codebase | `graphify-out/` | ~53 | Backend + Lambda |

**Merged result:** 303 nodes, 416 edges, 39 communities.

## God Nodes (Highest Connectivity)

1. **`BrainBreakProviderInner()`** — 28 edges. Central React context provider. Bridges state, cooldown, flags, and UI actions.
2. **`DataService`** — 16 edges. Backend data access layer.
3. **`IDataService`** — 15 edges. Interface contract for data operations.
4. **`LambdaService`** — 12 edges. AWS Lambda orchestration.
5. **`EngineTests`** — 10 edges. Test coverage hub.
6. **`useBrainBreakRecorder()`** — 9 edges. Hook for recording brain break interactions.
7. **`TestSetup`** — 9 edges. Cross-test infrastructure.
8. **`Learnosity Result Fetcher Lambda`** — 9 edges. Lambda handler for assessment results.
9. **`useBrainBreakSessionLock()`** — 8 edges. Cross-tab session lock hook.
10. **`useBrainBreakNavigation()`** — 8 edges. Navigation orchestration for brain break flow.

## Surprising Connections

- **`getAssignedPlacement()` ↔ `getDeterministicRotatingQuestion()`** — Hash placement logic and survey question rotation share a semantic pattern: both map stable input to deterministic output. Refactoring opportunity: extract shared "deterministic selector" utility.
- **`BRAIN_BREAK_FLAG_NAME` → `isBrainBreakEnabled` in `SkillResource`** — Feature flag constant defined in one file, read in a completely different component. The flag wiring crosses frontend/backend boundary implicitly.
- **`isLockActive()` ↔ `COOLDOWN_CONFIG`** — Session lock state and cooldown configuration are conceptually coupled but live in separate files. Changes to cooldown rules likely break lock behavior.
- **`extractLockData()` explains `recordExperimentSpeculativeData`** — Session lock extraction is the *rationale* for experiment speculative data tracking. The lock metadata enables A/B test segmentation.

## Community Structure

| Community | Label | Nodes | Cohesion | Notes |
|---|---|---|---|---|
| 1 | `BrainBreakState, BrainBreakDataLoader()` | 30 | 0.07 | Main React state layer. Low cohesion suggests too many responsibilities. |
| 5 | `COOLDOWN_CONFIG, buildLockPayload()` | 17 | 0.24 | Session lock + cooldown. Tightest cluster = well-factored. |
| 3 | `Amazon.Lambda.Tools` | 30 | 0.09 | Lambda infra/docs. Low cohesion = mixed concerns (deploy + runtime + local dev). |
| 0 | `IDataService, .AddLearnosityExitSlipSessionAsync()` | 9 | 0.08 | Data layer contracts. |
| 4 | `Engine.cs, Engine` | 4 | 0.11 | Core business engine. Small and focused. |

**Tightest cluster:** Cooldown & Lock (cohesion 0.24, 17 nodes)  
**Loosest clusters:** BrainBreak State (0.07, 30 nodes) and Lambda Infrastructure (0.09, 30 nodes)

## Cross-Browser TOCTOU Window

The [[BB being open in 2 sessions via different browser]] bug maps onto this graph through:

- `useBrainBreakSessionLock()` (8 edges) sits at intersection of **Community 1** (React state) and **Community 5** (lock/cooldown)
- The session lock hook does *not* have backend CAS support — graph shows it only connects to client-side storage nodes
- `localStorage` race handling is marked as "best-effort" in the graph (INFERRED edges with confidence 0.6)

**Remaining risk:** Backend still needs atomic compare-and-swap to fully eliminate Scenario B (two tabs submitting simultaneously).

## Open Questions This Graph Answers

1. **Why does `BrainBreakProviderInner()` bridge 4 communities?** — High betweenness centrality (0.081). God Object pattern — the provider knows about state, cooldown, flags, and modal actions. Consider splitting into focused providers.
2. **Should `BrainBreakState` community be split?** — 30 nodes, cohesion 0.07. Contains state, loader, provider, context, eligibility check, and cooldown extraction. Likely 3 separate concerns.
3. **What connects `HASH_PLACEMENTS` to the rest of the system?** — 29 weakly-connected nodes found — possible documentation gap. The hash placement logic is isolated from the survey flow it drives.

## Concepts Covered

- [[knowledge-graph-analysis]] — Using graphify for codebase understanding
- [[god-object]] — `BrainBreakProviderInner()` as high-centrality provider
- [[community-detection]] — Clustering code by cohesion metrics
- [[cross-browser-session-lock]] — TOCTOU race condition in session lock

## Related

- [[teame-218-brainbreak-postmortem]] — Implementation post-mortem
- [[bb-cross-browser-session-lock]] — Session lock technical details
- [[user-bridge-analysis-orphaned-assets]] — Another graph-based analysis from same codebase
