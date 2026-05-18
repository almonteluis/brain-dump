---
description: Design note arguing that the Three-Ring maintenance ring should use insight recall instead of traditional spaced repetition. The case for context-triggered retrieval over timer-based review.
tags:
  - source
  - insight-recall
  - spaced/repetition
  - three-ring
  - design
  - maintenance
sources: []
created: 2026-05-16
updated: 2026-05-16
---

# Insight Recall vs. Spaced Repetition in Three-Ring Maintenance

Design note comparing two approaches for the [[three-ring-mastery-system]] maintenance ring. Traditional approach: use [[spaced-repetition]] — mastered skills get reviewed at increasing intervals via the [[cooldown-system]]. Alternative approach: use [[insight-recall]] — instead of surfacing the *skill* for review, surface the student's *own past reasoning* about that skill when they encounter a contextually relevant problem.

The argument for IRec: [[encoding-specificity-principle]] says retrieval is strongest when the cue matches the encoding context. Flashcard-style SRS strips context. IRec preserves it. The student isn't just recalling "how to add fractions" — they're recalling "what I figured out about adding fractions when I was stuck on a recipe problem."

The argument for SRS: it's battle-tested, simple to implement, and [[duolingo-half-life-regression|HLR]] proves it works at scale. IRec is newer, less validated, and raises the misconception-reinforcement risk.

Cross-links: [[insight-recall]], [[spaced-repetition]], [[three-ring-mastery-system]], [[cooldown-system]], [[encoding-specificity-principle]], [[irec-metacognitive-scaffolding-arxiv]]
