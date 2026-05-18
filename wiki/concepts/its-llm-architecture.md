---
description: ITS-LLM Architecture — how to bolt LLMs onto existing Intelligent Tutoring Systems without letting the AI drive. The ITS decides when and what; the LLM handles how to say it.
tags:
  - ai/education
  - education/math
  - research
  - concept
sources:
  - paper-its-llm-motivational-feedback-2025.md
  - paper-ai-math-tutoring-2025.md
  - paper-llm-education-systematic-review-2025.md
created: 2026-05-10
updated: 2026-05-17
---

# ITS-LLM Architecture

Synthesis from 3 papers on integrating LLMs into [[Intelligent Tutoring Systems]].

The ITS-LLM pattern answers a specific question: "I already have a working ITS. How do I add LLM capabilities without the AI undermining my pedagogy?" The answer: keep the ITS in control of *when* and *what* to tutor. Let the LLM handle *how* to communicate with the student in natural language. The pedagogical brain stays rule-based. The language brain gets neural.

## The Architecture

```
┌─────────────────────────────────────────────┐
│              Student Interface               │
├─────────────────────────────────────────────┤
│           ITS Core (Pedagogical Engine)      │
│  ┌───────────┐ ┌──────────┐ ┌────────────┐  │
│  │ Knowledge  │ │ Skill    │ │ Difficulty │  │
│  │ Tracing    │ │ Mapping  │ │ Calibration│  │
│  └─────┬─────┘ └────┬─────┘ └─────┬──────┘  │
│        ▼            ▼             ▼          │
│  ┌─────────────────────────────────────┐    │
│  │     Tutoring Decision Engine         │    │
│  │  (when to intervene, what to target) │    │
│  └─────────────┬───────────────────────┘    │
│        ┌───────┴───────┐                     │
│        ▼               ▼                     │
│  ┌───────────┐  ┌───────────┐               │
│  │ Motivational│  │Instructional│              │
│  │ Feedback   │  │ Feedback   │               │
│  │ (LLM)      │  │ (LLM)      │               │
│  └───────────┘  └───────────┘               │
│        ▼               ▼                     │
│  ┌─────────────────────────────────────┐    │
│  │     LLM Interface Layer              │    │
│  │  (swappable: GPT, Llama, etc.)       │    │
│  └─────────────────────────────────────┘    │
└─────────────────────────────────────────────┘
```

## Four Design Principles

### 1. ITS Retains Control
The ITS core — [[knowledge-tracing]], skill mapping, difficulty calibration — remains the authority for pedagogical decisions. The LLM does not decide whether to intervene or what skill to target. It only generates natural language. This addresses hallucination risk by constraining the LLM's role.

### 2. Separate Feedback Types
Motivational feedback and instructional feedback should be **different LLM components** with different prompts, evaluation criteria, and delivery timing. Combining them in one prompt degrades both.

- **Motivational**: encouragement, goal-setting, self-efficacy support → triggered by engagement signals
- **Instructional**: concept explanation, error correction, scaffolding → triggered by mastery signals

### 3. Swappable LLM Backend
The interface layer abstracts the model. Swap GPT for Llama without architectural changes. This matters for cost management, vendor independence, and continuous improvement.

### 4. Multi-Agent Decomposition
Different AI agents handle different tutoring functions:

| Agent | Responsibility | ITS Integration |
|-------|---------------|-----------------|
| Content Generation | Create problems, explanations | Skill mapping → content |
| Difficulty Calibration | Adjust complexity | [[knowledge-tracing]] → difficulty |
| Feedback Generation | Instructional/motivational feedback | Decision engine → delivery |
| Progress Tracking | Monitor advancement | [[knowledge-tracing]] → mastery |

## Risk Mitigation

| Risk | How the architecture handles it |
|------|-------------------------------|
| **Hallucination** | ITS constrains LLM output; factual claims validated against curriculum |
| **Bias** | Feedback prompts designed for equity; ITS ensures appropriate challenge |
| **Privacy** | Student data stays in ITS; only anonymized prompts go to LLM |
| **Over-reliance** | Human facilitators stay in the loop |
| **Inconsistent quality** | ITS decision engine ensures feedback fires at appropriate moments |

## Production Concerns

- **Latency**: LLM inference (1-10 seconds) must fit within real-time tutoring. Pre-generate common feedback, stream responses, use smaller models for routine tasks.
- **Cost**: Per-student costs scale with interaction volume. [[tutor-copilot-2025]] shows effective AI augmentation can cost ~$20/tutor/year.
- **Evaluation**: Feedback quality should be measured against teacher benchmarks, student outcomes, and affective metrics.

## Why This Matters for TTO

TTO already has the ITS core — [[knowledge-tracing]], skill mapping, personalized paths, facilitator-managed classrooms. The question isn't "should we build an ITS?" It's "how do we add LLM capabilities onto the existing one?"

The modular design means TTO could:
1. **Start small** — LLM-generated motivational feedback alongside existing content
2. **Expand** — adaptive instructional feedback for common error patterns
3. **Augment facilitators** — AI-suggested feedback that also trains teachers to give better feedback ([[tutor-copilot-2025]] finding)
4. **Stay in control** — learning algorithm stays authoritative, LLM is the mouthpiece

The key insight from the research: the most effective AI tutoring systems **don't let the AI make pedagogical decisions**. They use AI to execute decisions made by proven frameworks. [[project-atlas]] is the pedagogical framework. The LLM is the communication layer.

## Related

- [[ai-math-tutoring]] — broader category of AI tutoring
- [[adaptive-feedback-education]] — feedback generation this architecture enables
- [[knowledge-tracing]] — drives intervention decisions
- [[three-ring-mastery-system]] — pedagogical framework this would serve
- [[just-in-time-adaptive-intervention]] — intervention timing within the ITS
- [[self-regulated-learning]] — the learning outcome this aims to support
