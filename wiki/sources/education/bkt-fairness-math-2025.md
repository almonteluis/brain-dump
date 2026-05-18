---
description: BKT fairness gap for math learners by reading ability — emerging readers receive systematically lower mastery estimates, with reading ability independently predicting math mastery outcomes.
tags:
  - knowledge-tracing
  - skill/mapping
  - research
sources:
  - paper-bkt-fairness-math-2025.md
created: 2026-05-10
updated: 2026-05-10
url: https://educationaldatamining.org/EDM2025/proceedings/2025.EDM.long-papers.158/index.html
authors:
  - Frank Stinar
  - Haejin Lee
  - Clara Belitz
  - Nidhi Nasiar
  - Stephen Fancsali
  - Steve Ritter
  - Husni Almoubayyed
  - Ryan Baker
  - Jaclyn Ocumpaugh
  - Nigel Bosch
---

# BKT Fairness Gaps in Math Tutoring by Reading Ability

## Summary

This EDM 2025 paper by Stinar, Lee, Belitz, Nasiar, Fancsali, Ritter, Almoubayyed, Baker, Ocumpaugh, and Bosch investigates fairness in Bayesian Knowledge Tracing for mathematics learning systems. The study reveals a significant fairness gap: emerging readers receive systematically lower BKT mastery estimates (M=.687) compared to proficient readers (M=.776) on the same math content. Critically, reading ability independently predicts math mastery estimates even after controlling for actual math performance, indicating that BKT is conflating reading comprehension with mathematical competence. The authors recommend modeling reading as a separate skill in KT systems to disentangle reading barriers from math mastery. The study has direct implications for any adaptive math platform serving diverse student populations, particularly in elementary and middle school where reading proficiency varies widely.

## Key Claims

- BKT produces systematically lower mastery estimates for emerging readers in math tutoring systems (M=.687 vs M=.776).
- Reading ability independently predicts math mastery estimates even after controlling for actual math performance.
- The fairness gap is not explained by differences in mathematical ability — it reflects reading comprehension barriers in math problem presentation.
- Modeling reading as a separate skill in KT systems can help disentangle reading barriers from genuine math mastery gaps.
- The finding generalizes beyond BKT to any KT approach that uses correctness signals without accounting for reading level.
- Adaptive math systems serving younger students must explicitly account for reading ability to avoid biased mastery estimates.

## Entities Mentioned

- [[Frank Stinar]]
- [[Haejin Lee]]
- [[Clara Belitz]]
- [[Nidhi Nasiar]]
- [[Stephen Fancsali]]
- [[Steve Ritter]]
- [[Husni Almoubayyed]]
- [[Ryan Baker]]
- [[Jaclyn Ocumpaugh]]
- [[Nigel Bosch]]
- EDM (Educational Data Mining conference)

## Concepts Covered

- [[bkt-fairness]]
- [[knowledge-tracing]]
- [[knowledge-graph-education]]
- [[skill-tree-competency-structure]]

## Why This Matters for Teach to One

Teach to One serves middle school students with a wide range of reading abilities, and its knowledge tracing engine estimates mastery from problem correctness. This paper identifies a critical fairness risk: students who struggle with reading may receive lower math mastery estimates not because they lack mathematical understanding, but because they can't fully parse word problems. This has cascading consequences in TON's learning algorithm — underestimated mastery leads to unnecessary remediation, slower progression through the curriculum, and potentially lower engagement. The recommendation to model reading as a separate skill is directly actionable for TON: by tracking reading comprehension alongside math skills, the system can distinguish "doesn't understand the math" from "can't read the problem." This is especially relevant for TON's commitment to equitable outcomes across diverse student populations, and aligns with broader [[knowledge-graph-education]] work on modeling multi-dimensional student competencies.
