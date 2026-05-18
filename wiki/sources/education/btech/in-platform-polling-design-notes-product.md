---
description: In-platform polling design — emotion/engagement measurement, interaction design, and trigger contexts
tags:
  - source
  - polling
  - marvin/frontend/brain-break
  - experiments
  - ux
  - product
  - work
created: 2026-04-30
updated: 2026-04-30
sources:
  - In-Platform Polling (Design Notes) - PRODUCT.md
---

# In-Platform Polling (Design Notes)

Source: [Confluence — In-Platform Polling Design Notes](https://newclassrooms.atlassian.net/wiki/spaces/PRODUCT/pages/1265074211/In-Platform+Polling+Design+Notes)

## Goals

- Enable high-fidelity measures of **motivation, engagement, and persistence** with low impact on student experience
- Use small numbers (maybe 1) of questions across many students instead of full surveys on smaller numbers
- Apply continuously and automatically across randomly sampled moments for easy A/B testing
- Integrate with general experimental logging
- Test custom emotion-polling / affect questions (e.g., 2-axis emotion scale)

## Validation Experiments

- Influence user emotion through purposefully good or bad experiences (e.g., variations on clicker/progress counters)

## Interaction Design

| Property | Requirement |
|----------|-------------|
| **Unskippable** | Full screen or covers most of it with blurred background |
| **Brief** | Minimal time investment |
| **Rewarding** | Animated answers/emoji; "juicy" interaction with animated entry/exit |
| **Clear** | Especially important if questions vary each time |
| **Randomized** | Every interaction uses randomly sampled questions |
| **Configurable** | Question text potentially configurable post-deploy via Unleash variant naming |
| **Rate-limited** | At most 1 question per session per student |
| **Non-sticky** | Question+location combo; if already answered this session, doesn't show again |
| **Contextualized** | "Brain Break!" messaging about what students return to |

## Trigger Contexts

The poll can appear after:

- Login
- Selecting a skill
- Viewing worked example video for more than 2 minutes (and moving on)
- Doing practice problems for more than 2 minutes (and moving on)
- After a skill assessment attempt (maybe distinguished passed/failed)
- After a skill assessment re-attempt

## Related

- [[brainbreak]] — Brain Break feature overview
- [[teame-177-in-platform-polling-cleanup]] — Implementation ticket
- [[teame-218-code-cleanup-lts-conversion]] — LTS conversion for polling
- [[cognitive-learning-model-product]] — Learning theory context
- [[unleash]] — Feature flag platform for variant configuration
