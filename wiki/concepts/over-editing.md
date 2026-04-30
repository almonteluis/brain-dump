---
description: AI coding models rewriting more code than necessary to fix a bug — functionally correct but structurally divergent
tags: [ai-coding, llm, code-review, brown-field, testing]
sources: ["coding-models-over-editing"]
created: 2026-04-29
updated: 2026-04-29
---

# Over-Editing

AI coding models rewriting more code than necessary to fix a bug. Functionally correct but structurally divergent from minimal fix. A brown-field failure invisible to test suites.

## The Problem

- Model fixes single off-by-one error by rewriting entire function
- Adds unnecessary checks, renames variables, changes signatures
- Diff becomes enormous, code review harder, codebase quality degrades
- Unlike correctness failures, over-editing passes all tests

## Measurement

- **Token-level Levenshtein Distance** — How much changed vs. minimal fix
- **Added Cognitive Complexity** — Unnecessary nesting/logic introduced
- **Pass@1** — Functional correctness (necessary but not sufficient)

## Model Rankings (Lower Levenshtein = Better)

| Model | Pass@1 | Norm. Levenshtein | Added CC |
|-------|--------|-------------------|----------|
| Claude Opus 4.6 (reasoning) | 0.912 | **0.060** | 0.200 |
| Qwen 3.6 Plus (reasoning) | 0.858 | 0.145 | **0.048** |
| GPT-5.4 (reasoning) | 0.723 | 0.395 | 2.313 |

## Fixes

1. **Explicit prompting**: "Preserve original code" reduces Levenshtein for all models
2. **RL training**: Teaches minimal editing without catastrophic forgetting
3. **Start simple**: Most projects need manual DI, not containers

## Related

- [[coding-models-over-editing]] — Source research article
- [[cognitive-complexity]] — Metric for code understandability
- [[brown-field-development]] — Working within existing codebases