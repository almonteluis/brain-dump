---
description: "paper-bkt-fairness-math-2025"
tags: ['research', 'paper', 'education-research']
raw_file: "paper-bkt-fairness-math-2025.md"
created: 2026-05-17
---

## One-line signal
Bayesian Knowledge Tracing models show significant fairness differences for math learners based on reading ability — emerging readers have lower estimated mastery rates (M=.687 vs M=.776), suggesting reading should be modeled as a separate skill in math tutoring systems.

## Core ideas
- Investigates algorithmic fairness of BKT models across reading ability groups in math learning
- Emerging readers show significantly lower first-answer mastery rates compared to non-emerging readers
- BKT parameters differ systematically between reading ability groups
- Reading ability independently predicts math mastery estimates — a potential source of bias
- Recommends modeling reading as a separate skill that differentially influences student outcomes
- Highlights that math word problems conflate math and reading skills in assessment

## Why this matters for the Three-Ring project
Critical fairness consideration: Three-Ring's knowledge tracing for middle/high school math students must account for reading ability differences. If the app uses BKT or similar models, failing to separate reading comprehension from math skill could unfairly penalize students who understand the math but struggle with word problem language — directly undermining motivation.

[[paper-deep-learning-knowledge-tracing-2025]] · [[paper-knowledge-graph-education-slr-2024]] · [[paper-skill-trees-competency-2025]]
