---
description: Ready-to-paste Claude Code prompts for investigating the Marvin codebase to implement research findings into the TTO product. Each prompt targets a specific gap or opportunity identified in the research-to-product bridge.
tags:
  - synthesis
  - tto
  - claude/code
  - implementation
  - prompts
  - research
sources:
  - research-to-product-bridge
  - three-ring-mastery-system
  - metacognitive-reflection
  - behavioral-nudges-education
  - productive-struggle
  - knowledge-tracing
  - brainbreak-mvc-refactor
created: 2026-05-10
updated: 2026-05-10
---

# Claude Code Prompts: Research → Implementation

Paste these into Claude Code inside the Marvin monorepo to investigate codebase feasibility, discover integration points, and draft implementation strategies for the research-backed opportunities identified in [[research-to-product-bridge]].

**How to use:** Open Claude Code in the marvin repo root. Paste the relevant prompt. Review the output, then iterate on the implementation plan.

---

## Prompt 1: Planning Prompt in BrainBreak
> **Gap:** BrainBreak captures emotion + confidence but not *planning/strategy* — the highest-impact metacognitive lever (Tolvanen 2025, f=221).
> **Effort:** Low — add a step to existing survey flow.
> **Research:** [[metacognitive-reflection]] §Explicit Prompts, ES=1.11 for metacognitive instruction.

```
I need to add a planning/strategy prompt to the BrainBreak survey flow.
Here's the current architecture context:
- BrainBreak survey flow: Emotion picker (4x4 circumplex grid) → Confidence slider (5-point) → GraphQL recording
- State: Redux slice (brainBreakSlice) with selectors and actions
- Recording: useBrainBreakRecorder hook with Promise.allSettled
- Feature flag: BRAIN_BREAK_FLAG_NAME via Unleash
- UI: PrimeReact Dialog with custom SVGs

Tasks:
1. Find the BrainBreak survey flow component(s) — trace from the modal trigger through each step (emotion picker → confidence → submission). Show me the file paths and the step sequencing logic.
2. Identify the exact Redux slice actions/types involved in recording a BrainBreak submission. I need to know the shape of the mutation payload sent to GraphQL.
3. Find the GraphQL mutation and its backend resolver. What table(s) does BrainBreak data land in? What columns exist?
4. Find the cooldown system logic — where is same-day prevention and the 10-day cooldown enforced? Show me the date comparison code.
5. Evaluate: if I add a new step between confidence slider and submission ("What's your plan for this practice session?"), what files need to change? Give me a concrete diff plan.
6. Check: does the BrainBreak data model have any concept of "session type" or "pre/post" that would let us distinguish planning prompts from reflection prompts?
7. Look for any existing A/B testing or experiment infrastructure wired into BrainBreak (experiment IDs, feature flag variants, etc.) that we could use to pilot this.

Be specific with file paths. I want to understand the full data flow from UI click → Redux action → GraphQL mutation → database write.
```

---

## Prompt 2: Teacher Progress Nudge System
> **Gap:** +1.89% math progress from teacher nudges (N≈3M) — zero product implementation. Biggest evidence gap.
> **Effort:** Medium — new system, but teacher dashboard exists.
> **Research:** [[behavioral-nudges-education]] §Teacher-Facing Nudges, [[paper-nudge-math-megastudy-2025]].

```
I need to understand the Marvin teacher dashboard and data pipeline to design a teacher nudge system.
Research context: a megastudy (N≈3M) found that personalized, data-driven email nudges to teachers boosted student math progress by 1.89%. The most effective nudges combined loss aversion framing, social norm benchmarks, and actionable progress data.

Tasks:
1. Find the teacher dashboard implementation — what components render the teacher view? What data does it currently display (per-student progress, class-level aggregates, pacing info)?
2. Trace the data pipeline: where does student progress/mastery data live? Is there a GraphQL query that exposes per-student skill mastery, skills/week pace, or streak data that we could surface in a nudge?
3. Find any existing notification/email system in the codebase. Is there a mailing service, notification queue, or scheduled job infrastructure? Check for SendGrid, SES, or similar integrations.
4. Look for any cron job or scheduled task infrastructure (AWS Lambda, EventBridge, CloudWatch Events) that could trigger weekly nudge generation.
5. Find the Unleash feature flag setup — how are flags structured for teacher vs student features? Is there precedent for teacher-facing feature flags?
6. Check the analytics/telemetry layer: is there existing event tracking for teacher dashboard views or teacher actions that we could use to measure nudge effectiveness?
7. Find the student-level data model: what fields exist on the student record that relate to pacing, mastery velocity, or engagement frequency?

I need enough context to draft a technical design for: "Weekly email to teachers listing students behind pace, with loss-aversion framing and actionable next steps."
```

