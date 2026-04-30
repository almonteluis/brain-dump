---
description: How cognitive load theory applies to software development and codebase comprehension
tags: ["cognitive-science", "learning", "code-quality", "complexity"]
sources: ["The Cognitive Load Theory in Software Development.md"]
created: 2026-04-09
updated: 2026-04-09
---

# Cognitive Load Theory in Software Development

**Source:** The Cognitive Load Theory in Software Development.md (raw, deleted)
**Author:** [[Matthieu Cneude]]
**Date ingested:** 2026-04-09
**Type:** Research article

## Summary

Cognitive load theory, coined by John Sweller in 1988, explains why software development is difficult: our working memory is severely limited (7±2 items), while our long-term memory is effectively infinite. Understanding this helps us write more comprehensible code and learn more effectively.

## Key Claims

- **Working memory holds ~7 items** — George Miller's "magical number seven, plus or minus two" (1956)
- **Long-term memory is unlimited** — But information must be actively constructed, not passively absorbed
- **Schemas** — Related information chunks stored as single units in long-term memory
- **Experts vs novices** — Difference is number of schemas, not raw intelligence

## Three Types of Cognitive Load

| Type | Description | Goal |
|------|-------------|------|
| **Intrinsic** | Inherent complexity of the concept | Minimize through simpler solutions |
| **Extraneous** | Accidental complexity, poor presentation | Eliminate entirely |
| **Germane** | Load that helps build schemas | Maximize |

Maps to Fred Brooks: Intrinsic = essential complexity, Extraneous = accidental complexity.

## Software Development Applications

### Technical Learning

1. **Working examples** — Study existing code, run it, modify it
2. **Isolate concepts** — Learn one thing at a time before connecting them
3. **DRY principle** — Redundant information wastes working memory slots

### Domain Learning

- Codebases *codify* business problems
- Good naming connects to existing schemas
- Ubiquitous language (DDD glossary) reduces translation load
- Split attention effect: documentation + codebase overloads working memory

### Problem Solving

Without schemas, working memory must hold:
- Current problem state
- Goal state
- Relations between them
- Relations between operations
- Stack of subgoals

**Result**: No capacity left for actual solution finding.

## Learning Strategies

| Strategy | How | Why It Works |
|----------|-----|--------------|
| Working examples | Run, read, modify existing code | Builds schemas through active participation |
| Concept isolation | Learn one concept before connecting | Prevents working memory overload |
| Deliberate practice | Build projects with new tools | Active learning creates schemas |
| Team diversity | Work with people who have different schemas | Expands collective problem-solving ability |

## Limits of the Theory

- Lab experiments differ from real learning contexts
- Subjectivity in measuring cognitive load
- No objective metric for "potential cognitive load" of information
- Motivation and metacognition not fully accounted for

## Related

- [[cognitive-load]] — Concept page with patterns
- [[working-memory]] — 7±2 limitation
- [[schema-theory]] — Long-term memory organization
- [[essential-complexity]] — Fred Brooks concept
- [[split-attention-effect]] — Documentation pitfalls

## Entities

- [[John Sweller]] — Cognitive load theory originator (1988)
- [[George Miller]] — Working memory research (1956)
- [[Fred Brooks]] — Essential vs accidental complexity
- [[Matthieu Cneude]] — Author, software developer

## Resources

- Original paper: [Cognitive Load During Problem Solving](https://github.com/Phantas0s/alexandria-library/blob/master/teaching_learning/_PAPERS/1988_cognitive_load_during_problem_solving.pdf)
- Miller's paper: [The Magical Number Seven](https://github.com/Phantas0s/alexandria-library/blob/master/teaching_learning/_PAPERS/1956_magical_number_seven_plus_minus_two.pdf)
- Source: https://thevaluable.dev/cognitive-load-theory-software-developer/
