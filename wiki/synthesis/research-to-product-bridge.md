---
description: Bridge between research evidence (19 papers, 5 clusters) and Marvin vault product/engineering context. Maps research findings to TTO implementation opportunities with Claude Code investigation prompts.
tags:
  - synthesis
  - tto
  - research
  - product
  - implementation
  - claude/code
sources:
  - mastery-velocity-three-ring-feature-concept
  - irec-metacognitive-scaffolding-arxiv
  - maintenance-ring-insight-recall-over-spaced-rep
  - insight-recall-paradigm-applied-to-three-ring
  - geometry-of-learning-kst-mastery-maps
  - cognitive-learning-model-product
  - orchestrator-three-ring
  - research-session-notes-2026-05-09
  - paper-metacognitive-instruction-meta-analysis-2025
  - paper-nudge-math-megastudy-2025
  - paper-streaks-math-engagement
  - paper-metacognitive-skills-math-problem-solving-2025
  - paper-metacognition-math-modeling-computational-thinking-2024
  - paper-nudge-meta-synthesis-2025
created: 2026-05-10
updated: 2026-05-10
---

# Research → Product Bridge

Cross-reference between the **research evidence base** (19 papers across 5 clusters, synthesized into wiki concepts) and the **Marvin vault product/engineering context** (Teach to One codebase, BrainBreak implementation, Three-Ring feature concept). This page is the living bridge between "what the research says" and "what the code can do."

## Architecture: Two Vaults

```
Knowledge Vault (this wiki)          Marvin Vault (work notes)
┌─────────────────────────┐          ┌─────────────────────────┐
│ Research evidence base   │          │ Product specs            │
│ 19 papers, 5 clusters    │◄────────►│ Three-Ring concept       │
│ 8 concept pages          │  BRIDGE  │ BrainBreak impl          │
│ Effect sizes, causal     │   PAGE   │ TEAME post-mortems       │
│ chains, design principles│          │ Codebase graph analysis  │
└─────────────────────────┘          └─────────────────────────┘
                    │
                    ▼
         ┌─────────────────────┐
         │ Implementation      │
         │ Prompts for         │
         │ Claude Code         │
         │ (below)             │
         └─────────────────────┘
```

---

## Validation: Research Confirms TTO Design Choices

The [[three-ring-mastery-system]] architecture is strongly grounded in the research. These aren't coincidental alignments — they're convergent validity.

| TTO Design Choice | Research Confirmation | Source |
|---|---|---|
| **New / Practice / Maintain** ring decomposition | Skill Trees paper (Bijl 2025) formalizes competency progression as DAG traversal — maps directly to skill lifecycle | [[skill-tree-competency-structure]] |
| **Path B empirical decay** (6yr data) over algorithmic SR | DLKT study: neural models degrade with sparse data; BKT stays competitive in low-data regimes. Empirical approach is pragmatic. | [[deep-knowledge-tracing-practical-evaluation]] |
| **Productive struggle credit** (wrong→wrong→right = 1.2x) | NCTM identifies productive struggle as core teaching practice; Bellwether report confirms AI must preserve struggle | [[productive-struggle]] |
| **Streaks above rings, not as a ring** | Chile RCT (Cristia et al.): streaks significantly increase **math achievement**, not just engagement. Mechanism = loss aversion. | [[behavioral-nudges-education]] |
| **Skills/week, not time-on-task** as primary metric | Duolingo + Apple Watch analysis: engagement metrics that don't correlate with learning outcomes are a trap | [[gamification]] |
| **Anti-patterns** (leaderboard bottom half, streak shame, over-scaffolding) | Meta-synthesis confirms context dependency, heterogeneous effects, and nudge fatigue | [[behavioral-nudges-education]] |
| **BrainBreak as metacognition flow** | Metacognitive instruction meta-analysis: ES=1.11 for math achievement — among largest in education research | [[metacognitive-reflection]] |
| **Insight Recall for Maintenance ring** | iRec paper (Hou & Tan 2025): context-triggered retrieval of personal insights as metacognitive scaffold | [[insight-recall]] |

---

## Gaps: Research Exists, Product Missing

### Gap 1: Teacher-Facing Nudges 🔴

**Evidence:** The [[paper-nudge-math-megastudy-2025|Zearn megastudy]] (N≈3M) shows email nudges to teachers boost student math progress by **+1.89%**. Personalized, data-driven content significantly outperforms generic reminders.

**Marvin vault status:** Teacher dashboard and teacher view are extensively brainstormed. **No teacher nudge system is designed.** No product spec references the megastudy findings.