---

## Prompt 3: Confidence × Performance Divergence Signal
> **Gap:** BrainBreak captures confidence, Learnosity captures performance — no signal connects them. Dunning-Kruger pattern documented in KST maps.
> **Effort:** Medium — data exists, needs computation layer.
> **Research:** [[metacognitive-reflection]], KST Mastery Maps Dunning-Kruger drop.

```
I need to build a "confidence × performance divergence" signal by combining BrainBreak confidence data with Learnosity assessment performance data.

Context:
- BrainBreak captures a 5-point confidence slider per student per session
- Learnosity captures correctness data per question attempt
- Research shows divergence (high confidence + low performance) is a learning risk signal
- KST Mastery Maps pilot documented Dunning-Kruger pattern: inflated self-assessment Week 1, corrected by coach assessment Week 2

Tasks:
1. Find the BrainBreak data model: what table(s) store confidence values? What's the granularity (per-session, per-skill, per-question)? Show me the schema.
2. Find the Learnosity result data: where do assessment results land? Is there a Learnosity result fetcher (LRF Lambda)? What fields are available — correctness, time-spent, attempt-count, skill-tag?
3. Find the GraphQL schema for both data sources — is there already a query that joins student confidence with performance, or are they in separate bounded contexts?
4. Trace the inference engine: does Marvin's KT (knowledge tracing) model already compute an ability estimate or mastery probability per skill? Where does that live?
5. Find any existing "alert" or "flag" system — is there infrastructure for surfacing student-level signals to teachers (e.g., "student is struggling", "student hasn't logged in")?
6. Evaluate: what's the simplest path to compute confidence - performance divergence? Options:
   a. Backend computation in the GraphQL resolver layer
   b. Scheduled Lambda that pre-computes and stores divergence scores
   c. Client-side computation in the teacher dashboard
7. Check: is there student identity linkage between BrainBreak records and Learnosity assessment records? (studentId, userId, etc.)

I want a concrete plan for: "Flag students whose confidence is consistently higher than their performance, surface this to teachers."
```

---

## Prompt 4: Insight Recall Forward-Priming MVP
> **Gap:** iRec paper describes context-triggered retrieval of personal insights. Maintenance ring designed but insight capture mechanism missing.
> **Effort:** Medium — needs capture (BrainBreak) + storage + trigger logic.
> **Research:** [[metacognitive-reflection]] §Just-in-time Recall, iRec paper (Hou & Tan 2025).

```
I want to prototype an "Insight Recall" system where student insights captured during BrainBreak are re-surfaced when contextually relevant in future practice sessions.

Research context: the iRec paradigm (Hou & Tan 2025) shows that context-triggered retrieval of personal insights — "you figured out last time that X works" — is more effective than generic review prompts. This would power the Maintenance ring in the Three-Ring mastery system.

Tasks:
1. Find BrainBreak's GraphQL mutation — what free-text or structured fields exist in the submission payload? Is there any open-ended response field, or is it all structured (emotion + confidence)?
2. Find the Learnosity practice session flow: when a student starts a practice session, what data is loaded? Is there a "pre-session" hook or context provider where we could inject a relevant past insight?
3. Look for any existing "hint" or "tip" system in the practice problem UI — is there infrastructure for showing contextual messages to students during practice?
4. Find the skill/concept tagging system: how are Learnosity questions tagged to skills? Is there a skill ID or concept ID on each question that we could use for relevance matching?
5. Check the BrainBreak recording infrastructure: if we added an optional "what clicked?" text field, where would it be stored? What's the max reasonable field size?
6. Find the Unleash feature flag for BrainBreak — could we gate the insight capture field behind a feature flag for a pilot?
7. Look for any existing "review" or "recall" mechanism in the spaced repetition / maintenance system — is there code that surfaces previously-mastered skills for review?

I want to understand the minimum viable path for: "Student writes an insight during BrainBreak → system stores it tagged to the skill → next time they practice that skill, the insight is shown as a pre-session prompt."
```

---

