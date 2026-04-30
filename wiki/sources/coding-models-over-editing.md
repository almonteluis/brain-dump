---
description: Research on AI coding models rewriting more code than necessary and interventions for minimal editing
tags: [ai-coding, llm, code-editing, over-editing, testing]
sources: ["Coding Models Are Doing Too Much.md"]
created: 2026-04-29
updated: 2026-04-29
---

# Coding Models Are Doing Too Much

**Source:** [[Coding Models Are Doing Too Much]]
**Date ingested:** 2026-04-29
**Type:** research article

## Summary

Investigation of the "Over-Editing" problem in AI coding assistants: models rewrite entire functions when a single-line fix would suffice. Measures over-editing across frontier models, tests prompting and training interventions.

## Key Claims

1. **Over-Editing** = model output is functionally correct but structurally diverges beyond minimal fix. Invisible to test suites — a brown-field failure.
2. **Claude Opus 4.6** achieves best balance: highest Pass@1 (0.912 reasoning) with lowest Levenshtein Distance (0.060) and low Added Cognitive Complexity (0.20).
3. **GPT-5.4** over-edits most: Levenshtein 0.395 (reasoning), 0.327 (non-reasoning). Adds 2.31/1.56 cognitive complexity respectively.
4. **Explicit prompting** ("preserve original code") improves all models. Reasoning models show largest gains — over-editing is default behavior, not capability limitation.
5. **RL training** on Qwen3 4B generalizes to out-of-domain corruptions, improves minimal editing without catastrophic forgetting. SFT memorizes corruptions and fails out-of-domain. LoRA rank 64 nearly matches full RL.
6. Metrics: token-level Levenshtein Distance (normalized), Added Cognitive Complexity.

## Entities Mentioned

- [[nreHieW]] — Author/researcher
- [[Claude Opus 4.6]] — Best-performing model on minimal editing
- [[GPT-5.4]] — Most over-editing
- [[Qwen3]] — Base model for RL training experiments
- [[tsyringe]] — Microsoft DI container mentioned

## Concepts Covered

- [[over-editing]] — AI models rewriting more code than necessary
- [[minimal-editing]] — Training models for surgical code fixes
- [[cognitive-complexity]] — Metric for code understandability
- [[catastrophic-forgetting]] — Degradation of general ability after fine-tuning