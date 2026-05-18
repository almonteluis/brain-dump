---
description: An educational knowledge graph is a list of skills and a list of arrows between them saying 'you need this before that.' Calling it a 'graph' makes it sound fancier than it is — but that simple structure is what makes adaptive sequencing possible.
tags:
  - concept
  - knowledge-graph
  - education
  - skill/graph
  - prerequisite
  - ontology
  - adaptive/learning
sources: []
created: 2026-05-16
updated: 2026-05-16
---

# Knowledge Graph (Education)

An educational knowledge graph is a list of skills and a list of arrows between them that say "you need to master this before you can learn that." Calling it a "knowledge graph" makes it sound fancier than it is. But that simple structure — nodes and prerequisite edges — is what lets an adaptive system sequence content without a human making every decision.

Picture a kid who's bombing three-digit addition with carrying. In a traditional curriculum, the teacher might not know *why* — is it the carrying? The place value? The basic addition facts? A knowledge graph lets the system trace back automatically: check two-digit addition → check carrying → check place value → check single-digit addition. Find the gap. No teacher intervention needed; the graph tells the orchestrator where to go.

## What's In It

| Node | Example | What it represents |
|------|---------|-------------------|
| Skill | "Add fractions with unlike denominators" | A learnable unit |
| Concept | "Equivalent fractions" | An idea that underlies multiple skills |
| Standard | CCSS.MATH.CONTENT.5.NF.A.1 | The formal requirement |
| Resource | Lesson, video, assessment item | The thing the kid actually interacts with |

| Edge | Meaning |
|------|---------|
| **prerequisite** | Must master A before attempting B |
| **related** | A and B share a conceptual foundation |
| **assesses** | Resource R measures skill S |
| **teaches** | Resource R covers skill S |

## Why It's the Skeleton

The knowledge graph is the static structure. Everything else moves on top of it:

- [[knowledge-tracing]] estimates where the student *is* on the graph
- The orchestrator decides what to serve *next* by walking the graph
- [[adaptive-feedback-education]] targets the specific node the student is struggling with
- [[cooldown-system]] pulls mastered nodes out of rotation and re-introduces them later

Without the graph, none of those systems have a map. They're just guessing.

## The Hard Problems

- **Granularity** — too fine-grained and you have thousands of sparse nodes with not enough data per node. Too coarse and you can't target the actual gap. "Fractions" isn't a skill; "add fractions with unlike denominators using visual models" might be. Where's the line?
- **Multiple prerequisites** — some skills need parallel mastery of several predecessors. The graph isn't always a tree.
- **Maintenance** — standards change, research refines prerequisite assumptions, and someone has to update the graph without breaking the downstream systems.
- **Cold start** — new students with no history. The graph can place them initially, but it needs diagnostic data to be accurate. 

[[skill-graph]] is TTO's specific implementation. The open thread: what if the graph isn't static? What if [[knowledge-tracing]] data from thousands of students could *revise* the prerequisite edges — discovering that skill C actually depends on skill B way more than anyone thought? A living graph that learns its own structure from usage data. That's the [[project-atlas]] vision, and it's where educational knowledge graphs get genuinely interesting.
