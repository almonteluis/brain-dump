---
description: Knowledge tracing is the system's running guess at what each student actually knows — updated after every answer, used to pick what comes next. The engine under every adaptive platform worth its salt.
tags:
  - concept
  - knowledge-tracing
  - bkt
  - dkt
  - ed-tech
  - mastery-based-learning
  - adaptive/learning
sources:
  - 
created: 2026-05-16
updated: 2026-05-16
---

# Knowledge Tracing

Knowledge tracing is the system's running guess at what each student actually knows. It updates that guess after every answer — right, wrong, fast, slow — and uses it to pick what comes next. The math underneath is Bayesian, but the idea is: keep a live model of the student's head.

Picture a kid who just got three fraction addition problems right in a row. Does the system move them to mixed numbers? Or was that a fluke — maybe they guessed, maybe the problems were too easy. Knowledge tracing is what lets [[teach-to-one]] make that call without a teacher hovering over every shoulder.

## Bayesian Knowledge Tracing (BKT)

The original, from Corbett & Anderson 1995. Four parameters per skill:

| Parameter | What it means | The question it answers |
|-----------|--------------|------------------------|
| **P(L0)** | Probability the student knew it *before* the first attempt | "Did they walk in with this?" |
| **P(T)** | Probability of *learning* after one attempt | "How fast do they pick it up?" |
| **P(G)** | Probability of a *guess* (right answer, no knowledge) | "Did they get lucky?" |
| **P(S)** | Probability of a *slip* (wrong answer, actually knows it) | "Did they blow it despite knowing?" |

The system updates P(learned) after every answer using Bayes' rule. Right answer → P(learned) goes up (unless it was a guess). Wrong answer → P(learned) goes down (unless it was a slip). It's a Hidden Markov Model under the hood — the true knowledge state is hidden, and we're inferring it from observed behavior.

BKT works. It's been running in production for 25+ years. But it has real limitations:

- **Skills are independent** — BKT treats every skill in isolation. If you master "add fractions" and then see "add fractions with unlike denominators," BKT starts from scratch. No transfer.
- **Only binary correctness** — no response time, no hint usage, no partial credit. A kid who takes 45 seconds and gets it right looks the same as a kid who answers in 2 seconds.
- **Cold start** — new students get population-average parameters until the system has enough data to personalize.

## Deep Knowledge Tracing (DKT)

Piech et al., 2015. Throw out the hand-crafted parameters and let a recurrent neural network learn the whole thing from data. DKT takes a sequence of (skill, correctness) pairs and outputs a prediction for every skill at every timestep. No P(G), no P(S), no EM algorithm — just a black box that eats interaction logs and spits out mastery estimates.

The upside: DKT captures skill-to-skill dependencies automatically. It can notice that mastering "place value" predicts success on "decimal addition" without anyone telling it they're related. The downside: it's a black box, it needs *tons* of data, and it's harder to debug when it goes wrong. See [[deep-knowledge-tracing-practical-evaluation]] for how it holds up outside the lab.

## Why It Matters for TTO / ATLAS

Knowledge tracing is the foundation that everything else in [[project-atlas]] sits on:

- [[skill-graph]] tells the system what skills *exist* and how they connect
- Knowledge tracing estimates where the student *is* on that graph
- [[adaptive-feedback-education]] decides what to *say* about it
- The orchestrator decides what to *serve next*

If KT is wrong — overestimating mastery, or underestimating it — every downstream decision compounds the error. A student who's incorrectly flagged as "mastered" gets advanced too early and hits a wall. A student who's underestimated reviews the same skill until they disengage. The stakes are real.

how does this relate to [[knowledge-graph-education]]?

[[three-ring-mastery-system]]'s maintenance ring is essentially knowledge tracing with a [[spaced-repetition]] layer on top — not just "do they know it now?" but "will they still know it in two weeks?" Two different questions, two different models, ideally one system that answers both.

### Sources:

- Corbett, A. T., & Anderson, J. R. (1995). Knowledge tracing: Modeling the acquisition of procedural knowledge. User Modeling and User-Adapted Interaction, 4(4), 253–278.
- Piech, C., et al. (2015). Deep knowledge tracing. NIPS 2015.
