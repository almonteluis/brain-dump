---
description: Learnosity migration strategy — why move in-house, phases, estimates, and success criteria
tags: [source, learnosity, migration, tech-strategy, product, work]
created: 2026-04-30
updated: 2026-04-30
sources: ["Learnosity Swap-Out Notes - PRODUCT.md"]
---

# Learnosity Swap-Out Notes

Source: [Confluence — Learnosity Swap-Out Notes](https://newclassrooms.atlassian.net/wiki/spaces/PRODUCT/pages/1726578690/Learnosity+Swap-Out+Notes)
Author: [[Sam Saarinen]]

## Context

Learnosity was used to bootstrap Academics Team authorship of questions for practice and assessment. Now used for rendering practice questions, administering skill challenges, adaptive diagnostics, exit tickets, grading feedback, and item bank management.

## Why Move In-House

| Factor | Issue |
|--------|-------|
| **Instability** | Multiple breaking LTS API changes unannounced; caused service disruption for tens of thousands of students |
| **Cost** | Fixed per-student cost (not usage-based); significant fraction of per-student tech costs |
| **Tech Performance** | No webhook/live-response grading; dependent on polling/synchronization; ~3-15 second loading times |
| **Limited UI Control** | Discontinuities with in-product design; limited UX improvement recourse |
| **Limited Academic Control** | Non-extensible question types; limited adaptive feedback; many interactive types cannot be integrated |
| **Use Case Mismatch** | Not the normal use case; improvements unlikely to align with needs |
| **Private Equity** | Bought out; rarely ends well |

## Why Not Move In-House

- **Time opportunity cost**: Several person-months for parity
- **Legal risk**: If open-sourcing tools or perceived code exploitation
- **Strategic dilution / scope creep**: Another thing to maintain; not central to core value add

## Success Criteria

- Users don't notice a difference, or perceive it as an upgrade
- Not deprioritized rest of roadmap; doesn't break the bank
- Opens new possibilities academically and UX-wise

## Timeline

- Must complete before **end of June 2027** (annual contract renewal)

## Resourcing Assumptions

- Dedicated product manager
- Engineering from across teams (no floating capacity)
- Dedicated QA resource (net new recommended)
- DevOps engineer (existing or net new)
- Limited UX/design resourcing
- Leverage AI-assisted coding where possible

## Components and Phases

### Phase 1: Renderer Parity (Practice Questions)

- Render questions with feature-parity + UI/UX improvements
- Support saving practice question responses
- Teacher preview / student response review
- ~20 hrs architecture design + open code standards
- ~100 hrs question UI engineering (~25 question types, 2-4 hrs each to reverse engineer)

### Phase 2: Internal Item Hosting, CMS Support

- Store existing items in own infrastructure
- Port items to new question format
- Schema defs / data model, table creation, CMS update + upload tool, table population
- Polyfill/transition: GraphQL endpoints and frontend updates

### Phase 3: Authoring Tools

- Authoring UI development
- CMS ↔ Authoring connection

### Phase 4: Inference from Results

- Skill Challenge + Exit Ticket student flows
- Internal server-side scoring/recording
- Inference engine refactor to run from internal grading
- Teacher-side exit ticket reporting

### Phase 5: Adaptive Testing Algorithms (Diagnostics)

- IRT swap-in with standard algorithms
- Eventually upgrade predictive model

### Phase 6: Historical Data Export + Backup

- Preserve sessions and data for research and continuity

## Related

- [[learnosity]] — Learnosity entity overview
- [[learnosity-access-product]] — Access and key management
- [[cognitive-learning-model-product]] — Learning theory informing product decisions
- [[tech-debt-infrastructure-opportunities-product]] — Related tech debt context
