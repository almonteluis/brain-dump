---
description: Algorithmic fairness concerns in Bayesian Knowledge Tracing — how reading ability, language proficiency, and demographic factors confound mastery estimates in math tutoring systems.
tags:
  - knowledge-tracing
  - skill/mapping
  - concept
sources:
  - paper-bkt-fairness-math-2025.md
  - paper-deep-learning-knowledge-tracing-2025.md
created: 2026-05-10
updated: 2026-05-10
---

# BKT Fairness

> Synthesis from 2 papers on algorithmic fairness in knowledge tracing for mathematics education.

## Overview

Bayesian Knowledge Tracing (BKT) models estimate student mastery from sequences of correct/incorrect responses. However, these estimates can be **systematically biased** when factors beyond the target skill influence response correctness. The most well-documented case is reading ability: students who struggle with reading comprehension may answer math problems incorrectly not because they lack mathematical understanding, but because they can't parse the problem text. This produces lower mastery estimates for emerging readers — a fairness gap with cascading consequences in adaptive systems.

## The Reading-Math Fairness Gap

From [[bkt-fairness-math-2025]] (Stinar et al., EDM 2025):

| Group | Mean Mastery Estimate |
|-------|----------------------|
| Proficient readers | M = .776 |
| Emerging readers | M = .687 |
| **Gap** | **.089 (~9 percentage points)** |

Key findings:
- Reading ability **independently predicts** math mastery estimates after controlling for actual math performance.
- The gap reflects **reading comprehension barriers**, not mathematical deficiency.
- The problem extends beyond BKT to any KT approach using correctness signals without accounting for reading level.

## Confounding Factors

Reading ability is the best-documented confound, but other factors may similarly bias mastery estimates:

| Confound | Mechanism | Affected Domains |
|----------|-----------|-----------------|
| **Reading ability** | Can't parse problem text | Math word problems, science |
| **Language proficiency** | ELL students face language barriers | All content areas |
| **Test anxiety** | Performance under pressure | All assessments |
| **Socioeconomic factors** | Unequal prior knowledge, test familiarity | All domains |
| **Cognitive load** | Problem presentation complexity | Multi-step problems |
| **Cultural context** | Unfamiliar scenarios or references | Word problems with cultural references |

## Cascading Consequences in Adaptive Systems

When mastery estimates are biased, the effects compound through the system:

1. **Underestimated mastery** → unnecessary remediation → slower progression → lower engagement
2. **Overestimated mastery** → premature advancement → gaps in foundational skills → future failure
3. **Biased learning paths** → students spend time on wrong skills → wasted learning time
4. **Inequitable outcomes** → systematic differences in learning opportunities → achievement gaps widen

## Mitigation Strategies

### Model Reading as a Separate Skill
The primary recommendation from [[bkt-fairness-math-2025]]: track reading comprehension as an independent skill alongside math skills. This allows the system to distinguish "doesn't understand the math" from "can't read the problem" and adjust mastery estimates accordingly.

### Multi-dimensional Student Models
Rather than a single mastery probability per skill, maintain a richer student model that accounts for confounding factors. [[deep-learning-knowledge-tracing-2025]] suggests neural KT models could incorporate auxiliary inputs (reading level, ELL status) as additional features.

### Problem Presentation Adaptation
Adjust problem text complexity based on student reading level. This doesn't change the math difficulty but removes the reading barrier, allowing mastery estimates to reflect mathematical competence.

### Fairness Auditing
Regularly audit mastery estimate distributions across demographic and ability groups. Significant gaps signal potential bias in the KT model or the underlying [[knowledge-graph-education]].

### Ensemble Approaches
Combine multiple KT approaches (BKT for interpretability, DKT for accuracy) and flag divergent estimates as potential bias signals.

## Connection to Deep Learning KT

[[deep-learning-knowledge-tracing-2025]] shows that neural KT models can potentially address fairness issues by incorporating auxiliary features (reading level, prior reading performance) into the prediction. However, neural models introduce their own fairness risks: if training data underrepresents emerging readers, the model may learn to perpetuate the same biases. The cold-start and data sparsity challenges identified in the DLKT study are themselves fairness concerns — students with sparse interaction histories (often the most vulnerable) receive the least accurate mastery estimates.

## Open Questions

- How large is the fairness gap for other confounding factors (language proficiency, test anxiety)?
- Does modeling reading as a separate skill fully close the gap, or are there residual effects?
- How do fairness gaps change across grade levels as reading proficiency develops?
- What evaluation metrics should platforms use to monitor KT fairness in production?
- How do fairness considerations interact with the accuracy-interpretability tradeoff in KT model selection?

## Related Concepts

- [[knowledge-tracing]] — the underlying technique where fairness issues arise
- [[knowledge-graph-education]] — KGs that model multi-dimensional competencies can help
- [[skill-tree-competency-structure]] — prerequisite structures that should account for cross-domain skills like reading
- [[ai-math-tutoring]] — AI systems that must be designed with fairness in mind
- [[three-ring-mastery-system]] — TTO's mastery progression must be fair across student populations

## Why This Matters for Teach to One

Teach to One serves a diverse student population with varying reading abilities, language backgrounds, and prior educational experiences. The BKT fairness gap identified by Stinar et al. is directly relevant: if TON's mastery estimates are biased against emerging readers, the learning algorithm will systematically disadvantage these students — assigning them more remediation, slowing their progression, and potentially reducing engagement. Given TON's mission of equitable outcomes, this is a critical issue. The mitigation strategies are actionable: modeling reading as a separate skill is feasible within TON's existing [[knowledge-tracing]] infrastructure, problem text adaptation aligns with TON's content management capabilities, and fairness auditing can be integrated into TON's analytics dashboard. The [[three-ring-mastery-system]] should explicitly account for confounding factors when determining ring transitions — a student in the "New" ring for a math skill may not lack mathematical ability but may need reading support to demonstrate mastery.
