---
description: Prototype ideas seeded from concepts and research. Where "this paper made me want to build X" lives.
tags:
  - index
  - ideas
  - prototypes
created: 2026-05-19
---

# Ideas

This folder is the bridge between `wiki/concepts/` / `wiki/sources/research/` and actual builds. An idea here is a candidate prototype — not a fully-scoped project, but a captured spark with enough structure that you (or Claude) can pick it up later and move it forward.

## How it works

1. Reading a paper or working through a concept sparks an idea.
2. Copy [[_template]] into a new file in this folder: `kebab-case.md`.
3. Fill `inspired_by` with the concepts and papers that birthed it.
4. Promote through the lifecycle below as the idea matures.
5. Back-link from the source concept page (`## Prototypes\n- [[idea-name]]`) so the graph stays bidirectional.

## Status lifecycle

| Status   | Meaning                                                       |
| -------- | ------------------------------------------------------------- |
| `seed`   | Captured, may die here. One paragraph minimum.                |
| `sketch` | Filled in: what, why now, smallest version, open questions    |
| `spike`  | Quick code or experiment in progress                          |
| `shipped`| Built and out the door — link to the artifact                 |
| `parked` | Set aside intentionally — note why, may revisit               |

## Effort sizing

| Tag | Meaning                                                  |
| --- | -------------------------------------------------------- |
| `S` | Weekend                                                  |
| `M` | A week of evenings                                       |
| `L` | Month+ — almost certainly needs to be split into smaller |

## Conventions

- **Filename:** `kebab-case.md`, no `idea-` prefix needed (the folder is the namespace).
- **Always fill `inspired_by`.** An idea with no source is a stray thought, not a prototype lead. If you can't link it back to a concept or paper, ingest the source first.
- **Always write "Smallest testable version."** If you can't sketch it, the idea isn't ready — leave it as `seed` and come back.
- **One idea per file.** Combine related ideas in `## Related`, don't merge them.

## Triage cadence

Once a week (pair with `/weekly-synthesis`), walk this folder and ask of each `seed`:
- Promote to `sketch`?
- Park with a reason?
- Delete?

Seeds that survive 3 reviews without movement are usually telling you something — promote, park, or delete.

## Related

- [[_template]] — Starter template for new ideas
- [[wiki/synthesis/research-to-product-bridge]] — Worked example of the research → idea pipeline
- [[wiki/index]] — Wiki entry point
