---
description: Systematic literature review of knowledge graph construction in education — covering personalized learning, curriculum design, concept mapping, content recommendation, and learning analytics.
tags:
  - knowledge-tracing
  - skill/mapping
  - research
sources:
  - paper-knowledge-graph-education-slr-2024.md
created: 2026-05-10
updated: 2026-05-10
url: https://pmc.ncbi.nlm.nih.gov/articles/PMC10847940/
authors:
  - Bilal Abu-Salih
  - Salihah Alotaibi
---

# Knowledge Graph Construction in Education: A Systematic Literature Review

## Summary

This systematic literature review by Abu-Salih and Alotaibi surveys knowledge graph (KG) construction methods in educational contexts, identifying five primary application domains: personalized learning pathways, curriculum design and optimization, concept mapping and prerequisite modeling, content recommendation systems, and learning analytics. The review reveals that construction approaches range from manually curated domain ontologies (expensive but high-quality) to automated extraction from textbooks, assessment data, and student interaction logs (scalable but noisy). The authors identify significant gaps in the field: scalability of KG construction to large curricula, real-time integration of KG updates as new learning data arrives, and the absence of standardized evaluation metrics for educational KGs. The review provides a taxonomy of construction methods and a roadmap for future research, making it a foundational reference for any adaptive learning platform considering knowledge graph infrastructure.

## Key Claims

- Knowledge graphs in education serve five domains: personalized learning, curriculum design, concept mapping, content recommendation, and learning analytics.
- Construction methods exist on a spectrum from manual ontology engineering (high quality, low scalability) to automated extraction (high scalability, lower quality).
- No single construction method dominates — hybrid approaches combining manual domain expertise with automated extraction show the most promise.
- Scalability remains the primary barrier: most existing educational KGs cover narrow domains with hundreds of concepts, not full K-12 curricula with thousands.
- Real-time integration of student performance data into the KG is largely unsolved — most systems use batch updates.
- Standardized evaluation metrics for educational KGs are absent, making cross-system comparison difficult.
- The review identifies prerequisite relationship quality as a critical factor for downstream personalization effectiveness.

## Entities Mentioned

- [[Bilal Abu-Salih]]
- [[Salihah Alotaibi]]

## Concepts Covered

- [[knowledge-graph-education]]
- [[skill-tree-competency-structure]]
- [[bkt-fairness]]
- [[knowledge-tracing]]
- [[ai-math-tutoring]]

## Why This Matters for Teach to One

Teach to One's skill map is essentially an educational knowledge graph — a structured representation of mathematical concepts, their prerequisite relationships, and their connections to learning activities. This review provides the theoretical foundation for understanding and improving TON's graph infrastructure. The scalability gap identified in the literature directly affects TON: as the curriculum expands to cover more skills and grade levels, maintaining a high-quality skill graph becomes increasingly challenging. The real-time integration gap is also relevant — TON's learning algorithm needs up-to-date prerequisite information to make good personalization decisions. The review's finding that hybrid approaches (manual expertise + automated extraction) work best validates TON's approach of combining curriculum designer expertise with data-driven refinement. For the [[three-ring-mastery-system]], knowledge graph quality directly determines the quality of learning path recommendations and gap detection.