## Prompt 5: Skill Graph Prerequisite Validation
> **Gap:** Skill Trees paper (Bijl 2025) formalizes competency as DAG traversal. TTO's skill map exists but prerequisite integrity is unverified.
> **Effort:** High — needs data pipeline + validation logic + visualization.
> **Research:** [[skill-tree-competency-structure]], [[knowledge-graph-education]].

```
I need to investigate TTO's skill prerequisite structure to evaluate the feasibility of Path C (prerequisite-graph-driven spaced repetition review).

Research context: the Skill Trees paper (Bijl 2025) formalizes competency progression as DAG (Directed Acyclic Graph) traversal and identifies three structural properties that predict student success: acyclicity (no circular dependencies), coverage (all skills reachable), and coherence (prerequisites actually help with the target skill).

The Three-Ring system's Path C — "skills surface when due AND needed for upcoming skill" — requires a clean prerequisite graph.

Tasks:
1. Find the skill/concept data model: where is TTO's skill map stored? Is it in a database table, a config file, or a GraphQL schema? Show me the schema including any prerequisite/dependency fields.
2. Find the skill assessment flow: when a student is assigned a skill, how is the "next skill" determined? Is there a placement algorithm, prerequisite check, or learning path logic?
3. Look for any existing graph/DAG utilities in the codebase — adjacency lists, topological sort, cycle detection. Check for libraries like dagre, graphlib, or custom implementations.
4. Find the Marvin GraphQL skill-related queries: what fields are exposed per skill? Is there a prerequisite list, skill group/topic, or ordering field?
5. Check the inference engine: does the KT model use prerequisite structure as input, or is it purely sequential/historical?
6. Look for any skill dependency or prerequisite data in the database migrations (Flyway) — schema evolution might reveal the history of how prerequisites were modeled.
7. Find any dashboard or admin UI for managing skills — is there a curriculum management interface where prerequisites are edited?

I need to answer: "Does TTO have a structured prerequisite map of skills? Is it a DAG? How clean is it?" — this determines whether Path C is feasible.
```

---

## Prompt 6: Struggle Detection → Adaptive Nudge Timing
> **Gap:** No engineering connection between KT model outputs and intervention triggers. Practice ring has adaptive credit but no *nudge* logic.
> **Effort:** Medium-High — needs KT → classification → trigger pipeline.
> **Research:** [[productive-struggle]], [[knowledge-tracing]].

```
I want to understand how we could build a "struggle detection → adaptive nudge" pipeline that distinguishes productive struggle (keep going) from unproductive struggle (intervene).

Research context: productive struggle research shows the difference between learning gains and disengagement is often a thin line. Nudging too early short-circuits the cognitive benefit; nudging too late means the student has already disengaged. The key signals are: attempt patterns, time-on-task trajectory, correctness trend, and emotional state.

Tasks:
1. Find the KT/knowledge tracing model implementation: what inputs does it consume? What outputs does it produce? Is it BKT, DKT, or custom? Where does it run (Lambda, batch, real-time)?
2. Find Learnosity's attempt-level data: can we access per-question time-spent, attempt count, and correctness sequence (not just final score)? Show me the data fetch path.
3. Find the BrainBreak emotional state data: is emotion data queryable per-student over time? Could we combine emotion + attempt pattern to classify struggle type?
4. Look for any existing "intervention" or "alert" system — teacher alerts, student messages, in-app notifications. What infrastructure exists for triggering actions based on student state?
5. Find the practice session state machine: what states does a practice session go through? (active, paused, completed, abandoned?) Where are transitions logged?
6. Check the experiment/observability infrastructure: can we log a "struggle classification" event without shipping a full feature? What's the path to instrument and evaluate before building the nudge trigger?
7. Find the Three-Ring practice ring credit logic (if implemented): the adaptive credit weighting (wrong→wrong→right = 1.2x) — where does this live? It's the foundation for struggle detection.

I want a plan for: "Instrument attempt patterns + emotion data → classify struggle type in real-time → trigger or suppress nudge based on classification."
```

---

## Prompt 7: Growth Mindset ≠ Self-Efficacy — Proximal Target Selection
> **Gap:** Macnamara 2023 meta-analysis shows generic growth mindset has near-zero achievement effect. Must target proximal constructs (self-efficacy, math identity, math anxiety).
> **Effort:** Low-Medium — reframing existing prompts/UX, not new infrastructure.
> **Research:** [[growth-mindset]], [[math-anxiety]], [[math-identity]], [[self-determination-theory]].

