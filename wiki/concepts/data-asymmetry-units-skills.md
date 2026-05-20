---
description: How page-level GraphQL query isolation creates invisible data boundaries within the same app
tags: [frontend, architecture, graphql, concept]
created: 2026-05-17
source_capture: "[[Working status of 203]]"
---

# Data asymmetry between pages — when the same app holds different truths

Two pages in the same product, looking at the same domain, running different GraphQL queries. The Units page has roadmap associations, curriculum context, target-vs-support skill types. The Skills page has none of that — different query, different data shape, no roadmap awareness. You assign a skill from either page, but the metadata you can attach to that assignment depends on *which page you were on when you created it*.

This is an architectural gotcha, not a bug. The queries evolved independently because the pages serve different user flows. But the downstream effect is real: any feature that depends on curriculum context (which roadmap? is this a target skill or support skill for this unit?) only works from one entry point. If you're building analytics or logging assignment metadata, you have to design around the asymmetry or accept incomplete data for half the assignments.

The pattern: **page-level query isolation creates invisible data boundaries**. Every page in a frontend app is potentially its own data silo, even when they share the same backend. The fix isn't merging queries — it's making the boundary explicit and deciding which page owns the canonical data for each field.

This connects to [[experiment-speculative-data]] — when you're logging experiment data per assignment, you need to know which fields are reliable from which page. What other data boundaries are hiding in plain sight across the app?

## Related Concepts
- [[experiment-speculative-data]]
