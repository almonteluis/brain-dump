---
type: concept
status: stub
created: 2026-05-17
source_capture: "[[daily note for friday]]"
---

# Graphify community detection on knowledge bases

Graphify does two passes on a folder of notes: first pass finds direct connections between nodes, second pass detects communities — clusters of nodes that are meaningfully related even when no obvious link connects them. That second pass is where the surprises live.

The first pass is what you'd expect. Run it on a research folder about student motivation and it'll connect [[self-determination-theory]] to [[growth-mindset]] because they share keywords and citations. Useful but predictable. The community pass is different — it surfaces that five nodes about math anxiety, teacher positioning, and metacognitive reflection form a cluster even though none of them explicitly reference each other. That's a *synthesis waiting to happen* that you wouldn't have found by reading any single source.

The workflow: point Graphify at a folder, let it build the graph, run the deeper community analysis, then review what it grouped together. The value isn't the graph itself (you could build that manually for a small enough set). The value is the community detection flagging relationships your linear reading missed because you encountered those sources on different days in different moods and never held them in working memory at the same time.

It's the same reason [[knowledge-graph-education]] works for students — the graph surfaces prerequisites and connections the learner can't see from inside their own progression. But here the learner is you, the researcher, and the "curriculum" is a pile of notes you haven't synthesized yet. Sounds adjacent to [[second-brain-pattern]] but this is specifically about the *detection* step, not the storage model.