```
I need to audit the Marvin codebase for any existing "growth mindset" messaging, motivational prompts, or encouragement patterns, and evaluate them against research that shows generic growth mindset interventions have near-zero achievement effects.

Research context:
- Macnamara 2023 meta-analysis: growth mindset interventions show near-zero effects when design flaws controlled
- Effective targets are PROXIMAL constructs: self-efficacy ("I can do this specific type of problem"), math identity ("I'm someone who can learn math"), math anxiety reduction
- Self-determination theory: autonomy support (student choice) > generic encouragement
- SDT meta-analysis (36 studies): autonomy support is the key active ingredient, not generic motivation messaging

Tasks:
1. Search the codebase for any hardcoded motivational messages, encouragement strings, or "you can do it" type content. Check:
   - UI text constants / i18n strings
   - BrainBreak response text
   - Practice session feedback messages
   - Dashboard celebration text
   - Onboarding messaging
2. Find any "streak" or "celebration" UI text — how is achievement framed? Is it generic ("Great job!") or specific ("You mastered negative numbers!")?
3. Look for student-facing messaging that implies fixed traits vs. effort/process framing. The research says to frame around specific strategies and effort, not inherent ability.
4. Check if there's any math anxiety assessment or screening — is anxiety captured anywhere in the student profile or BrainBreak data?
5. Find any "autonomy support" patterns — do students get choices (which skill to practice, when to take breaks, difficulty level)? Or is everything teacher/system-directed?
6. Look for any existing A/B tests on messaging framing — are there experiment variants for different encouragement styles?

I want a report card: "Which motivational messages in Marvin are aligned with research, which are misaligned (generic growth mindset), and what are the quick wins for reframing?"
```

---

## Usage Notes

### Before Running a Prompt
1. **Read the research concept page** linked in each prompt header first — the prompt assumes you know the evidence base
2. **Check the bridge page** [[research-to-product-bridge]] for the full validation/gap context
3. **Run from repo root** — prompts reference file paths relative to the marvin monorepo

### After Running a Prompt
1. **Save the output** as a wiki source page in `wiki/sources/` — name it `claude-code-investigation-{topic}-{date}.md`
2. **Cross-reference** against the bridge page — update the gap status if the investigation reveals the gap is smaller/larger than estimated
3. **Iterate** — most prompts will reveal follow-up questions. Run a second pass with the refined context

### Prioritization

Based on the opportunity map in [[research-to-product-bridge]]:

| Priority | Prompt | Why |
|----------|--------|-----|
| **1st** | Prompt 1 (Planning in BrainBreak) | Highest impact/lowest effort. Single UI step addition. |
| **2nd** | Prompt 7 (Mindset Audit) | Quick win — find and fix misaligned messaging. No new code. |
| **3rd** | Prompt 3 (Confidence Divergence) | Data already exists. Needs computation layer. |
| **4th** | Prompt 2 (Teacher Nudges) | Biggest effect size (+1.89%) but needs new system. |
| **5th** | Prompt 4 (Insight Recall MVP) | Depends on Prompt 1 (capture mechanism). |
| **6th** | Prompt 6 (Struggle Detection) | Depends on KT model access + data pipeline. |
| **7th** | Prompt 5 (Skill Graph Validation) | Needed for Path C but highest effort. Run after others. |

---

## Related

- [[research-to-product-bridge]] — Gap analysis and opportunity map (this page's source of truth)
- [[three-ring-mastery-system]] — Product container for all ring-related features
- [[metacognitive-reflection]] — ES=1.11 — the single largest effect size across all clusters
- [[behavioral-nudges-education]] — Nudge taxonomy + TTO application design
- [[productive-struggle]] — Practice ring foundation
- [[knowledge-tracing]] — Student modeling infrastructure
- [[brainbreak-mvc-refactor]] — BrainBreak state management context
- [[learnosity]] — Assessment data source
- [[unleash]] — Feature flag rollout
- [[self-regulated-learning]] — Theoretical container (SRL cycle)
- [[growth-mindset]] — Near-zero effects — why proximal targets matter
- [[math-anxiety]] — Longitudinal STEM gatekeeper
- [[skill-tree-competency-structure]] — DAG traversal formalization

---

*These prompts are living documents. Update them as codebase investigation reveals new integration points or constraints. Last updated: 2026-05-10.*
