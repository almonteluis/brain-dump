---
description: Settles & Meeder 2016 — the paper where Duolingo replaced hand-tuned spaced repetition with a regression model and got 50% better predictions. HLR is the bridge between Ebbinghaus and modern production SRS.
tags:
  - source
  - duolingo
  - spaced/repetition
  - settlles
sources:
  - Settles, B. & Meeder, B. (2016). A Trainable Spaced Repetition Model for Language Learning. ACL 2016.
created: 2026-05-16
updated: 2026-05-16
---

# Duolingo's Half-Life Regression (Settles & Meeder, 2016)

This is the paper where [[burr-settles]] replaced Duolingo's hand-tuned [[spaced-repetition]] parameters with a regression model learned from 12.5 million practice events — and cut prediction error roughly in half compared to [[sebastian-leitner|Leitner]]'s fixed-interval system. Half-Life Regression (HLR) estimates how quickly a learner will forget a word, then schedules the next review accordingly.

The "half-life" is the time until recall probability drops to 50%. HLR predicts this from features like: how many times you've seen the word, how long since last review, the word's intrinsic difficulty. It's simpler than it sounds — essentially a log-linear regression — but it works because Duolingo has enough data to make a simple model very accurate.

The key result: HLR boosted learner retention 9.5% and overall platform activity 12% in A/B testing. Those are big numbers at [[duolingo]]'s scale. The lesson for [[project-atlas]]: you don't need a deep learning model. You need enough data on the right features to make a simple model work well.

Cross-links: [[burr-settles]], [[duolingo]], [[spaced-repetition]], [[knowledge-tracing]], [[hermann-ebbinghaus]]
