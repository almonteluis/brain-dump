---
description: Skill Tree Competency Structure — formal DAG-based prerequisite modeling for education. Not a flat skill list. A directed acyclic graph with verifiable structural properties enabling automated coaching and gap detection.
tags:
  - knowledge-tracing
  - skill/mapping
  - concept
sources:
  - paper-skill-trees-competency-2025.md
  - paper-knowledge-graph-education-slr-2024.md
  - paper-ai-math-tutoring-2025.md
created: 2026-05-10
updated: 2026-05-17
---

# Skill Tree Competency Structure

Synthesis from 3 papers on formal competency structures in education.

A skill tree is what happens when you take a flat list of skills ("the student needs to learn fractions, decimals, percentages...") and add the prerequisite relationships between them as a directed acyclic graph (DAG). Not an informal skill map. Not a curriculum document. A formal structure with verifiable properties that machines can reason about.

## The Three Properties That Matter

| Property | What it means | What breaks without it |
|----------|--------------|----------------------|
| **Acyclicity** | No circular dependencies | Impossible learning paths — "learn A before B before A" |
| **Prerequisite Coverage** | Every skill reachable from foundational skills | Orphan skills nobody can learn |
| **Coherence** | Prerequisites actually enable the target | Spurious dependencies — the graph says you need X but you don't |

These are from [[skill-trees-competency-2025]]. They're a quality checklist for any competency structure used in algorithmic personalization. Miss one and the adaptive system makes bad decisions.

## How Skill Trees Get Built

Per [[knowledge-graph-education-slr-2024]], three approaches:

1. **Manual ontology engineering** — domain experts define skills and prerequisites. High quality, low scalability. Works for a single curriculum, breaks when you need to cover 12 grade levels.
2. **Automated extraction** — mine textbooks, assessment data, interaction logs for prerequisite relationships. Scalable but noisy. The graph might say skill A requires skill B when really it's the other way around.
3. **Hybrid** — expert-defined core + data-driven refinement. Most promising for production. Experts get the structure right; data fills in the edges they missed.

## What You Can Do With a Valid Skill Tree

- **Gap detection** — given a target competency, find which prerequisites a student hasn't mastered
- **Learning path generation** — traverse the DAG to produce ordered skill sequences
- **Curriculum validation** — catch structural problems (missing edges, circular dependencies, orphan skills) automatically
- **Progress estimation** — measure how far a student has progressed through the tree

## Relationship to Knowledge Graphs

Skill trees are a specialized form of [[knowledge-graph-education]]. Knowledge graphs can represent anything (associations, similarities, analogies). Skill trees focus specifically on **prerequisite relationships** — the partial ordering of competencies by dependency. Less expressive, more tractable for algorithmic path planning.

## In CBL Assessment

The DAG structure is assessment infrastructure:
- **Gap detection for assessment** — the tree identifies unmastered prerequisites before advancement. Assessment becomes a structural property of the learning pathway, not a separate event.
- **Evidence accumulates at nodes** — each node is a natural assessment checkpoint. Mastery-gated progression means the tree encodes the assessment sequence.
- **Curriculum validation = assessment quality assurance** — structural properties don't just prevent learning path problems. An orphan skill is also an unassessable skill.

## Open Questions

- **Cross-domain prerequisites** — reading comprehension as prerequisite for math word problems? How do you model that?
- **Prerequisite strength** — some prerequisites are essential, others are helpful. Binary vs. weighted?
- **Real-time updates** — can the tree learn from data as students use the system?
- **Alternative paths** — multiple paths to the same competency?

The open thread: the skill tree is static — humans built it, and it stays the same until someone updates it. But what if [[knowledge-tracing]] data from thousands of students revealed that skill C depends on skill B way more than anyone thought? A living graph that revises its own structure from usage data. That's the [[project-atlas]] vision, and it's where static skill trees become genuinely adaptive.

## Related

- [[knowledge-graph-education]] — broader framework including skill trees
- [[knowledge-tracing]] — estimates mastery on skills defined by the tree
- [[knowledge-space-theory]] — the mathematical formalization underlying skill tree structure
- [[bkt-fairness]] — fairness concerns when trees don't account for confounding skills
- [[ai-math-tutoring]] — systems that use skill trees for personalization
- [[three-ring-mastery-system]] — TTO's application of skill progression
