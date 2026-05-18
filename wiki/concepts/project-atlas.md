---

tags:
  - source
  - atlas
  - new-classrooms
  - ai/education
  - teach-to-one
  - concept-paper
  - adaptive/learning
sources:
  - Project Atlas.md
created: 2026-05-12
updated: 2026-05-17
related:
  - "[[adaptive-learning]]"
  - "[[metacognitive-reflection]]"
  - "[[competency based learning]]"
---

# Project ATLAS

Project ATLAS (AI-Native Teaching, Learning & Academic Support) is New Classrooms' concept paper for building an intelligence layer on top of [[teach-to-one]] Roadmaps. It operationalizes learning science into three interconnected loops: **sequencing**, **instruction**, and **assessment**. The question it answers: "how do you personalize at scale without losing teacher-led instruction?"

Source: `raw/Project Atlas.md` (PDF++ highlights with personal annotations from ATLAS Concept Paper 23-Pager).

## The Numbers That Motivate It

From [[Unlocking Algebra]] (TNTP & New Classrooms, 2025): Students missing critical [[predecessor-skills]] had only a **13% success rate** in Algebra 1. Students with both broad knowledge + targeted predecessor skills reached **58%**. The implication: don't cover everything. Master the right foundational skills.

## Architecture: Three Loops

### 1. Sequencing Engine
- Identifies highest-leverage [[predecessor-skills]] per student (not fill-all-gaps)
- Uses the existing [[knowledge-graph-education|knowledge graph]] + [[knowledge-tracing]] infrastructure
- Adaptive difficulty calibration maintains [[zone-of-proximal-development|ZPD]] automatically
- Maps to [[competency based learning|CBL]] principles — mastery-gated progression

### 2. Instruction Layer
- Curates modalities (teacher-led, collaborative, independent, digital) based on student state
- Dynamically adjusts difficulty, support, and encouragement
- Conversational AI as **bounded** tool — Socratic dialogue is one use case, not the whole thing
- Anti-gamification stance: engagement from system design, not bolted-on features

### 3. Assessment Infrastructure
- [[formative-assessment|Formative assessment]] — continuous low-stakes, not summative-only
- Multimodal scoring: voice, image uploads, open-ended explanations via large multimodal models
- [[metacognitive-reflection|Metacognitive]] exit slips — capture student insights for later recall
- Misconception detection: structured datasets of common algebra errors → targeted micro-lessons

## Learning Science Foundations

ATLAS operationalizes seven research-backed principles simultaneously:

| Principle | Effect Size / Evidence | Wiki Page |
|-----------|----------------------|-----------|
| Mastery learning | Kulik recalibrated: .59σ | [[competency based learning]] |
| Predecessor skills targeting | 13% → 58% Algebra success | [[predecessor-skills]] |
| Spaced retrieval | 72% vs 38% retention | [[spaced-retrieval-practice]] |
| Interleaved practice | Better transfer | [[desirable-difficulty]] |
| Formative feedback | Black & Wiliam (1998) | [[formative-assessment]] |
| Collaborative learning | .54σ (Kyndt et al., 2013) | [[peer-tutoring-math]] |
| Intrinsic motivation | SDT: competence + autonomy + relatedness | [[self-determination-theory]] |

## Luis's Annotations — Ideas Beyond the Paper

These surfaced from personal highlights:

1. **Spaced insight-recall** — "Capture students' aha moments and surface them years later when they hit Algebra 1. 'Oh snap, I remember going through this back in sixth grade.'" Ties to [[insight-recall]].
2. **Metacognitive exit slips** — "You just demonstrated mastery. Fulfill this exit slip that we'll save for you when you face this skill again." Bridges [[formative-assessment]] + [[metacognitive-reflection]] + spaced retrieval.
3. **Interactive curiosity-sparking content** — Med school dashboard pattern: high-detail cells you can explore. Different from gamification.
4. **Students teaching students** — "Put kids in groups and have them teach each other what the other is lacking." Reciprocal teaching → [[peer-tutoring-math]].
5. ==**LLM grading → adaptive re-routing** — "Judging by your reasoning, you don't fully grasp this. Let's go back to basics." Real-time [[adaptive-feedback-education|adaptive feedback]].==

## Connection to Three-Ring

[[three-ring-mastery-system]] is the product vision for mastery visualization. ATLAS is the intelligence engine underneath. The [[skill-tree-competency-structure|skill tree]] maps to ATLAS's predecessor skill graph. The maintenance ring's [[insight-recall]] mechanism directly implements the "capture aha moments and surface them later" annotation.

## Scale

Currently serving **~40,000 students** across diverse districts.

The open thread: ATLAS operationalizes seven principles simultaneously. The question isn't whether each one works in isolation — the evidence is clear. The question is what happens when they interact. Does spaced retrieval conflict with mastery-gated progression? Does interleaved practice undermine prerequisite targeting? Seven independently effective interventions don't automatically make seven times the impact when combined. That's the integration challenge, and it's where most adaptive systems plateau.

## References

- Bloom (1984) — 2σ problem
- Kulik et al. — mastery learning meta-analysis
- Cepeda et al. (2008) — spacing effects
- Rohrer et al. — interleaved practice (72% vs 38%)
- Black & Wiliam (1998) — formative assessment
- Kyndt et al. (2013) — collaborative learning (.54σ)
- Ryan & Deci (2000) — [[self-determination-theory|SDT]]
- TNTP & New Classrooms (2025) — [[Unlocking Algebra]]

## Related

- [[competitive-landscape-teach-to-one]] — where ATLAS fits in the market
- [[three-ring-mastery-system]] — product feature concept built on ATLAS foundations
- [[skill-tree-competency-structure]] — visualization of the predecessor skill graph
- [[insight-recall]] — metacognitive scaffolding paradigm
- [[ai-math-tutoring]] — AI tutoring landscape
- [[just-in-time-adaptive-intervention]] — JITAI framework
- [[knowledge-tracing]] — competency inference models
- [[knowledge-graph-education]] — skill map structure
- [[interactive app ideas from twitter]] — vibe-coded ideas found on Twitter
