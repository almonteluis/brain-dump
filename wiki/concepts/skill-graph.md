---
description: The skill graph is TTO's prerequisite map — which skills depend on which other skills. It's what lets the orchestrator know that a kid bombing three-digit addition should probably go back and check place value first.
tags:
  - concept
  - skill/graph
  - prerequisite
  - knowledge-graph
  - tto
  - sequencing
sources: []
created: 2026-05-16
updated: 2026-05-16
---

# Skill Graph

The skill graph is [[teach-to-one]]'s prerequisite map. Every skill the system teaches is a node. Every "you need this before that" relationship is a directed edge. When [[knowledge-tracing]] says a kid is struggling with a skill, the orchestrator traces back along the graph to find the gap.

Picture a kid who can't add fractions with unlike denominators. The system doesn't just re-serve the same lesson. It walks the graph: do they know equivalent fractions? Yes. Do they know how to find a common denominator? No. → Serve common denominator problems first, then loop back. The graph makes this automatic.

## The Design Decisions That Matter

**Granularity** is the big one. Too fine-grained and you have thousands of nodes with sparse data per node — the [[knowledge-tracing]] estimates get noisy. Too coarse and you can't target the actual gap. "Fractions" isn't a skill. "Recognize equivalent fractions using visual models" might be. Every ed-tech company wrestles with where to draw the line.

**Multiple prerequisites** complicate the graph. Some skills need parallel mastery — you need both "add single digits" and "understand place value" before you can do "add two-digit numbers with carrying." The graph isn't always a clean tree; sometimes it's a DAG with convergence points.

## The Living Graph Question

Right now the skill graph is static — someone (a content team, a curriculum designer) defines the prerequisites and the system follows them. But what if the graph could *learn* from data? If 10,000 students consistently struggle with skill B after mastering skill A but *not* skill C, maybe the prerequisite edge is wrong. A dynamic graph that revises its own structure based on [[knowledge-tracing]] data is the [[project-atlas]] vision.

That's where [[knowledge-graph-education]] gets interesting — not as a static map but as a living model of how learning actually progresses, not how we think it should.
