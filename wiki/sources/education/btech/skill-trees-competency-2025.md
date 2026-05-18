---
description: Formal skill tree structures for competency-based courses — prerequisite DAGs with acyclicity, coverage, and coherence properties enabling automated coaching algorithms.
tags:
  - knowledge-tracing
  - skill/mapping
  - research
sources:
  - paper-skill-trees-competency-2025.md
created: 2026-05-10
updated: 2026-05-10
url: https://arxiv.org/abs/2504.16966
authors:
  - Hildo Bijl
---

# Skill Trees as Formal Structure for Competency-Based Courses

## Summary

This paper (Koli Calling 2025) by Hildo Bijl introduces skill trees as a formal mathematical structure for representing competencies and their prerequisite relationships in competency-based education. Prerequisites are modeled as a directed acyclic graph (DAG), with formal properties including acyclicity (no circular dependencies), prerequisite coverage (every competency reachable from foundational skills), and coherence (prerequisites actually enable the target competency). The formalization enables automated coaching algorithms that can identify skill gaps, recommend learning paths, and detect structural problems in curriculum design. This bridges the gap between informal competency hierarchies used in practice and the rigorous structures needed for algorithmic personalization.

## Key Claims

- Skill trees can be formally represented as DAGs with three key properties: acyclicity, prerequisite coverage, and coherence.
- Formal skill tree properties enable automated gap detection — identifying which prerequisites a student lacks for a target competency.
- Automated coaching algorithms can traverse the skill tree to generate personalized learning paths.
- The formalization surfaces structural problems in curriculum design (missing prerequisites, circular dependencies) that informal approaches miss.
- Competency-based courses benefit from explicit, machine-readable prerequisite structures rather than implicit assumptions.

## Entities Mentioned

- [[Hildo Bijl]]
- Koli Calling (conference)

## Concepts Covered

- [[skill-tree-competency-structure]]
- [[knowledge-graph-education]]
- [[knowledge-tracing]]
- [[ai-math-tutoring]]

## Why This Matters for Teach to One

Teach to One's learning algorithm already depends on a skill map — the set of skills and their prerequisite relationships that drive personalized learning paths. Bijl's formalization provides a rigorous framework for validating and improving TON's skill map. The acyclicity and coherence properties are directly relevant: if TON's skill graph has circular dependencies or incoherent prerequisites, the learning algorithm may generate suboptimal or impossible learning paths. The automated gap detection capability maps to TON's diagnostic assessment system, and the coaching algorithms could enhance the [[three-ring-mastery-system]] by providing more precise guidance on which skills a student needs before advancing. This work formalizes what TON does intuitively, offering a path to more robust curriculum design.