**What's needed:** Weekly email/dashboard alerts with loss aversion framing, social norm benchmarks, and actionable progress data. See [[behavioral-nudges-education]] §TTO Applications for full design spec.

→ **Claude Code prompt:** [[#prompt-teacher-nudges]]

### Gap 2: Planning Prompts in BrainBreak 🔴

**Evidence:** Tolvanen et al. 2025 found that the most common metacognitive utterance is "creating a learning goal and a plan" (f=221). Goal-setting + actionable planning ("I'll use substitution first") dramatically outperforms superficial performance goals ("I want a good grade"). [[metacognitive-reflection]] §Explicit Prompts.

**Marvin vault status:** BrainBreak captures emotion (4×4 circumplex picker) + confidence (5-point slider). **No planning/strategy capture.** The confidence slider measures *outcome confidence*, not *process monitoring* — which the research says is the higher-impact lever.

**What's needed:** Add a "What's your plan?" prompt before practice sessions. Low-effort UI addition to existing BrainBreak survey flow.

→ **Claude Code prompt:** [[#prompt-planning-prompts]]

### Gap 3: Struggle Detection → Adaptive Nudge Timing 🟡

**Evidence:** [[productive-struggle]] research distinguishes productive vs unproductive struggle. Nudge timing matters — too early short-circuits struggle, too late means disengagement. [[knowledge-tracing]] provides the signals (attempt patterns, time-on-task, correctness trajectories).

**Marvin vault status:** No engineering connection between KT model outputs and nudge triggers. Practice ring has adaptive credit weighting but no *intervention* triggers.

**What's needed:** Pipeline from KT → struggle classification → nudge/not-nudge decision. See adaptive credit weighting in [[three-ring-mastery-system]] §Practice Ring as foundation.

→ **Claude Code prompt:** [[#prompt-struggle-detection]]

### Gap 4: Confidence × Performance Divergence Alert 🟡

**Evidence:** KST Mastery Maps (C-7 pilot) documented a clear Dunning-Kruger pattern — self-assessment inflated Week 1, corrected by coach assessment Week 2. Metacognitive calibration research shows divergence between confidence and competence is a learning risk signal.

**Marvin vault status:** BrainBreak captures confidence. Learnosity captures performance. **No divergence computation or alert exists.**

**What's needed:** Backend computation layer comparing BrainBreak confidence signals with Learnosity correctness data. Flag when divergence exceeds threshold → teacher alert or student reflection trigger.

→ **Claude Code prompt:** [[#prompt-confidence-divergence]]

### Gap 5: Causal Chain Not Operationalized 🟡

**Evidence:** Zhao et al. 2024 identified a causal chain: **metacognition → critical thinking → mathematical modeling**. [[metacognitive-reflection]] §Causal Chain.

**Marvin vault status:** BrainBreak captures emotion + confidence but doesn't capture *planning* or *strategy selection* — the actual metacognitive levers in the causal chain. No dashboard signal for teachers about students' metacognitive engagement.

**What's needed:** Add strategy/planning capture to BrainBreak (overlaps with Gap 2). Consider teacher dashboard widget showing aggregate metacognitive engagement metrics.

### Gap 6: GenAI Tutoring Research Not Connected 🟢

**Evidence:** Cluster B covers AI tutoring ([[ai-math-tutoring]]), adaptive feedback ([[mathedu-adaptive-feedback-2025]]), and GenAI meta-analysis ([[genai-math-meta-analysis-2026]]). TutorCopilot paper documents AI-assisted tutoring patterns.

**Marvin vault status:** No connection between BrainBreak's hint system and adaptive feedback research. TutorCopilot not referenced in any product spec. The "invisible orchestrator" concept from [[insight-recall]] is adjacent but not explicitly linked.

**What's needed:** Review adaptive feedback design principles against current hint/scaffolding implementation. Map TutorCopilot patterns to TTO's tutoring context.

---

## Opportunity Map

### 🔴 High-Impact, High-Feasibility

| Opportunity | Research Basis | Marvin Connection | Effort |
|---|---|---|---|
| Add planning prompt to BrainBreak | Tolvanen 2025: planning most accessible SRL entry (f=221) | BrainBreak survey flow exists — add step | **Low** |
| Teacher progress nudges | +1.89% math progress (N≈3M) | Teacher dashboard exists; no nudge system | **Medium** |
| Insight Recall forward-priming MVP | iRec paper + transfer research | Maintenance ring designed; capture via BrainBreak; trigger needs eng | **Medium** |

### 🟡 High-Impact, Higher Effort

| Opportunity | Research Basis | Marvin Connection | Effort |
|---|---|---|---|
| Confidence/performance divergence alert | Dunning-Kruger from KST maps | BrainBreak + Learnosity data exist; needs computation layer | **Medium** |
| Struggle detection → nudge timing | Productive struggle research | KT model exists; no nudge trigger pipeline | **Medium-High** |
| Aggregate insights for teachers | Maintenance ring: "8 students figured out negative-flip rule" | BrainBreak data + insight capture → teacher dashboard | **Medium-High** |
| Skill graph prerequisite validation | Bijl 2025: formal acyclicity, coverage, coherence | "Does TTO have a structured prerequisite map?" is open | **High** |

### 🟢 Incremental

| Opportunity | Research Basis | Marvin Connection | Effort |
|---|---|---|---|
| Nudge rotation to prevent fatigue | Meta-synthesis: nudge fatigue from overuse | Streak + ring system is static | **Low** |
| Multi-strategy nudge combinations | Meta-synthesis: combinations > single | Currently single-mechanism per touchpoint | **Low-Medium** |
| Equity-aware streak adaptation | Meta-synthesis: heterogeneous effects | "Students who can't hit 2/week → quietly adapt" noted | **Low-Medium** |

---

## Marvin Vault Engineering Context (for implementation)

### BrainBreak Architecture

The capture mechanism for [[insight-recall]] and [[metacognitive-reflection]]. Understanding its constraints is essential for evaluating feasibility.

- **Survey flow:** Emotion picker (4×4 circumplex grid) → Confidence slider (5-point continuous)
- **Cooldown system:** Same-day prevention + 10-day cooldown with timezone handling (date-fns)
- **Session lock:** Cross-tab/cross-browser via localStorage (note: TOCTOU risk — no backend CAS)
- **State management:** Redux slice (`brainBreakSlice`) with selectors and actions
- **Data recording:** GraphQL mutations via `useBrainBreakRecorder` hook, `Promise.allSettled`
- **Feature flag:** `BRAIN_BREAK_FLAG_NAME` gates entire feature via [[unleash]]
- **UI:** PrimeReact Dialog (accessibility + less code), custom SVGs (cross-platform consistency)
- **Post-mortem:** 7 major refactoring iterations (Feb–Apr 2026), TEAME-218

**Integration points for extensions:** Redux slice, survey flow steps, cooldown logic, GraphQL recording hook.

### Learnosity Constraints

Several research applications depend on attempt-level data granularity:

- 10 questions per page
- Grading API available
- **Open question:** Does Learnosity expose enough attempt-level metadata for implicit insight capture at scale?
- **Open question:** Can Learnosity config prevent retakes after seeing answers? (Blocker for Practice ring anti-gaming)

### TTO's 6-Year Data Asset

Most research papers operate in data-scarce environments. TTO's data richness makes several approaches practically feasible:

- Per-skill empirical decay curves (cold-start solved)
- Cohort-prior insight inheritance for new students
- Per-skill forgetting curve computation
- "Skills at risk" prediction from historical patterns

### Measurement Framework (already defined)

- **Primary metric:** Skills mastered per week (not time-on-task)
- **Rigorous trio:** Mean + median + distribution shape
- **Unit of analysis:** Student-day → student-week; class-week secondary
- **Feature flag rollout:** Via [[unleash]], 10-20% roll-in
- **Equity signal:** Distribution shape (does it lift the whole curve?)

This framework should be the evaluation plan for any research-derived feature.

### Existing Codebase Communities (from Graphify)

- **BrainBreak State Machine** (30 nodes, low cohesion 0.07 — needs splitting)
- **BrainBreak UI Components** (tight cluster)
- **Cooldown & Lock** (tightest cluster, 0.24 cohesion)
- **Math Achievement Hints** (separate from BrainBreak but adjacent — unification opportunity under metacognitive scaffolding)

---

## Related

- [[three-ring-mastery-system]] — Product container
- [[insight-recall]] — Maintenance ring content layer
- [[metacognitive-reflection]] — Cognitive activity being scaffolded
- [[behavioral-nudges-education]] — Nudge taxonomy + TTO applications
- [[productive-struggle]] — Practice ring foundation
- [[knowledge-tracing]] — Student modeling infrastructure
- [[self-regulated-learning]] — Theoretical container
- [[cooldown-system]] — BrainBreak cooldown pattern
- [[learnosity]] — Practice problem data source
- [[unleash]] — Feature flag rollout

---

*Claude Code investigation prompts for each gap are in [[claude-code-prompts-research-implementation]].*
