---
tags:
  - cbl
  - knowledge-tracing
  - competency-based-learning
  - operation-endgame
  - adaptive/learning
sources:
  - cbl-knowledge-frontier.md
created: 2026-05-11
updated: 2026-05-11
cluster: operation-endgame
---

# CBL Knowledge Frontier — Source Summary

> Ingested from `raw/cbl-knowledge-frontier.md`. Part of [[Operation Endgame]] — Pillar 2 of the CBL platform research.

## Overview

Research synthesis on **targeting each student's knowledge frontier** — the boundary between what they've mastered and what they're ready to learn next. Draws on five foundational frameworks and connects them to existing vault research on [[skill-tree-competency-structure]], [[productive-struggle]], [[adaptive-feedback-education]], [[ai-math-tutoring]], [[three-ring-mastery-system]], and [[insight-recall]].

## Foundational Frameworks Covered

| Framework | Key Source | Core Idea |
|-----------|-----------|-----------|
| [[zone-of-proximal-development]] | Vygotsky (1978) | Instruction should target the gap between independent and guided performance |
| [[knowledge-space-theory]] | Doignon & Falmagne (1999/2011) | Mathematical formalization of prerequisite relationships and knowledge states |
| [[knowledge-tracing]] / BKT | Corbett & Anderson (1995) | HMM-based mastery estimation from interaction sequences |
| [[deep-knowledge-tracing]] | Piech et al. (2015) | RNN/LSTM for higher-accuracy KT with temporal pattern capture |
| Adaptive Sequencing | Sarsa et al. (2025) | DKT + [[cognitive-load]] estimation for personalized path generation |

## Key Claims

1. **The skill tree DAG is a frontier map** — [[skill-tree-competency-structure]] gap detection directly implements knowledge frontier identification
2. **Productive struggle IS frontier calibration** — [[productive-struggle]] maps onto the ZPD: frustration (beyond frontier), fluency (below frontier), productive struggle (at frontier)
3. **Process-level feedback is most valuable at the frontier** — [[adaptive-feedback-education]] shows that targeting reasoning steps matters most when a student is at the edge of competence
4. **Multi-skill problems are frontier diagnostics** — [[ai-math-tutoring]] evidence that accuracy ≈ accuracy² on combination problems makes them ideal for assessing deep understanding at the frontier
5. **Spaced repetition reconnects decayed skills to the frontier** — [[three-ring-mastery-system]] decay means previously mastered skills can re-enter the frontier
6. **Bridge-aware scaffolding is proactive frontier targeting** — [[insight-recall]] forward-priming anticipates what students will need before they start

## Key Entities

- **Vygotsky's ZPD** — conceptual foundation for all adaptive learning
- **Knowledge Space Theory** — mathematical formalization (ALEKS implementation)
- **BKT** — interpretable, low-infra KT approach
- **DKT** — higher accuracy, black-box tradeoff
- **Cognitive load estimation** — prevents overwhelming students during adaptive sequencing

## Key Concepts

- [[zone-of-proximal-development]] — the instructional sweet spot
- [[knowledge-space-theory]] — prerequisite modeling
- [[knowledge-tracing]] — mastery estimation over time
- [[deep-knowledge-tracing]] — neural KT approaches
- [[productive-struggle]] — what learning at the frontier feels like
- [[skill-tree-competency-structure]] — the DAG that defines the frontier
- [[adaptive-feedback-education]] — feedback design for frontier instruction
- [[cognitive-load]] — managing mental overhead during adaptive sequencing

## Connections to Vault Research

See the full source for detailed connections to: [[skill-tree-competency-structure]], [[productive-struggle]], [[adaptive-feedback-education]], [[ai-math-tutoring]], [[three-ring-mastery-system]], and [[insight-recall]].

## Design Principles for Operation Endgame

1. Explicit frontier modeling via skill tree DAG
2. ZPD-aligned content delivery
3. Struggle detection (productive vs. flailing vs. coasting)
4. Adaptive sequencing through competency DAG
5. Bridge-aware transitions between skill areas
6. Cognitive load awareness in path generation
