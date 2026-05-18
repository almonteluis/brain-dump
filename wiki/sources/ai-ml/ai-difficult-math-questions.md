---
description: MATH² dataset — multi-skill combination math problems that expose weaknesses in LLM reasoning. Model accuracy on MATH² ≈ square of original MATH accuracy.
tags:
  - ai/education
  - education/math
  - research
sources:
  - paper-ai-difficult-math-questions.md
created: 2026-05-10
updated: 2026-05-10
url: https://arxiv.org/abs/2407.21009
authors:
  - Vedant Shah
  - Dingli Yu
  - Kaifeng Lyu
  - Simon Park
  - Jiatong Yu
  - Yinghui He
  - Nan Rosemary Ke
---

# AI's Struggle with Difficult Math Questions: The MATH² Dataset

## Summary

This paper introduces MATH², a dataset of math problems that require combining multiple mathematical skills within a single question, exposing significant weaknesses in current LLM mathematical reasoning. The key finding is that model accuracy on MATH² is approximately the **square** of accuracy on the original MATH benchmark — meaning a model that solves 60% of MATH problems drops to roughly 36% on MATH². The dataset provides a scalable method for generating calibrated difficulty through skill combination, and training on MATH² exemplars yields up to 13.72% improvement on the original MATH benchmark, demonstrating that multi-skill problems are a powerful training signal.

## Key Claims

- Multi-skill combination problems (MATH²) dramatically reduce LLM accuracy compared to single-skill problems — accuracy ≈ accuracy².
- Skill composition is a scalable mechanism for generating calibrated difficulty levels in math problems.
- Training on multi-skill problems transfers back to single-skill performance (+13.72% on MATH).
- Current LLMs struggle with problems requiring the **integration** of multiple mathematical concepts, not just individual concepts in isolation.
- The dataset enables better evaluation and training of math reasoning capabilities.

## Entities Mentioned

- [[MATH² dataset]]
- [[MATH benchmark]]
- [[Nan Rosemary Ke]]
- [[Vedant Shah]]

## Concepts Covered

- [[ai-math-tutoring]]
- [[knowledge-tracing]]
- [[adaptive-feedback-education]]

## Why This Matters for Teach to One

Teach to One's learning algorithm already generates personalized problem sets that combine multiple skills. MATH² validates the pedagogical intuition that multi-skill problems are harder and more diagnostic of deep understanding. The finding that skill composition scales difficulty is directly relevant to [[knowledge-tracing]] models used in TON — if a student can solve multi-skill problems, they likely have robust mastery of component skills. This also has implications for [[just-in-time-adaptive-intervention]]: multi-skill problems could serve as higher-stakes assessment checkpoints within the learning progression.
