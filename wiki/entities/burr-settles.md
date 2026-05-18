---
description: Burr Settles — Duolingo Head of Research who developed Half-Life Regression for production-scale spaced repetition, ACL 2016 paper author
tags:
  - entity/burr-settles
  - person
  - machine-learning
  - duolingo
  - research
  - spaced/repetition
  - ml-researcher
sources:
  - duolingo-half-life-regression.md
created: 2026-05-03
updated: 2026-05-03
---

# Burr Settles

**Burr Settles** is Head of Research at [[duolingo]] and a machine learning researcher who has published extensively on language learning, active learning, and crowdsourcing. Best known in the spaced repetition community for **Half-Life Regression (HLR)** — the algorithm that powers Duolingo's word-level practice scheduling.

## Major Contribution: Half-Life Regression

- **Published**: ACL 2016 paper *A Trainable Spaced Repetition Model for Language Learning* (with B. Meeder)
- **Code + dataset**: [github.com/duolingo/halflife-regression](https://github.com/duolingo/halflife-regression)
- **Method**: combines [[forgetting-curve]] with logistic-regression-style feature weights
- **Result**: ~50% lower error rate than Leitner on 12M+ practice events
- **Production impact**: 9.5% retention bump, 12% overall activity increase in A/B test

## Research Areas

- **Language learning algorithms** — HLR, A/B test methodology at scale
- **Active learning** — minimal-supervision ML, his earlier academic focus
- **Crowdsourcing** — quality control in human-labeled data
- **Educational data science** — student model design, retention metrics

## Influence

[[half-life-regression]] became:
- A reference algorithm in academic spaced repetition literature
- Open-sourced for general use
- Direct precursor to FSRS and SSP-MMC family algorithms
- Production-deployed pattern for adaptive learning at billions-of-events scale

## Related

- [[duolingo]] — Employer
- [[half-life-regression]] — Algorithm contribution
- [[spaced-repetition]] — Broader field
- [[hermann-ebbinghaus]] — Theoretical predecessor
- [[paul-pimsleur]], [[sebastian-leitner]] — Algorithmic predecessors he benchmarked HLR against
- [[duolingo-half-life-regression]] — Source page (his blog post)
