---
description: Brainstorm session for TEAME — three-ring progress system combining spaced repetition, mastery stages, and weekly goals
tags:
  - product
  - ed-tech
  - mastery-based-learning
  - spaced/repetition
  - brainstorm
sources:
  - Mastery Velocity — Three-Ring Feature Concept.md
created: 2026-05-01
updated: 2026-05-01
---

# Mastery Velocity — Three-Ring Feature Concept

**Source:** Mastery Velocity — Three-Ring Feature Concept.md
**Date ingested:** 2026-05-01
**Type:** Brainstorm session

## Summary

Brainstorm for TEAME / Team E. Goal: prototype features that move students through the mastery loop at 2 skills/week pace target while opening room for kids who want to go faster. Proposes a three-ring daily/weekly progress indicator (Apple-Rings-style) where each ring maps to a stage of learning: New, Practice, Maintain. Three interlocking mechanics — spaced repetition, mastery stages, streaks — form the core.

## Objective (SMART)

Within 4 weeks, generate 15+ distinct concepts, narrow to 2-3 prototypes, present to 3+ partner teachers for feedback.

## Research Question (PICOT)

In middle school students on TTO platform with 2 skills/week pace target (P), do [prototype feature] (I), compared to standard experience (C), increase % students meeting 2 skills/week (O) over 2-3 week pilot (T)?

## Key Claims

- Three-ring system mirrors actual skill lifecycle (learn → practice → keep sharp)
- Practice ring closes a current gap: stuck students get no visible credit for trying
- Spaced repetition gives the skill graph a reason to be revisited (sleeper insight)
- Practice ring should reward productive struggle, not correctness (Manu Kapur)
- Measuring time-on-task instead of mastery velocity is the social-media trap
- 6 years of TTO data enables empirical decay curves per skill (cold-start solved)
- SR can feel like punishment — frame as "skill maintenance" / "keeping skills sharp"
- Teacher view is probably not a graph at top level — it's an aggregation of graphs

## Cross-Industry Inspiration

| Product | What to steal |
|---------|---------------|
| Duolingo | Self-chosen pace tier, weekly leagues, streak freezes, time-calibrated notifications |
| Apple Fitness Rings | Three rings = full lifecycle in one glance, monthly auto-calibrating challenges |
| Peloton | Bounded class leaderboards, milestone badges |
| Strava | Kudos (lightweight social acknowledgment), monthly distance challenges |
| Khan Academy | Mastery levels (familiar → proficient → mastered), self-set daily goals, pullback from streaks |

## Measurement Strategy

- **Primary metric:** Skills mastered per week (not time-on-task)
- **Recommended trio:** Mean + median + distribution shape
- **Headline metric:** % meeting 2/week (for storytelling to teachers/leadership)
- **Key signal:** Distribution shape — does the feature lift the whole curve or just kids already doing well?
- **Unit of analysis:** Student-day → aggregated to student-week; class-week as secondary
- **Control:** Feature flag via Unleash, roll-in rollout starting 10-20%

## Anti-patterns

- Social media optimizes for engagement (time spent) — orthogonal to and opposed to user benefit
- Time-on-task as primary metric = engagement trap
- Leaderboards showing bottom half = demotivation for majority

## Terms to Research

- Spaced Repetition / SM-2 / FSRS algorithm
- Forgetting Curve (Ebbinghaus, 1885)
- Productive Failure (Manu Kapur)
- Bayesian Knowledge Tracing (BKT)
- Deep Knowledge Tracing (DKT)
- Item Response Theory (IRT)
- Just-in-time vs just-in-case learning
- Knowledge Space Theory (ALEKS)
- Sugiyama Layout (DAG drawing)

## References

- Bloom (1984) — "The 2 Sigma Problem"
- Roediger & Karpicke (2006) — "Test-Enhanced Learning"
- Wise & Kong (2005) — "Response time effort" (rapid-guessing detection)
- Manu Kapur — "Productive Failure"
- Wozniak — SuperMemo/SM-2 (supermemo.guru)
- FSRS — open-spaced-repetition (GitHub)

## Open Threads

- Personal skill graph as living artifact (lit/dim states, decay) — strongest UI hook
- Subway map visualization underused in ed-tech — competitive moat?
- "Most improved this week" board = low-cost high-equity addition
- Teacher view: pace ribbon leading candidate over graph at top level
- BrainBreak integration — could daily check-in be what closes a ring?
- Student self-chosen pace tier as roll-in feature (offer after 2 strong weeks)

## Entities Mentioned

- [[teach-to-one]] — TTO platform, 6 years of student data
- [[learnosity]] — Practice problems source, 10 questions per page, grading API
- [[unleash]] — Feature flag management for A/B rollout

## Concepts Covered

- [[three-ring-mastery-system]] — Combined ring + SR + mastery + weekly goal feature concept
- [[productive-failure]] — Wrong→right counts more than instant correct (Manu Kapur)
- [[spaced-repetition]] — Mastered skills decay without review; system surfaces at right time
- [[master-based learning]] — Skills move through stages (new → practice → mastered → maintained)
- [[skill-graph]] — Student roadmap as living graph with lit/dim decay states
