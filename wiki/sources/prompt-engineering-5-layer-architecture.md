---
description: 5-layer prompt architecture (Identity, Context, Task, Process, Output) with One-Day Protocol for systematic prompting improvement
tags: [ai, prompting, engineering, framework, documentation]
sources: ["2026-01-30 - Why You Suck at Prompting.md"]
created: 2026-04-21
updated: 2026-04-21
---

# Prompt Engineering: 5-Layer Architecture

**Source:** 2026-01-30 - Why You Suck at Prompting.md
**Date ingested:** 2026-04-21
**Type:** Twitter thread synthesis

## Summary

@kloss_xyz's comprehensive framework reframing prompting from conversation to engineering. The 5-layer architecture (Identity, Context, Task, Process, Output) maps to how models actually process information. Canonical documentation separates amateurs from professionals.

## Key Claims

- "You're not prompting. You're praying." — vague inputs produce generic outputs
- Prompt portability is a myth; prompt adaptation is THE skill (different models are different specialists)
- Vagueness isn't flexibility — it's cowardice. Constraints are instructions, not limitations
- "The model will match your level of rigor"
- Without PRDs, design systems, constraints docs — you're gambling, not prompting

## The 5-Layer Prompt Architecture

| Layer | Purpose | Example |
|-------|---------|---------|
| **Identity** | Specific role with expertise | "Senior product marketer specializing in B2B SaaS" |
| **Context** | Ordered, scoped, labeled background | Background, prior decisions, constraints |
| **Task** | Specific action with success criteria | "Produce 500-word description emphasizing time-saving" |
| **Process** | Step-by-step approach with checkpoints | "First analyze audience, then define positioning, then write" |
| **Output** | Exact format specification | "JSON with headline, subheadline, body. No chat." |

**The rule:** Miss one layer, structure wobbles. Miss two, it collapses.

## The One-Day Protocol

**Morning — Audit (30-45 min):**
1. Archaeology: Review last 10 prompts for missing layers
2. Pattern Recognition: Name 3 failure patterns
3. Anti-Vision: "If I keep prompting this way, in one year I'll still be..."

**Afternoon — Build Foundation (2-3 hours):**
1. Role Library: 5-10 specific role definitions
2. Context Templates: Reusable context structures
3. Constraints Doc: Universal constraints that never change
4. Output Format Library: JSON schemas, markdown patterns

**Evening — Test and Refine (1-2 hours):**
1. Rebuild one past failure prompt using new system
2. Compare results
3. Iterate: Structure → Test → Analyze → Refine

## Key Insight

Prompting scales when docs exist and are referenced. Without canonical documentation, every session starts from zero. Build infrastructure that makes good prompting inevitable, not accidental.

## Concepts Covered

- [[context-engineering]] — Layer 2 is literally context engineering
- [[ai-engineering]] — Systematic approach to AI interaction
- [[cognitive-load]] — Structure reduces cognitive load on both human and model

## Entities Mentioned

- [[Kloss (@kloss_xyz)]] — Prompt engineering expert, framework author
