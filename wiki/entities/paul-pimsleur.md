---
description: Paul Pimsleur — the applied linguist who turned spaced repetition into a practical schedule in 1967. His graduated intervals (5 seconds → 2 years) are the ancestor of every SRS algorithm running today.
tags:
  - entity/pimsleur
  - person
  - linguistics
  - language-learning
  - spaced/repetition
sources:
  - spaced-repetition-wikipedia.md
  - duolingo-half-life-regression.md
created: 2026-05-03
updated: 2026-05-17
---

# Paul Pimsleur

Paul Pimsleur (1927–1976) was an American applied linguist who developed **graduated-interval recall** in 1967. His audio-based language programs were the first practical application of [[spaced-repetition]] at scale — you listen to the lesson, the narrator asks you to recall a phrase, and the time between recalls increases on a fixed schedule. It works. The Pimsleur Method is still sold today, largely unchanged from his original design.

## Graduated-Interval Recall (1967)

From his paper "A memory schedule" (Modern Language Journal):

```
5 seconds → 25 seconds → 2 minutes → 10 minutes →
1 hour → 5 hours → 1 day → 5 days → 25 days →
4 months → 2 years
```

Each successful retrieval graduates the item to the next interval. Simple, effective, universal.

## Why The Schedule Endures

- **Empirical** — derived from forgetting-curve experiments
- **Practical** — short intervals (seconds) match audio-program pacing
- **Universal** — same schedule for all learners and items

## Limitations vs Modern Algorithms

| Pimsleur (1967) | Modern SRS |
|-----------------|------------|
| Fixed intervals for everyone | Adaptive per-item, per-learner |
| Same schedule regardless of difficulty | [[half-life-regression|HLR]] estimates item-specific decay rates |
| No data collection | Every response feeds the model |
| N=1 validation | [[burr-settles|Settles]] validated on 12M+ events |

The gap: Pimsleur's schedule is one-size-fits-all. Modern algorithms personalize based on the learner's history with each item. But the core insight — increasing intervals between successful recalls — hasn't changed in 60 years.

## Where He Sits in the Lineage

| Generation | Who | What they added |
|------------|-----|----------------|
| Discovery | [[hermann-ebbinghaus]] | Forgetting curve, spacing effect (1885) |
| First algorithm | **Pimsleur** | Scheduled intervals for language vocab (1967) |
| Accessible system | [[sebastian-leitner]] | Flashcard box method (1972) |
| Adaptive algorithm | [[burr-settles]] | Half-Life Regression, per-item personalization (2016) |

## Related

- [[spaced-repetition]] · [[forgetting-curve]] · [[half-life-regression]] · [[burr-settles]] · [[hermann-ebbinghaus]] · [[sebastian-leitner]]
