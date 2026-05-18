---
description: Hoppenstedt portfolio post on Knowledge Skills and Technologies (KST) Mastery Maps at Platzi Master — 0-5 mastery rubric, jittered scatter plot fingerprints, Dunning-Kruger insights, future direction toward knowledge graphs
tags:
  - source
  - learning
  - visualization
  - kst
  - platzi
  - education/technology
  - dunning-kruger
  - mastery-based-learning
sources:
  - The Geometry of Learning Mapping the Evolution of Mastery through KSTs.md
created: 2026-05-03
updated: 2026-05-03
---

# The Geometry of Learning — KST Mastery Maps

**Source:** [hoppenstedt.mx/project/1](https://hoppenstedt.mx/project/1/) — portfolio piece on Platzi Master pilot
**Date ingested:** 2026-05-03
**Type:** Case study / portfolio post

## Summary

Pilot project at **Platzi Master** (Mexico) building **Knowledge, Skills, and Technologies (KST) Mastery Maps**. Replaces binary pass/fail with a granular 0-5 rubric and jittered scatter plot visualizations that produce a unique "fingerprint" of each student's competency. Pilot on 7th cohort (C-7) revealed Dunning-Kruger drops and depth-vs-breadth insights invisible to traditional grading. Future direction: move from scatter plots → **knowledge graphs** showing prerequisite links between competencies.

## Philosophical Friction

Traditional grading is binary (pass/fail, certified/uncertified). For high-personalization coaching programs:
- Standardized curriculum **counters** personalization
- BUT job market demands **specific demonstrable competencies**

KST Mastery Maps bridge this — visualize competency acquisition without enforcing a curriculum.

## The 0-5 Mastery Rubric

| Level | Name | Description |
|---|---|---|
| 0-1 | Unknown | Not yet exposed |
| 2 | **Insufficient** | Little experience, cannot resolve related problems |
| 3 | **Skilled** | Has solved related problems, can resolve future ones with guidance |
| 4 | **Solid** | Can face related problems with little/no support |
| 5 | **Mastery** | Can solve and **teach others** |

Granularity > traditional grading. Captures intermediate states (3-4 distinction matters).

## Visualization: Jittered Scatter Plot Fingerprints

Each KST item gets unique X/Y coordinates. Plotting student mastery levels yields a unique competency "fingerprint".

Built in **R + Plotly**. Interactive filters (e.g. Level 3+) show what skills the student has reached.

Enables question shift:
- **Old**: "What grade did they get?"
- **New**: "What does their current skill map look like?"

## C-7 Pilot Insights

### Dunning-Kruger Reality Check

Backend & Data Science cohort showed **a distinct drop in KST scores Week 1 → Week 2**.

- **Week 1**: students self-assessed (inflated)
- **Week 2**: coaches assessed after first real project (rigorous)

Captured the transition from **unconscious incompetence → conscious incompetence**. Grounds expectations in reality.

### Depth vs Breadth (Laura Rivas Insight)

Tracking student Laura Rivas Weeks 3-5: little increase in *new* competencies (KST 3+), but visible movement of existing skills from Level 4 → Level 5.

> She wasn't just learning more things: she was learning things better.

In traditional grading this looks like a plateau. KST maps reveal **deepening mastery is as significant as acquiring new skills**.

### Operational Efficiency

Master Coach Ana Belisa: organizing a new cohort dropped from **a full day → under an hour**. Frees coaches from diagnosis to active coaching.

## Future Direction: Points → Graphs

Scatter plots treat KSTs as isolated points. Next: **knowledge graphs** with prerequisite links.

> If a student is stuck on a high-level technology, the graph could highlight that they have a hidden Level 2 gap in a foundational milestone, making the non-linear path to mastery clear and actionable.

## Challenges Identified

1. **Manual + tedious** — R scripts and catalogue filling
2. **Automation needed** — completion of courses/projects should auto-update maps
3. **Universal Competency Catalogue** — to allow students to mix areas (e.g. Frontend + Data Science)
4. **B2B integration** — orgs see "pool of KSTs" across teams to address gaps strategically

## Key Claims

- Binary pass/fail loses signal — 0-5 mastery rubric captures intermediate states
- Visualization enables coaches to see depth vs breadth tradeoffs that grading hides
- Self-assessment inflates Week 1; coach-rigorous assessment Week 2 corrects (Dunning-Kruger pattern)
- Plateau in *new* skills can mask significant *deepening* of existing skills
- Knowledge graphs over scatter plots is the next evolution — surfaces prerequisite gaps
- Automating diagnosis flips the time ratio from diagnosis-heavy to coaching-heavy

## Entities Mentioned

- [[platzi-master]] — Mexican high-personalization coaching program
- [[Ana Belisa]] — Master Coach
- [[Laura Rivas]] — C-7 cohort student (depth-vs-breadth case)

## Concepts Covered

- [[mastery-rubrics]] — 0-5 granular mastery levels
- [[knowledge-tracing]] — Tracking competency over time
- [[dunning-kruger]] — Self-assessment vs rigorous assessment gap
- [[depth-vs-breadth]] — Plateau in new skills can mask deepening
- [[knowledge-graphs]] — Prerequisite-linked competency representation

## Related

- [[three-ring-mastery-system]] — Direct inspiration for mastery-stages dimension
- [[mastery-velocity-three-ring-feature-concept]] — Brainstorm referencing this case
- [[deep-knowledge-tracing-practical-evaluation]] — DKT models as quantitative complement
- [[graphify-knowledge-graph-tool]] — Knowledge-graph tooling reference
