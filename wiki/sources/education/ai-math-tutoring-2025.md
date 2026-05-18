---
description: Multi-agent AI platform for personalized math tutoring with adaptive difficulty, multiple learning modes (new topics, weakness practice, exam revision), and scalable deployment.
tags:
  - ai/education
  - education/math
  - research
sources:
  - paper-ai-math-tutoring-2025.md
created: 2026-05-10
updated: 2026-05-10
url: https://arxiv.org/abs/2507.12484
authors:
  - Jarosław A. Chudziak
  - Adam Kostka
---

# Multi-Agent AI Platform for Personalized Math Tutoring

## Summary

This paper presents a multi-agent AI platform designed for personalized mathematics tutoring, featuring four distinct learning modes: new topic introduction, weakness-targeted practice, exam revision, and unlimited exercise generation. The system uses adaptive difficulty algorithms to calibrate problem complexity to individual student proficiency levels. The multi-agent architecture separates concerns across specialized agents (e.g., content generation, difficulty calibration, feedback, progress tracking), enabling modular development and deployment. The platform demonstrates scalable deployment potential and provides a reference architecture for building comprehensive AI tutoring systems that go beyond simple question-answering.

## Key Claims

- Multi-agent architectures enable more flexible and maintainable AI tutoring systems than monolithic designs.
- Four learning modes (new topics, weakness practice, exam revision, unlimited exercises) cover the full student learning lifecycle.
- Adaptive difficulty calibration is essential for maintaining student engagement and matching skill level.
- Separating content generation from feedback and progress tracking allows independent improvement of each component.
- The architecture is designed for scalable deployment across diverse educational contexts.

## Entities Mentioned

- [[Jarosław A. Chudziak]]
- [[Adam Kostka]]

## Concepts Covered

- [[ai-math-tutoring]]
- [[its-llm-architecture]]
- [[adaptive-feedback-education]]
- [[knowledge-tracing]]
- [[spaced-repetition]]

## Why This Matters for Teach to One

The multi-agent architecture described here closely parallels the modular design philosophy that Teach to One could adopt for AI integration. The four learning modes map well to TON's existing instructional modalities (new learning, practice, assessment). The separation of content generation, difficulty calibration, and feedback into distinct agents aligns with the [[its-llm-architecture]] pattern where LLMs are embedded within a broader ITS framework. The weakness-targeted practice mode is particularly relevant to TON's approach of identifying and addressing individual skill gaps through [[knowledge-tracing]].
