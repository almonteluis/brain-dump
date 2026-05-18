---
description: Adaptive learning systems adjust what a kid sees based on how they're performing. The 'adaptive' part is easy to claim and hard to do well — most systems are just branching logic dressed up as AI.
tags:
  - concept
  - its
  - ed-tech
  - personalized-learning
  - adaptive/learning
sources: []
created: 2026-05-16
updated: 2026-05-16
---

# Adaptive Learning Systems

Adaptive learning systems are supposed to adjust content, pace, and difficulty based on how the student is actually doing — not where the curriculum says they should be. The idea is simple. The execution is where it gets interesting.

Every adaptive system has three models under the hood:

| Model | What it does | The hard part |
|-------|-------------|--------------|
| **Learner model** | Estimates what the student knows | [[knowledge-tracing]] — getting this right is the whole game |
| **Domain model** | Maps the skills and their relationships | The [[skill-graph]] — granularity decisions are brutal |
| **Pedagogical model** | Decides what to do next | Sequencing, scaffolding, feedback — the part that looks like teaching |

If the learner model is wrong, the pedagogical model makes bad decisions. If the domain model is too coarse, the system can't target the actual gap. If the pedagogical model is just "serve the next problem," it's not adaptive — it's a playlist.

## The Spectrum

Not everything called "adaptive" is the same thing:

- **Branching logic** — If score < 70%, route to remediation. That's a flowchart, not AI. Most "adaptive" products stop here.
- **Knowledge tracing + sequencing** — [[teach-to-one]] territory. Real mastery estimates feeding real scheduling decisions.
- **Real-time within-session adaptation** — [[project-atlas]] territory. Adjusting mid-problem based on response time, hint usage, affect signals.

The jump from level 2 to level 3 is where it gets genuinely hard. Between sessions, you have time to compute. Within a session, you're making decisions in milliseconds while the kid is staring at a screen.

[[differentiated-instruction]] is the teacher version of what adaptive systems try to automate. [[zone-of-proximal-development]] is the theoretical target. The question that matters: can an algorithm match a skilled teacher's ability to read a kid's zone and respond in real time? For the mechanics (sequencing, difficulty calibration), probably yes. For the relational piece (knowing when to push, when to back off, when the kid needs encouragement not another problem), not yet. Maybe not ever.
