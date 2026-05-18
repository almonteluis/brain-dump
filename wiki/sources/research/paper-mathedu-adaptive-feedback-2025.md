---
description: "paper-mathedu-adaptive-feedback-2025"
tags: ['research', 'paper', 'education-research']
raw_file: "paper-mathedu-adaptive-feedback-2025.md"
created: 2026-05-17
---

## One-line signal
Introduces MathEDU, a dataset of student math problem-solving processes paired with teacher-written feedback, and evaluates LLM performance on generating adaptive feedback using prompting and LoRA fine-tuning.

## Core ideas
- MathEDU dataset: student problem-solving processes in mathematics with corresponding teacher-written feedback
- Focuses on math word problem-solving — students' step-by-step reasoning processes, not just final answers
- Evaluates LLMs on generating personalized, adaptive feedback that mirrors teacher quality
- Tests both zero/few-shot prompting and LoRA fine-tuning approaches
- Addresses the gap of LLMs generating feedback on the *process* of problem-solving rather than just correctness
- Benchmark for measuring how well AI can provide teacher-quality feedback at scale

## Why this matters for the Three-Ring project
MathEDU provides a concrete dataset and methodology for generating adaptive feedback on math problem-solving processes. Three-Ring could leverage similar approaches to provide process-level (not just answer-level) feedback to middle/high school math students, keeping them motivated by addressing specific misconceptions.

[[paper-its-llm-motivational-feedback-2025]] · [[paper-ai-math-tutoring-2025]] · [[paper-llm-education-systematic-review-2025]]
