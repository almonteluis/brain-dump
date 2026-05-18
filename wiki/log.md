---
description: Processing log — track what has been ingested into the wiki
tags:
  - session/log
  - wiki
  - meta
created: 2026-04-08
---

## [2026-05-12] ingest | Project ATLAS Concept Paper — 1 source, 2 new concepts, 5 updated concepts

Processed `raw/Project Atlas.md` (PDF++ highlights with personal annotations from ATLAS Concept Paper 23-Pager). Project ATLAS is New Classrooms' AI-native intelligence layer for Teach to One Roadmaps.

### New Source Pages (1)

| Source           | Wiki Page         | Type                                                                                       |
| ---------------- | ----------------- | ------------------------------------------------------------------------------------------ |
| Project Atlas.md | [[project-atlas]] | ATLAS concept paper — AI-native intelligence layer (sequencing + instruction + assessment) |

### New Concept Pages (1)

| Concept                | Description                                                                                                    |
| ---------------------- | -------------------------------------------------------------------------------------------------------------- |
| [[predecessor-skills]] | Foundational competencies predicting Algebra 1 success; 13% → 58% targeting insight from [[Unlocking Algebra]] |

### Updated Concept Pages (5)

| Concept                                | Change                                                |
| -------------------------------------- | ----------------------------------------------------- |
| [[competitive-landscape-teach-to-one]] | Added ATLAS intelligence layer section                |
| [[three-ring-mastery-system]]          | Added ATLAS connection to feature concept             |
| [[competency based learning]]          | Added ATLAS source                                    |
| [[insight-recall]]                     | Added ATLAS source (spaced insight-recall annotation) |
| [[knowledge-tracing]]                  | Added ATLAS source (competency inference)             |

### Key Annotations Extracted

Luis's personal highlights surfaced 5 ideas beyond the paper:
1. Spaced insight-recall for predecessor skills across grade levels
2. Metacognitive exit slips saved for future skill encounters
3. Interactive curiosity-sparking content (med school dashboard pattern)
4. Students teaching students via reciprocal peer tutoring
5. LLM-based reasoning assessment → adaptive re-routing

## [2026-05-11] ingest | Operation Endgame CBL Research — 3 sources, 9 new concepts, 3 new entities, 16 updated concepts

Processed 3 CBL research notes from `raw/` as part of Operation Endgame — a Spring 2026 co-design prototype for competency-based learning with North Dakota teachers. Each note covers one pillar of the CBL framework.

### New Source Pages (3)

| Source | Wiki Page | Type |
|--------|-----------|------|
| cbl-assessing-demonstrations.md | [[cbl-assessing-demonstrations]] | CBL Pillar 1: performance-based assessment, formative assessment, equity |
| cbl-knowledge-frontier.md | [[cbl-knowledge-frontier]] | CBL Pillar 2: ZPD, KST, BKT/DKT, adaptive sequencing |
| cbl-differentiated-support.md | [[cbl-differentiated-support]] | CBL Pillar 3: differentiated instruction, scaffolding, AI tutoring, CRP |

### New Concept Pages (9)

| Concept | Description |
|---------|-------------|
| [[competency based learning]] | Three-pillar CBL framework; transparent targets, mastery-gated progression, continuous assessment; SDT alignment |
| [[formative-assessment]] | Black & Wiliam (1998), Hattie (2009) effect sizes; continuous low-stakes demonstration in CBL |
| [[performance-based-assessment]] | Stiggins (2005), Tobón (2020); portfolios, rubric design, multiple evidence types |
| [[zone-of-proximal-development]] | Vygotsky (1978); three zones (below/within/beyond); maps to productive struggle states |
| [[knowledge-space-theory]] | Doignon & Falmagne; knowledge states, learning spaces, ALEKS implementation |
| [[deep-knowledge-tracing]] | Piech et al. (2015); LSTM architecture, BKT comparison, later variants (SAKT/SAINT/AKT) |
| [[differentiated-instruction]] | Tomlinson (1999); readiness/interest/learning profile → content/process/product/environment |
| [[scaffolding]] | Wood/Bruner/Ross (1976); Van de Pol (2010); Belland (2017, g≈0.50); four types |
| [[culturally-responsive-pedagogy]] | Ladson-Billings (1995); academic achievement, cultural competence, sociopolitical consciousness |

### New Entity Pages (3)

| Entity | Description |
|--------|-------------|
| [[vygotsky]] | Lev Vygotsky: ZPD, social constructivism, scaffolding origins |
| [[tomlinson]] | Carol Ann Tomlinson: differentiated instruction framework |
| [[ladson-billings]] | Gloria Ladson-Billings: culturally relevant pedagogy |

### Existing Concept Pages Updated (16)

| Page | Changes |
|------|---------|
| [[skill-tree-competency-structure]] | Added CBL assessment section: DAG enables automated gap detection |
| [[three-ring-mastery-system]] | Added mastery stages as assessment milestones |
| [[insight-recall]] | Added metacognitive assessment extending beyond content mastery |
| [[reverse-scoring]] | Added psychometric validity for affective measures in CBL |
| [[adaptive-feedback-education]] | Added process-level feedback at knowledge frontier |
| [[knowledge-tracing]] | Added DKT extension, CBL frontier targeting connection |
| [[productive-struggle]] | Added ZPD mapping: frontier location → struggle state table |
| [[ai-math-tutoring]] | Added multi-skill problems as frontier diagnostics |
| [[cognitive-load]] | Added cognitive load estimation for personalized path generation |
| [[self-determination-theory]] | Added CBL naturally satisfies all three SDT needs |
| [[math-anxiety]] | Added CBL mastery orientation as protective against performance-goal anxiety |
| [[math-identity]] | Added teacher positioning in CBL contexts |
| [[behavioral-nudges-education]] | Added nudges as scalable differentiated support mechanism |
| [[ai-math-tutoring]] | Added human-AI copilot as differentiated support delivery |
| [[productive-struggle]] | Added emotional vs cognitive scaffolding equally important |
| [[adaptive-feedback-education]] | Added process-level feedback at frontier boundary |

### Raw Files Tagged
- `raw/cbl-assessing-demonstrations.md` — tagged `ingested: true`, `cluster: operation-endgame`
- `raw/cbl-knowledge-frontier.md` — tagged `ingested: true`, `cluster: operation-endgame`
- `raw/cbl-differentiated-support.md` — tagged `ingested: true`, `cluster: operation-endgame`

### Graphify
- Rebuilt: 1,382 nodes, 1,819 edges, 134 communities (markdown wiki pages included)

### Key Insights for Operation Endgame

1. **CBL naturally satisfies all three SDT needs** — autonomy (choice in pace), competence (mastery-gated advancement), relatedness (teacher relationships)
2. **ZPD maps directly to three struggle states** — below frontier = coasting, within = productive struggle, beyond = flailing
3. **Multi-skill combination problems are ideal frontier diagnostics** — accuracy ≈ accuracy² makes them sensitive to partial mastery
4. **Scaffolding has a robust effect size** — Belland meta-analysis g ≈ 0.50; four types (conceptual, strategic, metacognitive, motivational)
5. **Culturally responsive pedagogy is structural, not additive** — CRP + CBE in NYC Competency Collaborative shows integration, not layering
6. **Knowledge Space Theory provides the mathematical formalism** — prerequisite relationships between competencies enable automated gap detection
7. **Formative assessment effect sizes dwarf summative** — d=0.90 (formative) vs typical summative; CBL is fundamentally formative

---

## [2026-05-10] synthesis | Claude Code Prompts for Research Implementation — 7 investigation prompts

Created [[claude-code-prompts-research-implementation]] with 7 ready-to-paste Claude Code prompts targeting the gaps and opportunities identified in [[research-to-product-bridge]]. Each prompt is grounded in specific research evidence and targets a concrete codebase investigation.

### Prompts Created

| # | Target | Research Basis | Effort |
|---|--------|---------------|--------|
| 1 | Planning prompt in BrainBreak | Tolvanen 2025 (f=221), ES=1.11 | Low |
| 2 | Teacher progress nudge system | Zearn megastudy, +1.89% (N≈3M) | Medium |
| 3 | Confidence × performance divergence | Dunning-Kruger from KST maps | Medium |
| 4 | Insight Recall forward-priming MVP | iRec paper + transfer research | Medium |
| 5 | Skill graph prerequisite validation | Bijl 2025 DAG formalization | High |
| 6 | Struggle detection → adaptive nudge | Productive struggle + KT signals | Medium-High |
| 7 | Growth mindset → proximal target audit | Macnamara 2023 near-zero effects | Low-Medium |

### Files Changed
- Created `wiki/synthesis/claude-code-prompts-research-implementation.md`
- Updated `wiki/index.md` — added synthesis entry
- Linked from `wiki/synthesis/research-to-product-bridge.md` (was dangling reference)

---

## [2026-05-10] ingest | TTO Research Clusters F+G — 16 sources, 11 new concepts, 4 updated concepts

Processed 16 paper notes from `raw/` across two research clusters: Motivation Theories (12) and Spaced Retrieval/Fluency (4). Framed for Teach to One / New Classrooms broadly.

### New Source Pages (16)

**Cluster F — Motivation Theories:**

| Source | Wiki Page | Type |
|--------|-----------|------|
| paper-achievement-goal-profiles-math-2023.md | [[achievement-goal-profiles-math-2023]] | LPA of achievement goal profiles; instructional quality moderates |
| paper-evt-achievement-goals-2025.md | [[evt-achievement-goals-2025]] | 6 homework motivation profiles integrating AGT + EVT + SRL (N=1,256) |
| paper-evt-math-profiles-2024.md | [[evt-math-profiles-2024]] | EVT profiles shift during secondary-to-tertiary STEM transition |
| paper-growth-mindset-chinese-math-2023.md | [[growth-mindset-chinese-math-2023]] | Chain mediation: mindset → self-efficacy → intrinsic motivation |
| paper-growth-mindset-differentiation-2025.md | [[growth-mindset-differentiation-2025]] | Mathematical mindset ≠ growth mindset ≠ self-efficacy |
| paper-growth-mindset-meta-analysis-2023.md | [[growth-mindset-meta-analysis-2023]] | Near-zero effects when design flaws controlled (Macnamara) |
| paper-math-anxiety-stem-choices-2024.md | [[math-anxiety-stem-choices-2024]] | 3-year longitudinal: anxiety vs self-efficacy STEM pathways |
| paper-math-identity-instrument-2023.md | [[math-identity-instrument-2023]] | First validated group-administrable math identity measure (grades 5–12) |
| paper-sdt-math-outcomes-2026.md | [[sdt-math-outcomes-2026]] | SDT need-satisfaction → lower anxiety, more STEM major choice |
| paper-sdt-meta-analysis-2024.md | [[sdt-meta-analysis-2024]] | 36-study meta-analysis: autonomy support is key active ingredient |
| paper-sdt-online-math-2024.md | [[sdt-online-math-2024]] | SDT-based online math: competence/relatedness improved, autonomy harder digitally |
| paper-teacher-positioning-math-identity-2023.md | [[teacher-positioning-math-identity-2023]] | Teacher positioning → math identity via problem-solving flexibility |

**Cluster G — Spaced Retrieval / Fluency:**

| Source | Wiki Page | Type |
|--------|-----------|------|
| paper-spaced-retrieval-calculus-desirable-difficulty-2022.md | [[spaced-retrieval-calculus-desirable-difficulty-2022]] | Desirable difficulty: worse quizzes, better final exams |
| paper-spaced-retrieval-nine-STEM-courses-2024.md | [[spaced-retrieval-nine-STEM-courses-2024]] | 9-course within-subjects: 3–5% precalculus gains |
| paper-math-fact-fluency-high-schoolers-2024.md | [[math-fact-fluency-high-schoolers-2024]] | High schoolers = professionals for fluency delivery |
| paper-multiplication-fact-fluency-intervention-modality-2024.md | [[multiplication-fact-fluency-intervention-modality-2024]] | iPad = peer tutoring; retrieval practice is the active ingredient |

### New Concept Pages (11)

| Concept | Description |
|---------|-------------|
| [[growth-mindset]] | Near-zero achievement effects; construct differentiation from self-efficacy and math identity; proximal mediator targeting |
| [[self-determination-theory]] | Three basic needs; 36-study meta-analysis validates autonomy support as key lever; digital autonomy challenge |
| [[math-anxiety]] | Longitudinal STEM gatekeeper; anxiety pushes away from STEM, self-efficacy pulls toward; SDT reduction pathway |
| [[math-identity]] | Validated instrument grades 5–12; teacher positioning co-construction; problem-solving flexibility mediator |
| [[achievement-goal-theory]] | Mastery vs performance goals; latent profile approaches; instructional quality moderation |
| [[expectancy-value-theory]] | Five EVT constructs; profile instability during secondary-tertiary transition |
| [[motivational-profiles]] | Person-centered approach; multi-theory integration; 5–6 distinct profiles |
| [[desirable-difficulty]] | Bjork's framework; spacing as productive short-term cost; motivation framing implications |
| [[math-fact-fluency]] | Definition; intervention evidence; digital delivery validated; translation gap |
| [[spaced-retrieval-practice]] | Classroom-level evidence; 3–5% precalculus gains; context-dependent effects |
| [[peer-tutoring-math]] | Cross-age and reciprocal models; modality equivalence; social motivation angle |

### Existing Pages Updated (4)

| Page | Changes |
|------|---------|
| [[self-regulated-learning]] | Added 3 source references; 6 motivation framework cross-links; 4 motivation cross-links |
| [[productive-struggle]] | Added 4 motivation cross-links |
| [[spaced-repetition]] | Added STEM Classroom Evidence section (Lyle et al. + Bego et al.); added desirable-difficulty and spaced-retrieval-practice links |
| [[forgetting-curve]] | Added classroom validation section connecting spaced retrieval to decay predictions |

### Key Insights for TTO

1. **Growth mindset alone is near-zero** on achievement — target proximal constructs (self-efficacy, math anxiety) instead
2. **SDT has the strongest intervention evidence** — autonomy support is the key active ingredient across 36 studies
3. **Motivation is heterogeneous** — 5–6 distinct profiles; one-size-fits-all interventions miss subgroups
4. **Math identity ≠ growth mindset ≠ self-efficacy** — conflating them leads to muddled outcomes
5. **Math anxiety is the STEM gatekeeper** — 3-year longitudinal evidence; middle school is the intervention window
6. **Autonomy is hardest to achieve digitally** — requires intentional scaffolding in online math contexts
7. **Spaced retrieval creates desirable difficulty** — students feel worse during practice but retain more long-term
8. **Retrieval practice is the active ingredient, not modality** — iPad flashcards = peer tutoring for fluency

---

## [2026-05-10] ingest | TTO Research Clusters D+E — 6 sources, 1 new concept, 2 updated concepts

Processed 6 paper notes from `raw/` across two research clusters: Behavioral Nudges (3) and Metacognition/Self-Regulation (3). Framed for Teach to One / New Classrooms broadly.

### New Source Pages (6)

**Cluster D — Behavioral Nudges:**

| Source | Wiki Page | Type |
|--------|-----------|------|
| paper-nudge-meta-synthesis-2025.md | [[nudge-meta-synthesis-2025]] | Meta-synthesis — nudge taxonomy + design principles |
| paper-streaks-math-engagement.md | [[streaks-math-engagement]] | RCT — streaks boost engagement + achievement |
| paper-nudge-math-megastudy-2025.md | [[nudge-math-megastudy-2025]] | Megastudy — teacher nudges +1.89% math progress (N≈3M) |

**Cluster E — Metacognition / Self-Regulation:**

| Source | Wiki Page | Type |
|--------|-----------|------|
| paper-metacognition-math-modeling-computational-thinking-2024.md | [[metacognition-math-modeling-ct-2024]] | Causal chain: metacognition → CT → math modeling |
| paper-metacognitive-skills-math-problem-solving-2025.md | [[metacognitive-skills-math-problem-solving-2025]] | Structured prompts enhance metacognition |
| paper-metacognitive-instruction-meta-analysis-2025.md | [[metacognitive-instruction-meta-analysis-2025]] | PRISMA meta-analysis — ES=1.11 math, ES=1.27 other |

### New Concept Page (1)

| Concept | Description |
|---------|-------------|
| [[behavioral-nudges-education]] | Nudge taxonomy (informational/social/temporal/choice architecture), evidence base, design principles, intensive vs extensive margin, TTO applications, risks |

### Existing Pages Updated (2)

| Page | Changes |
|------|---------|
| [[metacognitive-reflection]] | Added evidence base (ES=1.11), causal chain section (metacognition → CT → math modeling), enriched explicit prompts with Tolvanen 2025 findings, added 3 sources + 3 cross-links |
| [[self-regulated-learning]] | Added evidence for metacognitive instruction section, enriched SRL scaffolding target with prompt findings, added causal chain, added 3 sources + 2 cross-links |
| [[index]] | Added 3 concept entries + 6 source entries under Learning Science section |

### Key Insights for TTO

1. **Streaks are proven** — RCT shows streaks increase both engagement AND math achievement; loss aversion is the mechanism
2. **Personalized data > generic nudges** — Duckworth megastudy (N≈3M): teacher nudges referencing classroom-specific data significantly outperform generic reminders
3. **Intensive vs extensive margin** — streaks keep active users engaged; reminders activate new users. Dual strategy needed.
4. **Nudge design principles** — timeliness, personalization, workflow embedding, multi-strategy combination, actionability, heterogeneous treatment
5. **Metacognitive instruction has massive effect sizes** — ES=1.11 for math achievement, ES=1.27 for other outcomes. Rare in education research.
6. **Causal chain identified** — metacognition → critical thinking → mathematical modeling. CT bridges awareness and applied problem-solving.
7. **Structured prompts dramatically enhance metacognition** — math problems alone activate some, but embedded reflective prompts (goal-setting + planning) massively amplify planning, monitoring, evaluation.
8. **Goal-setting + actionable planning > superficial performance goals** — "I'll use substitution first" beats "I want a good grade"

---

## [2026-05-10] ingest | TTO Research Clusters A+B+C — 13 sources, 7 new concepts, 2 updated concepts

Processed 13 paper notes from `raw/` across three research clusters: AI/Math Education (7), Knowledge Tracing/Skill Maps (4), and Productive Struggle (2). All framed for Teach to One / New Classrooms product research broadly.

### New Source Pages (13)

**Cluster A — AI/Math Education:**

| Source | Wiki Page | Type |
|--------|-----------|------|
| paper-tutor-copilot-2025.md | [[tutor-copilot-2025]] | RCT — human-AI tutoring |
| paper-genai-math-meta-analysis-2026.md | [[genai-math-meta-analysis-2026]] | Meta-analysis (22 studies, N=5,232) |
| paper-ai-difficult-math-questions.md | [[ai-difficult-math-questions]] | MATH² multi-skill problem generation |
| paper-mathedu-adaptive-feedback-2025.md | [[mathedu-adaptive-feedback-2025]] | Process-level feedback dataset |
| paper-llm-education-systematic-review-2025.md | [[llm-education-systematic-review-2025]] | Systematic review (88 studies) |
| paper-ai-math-tutoring-2025.md | [[ai-math-tutoring-2025]] | Multi-agent tutoring platform |
| paper-its-llm-motivational-feedback-2025.md | [[its-llm-motivational-feedback-2025]] | ITS-LLM architecture |

**Cluster B — Knowledge Tracing/Skill Maps:**

| Source | Wiki Page | Type |
|--------|-----------|------|
| paper-skill-trees-competency-2025.md | [[skill-trees-competency-2025]] | Formal competency DAGs |
| paper-deep-learning-knowledge-tracing-2025.md | [[deep-learning-knowledge-tracing-2025]] | DLKT vs BKT comparison |
| paper-bkt-fairness-math-2025.md | [[bkt-fairness-math-2025]] | BKT fairness by reading ability |
| paper-knowledge-graph-education-slr-2024.md | [[knowledge-graph-education-slr-2024]] | SLR of KGs in education |

**Cluster C — Productive Struggle:**

| Source | Wiki Page | Type |
|--------|-----------|------|
| paper-productive-struggle-ai-bellwether.md | [[productive-struggle-ai-bellwether]] | AI design for struggle |
| paper-productive-struggle-students.md | [[productive-struggle-students]] | Student perceptions study |

### New Concept Pages (7)

| Concept | Description |
|---------|-------------|
| [[ai-math-tutoring]] | AI-powered math tutoring: human-AI copilot to autonomous platforms, multi-agent architectures, adaptive difficulty |
| [[adaptive-feedback-education]] | Process-level feedback on student reasoning; teacher-quality benchmarks; instructional/motivational/diagnostic feedback types |
| [[its-llm-architecture]] | ITS + LLM integration pattern; modular architecture for motivational and instructional feedback generation |
| [[skill-tree-competency-structure]] | Formal prerequisite DAGs (acyclicity, coverage, coherence) enabling automated coaching and gap detection |
| [[knowledge-graph-education]] | KGs in education: personalized learning, curriculum design, content recommendation, learning analytics |
| [[bkt-fairness]] | Algorithmic fairness in BKT: reading ability confounds math mastery estimates by ~9 p.p. |
| [[productive-struggle]] | Effortful grappling → deeper understanding; cognitive + emotional scaffolding; AI must preserve struggle |

### Existing Pages Updated

| Page | Changes |
|------|---------|
| [[knowledge-tracing]] | Added 2 sources, 3 cross-links (bkt-fairness, knowledge-graph-education, skill-tree-competency-structure) |
| [[three-ring-mastery-system]] | Strengthened Practice Ring productive struggle section with research backing (emotional scaffolding, AI design principles) |
| [[index]] | Added 7 concept entries + 13 source entries under Learning Science section |

### Key Insights for TTO

1. **Human-AI tutoring beats pure AI** — Tutor CoPilot RCT shows +9 p.p. for struggling students when AI augments human facilitators
2. **GenAI reduces math anxiety** — Meta-analysis confirms low-stakes AI practice = psychological safety for struggling learners
3. **Process-level feedback > answer-level** — LLMs can generate teacher-quality feedback on *how* students reason
4. **ITS-LLM architecture is modular** — Motivational feedback generation is swappable; distinct from instructional feedback
5. **BKT has a fairness gap** — Emerging readers penalized ~9 p.p.; must model reading as separate skill in math systems
6. **Skill trees enable automated coaching** — Formal prerequisite DAGs with acyclicity/coverage/coherence properties
7. **Knowledge graphs underpin adaptive systems** — Prerequisite mapping, gap detection, content recommendation
8. **Productive struggle has two dimensions** — Emotional scaffolding (patience, normalizing difficulty) matters as much as cognitive scaffolding (hints, prompts)
9. **AI must preserve struggle** — Over-scaffolding (immediate answers) reduces cognitive engagement; design for just-in-time support

---

## [2026-05-06] synthesis | Convert INFERRED bridges to EXTRACTED — 2 new synthesis pages, 6 cross-links

Acted on graphify analysis from prior session. INFERRED `semantically_similar_to` bridges identified between communities are now backed by explicit synthesis pages + bidirectional cross-links in concept pages. Next ingest should re-classify these edges as EXTRACTED.

### New Synthesis Pages

| Page | Bridges | Purpose |
|------|---------|---------|
| [[speculative-data-as-state-machine]] | Experiment Speculative Data ↔ State Management | TEAME-287 root cause as state-machine problem; Path A/B/C refactor proposal |
| [[trust-boundaries-formal-verification-and-bloat]] | Formal Verification ↔ Dependency Bloat | Twin strategies for trust boundary problem; 5-tier code provenance framework |

### Cross-Links Added (INFERRED → EXTRACTED candidates)

| Page | Cross-link added |
|------|------------------|
| [[experiment-speculative-data]] | → state-management + speculative-data-as-state-machine |
| [[state-management]] | → experiment-speculative-data + speculative-data-as-state-machine |
| [[formal-verification]] | → dependency-bloat + trust-boundaries synthesis |
| [[dependency-bloat]] | → formal-verification + trust-boundaries synthesis |
| [[design-systems]] | → dependency-injection-nodejs-typescript (Design Patterns ↔ DI bridge) |
| [[dependency-injection-nodejs-typescript]] | → design-systems + react-patterns |

### Skipped (graph signal weak)

- Distributed Locking ↔ Ally Piechowski — INFERRED but not a real conceptual link; let next clustering downweight it
- React Concurrent Mode ↔ Event Loop — neither has a wiki concept page; defer until wiki has dedicated concurrency-primitives concepts
- Supply Chain Security ↔ JWT — INFERRED via Full App Embedding source page; weak

### Index Changes

- Added 2 entries under Synthesis section

### Why this matters

Two reasons to convert INFERRED → EXTRACTED:
1. **Graph fidelity** — EXTRACTED edges reflect documented relationships; INFERRED edges are AI guesses. Writing the cross-link upgrades the graph.
2. **Code quality leverage** — INFERRED semantic_similar_to edges often indicate duplicated code patterns or extractable abstractions. Making the relationship explicit in the wiki surfaces refactor candidates in the codebase.

For TEAME-287 specifically, the state-machine framing (Path A) is the recommended ship-now fix.

---

## [2026-05-05] query | 5 major themes from last 2 days

User asked for top 5 themes + takeaway from May 4-5 notes. Answered with five-theme breakdown, saved as synthesis page.

### New Synthesis Page

| Page | Description |
|------|-------------|
| [[may-4-5-2026-themes]] | Five themes: BrainBreak LTS bugs, dev-env friction, QA tooling, learning-product research, personal/wellness |

### Project Status Change

- Moved **TEAME-218: BrainBreak Feature** from [[Completed Work]] back to [[Active Projects]] as **TEAME-218: BrainBreak LTS Conversion** — feature shipped April 2026 but LTS conversion in progress, blocked on cooldown parser + speculative data bugs.

### Key Themes Surfaced

1. BrainBreak LTS close — Fix A + Fix B for cooldown parser, TEAME-287 speculative data, rehydration weirdness
2. Dev-env friction — Docker volume cross-platform pitfall, stale rebase, Marvin FE setup
3. QA + tooling self-evaluation — WezTerm 3-pane Playwright, axe linter ≈ 20% browser coverage
4. Learning-product research — math game eureka design, reverse scoring, knowledge tracing scholar search, TTO tier disconnect
5. Personal/wellness — meditation (Kobe), Type I/II fun, NBA playoffs, drinking rule

---

## [2026-05-05] lint | Health check
Found 4 errors, 462 warnings (orphan pages), 0 info items. Fixed all 4 errors.

### Errors (fixed)

| Broken link | Fixed to | Files |
|---|---|---|
| `brain-break-cooldown-system` | `cooldown-system` | `work-status-may-5-2026`, `caption-logs-may-4-2026`, `remaining-brain-break-tickets`, `reverse-scoring` |
| `remaining brain break tickets` | `remaining-brain-break-tickets` | `work-status-may-5-2026`, `caption-logs-may-4-2026`, `qa-fe-automation-local-workflow` |
| `TEAME-287` | `teame-287-speculative-data-created-bug` | `brainbreak-lts-cooldown-speculative-bugs` (2x) |
| `teame-218` | `teame-218-code-cleanup-lts-conversion` | `worktree-rebase-missed-flyway-migrations` |

### Warnings (expected)
- 462 orphan pages — concept/entity pages not heavily cross-linked yet. Normal for growing wiki.
- ~1750 red links to future expansion topics. Expected.

### Index consistency
All 19 recent pages have exactly 1 index entry. Clean.

---

## [2026-05-05] ingest | Marvin runbook + worktree gotcha — 2 sources, 1 new concept, 2 updated

Processed 2 new files from raw/. 2 new source pages, 1 new concept page, 2 existing pages updated.

### New Source Pages

| Source | Wiki Page | Type |
|--------|-----------|------|
| Marvin – Local Frontend Dev & Test User Setup.md | [[marvin-local-frontend-dev-setup]] | Runbook |
| Worktree Rebase Missed Flyway Migration Files.md | [[worktree-rebase-missed-flyway-migrations]] | Gotcha / diagnosis |

### New Concept Page

| Concept | Description |
|---------|-------------|
| [[git-rebase-hygiene]] | Always fetch before rebasing — cached origin/main is stale |

### Existing Pages Updated

| Page | Changes |
|------|---------|
| [[flyway]] | Added gotcha section: missing migrations after stale rebase |
| [[git-worktrees-parallel-work]] | Added fetch-before-rebase rule and worktree location guidance |

### Key Insights

1. **Marvin FE dev workflow** — run frontend outside Docker (`npm run dev:relay`) for hot-reload, stack in containers
2. **Grade selection hang** — documented as real bug as of May 5, not setup issue
3. **Rebase hygiene** — `git rebase origin/main` uses cached remote; stale `origin/main` = missing commits
4. **Worktree location** — inside vs outside repo doesn't affect git (same object DB); outside preferred for IDE separation

---

## [2026-05-05] ingest | BrainBreak LTS refined write-up — 2 sources, 2 updated concepts

Processed pasted markdown document: refined write-up of BrainBreak cooldown + speculative data bugs. More structured than voice memo. 2 new source pages, 2 concept pages updated, 1 source page cross-linked.

### New Source Pages

| Source | Wiki Page | Type |
|--------|-----------|------|
| BrainBreak LTS — Cooldown & Speculative Data Bugs (pasted) | [[brainbreak-lts-cooldown-speculative-bugs]] | Refined debug write-up |
| TEAME-287 | [[teame-287-speculative-data-created-bug]] | Work ticket |

### Existing Pages Updated

| Page | Changes |
|------|---------|
| [[cooldown-system]] | Added proposed Fix A + Fix B code, manual QA table, next steps checklist, link to refined source |
| [[experiment-speculative-data]] | Added TEAME-287 bug section: `created` column updated instead of `modified` |
| [[remaining-brain-break-tickets]] | Added link to refined write-up |

### Key Insights

1. **Fix A + Fix B must ship together** — Fix A (robust ISO parsing) alone leaves off-by-hours edge from Fix B (calendar-day arithmetic)
2. **Rehydration path has separate bug** — Redux state inconsistent (`hydrated: true` but no cooldown data) beyond parser issue
3. **TEAME-287 = insert vs update confusion** — `created` bumped on repeat instead of `modified`
4. **Placement fetch waste** — ~10 days of compute per student fetching placements for modal that can't render

---

## [2026-05-05] ingest | May 4–5 batch — 11 sources, 4 new concepts, 3 updated concepts

Processed 11 source files (skipped 3 empty Untitled files). 6 work sources, 5 personal sources. 4 new concept pages, 3 existing concept pages updated, index updated with Personal section.

### New Source Pages

**Work:**

| Source | Wiki Page | Type |
|--------|-----------|------|
| remaining brain break tickets.md | [[remaining-brain-break-tickets]] | Debug session / root cause analysis |
| Work status for May 5, 2026.md | [[work-status-may-5-2026]] | Daily status |
| Docker FE esbuild.exe error.md | [[docker-fe-esbuild-exe-error]] | Technical note |
| QA FE automation local workflow.md | [[qa-fe-automation-local-workflow]] | Personal workflow |
| Question for axetool linter.md | [[question-axe-linter]] | Tool evaluation |
| Research terms recap.md | [[research-terms-recap]] | Research note |

**Personal:**

| Source | Wiki Page | Type |
|--------|-----------|------|
| Captain's log, volume one.md | [[captains-log-volume-one]] | Journal / voice memo |
| Caption logs 5 4 2026.md | [[caption-logs-may-4-2026]] | Journal / voice memo |
| NBA Eastern Playoff 5-2-26.md | [[nba-eastern-playoff-may-2-2026]] | Sports commentary |
| Kobe Bryant meditation article | [[kobe-bryant-meditation-article]] | Article clipping |
| Crazy Tweets.md | [[crazy-tweets]] | One-liner |

### New Concept Pages

| Concept | Description |
|---------|-------------|
| [[math-problem-game]] | Abstraction tools trigger pattern-recognition eureka moments |
| [[meditation-practice]] | Daily silence routine: morning stillness, visualization, restorative mode |
| [[reverse-scoring]] | Invert scale direction to detect response bias in questionnaires |
| [[type-i-type-ii-fun]] | Fun taxonomy: enjoyable throughout vs hard now, rewarding later |

### Existing Pages Updated

| Page | Changes |
|------|---------|
| [[cooldown-system]] | Added Bug Analysis section: 4 bugs from debug session (broken parser, off-by-one, time-of-day eligibility, wasted compute) |
| [[axe-deque]] | Added IDE Linter vs Browser Extension comparison table |
| [[docker]] | Added cross-platform node_modules volume mount pitfall |

### Index Changes

- Added **Personal** section with 5 entries
- Added 6 work entries under Architecture Patterns
- Added 2 concepts under Product Concepts
- Added 2 concepts under Thinking Frameworks

---

## [2026-05-03] ingest | Learning Science cluster — 8 source pages + 5 concept pages + 4 entity pages

Processed 9 source files (skipped arxiv_2506_20156_1 dup). 8 new source pages, 5 new concept pages, 4 new entity pages, 1 existing concept page expanded with research-foundations cross-link section. Index updated with new Learning Science section.

### New Source Pages

| Source | Wiki Page | Type |
|--------|-----------|------|
| A Teacher's Guide To Spaced Repetition.md | [[teachers-guide-spaced-repetition]] | Pedagogical guide |
| Spaced repetition.md (Wikipedia) | [[spaced-repetition-wikipedia]] | Reference article |
| How we learn how you learn.md (Settles) | [[duolingo-half-life-regression]] | Industry research blog |
| Introducing the new Duolingo learning path.md | [[duolingo-new-learning-path]] | Product redesign blog |
| Duolingo Learning Strategy.md | [[duolingo-learning-strategy]] | Strategy synthesis |
| The Geometry of Learning Mapping the Evolution of Mastery through KSTs.md | [[geometry-of-learning-kst-mastery-maps]] | Case study |
| Practical Evaluation of Deep Knowledge Tracing Models.md | [[deep-knowledge-tracing-practical-evaluation]] | EDM 2025 industry paper (clipping) |
| arxiv_2506_20156.md (Hou & Tan 2025) | [[irec-metacognitive-scaffolding-arxiv]] | Conceptual research paper |
| The Psychology Behind Apple Watch.md | [[apple-watch-psychology-gamification]] | Behavioral science explainer |

### New Concept Pages

| Concept | Description |
|---------|-------------|
| [[spaced-repetition]] | Core SR concept with algorithm family, applications, critiques |
| [[forgetting-curve]] | Ebbinghaus's `p = 2^(-Δ/h)` exponential decay model |
| [[half-life-regression]] | Duolingo's trainable per-word HLR algorithm |
| [[knowledge-tracing]] | Modeling student mastery state (BKT/DKT/SAINT/AKT) |
| [[gamification]] | Game mechanics for non-game contexts + anti-patterns |

### New Entity Pages

| Entity | Description |
|--------|-------------|
| [[hermann-ebbinghaus]] | Forgetting curve discoverer (1880s) |
| [[sebastian-leitner]] | Leitner box system creator (1973) |
| [[paul-pimsleur]] | Graduated-interval recall pioneer (1967) |
| [[burr-settles]] | Duolingo Half-Life Regression author (ACL 2016) |

### Existing Pages Updated

| Page | Changes |
|------|---------|
| [[three-ring-mastery-system]] | Appended Research Foundations section linking 9 source + 5 concept + 4 entity pages with 8 key takeaways for ring design |
| [[index]] | Added Learning Science section under Product Concepts with concepts/sources/entities split |

### Skipped as Confirmed Duplicate

- arxiv_2506_20156_1.md → identical to arxiv_2506_20156.md except `captured_at` timestamp

### Key Insights

1. **Path B (empirical decay curves) is empirically grounded** — TTO has 6 years of data; can compute per-skill `h` without full ML infra (HLR-style) but with more accuracy than fixed Leitner intervals
2. **15-20min daily session is empirically optimal** per Duolingo — directly informs three-ring daily-fill cadence
3. **Practice ring rewards productive struggle** matches Manu Kapur's productive failure research and Apple Watch's "outcomes vary" finding (intrinsic motivation matters)
4. **Anti-pattern: time-on-task** — Duolingo + Apple Watch both warn against engagement metrics that don't correlate with learning outcomes
5. **"Practice as forward progress" reframing** (Duolingo path) avoids "going back" psychology — directly applicable to three-ring Maintain ring framing
6. **Dunning-Kruger drop** (KST C-7 pilot) — expect Week 1 self-assessment to inflate; coach assessment Week 2 corrects. Implication: ring viz should incorporate teacher correction moments.
7. **Depth vs breadth** (KST Laura Rivas case) — plateau in new skills can mask significant deepening; ring viz should surface both dimensions
8. **Irec critique of SRS as de-contextualized** — opens design space for context-triggered review beyond schedule-based decay (JITAI framework)
9. **HLR beat Leitner ~50% in error rate** at Duolingo scale (12M+ practice events) with 9.5% retention bump — strongest production validation of trainable SRS
10. **Knowledge graph as next mastery-tracking substrate** — Hoppenstedt's KST scatter plots → graphs is parallel to Irec's knowledge-graph-driven retrieval

---

## [2026-05-03] ingest | Work/Marvin cluster — 12 source pages + 4 concept pages

Processed 13 source files (folded TEAMF-539 into teamf-fe-package-updates) from the raw folder Work/Marvin cluster. 12 new source summaries, 4 new concept pages, 2 existing pages updated, Backlog updated, index updated.

### New Source Pages

| Source | Wiki Page | Type |
|--------|-----------|------|
| Local Development with Unleash.md | [[unleash-local-development-setup]] | Tool guide |
| Edit - Unleash One Pager - PRODUCT.md | [[unleash-one-pager-product]] | Team agreement |
| Feature Flagging One-Pager.md | [[feature-flagging-quick-reference]] | Quick reference |
| Accessibility - Marvin.md | [[accessibility-marvin-wcag]] | Work documentation |
| Using CloudWatch Logs Insights - Marvin.md | [[cloudwatch-logs-insights-queries]] | Tool reference |
| New Classrooms Tech Stack - Quality Assurance.md | [[nc-tech-stack-overview]] | Stack reference |
| How to run the QA frontend automated test workflow - Quality Assurance.md | [[qa-frontend-automated-test-workflow]] | Process / runbook |
| teamf FE Package updates.md + TEAMF-539 Dependabot.md | [[teamf-fe-package-updates]] | Work ticket (folded) |
| Learnosity incident 2026-02-24.md | [[learnosity-cdn-incident-2026-02-24]] | Incident post-mortem |
| 2026-05-01-SkillResource-Phase2-Extract-GraphQL-Hook.md | [[skill-resource-phase2-extract-graphql-hook]] | Refactor plan |
| 2026-05-01-SkillResource-Phase2-Extract-Modals-Hook.md | [[skill-resource-phase2-extract-modals-hook]] | Refactor plan |
| 2026-05-01-SkillResource-Phase2-Extract-Timeline-Hook.md | [[skill-resource-phase2-extract-timeline-hook]] | Refactor plan |

### New Concept Pages

| Concept | Description |
|---------|-------------|
| [[axe-deque]] | Deque axe-DevTools / axe Linter for WCAG accessibility testing |
| [[wcag-2-1]] | Web Content Accessibility Guidelines 2.1 (A/AA/AAA) |
| [[cloudwatch-logs-insights]] | AWS log query interface |
| [[third-party-version-management]] | Pinning, archive monitoring, self-hosting tradeoffs for vendor libraries |

### Existing Pages Updated

| Page | Changes |
|------|---------|
| [[unleash-feature-flags]] | Added cross-links to new Local Dev / One Pager / Quick Reference pages |
| [[learnosity]] | Added CDN incident link + third-party-version-management |
| [[Backlog]] | Added TEAMF-539 to In Progress section + ticket details |

### Skipped as Confirmed Duplicates

- General Conventions - Marvin.md → already ingested as [[general-graphql-conventions]] (different filename, same Confluence content)
- Tech Debt andInfrastructure Opportunities.md → typo'd draft of already-ingested [[tech-debt-infrastructure-opportunities-product]]
- How to run the QA frontend automated test workflow - Quality Assurance 1.md → identical content (image URL token only diff)
- The Psychology of Apple Watch's Close Your Rings.md → 0-byte empty file

### Key Insights

1. **Unleash trio is complementary not duplicate** — Local Dev = tutorial, One Pager = team agreement, Quick Reference = synthesized card. Each plays a different role and should be linked from [[unleash-feature-flags]] hub.
2. **Learnosity incident drives third-party-version-management concept** — pinning to specific patch (`v1.132.3`) within LTS branch (`v2025.1.LTS`) is the only stable strategy. Self-hosting decouples release cadence but loses archive notification surface.
3. **SkillResource Phase 2 trio extends architecture overview** — already-ingested [[skill-resource-phase2-architecture-overview]] referenced sub-page wikilinks; now resolved with concrete plans for `useSkillResourceQueries`, `useSkillModals`, `useSkillTimeline`.
4. **Accelerated CR/QA is a deliberate quality tradeoff** — `/experiments/` code is not reviewed for quality, only containment; LTS code outside `/experiments/` retains full review rigor. Captured in [[unleash-one-pager-product]].
5. **Marvin's 3 backend log groups** (BFF Lambda, GraphQL Service ECS, Inference Engine Lambda) are the observability surface area — captured as concrete query reference in [[cloudwatch-logs-insights-queries]].

---

## [2026-05-01] ingest | Mastery Velocity Three-Ring Feature Concept

Processed brainstorm session for TEAME — three-ring progress system for TTO platform. 1 source summary, 1 concept page, index updated.

### New Source Summary

| Source | Wiki Page | Type |
|--------|-----------|------|
| Mastery Velocity — Three-Ring Feature Concept.md | [[mastery-velocity-three-ring-feature-concept]] | Brainstorm session |

### New Concept Page

| Concept | Description |
|----------|-------------|
| [[three-ring-mastery-system]] | Combined ring + SR + mastery + weekly goal feature concept (all ring details in one note) |

### Key Insights

1. **Three rings = skill lifecycle** — New/Practice/Maintain mirrors learn→practice→keep sharp. Practice ring closes "no credit for trying" gap.
2. **SR = skill graph's reason to live** — Without decay, tree fills in monotonically. With decay, students tend a living artifact.
3. **Practice ring rewards productive struggle** — Wrong→right counts MORE than instant correct (Manu Kapur). Adaptive credit weighting.
4. **Path B = sweet spot** — Leitner + empirical decay curves from 6yr data. Uses data without ML infra.
5. **Anti-pattern: time-on-task as primary metric** — That's the social-media trap. Measure skills/week directly.

---

## [2026-05-01] ingest | Brain Break sprint status + TEAME-284 + career resources

Processed 2 source files from `raw/` — 3 new source summaries, 5 existing pages updated, 1 wiki page updated.

### New Source Summaries

| Source | Wiki Page | Type |
|--------|-----------|------|
| Brain Break voice memo (sprint status) | [[BB being open in 2 sessions via different browser]] | Sprint snapshot |
| TEAME-284 (root file + voice memo) | [[teame-284-emotion-picker-responsiveness]] | Work ticket |
| Jordan Cutler handbook (GitHub) | [[path-to-senior-engineer-handbook]] | Career resources |

### Existing Pages Updated

| Page | Changes |
|------|---------|
| [[teame-268-brain-brake-retry-cooldown]] | Status: In Progress → Ready to merge (pending DB verification). Added sprint snapshot link |
| [[teame-272-scrollbar-usability]] | Status: Open → Fixed (2026-05-01). Added sprint snapshot link |
| [[teame-277-brain-break-two-minute-trigger]] | Status: Open → Ready to merge. Added sprint snapshot link |
| [[teame-265-brain-brake-login]] | Added animation update "ready to merge" note + sprint snapshot link |
| [[teame-267-brain-brake-practice-problems]] | Added sprint snapshot link, cancelled duplicate note |
| [[Backlog]] | Moved TEAME-272/277 to Recently Resolved, added TEAME-284 to In Progress, updated stats |
| [[index]] | Added 3 new entries (sprint snapshot, TEAME-284, handbook) |

### Key Insights

1. **TEAME-284 = release blocker** — Maria QA: "as long as we have TEAME-284 before release, UI ready to go"
2. **Sprint wrap nearly done** — TEAME-272, 277, 265, 267 resolved/ready; 268 needs DB verification; 284 = last UI blocker
3. **Jordan Cutler resource list** — career-progression scoped; companion to existing [[lifelong-learning-resources]]

---

## [2026-05-01] lint | Health check (session 2)

Found 0 errors, 16 warnings, 1 info item. Fixed all warnings.

### Warnings (fixed)
- 16 pages missing from `wiki/index.md` — added entries for 12 concept hubs (metabase, qwen, unleash, vite, angular, learnosity, graphql, docker, postgresql, powershell, backend-for-frontend, observability), 2 skill-resource-phase2 pages, 2 three-ring mastery pages

### Info
- ~1100 red links remain as expected future expansion topics
- 4 filename artifacts (Active, Projects, Completed, Work) appear as "missing" but are multi-word files already indexed under full names

---

## [2026-05-01] lint | Health check

Found 1 error, 45 warnings, 1 info item.

### Error (fixed)
- `[[andrej-karpathy-bio]]` broken link in `wiki/concepts/vibe-coding.md` — page was renamed to `andrej-karpathy` in prior session. Fixed source reference and wikilink.

### Warnings (fixed)
- 44 pages missing from `wiki/index.md` — added entries for concepts (auth0, aws-aurora-serverless, browser-devtools, cooldown-system, experiment-speculative-data, flyway, frontend-performance, graphql-over-fetching, hot-chocolate-graphql, hotjar, jwt, lts-transition, openclaw, relay-connections, sentry, soapbox-labs, telemetry, voice-ui), work sources (cognitive-learning-model-product, in-platform-polling-design-notes-product, learnosity-access-product, learnosity-swap-out-notes-product, logging-conventions, marvin-architecture, marvin-diagnostic-inferencing-functional-requirements, marvin-example-skill-assessment-json-response, marvin-frontend, marvin-graphql-service, marvin-inferencing-v2, marvin-skill-assessment-inferencing-implementer-notes, query-filters, querying-graphql, team-e-onboarding-product, teamd-1010-embedding-prototype-metabase, teamf-556-chromebook-touchscreen-tap, tech-debt-infrastructure-opportunities-product), and misc sources (ai-should-elevate-your-thinking, graphify-knowledge-graph-tool-v5, how-i-use-llms-karpathy, karpathy-llm-wiki-day-job, global-object-ids).
- `graphify-knowledge-graph-tool-v5` orphan — added cross-link from `graphify-knowledge-graph-tool.md`.

### Info
- ~1180 red-link topics remain as expected future expansion topics.

---

## [2026-04-30] ingest | TEAME notes — full backlog processing

Processed all remaining TEAME ticket files from `raw/` into wiki source pages and comprehensive Backlog tracking.

### Source Pages Created (12 total)

**Substantial notes:**

| Source | Wiki Page | Status |
|--------|-----------|--------|
| TEAME-218 Code Cleanup | [[teame-218-code-cleanup-lts-conversion]] | In Progress |
| TEAME-268 | [[teame-268-brain-brake-retry-cooldown]] | In Progress |
| TEAME-272 | [[teame-272-scrollbar-usability]] | Open |
| TEAME-277 | [[teame-277-brain-break-two-minute-trigger]] | Open |

**Thin tickets (Jira clippings with minimal description):**

| Source | Wiki Page | Status |
|--------|-----------|--------|
| TEAME-169.md | [[teame-169-update-color-definitions]] | To Do |
| TEAME-173 | [[teame-173-calculator-skill-challenge]] | To Do |
| TEAME-182 | [[teame-182-footer-updates]] | To Do |
| TEAME-204 | [[teame-204-performance-assignment-status]] | To Do (possibly resolved) |
| TEAME-213.md | [[teame-213-expand-student-flow-metrics]] | To Do |
| TEAME-235 | [[teame-235-dropdowns-overlapping-footer]] | To Do |
| TEAME-265 | [[teame-265-brain-brake-login]] | Resolved |
| TEAME-267 | [[teame-267-brain-brake-practice-problems]] | Resolved |

### Backlog Updated

**To Do (8 tickets):** TEAME-169, 173, 182, 188, 189, 204, 213, 235
**In Progress (4 tickets):** TEAME-218 (LTS conversion), 268, 272, 277
**Near Release (1):** TEAME-177
**Recently Resolved (3):** TEAME-157, 265, 267
**Cross-functional (1):** Metabase Admin Dashboard

### Completed Work Updated

- Added TEAME-203 (Assignment Creation Logging) to Completed Work

### Red Links Fixed

- [[teame-169-update-color-definitions]] — previously referenced in Backlog but no source page existed
- [[teame-213-expand-student-flow-metrics]] — previously referenced in Backlog but no source page existed

---

## [2026-04-30] ingest | Backlog page created

Created [[Backlog]] to track pending TEAME tickets and cross-functional initiatives not yet started or actively worked.

**Tickets added:**
- TEAME-169 — Update Color Definitions in Frontend (To Do, Sprint 44/45)
- TEAME-188 — Timeline Reset After Leaving Skill Resource Page (To Do, Sprint 48)
- TEAME-189 — Skill Assessment Refresh Failure (To Do, Sprint 48)
- TEAME-213 — Expand Student-Flow and Pace Guardrail Metrics (To Do, Sprint 48)

**Near release:**
- TEAME-177 — In-Platform Polling → LTS (In QA, 2nd round)

**Cross-functional initiative:**
- Metabase Admin Dashboard — Universal dashboard for partner districts, target Aug 1, 2026

**Files created/modified:**
- `wiki/Backlog.md` — New backlog tracking page
- `wiki/index.md` — Added Backlog under Projects section
- `wiki/Active Projects.md` — Added cross-link to Backlog

---

## [2026-04-30] ingest | 28 raw files — work tickets, architecture, external refs

Processed 28 source files from `raw/` — 31 new source summaries, 29 new concept pages, 1 entity page, 10 existing pages updated. 8 files skipped (too small or duplicates).

### Agent 1: Work Tickets & Notes (9 of 11 processed)

**New source summaries:**
- [[teame-188-timeline-reset-skill-resource]] — Timeline reset skill resource implementation
- [[teame-189-skill-assessment-refresh-failure]] — Skill assessment refresh failure investigation
- [[teame-203-assignment-creation-logging]] — Assignment creation logging and readiness score tracking
- [[teamf-296-vite-upgrade]] — Vite build tool upgrade initiative
- [[BB being open in 2 sessions via different browser]] — BrainBreak session lock update implementation
- [[cross-browser-toctou-window-analysis]] — Cross-browser TOCTOU window timing analysis
- [[devtools-simulated-devices]] — Chrome DevTools device emulation guide
- [[classesroster-graphql-performance-issue]] — GraphQL over-fetching fix for ClassesRoster (30s → 2s)

**New concept pages:**
- [[telemetry]] — Event tracking and observation logging patterns
- [[graphql-over-fetching]] — GraphQL query bloat and optimization
- [[vite]] — Build tool overview and upgrade patterns
- [[browser-devtools]] — Device emulation and debugging tools
- [[frontend-performance]] — Performance optimization patterns
- [[learnosity]] — Third-party assessment platform integration

**Updated pages:**
- [[relay]] — Added ClassesRoster performance case study and over-fetching concept
- [[distributed-locking]] — Added link to brain break session lock update
- [[toctou]] — Added cross-browser TOCTOU window analysis
- [[bb-cross-browser-session-lock]] — Added link to updated implementation notes

**Skipped:** TEAME-169 (only Figma link), TEAME-213 (single line)

### Agent 2: Work Architecture (9 processed)

**New source summaries:**
- [[brainbreak-context-cleanup-implementation]] — Implementation plan for BrainBreak context cleanup
- [[teame-177-in-platform-polling-cleanup]] — In-platform polling cleanup for assessment state
- [[ab-testing-logging-rollout]] — A/B test logging rollout plan
- [[general-graphql-conventions]] — GraphQL naming and structure conventions
- [[bff-learnosity-bridge]] — Backend-for-Frontend service for Learnosity APIs
- [[inference-engine]] — Lambda service for assessment inference
- [[learnosity-result-fetcher]] — Lambda service for fetching Learnosity assessment results
- [[graphql-schema]] — GraphQL schema definitions and types
- [[graphql-service]] — .NET Hot Chocolate GraphQL service implementation

**New concept pages:**
- [[backend-for-frontend]] — BFF pattern
- [[cooldown-system]] — Time-based eligibility gating
- [[experiment-speculative-data]] — Pattern for experiment transient data
- [[hot-chocolate-graphql]] — .NET GraphQL framework
- [[lts-transition]] — Long-Term Support conversion process
- [[observability]] — Observability as competitive advantage

**New entity:**
- [[learnosity]] — Third-party assessment platform (wiki/entities/)

**Updated pages:**
- [[lambda-service-pattern]] — Added links to Inference Engine, Learnosity Result Fetcher, BFF Learnosity Bridge
- [[teame-218-brainbreak-postmortem]] — Added context cleanup implementation and TEAME-177
- [[ab-testing-lifecycle]] — Added links to experiment-speculative-data and observability
- [[relay]] — Added links to hot-chocolate-graphql and graphql-service
- [[claude-graphql-service]] — Added links to graphql-service and general-graphql-conventions
- [[state-context-reducer-pattern]] — Added links to brainbreak-context-cleanup-implementation

### Agent 3: External References (14 of 17 processed)

**New source summaries:**
- [[angular-typescript-coding-standards]] — Angular TypeScript coding standards
- [[react-coding-standards]] — React coding standards and patterns
- [[frontend-architecture-guide]] — Production frontend architecture guide (React, Angular, Auth0, Sentry)
- [[database-postgresql-aurora-guide]] — PostgreSQL and AWS Aurora Serverless guide
- [[docker-best-practices]] — Docker containerization best practices
- [[powershell-get-childitem-guide]] — PowerShell Get-ChildItem equivalent of find
- [[second-brain-graphify-workflow]] — Graphify workflow for knowledge graph generation
- [[qwen-3-6-27b-release]] — Qwen 3.6-27B model release and benchmarks
- [[voice-first-experiences-kids]] — Voice-first experiences for children guide
- [[metabase-admin-dashboard-initiative]] — Metabase admin dashboard initiative
- [[metabase-modular-sdk-quickstart]] — Metabase modular SDK quickstart
- [[metabase-full-app-embedding]] — Metabase full app embedding guide
- [[metabase-modular-authentication]] — Metabase modular authentication (JWT/SAML)
- [[graphify-knowledge-graph-tool]] — Graphify knowledge graph generation tool

**New concept pages:**
- [[angular]] — Angular framework
- [[auth0]] — Authentication platform
- [[aws-aurora-serverless]] — AWS Aurora Serverless database
- [[docker]] — Docker containerization
- [[flyway]] — Database migration tool
- [[graphql]] — GraphQL query language
- [[hotjar]] — User behavior analytics
- [[jwt]] — JSON Web Tokens
- [[metabase]] — Business intelligence platform
- [[openclaw]] — Open-source AI agent framework
- [[postgresql]] — PostgreSQL database
- [[powershell]] — PowerShell scripting
- [[qwen]] — Qwen LLM family
- [[sentry]] — Error tracking platform
- [[soapbox-labs]] — Voice AI for children
- [[unleash]] — Feature flag management
- [[voice-ui]] — Voice user interface patterns

**Updated pages:**
- [[react-useeffect-patterns]] — Added link to react-coding-standards

**Skipped:** Metabase setup.md (stub), metabase embedded.md (single sentence)
**Already existed:** Big-O Algorithm Complexity Cheat Sheet

### Index Updated
Added 38 new entries across Architecture Patterns, Frontend, Backend, Tools & SDKs, and AI Engineering sections.

---

## [2026-04-30] graphify | Hub pages created to fix isolated nodes
Created 1 new hub page, enriched 2 existing hub pages. Target: connect isolated graph nodes identified in lint analysis.

### New Hub Page
- [[claude-code]] — Hub for Claude Code ecosystem (workflows, config, prompts, plugins, agent patterns, discussions)

### Enriched Hub Pages
- [[relay]] — Added 13 topic links covering fragments, mutations, subscriptions, pagination, environment, compiler, migration, refactoring, ESLint rules
- [[testing-patterns]] — Added test type matrix (unit, integration, E2E, component, visual, snapshot, smoke, property) + AI-assisted testing section

---

## [2026-04-30] lint | Health check
Found 0 errors, 1 warning (mitigated), 1 info item. Fixed: Renamed `andrej-karpathy-bio.md` to `andrej-karpathy.md`, fixed 23 entity wikilinks to use kebab-case targets with display pipes. ~80 concept red links remain as expected future expansion topics.

### Index Updated
- Added [[claude-code]] to Claude Code section of wiki/index.md

### Impact
These 3 hub pages connect ~30+ previously isolated graph nodes. Next: re-run `/graphify --update` to measure connectivity improvement.

---

## [2026-04-29] lint | Health check
Found 0 errors, 0 warnings, 2 info items. Fixed: Added `description:` frontmatter to 23 pages missing them (16 sources, 7 concepts). All content pages now have YAML descriptions.

---

## [2026-04-29] lint | Health check
Found 0 errors, 1 warning, 2 info items. Fixed: Added cross-reference links between 5 package manager source pages (pnpm-vs-npm-vs-yarn-vs-bun-2026, choosing-right-js-package-manager-2025, migrating-npm-to-pnpm, pnpm-vs-bun-vs-yarn-berry, pnpm-npm-yarn-bun-benchmarks).

---

## [2026-04-29] ingest | 16 sources: AI trends, tools, work docs

Processed 16 source files from `raw/` — 16 new source summaries, 1 existing page updated, 3 new entity pages, 3 new concept pages.

### New Source Summaries

| Source | Wiki Page | Type |
|--------|-----------|------|
| When AI writes almost all code | [[when-ai-writes-almost-all-code]] | Industry analysis |
| When AI Writes the World's Software, Who Verifies It? | [[when-ai-writes-worlds-software-who-verifies]] | Research article |
| How Claude Code is built | [[how-claude-code-is-built]] | Architecture deep-dive |
| Real-world engineering challenges: building Cursor | [[real-world-engineering-challenges-cursor]] | Architecture deep-dive |
| Good software knows when to stop | [[good-software-knows-when-to-stop]] | Essay |
| The unwritten laws of software engineering | [[unwritten-laws-software-engineering]] | Essay |
| Farzapedia (Twitter thread) | [[farzapedia-personal-wiki-agents]] | Twitter thread |
| Building a code search engine with Turso | [[building-code-search-engine-turso]] | Technical guide |
| karpathy/rendergit | [[karpathy-rendergit]] | Tool documentation |
| karpathy/arxiv-sanity-lite | [[karpathy-arxiv-sanity-lite]] | Tool documentation |
| Accessibility (NC work doc) | [[accessibility-nc-wcag-deque]] | Work documentation |
| Unleash Release Flag Management | [[unleash-release-flag-management-ab-lts]] | Work documentation |
| CLAUDE GraphQL Service | [[claude-graphql-service]] | Work documentation |
| CLAUDE Backend-for-Frontend | [[claude-backend-for-frontend]] | Work documentation |
| Tech Debt and Infrastructure | [[tech-debt-infrastructure-opportunities]] | Work documentation |
| Andrej Karpathy (Wikipedia) | [[andrej-karpathy-bio]] | Biography |

### Existing Page Updated

| Page | Changes |
|------|---------|
| [[unleash-feature-flags]] | Added link to new A/B Test vs LTS comparison |

### New Entity Pages

| Entity | Description |
|--------|-------------|
| [[gergely-orosz]] | Author, The Pragmatic Engineer |
| [[boris-cherny]] | Claude Code founding engineer |
| [[leonardo-de-moura]] | Creator of Lean and Z3 |

### New Concept Pages

| Concept | Description |
|---------|-------------|
| [[ai-code-generation]] | AI as primary code author, not assistant |
| [[formal-verification]] | Mathematical proof of software correctness |
| [[vibe-coding]] | Hobbyist app construction via AI prompts |

### Skipped (Not Ingested)

- `Common Claude Code Prompts.md` — overlaps with existing Claude Code pages
- `frontend resources.md` — lightweight reference list

---

## Unprocessed Raw Files (Scan: 2026-04-29)

The following files in `raw/` remain unprocessed after this ingest. Listed for future prioritization.

### AI / Personal (Low Priority)
- `How I use LLMs.md` — Karpathy transcript (~26K tokens, very long)
- `recursive-spinning-kurzweil.md` / `recursive-tickling-kahn.md` — Generated names, likely ephemeral
- `adaptive-scribbling-charm.md` / `buzzing-prancing-plum.md` / `cozy-launching-ullman.md` / `fuzzy-twirling-boole.md` / `merry-crafting-sunbeam.md` / `quiet-stargazing-whisper.md` / `sequential-sleeping-spark.md` / `sorted-stargazing-gosling.md` / `stateful-watching-adleman.md` / `tingly-zooming-parasol.md` / `typed-weaving-pearl.md` — Generated/ephemeral filenames

### Work-Specific (Medium Priority)
- `TEAME-169.md`, `TEAME-177-in-platform-polling-cleanup.md`, `TEAME-188.md`, `TEAME-189.md`, `TEAME-203.md`, `TEAME-213.md`, `TEAMF-296.md` — Jira tickets
- `Working status of 203.md` — Work status doc
- `BB being open in 2 sessions via different browser.md` — Bug note
- `cross-browser TOCTOU window.md` — Security note
- `BrainBreak Context Cleanup Implementation Plan.md` — Work plan
- `BFF_LearnosityBridge.md` — Architecture doc
- `InferenceEngine.md` — Component doc
- `LearnosityResultFetcher.md` — Component doc
- `GraphQLSchema.md`, `GraphQLService.md` — Schema docs
- `FrontEnd.md`, `React.md`, `Database.md`, `Docker.md` — Stub/reference docs
- `Metabase conflucence info.md`, `metabase embedded.md`, `Metabase setup.md`, `metabase-notes.md` — Metabase docs
- `Modular embedding - authentication.md`, `Full app embedding quickstart.md` — Metabase embedding
- `ab-testing-logging-rollout.md` — Work doc
- `GeneralConventions.md` — Conventions doc
- `Create your own simulated devices.md` — Work doc
- `Local Development with Unleash.md` — Work doc

### Technical References (Medium Priority)
- `AngularTypeScript.md` — Technical reference
- `Big-O Algorithm Complexity Cheat Sheet.md` — May overlap with existing [[big-o-complexity-cheatsheet]]
- `PowerShell equivalent of find.md` — Quick reference
- `Qwen Studio.md` — Tool reference
- `A beginner's guide to voice-first experiences for kids.md` — Article
- `safishamsigraphify AI coding assistant skill...md` — Graphify skill description
- `second-brain-workflow.md` — Workflow doc (created in session)

### Templates / System (Skip)
- `blog-ingest-template.md` — Template created in prior session
- `Daily Note Template.md`, `Project Template.md`, `Research Note Template.md` — Templates
- `HEARTBEAT.md`, `README.md` — System files
- `GRAPH_REPORT.md` — Graphify output
- `_Index.md` — Index file
- `2025-11-20.md`, `2026-01-29.md` — Daily notes

### Personal / Non-SE (Skip)
- `Bahamas Resort Research.md` — Personal
- `street cart chicken over rice.md` — Recipe
- `css-tools-presentation.md` — Presentation

---

# Wiki Processing Log

## [2026-04-29] ingest | 17 unprocessed articles from raw/

Processed 17 source files from `raw/` — 16 new source summaries, 1 existing page updated. 7 new concept pages created.

### New Source Summaries

| Source | Wiki Page | Type |
|--------|-----------|------|
| The Three Pillars of JavaScript Bloat | [[three-pillars-javascript-bloat]] | Performance analysis |
| CSS is DOOMed! | [[css-is-doomed]] | CSS demo/article |
| Bun v1.3.12 | [[bun-v1-3-12]] | Release notes |
| Coding Models Are Doing Too Much | [[coding-models-over-editing]] | Research article |
| Fastest Frontend Tooling for Humans & AI | [[fastest-frontend-tooling]] | Tooling guide |
| Modal vs Popover vs Tooltip | [[modal-vs-popover-vs-tooltip]] | UX guide |
| pnpm vs npm vs yarn vs Bun 2026 Showdown | [[pnpm-vs-npm-vs-yarn-vs-bun-2026]] | Comparison |
| Choosing the Right JS Package Manager 2025 | [[choosing-right-js-package-manager-2025]] | Beginner guide |
| Migrating from NPM to PNPM | [[migrating-npm-to-pnpm]] | Migration guide |
| Dependency Injection in Node.js & TS | [[dependency-injection-nodejs-typescript]] | Tutorial |
| Lifelong Learning 88+ Resources | [[lifelong-learning-resources]] | Resource list |
| From Console.log to Job Hunting | [[console-log-to-job-hunting]] | Personal blog |
| PNPM vs Bun Install vs Yarn Berry | [[pnpm-vs-bun-vs-yarn-berry]] | Comparison |
| pnpm vs npm vs Yarn vs Bun Benchmarks | [[pnpm-npm-yarn-bun-benchmarks]] | Benchmarks |
| Claude Code Source Leak | [[claude-code-source-leak]] | Security analysis |
| Back Button Hijacking Spam Policy | [[back-button-hijacking-spam-policy]] | Policy |

### Updated Source Page

| Page | Changes |
|------|---------|
| [[programmers-oath]] | Updated source reference and date |

### New Concept Pages

| Concept | Description |
|---------|-------------|
| [[dependency-bloat]] | Three pillars of JS dependency tree bloat |
| [[over-editing]] | AI models rewriting more code than necessary |
| [[package-manager-comparison]] | npm vs yarn vs pnpm vs Bun |
| [[dependency-injection]] | Manual DI for Node.js/TypeScript |
| [[bun-runtime]] | All-in-one JS runtime |
| [[css-3d-rendering]] | 3D scenes with CSS |
| [[overlay-patterns]] | Modal vs Popover vs Tooltip framework |

### New Entities

- [[Niels Leenheer]] — cssDOOM author
- [[Petar Ivanov]] — thetshaped.dev author
- [[Alex Kim]] — Source leak analyst
- [[Christoph Nakazawa]] — cpojer, frontend tooling
- [[James Garbutt]] — 43081j.com, e18e initiative

---

## [2026-04-28] ingest | Work/TEAME + TOCTOU/security files

Processed 13 files from `raw/` — 11 new source summaries, 4 new concept pages, 1 existing page updated.

### New Source Summaries

| Source | Wiki Page | Type |
|--------|-----------|------|
| AssessmentAuditor vs AssignmentChecker Pattern Analysis | [[assessmentauditor-assignmentchecker-pattern-analysis]] | Architecture analysis |
| Cross-Browser Session Lock (TEAME-218) | [[bb-cross-browser-session-lock]] | Implementation docs |
| BrainBreak Knowledge Graph Analysis | [[brainbreak-knowledge-graph-analysis]] | Graph analysis |
| JumpCloud to Django User Sync Pipeline | [[jumpcloud-django-user-sync-pipeline]] | Architecture docs |
| User Bridge Analysis and Orphaned Assets | [[user-bridge-analysis-orphaned-assets]] | Architecture/dead code |
| Time-of-check to time-of-use (Wikipedia) | [[toctou-wikipedia]] | Reference |
| What Is TOCTOU? Explained (DeepStrike) | [[toctou-explained-deepstrike]] | Security guide |
| Lock It or Lose It: Avoiding Race Conditions | [[lock-it-or-lose-it-race-conditions]] | Technical guide |
| Post Mortem: axios npm supply chain compromise | [[axios-supply-chain-compromise-postmortem]] | Incident post-mortem |
| Adding Correctness Conditions to Code Changes | [[adding-correctness-conditions-code-changes]] | Methodology (Jessica Kerr) |
| Fragments: April 14, 2026 (Martin Fowler) | [[fragments-april-14-2026]] | Blog post |

### New Concept Pages

| Concept | Description |
|---------|-------------|
| [[toctou]] | Time-of-check to time-of-use race condition |
| [[distributed-locking]] | Mutual exclusion patterns in distributed systems |
| [[supply-chain-security]] | npm package integrity and maintainer protection |
| [[lambda-service-pattern]] | Three-tier Lambda architecture |

### Existing Page Updated

| Page | Changes |
|------|---------|
| [[teame-218-brainbreak-postmortem]] | Added Cross-Browser Session Lock section, Knowledge Graph Analysis section, updated sources list |

### Key Insights

1. **TOCTOU learned from experience** — Discovered the term while googling the race condition during TEAME-218 session lock implementation
2. **Lambda Service Pattern duplication** — AssessmentAuditor and AssignmentChecker share 100% structural scaffolding; candidate for generic framework
3. **User entity is a god object** — Bridges 3 communities (Shared Domain, Clever API, Django CMS) with 15+ collection properties
4. **Fence tokens prevent stale updates** — Version numbers incremented per lock acquisition reject writes from paused nodes
5. **axios incident: social engineering is the new normal** — Targeted campaigns against high-impact package maintainers

---

## [2026-04-23] ingest | Archives/coding AI conversations batch

Processed ~80 SE-relevant conversations from `raw/02_reference/ai-conversations/Archives/coding/` (150 total files). Created 5 new pages, updated 1 existing page.

**New source pages:**
- [[react-component-architecture-conversations]] — 17 React conversations: state management, TypeScript integration, CSS/testing
- [[python-automation-conversations]] — 6 Python conversations: API integration, file automation, FastAPI, scraping
- [[algorithm-practice-conversations]] — 3 algorithm conversations: two-pointer, sliding window, hash map patterns
- [[frontend-interview-prep-conversations]] — 9 conversations: JS core, React interview, Sitecore XM prep
- [[job-search-strategy-conversations]] — 55 conversations: resume optimization, ATS, automation tools, interview prep, recruiter management

**New reference page:**
- [[resume]] — Markdown resume with New Classrooms (Senior Frontend Engineer, Apr 2025 - Present)

**Updated:** [[index]] — Added 6 new entries

---

## [2026-04-22] query | Thinking frameworks for code review

**Question:** "What frameworks apply to code review?"
**Created:** `wiki/synthesis/thinking-frameworks-for-code-review.md`
**Sources:** [[thinking-frameworks-collection]], [[cognitive-load]], [[clean-code-javascript]], [[programmers-oath]], [[teame-218-brainbreak-postmortem]]
**Key insight:** Seven frameworks map to review: Cognitive Load (PR sizing), SBI (feedback structure), Six Hats (coverage), Ladder of Inference (assumptions), Minto Pyramid (comment clarity), Conflict Resolution Diagram (disagreements), Clean Code + Oath (checklist + ethics).

---

## [2026-04-22] lint | Health check

Found 1 error, 1 warning, 2 info items. Fixed:
1. Deleted 2 duplicate basename pages: `thinking/ai-as-management-skill.md` and `thinking/ai-coordination-gap.md` (kept richer `concepts/` versions)
2. Normalized 11 title-case wikilinks to kebab-case equivalents across 13 files

**Wiki stats:** 250 unique pages, 251 index entries, 0 orphans, ~739 red links (expected).

---

## [2026-04-22] ingest | 36 raw files — thinking frameworks, JS deep-dives, and misc

**Processed 36 files** — 3 batch synthesis pages + 4 individual pages created. Batch approach used to keep wiki scannable.

### Batch Synthesis Pages Created

| Theme | Wiki Page | Sources |
|-------|-----------|---------|
| Thinking frameworks (17) | [[thinking-frameworks-collection]] | OODA, Six Hats, Ishikawa, Concept map, Decision matrix, Conflict Resolution, Connection circles, Issue trees, Ladder of inference, Minto Pyramid, Productive Thinking Model, First principles, Reinforcing/Balancing feedback loops, SBI, Impact-Effort Matrix, Zwicky box |
| JavaScript fundamentals (15) | [[javascript-fundamentals-collection]] | Callbacks, Promises, async/await, Event Loop, Prototypes, this/call/apply/bind, Factories & Classes, Inheritance & Polymorphism, IIFE & Namespaces, Type Coercion, Data Structures, Algorithms & Big O, localStorage/sessionStorage, Design Patterns, Clean Code |

### Individual Pages Created

| Source | Wiki Page | Type |
|--------|-----------|------|
| Big-O Algorithm Complexity Cheat Sheet | [[big-o-complexity-cheatsheet]] | Reference |
| Programmer's Oath | [[programmers-oath]] | Ethics/philosophy |
| Clean Code JavaScript (ryanmcdermott) | [[clean-code-javascript]] | Style guide |
| Modal vs Popover vs Tooltip | [[modal-popover-tooltip-patterns]] | UI patterns guide |

### Wiki Index Updated

- Added "Thinking Frameworks" section with collection page
- Added JavaScript fundamentals collection to Languages section
- Added 4 individual pages to appropriate sections
- Updated ingest queue (removed completed items)

### Source Details

**Thinking frameworks** — All from untools.co, clipped articles covering decision-making (OODA, Decision matrix, Six Hats), problem-solving (Ishikawa, Issue trees, First principles, Productive Thinking Model), communication (Minto Pyramid, Ladder of inference, SBI, Conflict Resolution), systems thinking (Connection circles, Reinforcing/Balancing feedback, Concept map), and planning (Impact-Effort Matrix, Zwicky box).

**JavaScript deep-dives** — All from 33jsconcepts.com by Leonardo Maldonado. Comprehensive tutorials with practical code examples, common pitfalls, and best practices.

---

## [2026-04-22] query | Thinking frameworks for debugging

**Question:** "What thinking frameworks apply to debugging?"
**Created:** `wiki/synthesis/thinking-frameworks-for-debugging.md`
**Sources:** [[thinking-frameworks-collection]], [[typescript-debugging-patterns]], [[react-useeffect-patterns]]
**Key insight:** Six frameworks map to debugging phases: OODA Loop (core cycle), Ishikawa (root cause), Issue Trees (decomposition), First Principles (assumption-busting), Ladder of Inference (preventing premature conclusions), Connection Circles (finding feedback loops).

---

## [2026-04-22] cleanup | Moved non-SE content to Personal Knowledge Base

Moved all non-software engineering content from `raw/` to a separate vault at `/Users/lalmonte/Desktop/Obsidian/Personal Knowledge Base/`.

### Moved to Personal Knowledge Base

| Source | Destination | Files |
|--------|-------------|-------|
| `raw/02_reference/esoteric-research/` | Research/Esoteric/ | 18 |
| `raw/02_reference/investigations/` | Research/Investigations/ | 5 |
| `raw/02_reference/sources/readwise/` | Readwise/ | ~100+ |
| `raw/02_reference/sources/piezopolymer*` | Research/Materials-Science/ | 2 |
| `raw/03_personal/02-22-2026.md` | Personal/ | 1 |
| `raw/03_personal/drafts/HV Party Carts*.md` | Personal/Drafts/ | 1 |
| `raw/03_personal/finance/` | Personal/Finance/ | 1 |
| `raw/05_archive/daily/` | Archive/Daily/ | ~100 |
| `raw/05_archive/ai-conversations-non-se/` | Archive/Non-SE-Conversations/ | ~96 |
| Root-level thinking frameworks* | Thinking Frameworks/ | 17 |

\* Initially moved, then returned — thinking frameworks are core engineering skills and belong in the SE notebook.

### Kept in SE Notebook

- `raw/03_personal/drafts/ab-testing-logging-rollout.md` — SE work
- `raw/03_personal/drafts/css-tools-presentation.md` — SE
- `raw/03_personal/drafts/relay-fragment-research-presentation.md` — SE
- `raw/04_published/blogs/` — SE blog post
- `raw/05_archive/process/` — SE process docs (already in wiki)
- `raw/05_archive/work docs/` — SE work docs (already in wiki)
- `raw/02_reference/ai-conversations/` — 1700+ SE coding conversations

### Empty Directories Removed

- `raw/02_reference/esoteric-research/`
- `raw/02_reference/investigations/`
- `raw/03_personal/finance/`

---

## [2026-04-22] lint | Health check

Found 0 errors, 0 warnings, 1 info item. No fixes needed.
- Verified 10 new pages all present in wiki/index.md
- Verified all new pages have 2+ inbound cross-references (range: 2-5)
- Verified all cross-references from new pages resolve to existing wiki pages
- ~500+ red links exist across wiki (topics mentioned but without pages) — expected, not errors

---

## [2026-04-22] ingest | 294 coding conversations (batch synthesis)

**Processed 294 files** from `raw/02_reference/ai-conversations/Areas/coding/` — 11 new synthesized wiki pages created. ~96 non-SE files archived.

### Approach: Batch Synthesis

Rather than creating 294 individual wiki pages, grouped ~198 SE-relevant conversations into 11 themed synthesis pages by topic area. This keeps the wiki scannable and avoids hundreds of nearly-identical pages.

### New Source Summaries Created

| Theme | Wiki Page | Conversations |
|-------|-----------|---------------|
| Travel booking app (Next.js 14) | [[nextjs-travel-booking-development]] | ~65 |
| TypeScript debugging | [[typescript-debugging-patterns]] | ~30 |
| CSS/layout patterns | [[css-layout-patterns-conversations]] | ~15 |
| Git workflows | [[git-workflow-conversations]] | ~5 |
| Algorithms & data structures | [[dsa-learning-journey]] | ~12 |
| Testing (Jest, RTL) | [[testing-conversations]] | ~5 |
| Side projects & portfolio | [[side-project-portfolio-development]] | ~20 |
| Frontend architecture | [[frontend-architecture-explorations]] | ~10 |
| Python CLI scripts | [[python-cli-scripts]] | ~8 |
| Obsidian, Claude Code, AI tools | [[obsidian-claude-ai-tools-conversations]] | ~12 |

### Key Insights Extracted

1. **Zustand store per step** — Separate stores with `persist` + `sessionStorage` for multi-step booking flow
2. **Infinite loop prevention** — Avoid Zustand function updaters + useEffect reading/writing same state
3. **TypeScript cascading errors** — Update interface → parent → child in order when modifying props
4. **Flex `order` for reordering** — More maintainable than grid for complex asymmetric layouts
5. **Jest ESM headaches** — `transformIgnorePatterns`, `moduleNameMapper`, or switch to Vitest
6. **Learning trajectory** — Basic games → sorting algorithms → LeetCode problems (Sept 2024 - March 2025)
7. **CLAUDE.md evolution** — From simple instructions to 3-layer architecture (routing hub + path-scoped rules + hooks)
8. **Feature flag discipline** — Containment in `/experiments/[ticket-#]/`, zombie flag cleanup required

### Wiki Index Updated

- Added "Coding Conversations (Synthesized)" section with 10 new entries

### Archived

- ~96 non-SE files moved to `raw/05_archive/ai-conversations-non-se/`

### Deleted (after ingestion)

- ~198 SE-relevant raw files deleted from `raw/02_reference/ai-conversations/Areas/coding/`

---

## [2026-04-21] lint | Health check
Found 2 errors, 4 warnings, 4 info items. Fixed:
1. Added YAML frontmatter to 2 reference pages (claude-code-plugins-guide, claude-code-skills-reference)
2. Added `description:` fields to 14 pages missing them (3 concepts, 11 sources)
3. Converted 96 title-cased wikilinks to kebab-case equivalents across all wiki files (e.g., `[[Relay]]` → `[[relay]]`)
4. Verified index is fully consistent — 233 entries match 233 pages exactly

---

## [2026-04-21] ingest | 7 files from articles/ + graphql/ + notes/

**Processed 7 source files** — 6 new source summaries, 1 existing page enriched. 7 additional raw files skipped (personal/spiritual/not SE-relevant). All 14 raw files deleted.

### New Source Summaries Created

| Source | Wiki Page | Type |
|--------|-----------|------|
| BuildFlow (GitHub) | [[buildflow-automated-research-pipeline]] | Project analysis |
| Why You Suck at Prompting | [[prompt-engineering-5-layer-architecture]] | Framework |
| MIT Street-Fighting Mathematics | [[street-fighting-mathematics]] | Book/course summary |
| Moltbot Self-Check Framework | [[agent-self-check-framework]] | Agent pattern |
| Vibe Coding Games with ThreeJS | [[vibe-coding-games-threejs]] | Workflow guide |
| Document Build Output Sizes | [[build-output-size-measurement]] | Technical reference |

### Existing Pages Updated

| Page | Changes |
|------|---------|
| [[fullstack-graphql-workshop]] | Enriched with DataLoader code, Connection pattern, Mutation/Subscription patterns, Relay client examples |

### Skipped (Not SE-Relevant)

- Vault Systems & Daily Templates — already in wiki
- Kimi K2.5 + ClawdBot — tool-specific setup
- Claim-Based Titles — 3 lines, already in conventions
- levels-of-energy-atomic — spiritual/personal
- spatial.md — interview experience (personal)
- Technical Leadership — career notes (personal)
- uncensored-llms-guide — tangential research

### Wiki Index Updated

- AI/Strategy: Added 4 new entries (self-check, prompt architecture, buildflow, vibe coding)
- Frontend Reference: Added build-output-size-measurement
- Problem Solving: Added street-fighting-mathematics

### All 14 raw files deleted post-ingestion.

---

## [2026-04-21] lint | Health check
Found 0 errors, 3 warnings, 2 info items. Fixed:
1. Converted 6 source `**Source:** [[filename.md]]` wikilinks to plain text (raw files deleted)
2. Fixed 3 path-prefixed wikilinks in index (`sources/xxx` → bare names)
3. Updated Ingest Queue section to reflect current raw/ state (removed deleted `01_thinking`)

---

## [2026-04-21] cleanup | Deleted processed raw files

Deleted all root-level raw .md files (72 files) that were previously processed into wiki or assessed and skipped.

### Also deleted
- `raw/02_reference/frontend/Vite Rollup tree-shaking.md` — already in [[vite-rollup-tree-shaking-guide]]
- `raw/02_reference/ecc-language-patterns-archived/` (39 files) — already in [[ecc-coding-standards]]
- `raw/00_inbox/2026-04-09-frontend-ui-state-graphql-redux-tailwind.md` — already processed

### Kept (not yet processed)
- `raw/00_inbox/` (HEARTBEAT.md, README.md)
- `raw/02_reference/ai-conversations/` (1841 files)
- `raw/02_reference/sources/` (131 files)
- `raw/02_reference/software-engineer/` (268 files)
- `raw/02_reference/` other subdirs
- `raw/03_personal/`, `raw/04_published/`, `raw/05_archive/`

---

## [2026-04-21] ingest | 6 raw files processed

**Processed 4 new source summaries**, verified 2 TEAME-218 files already in existing page.

### New Source Summaries Created

| Source | Wiki Page | Type |
|--------|-----------|------|
| Claude Code unusable HN issue (303KB) | [[claude-code-unusable-hn-discussion]] | HN discussion |
| How To Create An NPM Package (21KB) | [[npm-package-setup-guide]] | Technical guide |
| Relative import paths ES modules (5.4KB) | [[es-module-relative-imports]] | Technical reference |
| 10 AI Prompts workflow (5.8KB) | [[10-ai-prompts-workflow]] | Prompt collection |

### Already Ingested (Verified)

| Source | Wiki Page | Status |
|--------|-----------|--------|
| TEAME-218-Rebase-Plan.md | [[teame-218-brainbreak-postmortem]] | Already in sources list + content |
| TEAME-218-PR-Plan-2026-04-12.md | [[teame-218-brainbreak-postmortem]] | Already in sources list + content |

### Wiki Index Updated

- Claude Code: Added [[claude-code-unusable-hn-discussion]], [[10-ai-prompts-workflow]]
- Software Engineering/Frontend: Added [[npm-package-setup-guide]], [[es-module-relative-imports]]

### Key Insights

1. **Adaptive thinking bug** — Boris Cherny confirmed zero reasoning emitted on certain turns caused fabrications; workaround: `CLAUDE_CODE_DISABLE_ADAPTIVE_THINKING=1`
2. **gck1 sidecar pattern** — Unsupervised agents intercept thinking heuristics (flag "pragmatic" → Esc Esc)
3. **NPM package setup** — Matt Pocock's full stack: NodeNext, Vitest, Changesets
4. **ES module imports** — `NodeNext` requires `.js` extensions; alternative is `Bundler` mode

---

## [2026-04-17] lint | Health check (Iteration 3 — Final)

Final verification pass. Wiki is clean.

**Results:** 0 errors, 0 warnings, 0 info items.
- All 240 index entries point to existing pages (24 in nested subdirectories — wikilinks resolve correctly in Obsidian)
- All 7 new source pages have 2+ inbound cross-references
- No duplicate pages remaining

**Wiki totals after all 3 iterations:**
- Total pages: 227 (sources: 180, concepts: 24, thinking: 9, reference: 8, synthesis: 2)
- Index entries: 240
- Files ingested this session: 7 new + 1 updated = 8
- Files assessed and skipped: 20 (duplicates, stubs, non-SE content)

---

## [2026-04-17] lint | Health check (Iteration 2)

No new files to ingest — all 28 root-level raw files assessed in iteration 1. Remaining reference subdirectories contain non-SE content or already-processed duplicates.

**Lint results:** 0 errors, 0 warnings, 0 info items. Wiki is clean after iteration 1 fixes.

---

## [2026-04-17] lint | Health check (Iteration 1)

Found 2 errors, 1 warning, 0 info items. Fixed:

1. **Consolidated stale index entries** — Replaced `[[relay-query-refactoring]]` and `[[relay-hooks-comparison]]` with single entry pointing to existing `[[relay-query-refactoring-guide]]`
2. **Removed duplicate source page** — Deleted `wiki/sources/10-high-impact-ai-prompts.md` (duplicate of existing `wiki/sources/10-high-impact-claude-prompts.md`)
3. **Verified cross-references** — All 7 new pages have 2+ inbound links each

**Status:** 0 errors remaining, 0 orphans, all index entries valid.

---

## [2026-04-17] ingest | 28 raw files assessed, 10 processed

**Processed 10 files** — 8 new source summaries, 1 existing page updated, index updated.

### New Source Summaries Created

| Source | Wiki Page | Type |
|--------|-----------|------|
| Claude Code thinking HN discussion (303KB) | [[claude-code-thinking-hn-discussion]] | HN discussion |
| Git commands HN discussion (210KB) | [[git-commands-hn-discussion]] | HN discussion |
| Neovim 0.12.0 HN discussion (95KB) | [[neovim-0-12-hn-discussion]] | HN discussion |
| Designing Component APIs (17KB) | [[designing-component-apis]] | Technical guide |
| @kloss_xyz batch execution prompt | [[coding-agent-batch-prompt]] | Prompt template |
| @JackCulpan workflow orchestration | [[workflow-orchestration-prompt]] | Prompt template |
| @mattpocockuk skill lineup | [[matt-pocock-skill-lineup]] | Twitter thread |

### Existing Pages Updated

| Page | Changes |
|------|---------|
| [[teame-218-brainbreak-postmortem]] | Added Unit Test Plan (90-110 cases), PR Plan (+5,544/-1,763 across 48 files), Rebase Plan references |

### Skipped (Low Value for Wiki)

- `raw/Pernil.md` — Recipe, not software engineering
- `raw/Thread by @zodchiii.md` — Meme post about AI subscription costs
- `raw/Thread by @morganlinton.md` — Single tip about Chrome DevTools heap snapshot
- `raw/You Might Not Need an Effect – React 1.md` — Duplicate of already-processed file
- `raw/Concept map.md` — Concept map template
- `raw/Decision matrix.md` — Decision matrix template
- `raw/Session Summary — 2026-03-07.md` — Short session summary (878 bytes)
- `raw/Skill generated by Factory Droid.md` — Skill generation output
- `raw/nextlevelbuilderui-ux-pro-max-skill...md` — Skill definition file
- `raw/athityakumarcolorls...md` — Ruby gem showcase
- `raw/The Secrets of The Universe Lies in The "3-6-9 Theory".md` — Esoteric, not SE
- `raw/humanlayerhumanlayer...md` / `raw/humanlayer.claudeagentscodebase-locator.md` — Already covered by [[humanlayer-ai-agent-patterns]]
- `raw/Frontend-Unit-Testing-Guide-2026-04-11.md` — TEAME-218 specific, folded into postmortem
- `raw/TEAME-218-CounterArguments-2026-04-11.md` — Already in postmortem sources
- `raw/TEAME-218-PR-Readiness-Research-2026-04-11.md` — Already in postmortem sources
- `raw/TEAME-218-PR-Review-2026-04-11.md` — Already in postmortem sources
- `raw/LLM x Obsidian 2nd Brain.md` — Stub (331 bytes)
- `raw/Tmux Cheat Sheet...md` — Already covered by [[tmux-cheatsheet]]

### Key Insights

1. **Claude Code thinking changes** — Boris Cherny confirmed adaptive thinking > fixed budgets; `showThinkingSummaries: true` restores visibility; effort=85 is the new default
2. **Component API design** — Assess purpose first (Presentation/Container/Layout/Behavior), then choose technique (Props/Slots/Render Props/Compound)
3. **Agent batch execution** — @kloss_xyz prompt enables autonomous multi-hour execution with upfront approval batching
4. **Matt Pocock's workflow** — Own your process; don't outsource to GSD/BMAD/Spec-Kit

---

## [2026-04-16] lint | Health check
Found 0 errors, 6 warnings, 2 info items. Fixed:
1. Added 11 missing pages to wiki/index.md (synthesis pages, claude-code reference pages, architecture sources)
2. Fixed 6 path-prefixed wikilinks in index (e.g., `[[sources/foo]]` → `[[foo]]`)
3. Added cross-references to 4 orphan pages: unified-search-component-pattern (from autocomplete-system-design), prompts-for-ai-unit-test-generation (from testing-patterns), claude-code-patterns-reddit-synthesis + 10-high-impact-claude-prompts (from claude-code-power-user-patterns)
4. Added claude-code-plugins-guide and claude-code-skills-reference to index under Claude Code section

---

## [2026-04-16] query | Unified search component pattern for PrimeReact
**Trigger:** Co-worker question about combining AutoComplete + MultiSelect
**Created:** `wiki/synthesis/unified-search-component-pattern.md`
**Sources:** [[autocomplete-system-design]], [[nc-frontend-architecture-research-2026-04-09]], [[atomic-design]], [[state-context-reducer-pattern]]
**Key insight:** Share the data layer (fetch hook), not the UI layer. Facade pattern with sub-components beats a god component with if/else branching.

## [2026-04-11] ingest | 8 raw files processed (Group A + Group B)

**Processed 8 files** — 4 new source summaries, 1 concept page, updates to 5 existing pages.

### Group A: New Source Summaries Created

| Source | Wiki Page | Type |
|--------|-----------|------|
| The prompt combos nobody talks about... | [[claude-prompt-prefix-combos]] (already existed) | Prompt engineering |
| Under the hood of MDN's new frontend | [[mdn-frontend-architecture]] | Architecture case study |
| fallow dead code tool | [[fallow-dead-code-detection]] | Tool documentation |
| Claude Code thinking issue (HN) | [[claude-code-thinking-transparency]] | Community discussion |

### Concept Page Created

| Concept | Description |
|---------|-------------|
| [[web-components-architecture]] | Web components + server components for production frontends (MDN pattern) |

### Group B: Existing Pages Updated

| Page | Changes |
|------|---------|
| [[workflows]] | Added "Prompt Prefix Combos" section and "Thinking Transparency and Effort Levels" section |
| [[teame-218-brainbreak-postmortem]] | Added "Counter-Arguments" (8 defense strategies), "PR Readiness: Scoring Frameworks" (GitVelocity 6-dimension, AI Harness Scorecard), "PR Review Findings" (4 blocking, 4 discussion, 3 non-issues) |
| [[teame-218-git-cleanup]] | Added "Detailed Rebase Plan" with 5 final commit messages, rebase todo file, post-rebase verification steps |

### Wiki Index Updated

- Added to Frontend Reference: [[web-components-architecture]], [[mdn-frontend-architecture]], [[fallow-dead-code-detection]]
- Added to Claude Code: [[claude-prompt-prefix-combos]], [[claude-code-thinking-transparency]]

### Key Insights Extracted

**MDN Architecture:**
- Rebuilt from React SPA to Lit web components + server components + Rspack
- Flat name-based component structure enables automatic lazy loading
- Declarative Shadow DOM provides progressive enhancement
- Dev startup: 2 min → 2 sec
- Multiple small files > one large bundle in HTTP/2+ era

**Fallow Dead Code:**
- 15 issue types with severity levels and priority ordering
- Priority: unresolved imports > unlisted deps > boundary violations > unused files > unused deps > unused exports
- Incremental adoption via baseline comparison and changed-since filters

**Claude Code Thinking:**
- `showThinkingSummaries: true` restores thinking visibility
- `/effort high` or ULTRATHINK for complex tasks
- Adaptive thinking (model decides duration) > fixed budgets

**TEAME-218 Counter-Arguments:**
- 8 defense strategies for PR review pushback
- Principle: ask questions first, measure before optimizing, consider constraints
- Redux + Context = separation of concerns (serializable vs non-serializable state)

---

## [2026-04-11] query | AI unit test generation prompts

**Synthesized** prompt templates for generating unit tests covering error states and edge cases.

### Sources Used
- [[workflows]] — Bug-catching prompts
- [[testing-patterns]] — Testing best practices
- [[TEAME-218-BrainBreak-Unit-Test-Plan-2026-04-11]] — Real-world test plan pattern
- [[Frontend-Unit-Testing-Guide-2026-04-11]] — Team testing conventions

### Created
- [[synthesis/prompts-for-ai-unit-test-generation]] — Categorized prompt templates with edge case checklist

---

## [2026-04-11] ingest | TEAME-218 React patterns verification

**Verified existing wiki content** for TEAME-218 and BrainBreak learnings.

### Source Pages Already Present

| Source | Focus |
|--------|-------|
| [[teame-218-brainbreak-postmortem]] | 7 refactoring approaches, key learnings |
| [[teame-218-git-cleanup]] | 19 commits → 5 logical commits |
| [[teame-218-brainbreak-refactor]] | Context + reducer pattern |
| [[TEAME-218 Code Cleanup - TEAME-177 (In-Platform Polling)]] | Barrel file removal, reducer naming |
| [[brainbreak-mvc-refactor]] | MVC state management refactor |

### React Pattern Concepts Already Present

| Concept | TEAME-218 Connection |
|---------|----------------------|
| [[react-useeffect-patterns]] | Anti-pattern elimination (key-based remount) |
| [[rules-of-hooks]] | HOC → hook pattern fix |
| [[key-based-remount]] | User change reset pattern |
| [[state-context-reducer-pattern]] | Two-Context pattern for performance |
| [[barrel-files]] | Vercel best practices applied |

### Key Learnings Already Captured

1. **useEffect Anti-patterns** — Use key-based remount instead of manual reset
2. **Rules of Hooks** — Hooks must be unconditional at top level
3. **Redux vs Context** — Redux for session state traceability
4. **Barrel Files** — Anti-pattern for tree-shaking
5. **Date Handling** — Use date-fns, not manual math
6. **UI Libraries** — PrimeReact Dialog > custom portals
7. **SVG Icons** — Custom SVGs > emojis for consistency

**No new pages created.** All TEAME-218 and BrainBreak content was already processed into the wiki with proper cross-references.

---

## [2026-04-11] ingest | High-priority concept pages created

**Created 3 concept pages** from frequently-mentioned topics without dedicated pages.

### Concept Pages Created

| Concept | Description | Source |
|---------|-------------|--------|
| [[ai-coordination-gap]] | Gap between having AI and coordinating it at organizational scale | wiki/thinking/, wiki/sources/ |
| [[ai-as-management-skill]] | Six critical skills for effective AI integration | wiki/thinking/, wiki/reference/ |
| [[ally-piechowski]] | Git codebase analysis expert and consultant | wiki/sources/git-commands-before-reading-code.md |

### Key Content Extracted

**AI Coordination Gap:**
- The three gaps: Coordination, Orchestration, Governance/Auditability
- Root cause: Local optimization without coordination layer
- MIT research: Advanced AI maturity correlates with above-average performance
- Connection to [[process-over-outcome]] as organizational-level pattern

**AI as Management Skill:**
- Six skills: Context Assembly, Quality Judgment, Task Decomposition, Iterative Refinement, Workflow Integration, Frontier Recognition
- Parallels [[critical-ai-literacy]] in education
- The "Tinkerer Strategy": Hire explorers who teach others
- Connection to [[new-ai-divide-tool-literacy-not-access]]

**Ally Piechowski:**
- Consultant specializing in legacy codebase diagnostics
- Five git commands framework for codebase health
- Risk matrix: Churn × Bugs = Risk level
- Cites Microsoft Research (2005): Churn predicts defects better than complexity

### Wiki Updates

- Added all 3 pages to wiki/index.md under "AI / Strategy" section
- Pages cross-link to existing concepts: [[agentic-ai-maturity]], [[critical-ai-literacy]], [[decision-velocity]], [[git-codebase-analysis]]

---

## [2026-04-09] cleanup | Deleted 01_thinking after ingestion

**Source folder deleted:** `raw/01_thinking/`

All 17 thinking notes were previously ingested. Source files deleted post-ingestion as requested.

| Source File | Wiki Page |
|-------------|-----------|
| agi-timeline-2026.md | [[agi-timeline-2026]] |
| ai-as-management-skill.md | [[ai-as-management-skill]] |
| ai-coordination-gap.md | [[ai-coordination-gap]] |
| Critical AI Literacy Framework.md | [[critical-ai-literacy]] |
| decision-velocity-agentic-ai.md | [[decision-velocity]] |
| observability-as-competitive-advantage.md | [[observability-competitive-advantage]] |
| Process Over Outcome Universal Pattern.md | [[process-over-outcome]] |
| Relay Fragment Research & Presentation.md | [[relay-fragment-research-presentation]] |
| Relay refactor.md | [[relay-refactor]] |
| Vite 4.4.1 to 7.x Upgrade Gameplan.md | [[vite-4-4-1-to-7-x-upgrade-gameplan]] |
| twitter-bookmarks-connections-analysis.md | [[twitter-bookmarks-connections-analysis]] |
| Progressive disclosure in practice.md | [[progressive-disclosure-in-practice]] |
| TEAME-246 Assignment Creation Logging.md | [[teame-246-assignment-creation-logging]] |
| vault-wide-connections-synthesis.md | [[vault-wide-connections-synthesis]] |
| If AI Can Answer It Question Quality Test.md | [[if-ai-can-answer-it-question-quality-test]] |
| New AI Divide Tool Literacy Not Access.md | [[new-ai-divide-tool-literacy-not-access]] |
| Guilt as Intuition Not Shame.md | [[guilt-as-intuition-not-shame]] |

---

## [2026-04-08] setup | Vault migrated to LLM Wiki pattern

**Migration complete.**

- Moved existing vault structure to `raw/`
- Created `wiki/` with index and log
- Updated `CLAUDE.md` with LLM Wiki configuration
- Domain: Software engineering knowledge management
- Initial scope: Technical notes, research, AI conversations, tool documentation

**Raw sources moved:**
- `00_inbox/` — 300+ files (daily notes, links, work docs)
- `01_thinking/` — 15+ thinking notes
- `02_reference/` — Technical references, tools, AI conversations
- `03_personal/` — Personal notes (may be excluded from wiki processing)
- `04_published/` — Published content
- `05_archive/` — Archived materials
- `06_system/` — System files (templates, scripts, logs)

## [2026-04-08] ingest | First batch of thinking notes processed

**Processed 7 thinking notes** from `raw/01_thinking/notes/` → `wiki/thinking/`

| Source | Wiki Page | Tags |
|--------|-----------|------|
| agi-timeline-2026.md | [[agi-timeline-2026]] | agi, ai-timeline, strategy |
| ai-as-management-skill.md | [[ai-as-management-skill]] | ai, management, skills |
| ai-coordination-gap.md | [[ai-coordination-gap]] | coordination, orchestration |
| Critical AI Literacy Framework.md | [[critical-ai-literacy]] | education, framework |
| decision-velocity-agentic-ai.md | [[decision-velocity]] | metrics, automation |
| observability-as-competitive-advantage.md | [[observability-competitive-advantage]] | governance |
| Process Over Outcome Universal Pattern.md | [[process-over-outcome]] | universal-pattern |

**Enhancements made:**
- Standardized frontmatter with `sources` field
- Created cross-link structure between related concepts
- Added summary tables and decision frameworks
- Unified tag taxonomy

## [2026-04-09] lint | Health check
Found 0 errors, 3 warnings, 8 missing index entries. Fixed: Added 8 orphan pages to wiki/index.md:
- dynamic-routing, runtime-optimization (Frontend)
- testing-types-overview, tdd-python-guide (Testing - new section)
- python-data-types-reference (Languages)
- git-cheatsheet (Quick Reference)
- prompt-engineering-system-command, self-improvement-loop (AI/Concepts)

## [2026-04-08] ingest | Technical references batch 1

**Processed 6 technical references** from `raw/02_reference/approaches/` and `raw/02_reference/tools/`

### Source Summaries Created

| Source | Wiki Page |
|--------|-----------|
| relay-fragment-composition.md | [[relay-fragment-composition]] |
| relay-fragment-naming-and-typing.md | [[relay-fragment-naming-and-typing]] |
| relay-mutations-guide.md | [[relay-mutations-guide]] |
| relay-uselazyload-to-usefragment-migration.md | [[relay-uselazyload-to-usefragment-migration]] |
| airbnb-react-patterns-summary.md | [[airbnb-react-patterns]] |
| claude-code-power-user-patterns.md | [[claude-code-power-user-patterns]] |

### Concept Pages Created

| Concept | Description |
|---------|-------------|
| [[relay]] | Meta's React GraphQL framework |
| [[fragment-composition]] | Parent-child fragment patterns |
| [[data-colocation]] | Keeping data declarations near usage |

### Reference Pages Created

- [[react-patterns]] — React best practices
- [[workflows]] — Claude Code power user workflows

**New entities:** [[relay]], [[react-patterns]], [[Claude Code]], [[Superpowers Plugin]], [[Obsidian]], [[QMD]], [[Flowy Plugin]]
**New concepts:** fragment-composition, data-colocation, optimistic-updates, declarative-directives, plan-mode, pretooluse-hooks, security-self-review

---

## [2026-04-09] ingest | Links folder processed

**Processed 4 links** from `raw/00_inbox/Links/`

### Source Summaries Created

| Source | Wiki Page | Original |
|--------|-----------|----------|
| Agentic AI Maturity Gap.md | [[agentic-ai-maturity-gap]] | Dev.to article by Nick Talwar |
| Energy Spectrum Universal Pattern.md | [[energy-spectrum-universal-pattern]] | YouTube transcript |
| How teachers and students feel about AI.md | [[ai-in-education-nyt]] | NYTimes article |
| Relay GraphQL Fragments.md | [[relay-graphql-fragments]] | Relay official docs |

### Concept Pages Created

| Concept | Description |
|---------|-------------|
| [[agentic-ai-maturity]] | Organizational AI readiness framework |
| [[universal-patterns]] | Patterns across physics, spirituality, psychology |
| [[ai-education]] | AI in education transformation |

### New Entities

- [[Nick Talwar]] — CTO, ex-Microsoft
- [[Nicole Haddad]] — SMU, critical AI literacy
- [[Ethan Mollick]] — Wharton, AI education expert
- [[Jennifer Parnell]] — History teacher using AI
- [[Ricardo Galliano Court]] — Northwestern, equity concerns

### New Concepts

- agentic-ai-maturity — Maturity model for AI adoption
- ooag — Orchestration, Observability, Auditability, Governance
- universal-patterns — Cross-domain structural similarities
- ai-equity-gap — New digital divide around AI literacy
- energy-hierarchy — Red foundation enables purple transcendence

---

## [2026-04-09] ingest | Technical references batch 2

**Processed 5 technical references** from `raw/02_reference/approaches/` and `raw/02_reference/software-engineer/`

### Source Summaries Created

| Source | Wiki Page |
|--------|-----------|
| data-masking-in-relay.md | [[data-masking-in-relay]] |
| fragment-references-relay.md | [[fragment-references-relay]] |
| relay-subscriptions-guide.md | [[relay-subscriptions-guide]] |
| redux-vs-relay.md | [[redux-vs-relay]] |
| ⚛️Atomic Design Methodology.md | [[atomic-design-methodology]] |

### Concept Pages Created

| Concept | Description |
|---------|-------------|
| [[data-masking]] | Hiding data from non-declaring components |
| [[atomic-design]] | Hierarchical component methodology |

### New Concepts

- data-masking — Relay's encapsulation mechanism
- fragment-references — Opaque pointers to graph data
- subscriptions — Real-time push updates
- state-separation — Server vs UI state concerns
- atomic-design — Five-level component hierarchy

## [2026-04-09] ingest | Technical references batch 3

**Processed 5 technical references** from `raw/02_reference/approaches/` and `raw/02_reference/relay/`

### Source Summaries Created

| Source | Wiki Page |
|--------|-----------|
| orchestration-observability-auditability-governance.md | [[orchestration-observability-auditability-governance]] |
| relay-compiler-build-setup.md | [[relay-compiler-build-setup]] |
| relay-environment-setup.md | [[relay-environment-setup]] |
| vite-rollup-tree-shaking-guide.md | [[vite-rollup-tree-shaking-guide]] |
| relay-main.md | [[relay-overview]] |

### New Concepts

- relay-compiler — Build-time code generation
- relay-environment — Runtime configuration
- tree-shaking — Dead code elimination
- bundle-optimization — Reducing bundle size
- network-layer — HTTP request handling
- cache-policies — Store vs network fetching

---

## [2026-04-09] ingest | Software Engineer Patterns Batch

**Processed 17 files** from `raw/02_reference/software-engineer/frontend/Patterns/`

### Source Summaries Created

| Source | Wiki Page |
|--------|-----------|
| Atoms.md | [[atomic-design-atoms]] |
| Molecules.md | [[atomic-design-molecules]] |
| Organisms.md | [[atomic-design-organisms]] |
| Templates.md | [[atomic-design-templates]] |
| Pages.md | [[atomic-design-pages]] |
| Bundle optimization.md | [[bundle-optimization]] |
| Code splitting.md | [[code-splitting]] |
| Tree Shaking.md | [[tree-shaking]] |
| Big O notation.md | [[big-o-notation]] |
| E2E Testing.md | [[e2e-testing]] |
| End-to-End testing with Playwright.md | [[playwright-testing]] |
| Introduction to Web Frameworks.md | [[web-frameworks-guide]] |
| fullstack-graphql-workshop.md | [[fullstack-graphql-workshop]] |
| Todo List Coding Challenge.md | [[todo-list-challenge]] |

### Concept Pages Created

| Concept | Description |
|---------|-------------|
| [[performance-patterns]] | Frontend optimization patterns |
| [[bundle-optimization]] | Reducing JavaScript bundle size |
| [[testing-patterns]] | Unit, integration, and E2E testing |

### New Concepts

- atomic-design-atoms — Smallest UI building blocks
- atomic-design-molecules — Functional component groups
- atomic-design-organisms — Complex UI sections
- atomic-design-templates — Page layouts
- atomic-design-pages — Template instances with content
- code-splitting — Lazy loading JavaScript chunks
- tree-shaking — Dead code elimination
- big-o-notation — Algorithm complexity analysis
- e2e-testing — End-to-end workflow testing
- playwright — Microsoft's browser automation framework
- nodejs-frameworks — Express, NestJS, Koa comparison

---

## [2026-04-09] ingest | Thinking notes batch — Relay, Vite, AI patterns

**Processed 10 thinking notes** from `raw/01_thinking/notes/`

### Source Summaries Created

| Source | Wiki Page | Type |
|--------|-----------|------|
| Relay Fragment Research & Presentation.md | [[relay-fragment-research-presentation]] | presentation research |
| Relay refactor.md | [[relay-refactor]] | refactoring plan |
| Vite 4.4.1 to 7.x Upgrade Gameplan.md | [[vite-4-4-1-to-7-x-upgrade-gameplan]] | migration guide |
| twitter-bookmarks-connections-analysis.md | [[twitter-bookmarks-connections-analysis]] | pattern synthesis |
| Progressive disclosure in practice.md | [[progressive-disclosure-in-practice]] | workflow framework |
| TEAME-246 Assignment Creation Logging.md | [[teame-246-assignment-creation-logging]] | work notes |
| vault-wide-connections-synthesis.md | [[vault-wide-connections-synthesis]] | meta-patterns |
| If AI Can Answer It Question Quality Test.md | [[if-ai-can-answer-it-question-quality-test]] | education |
| New AI Divide Tool Literacy Not Access.md | [[new-ai-divide-tool-literacy-not-access]] | equity |
| Guilt as Intuition Not Shame.md | [[guilt-as-intuition-not-shame]] | personal growth |

### New Concepts

- [[progressive-disclosure]] — Layered information navigation
- [[relay-refactoring]] — Component migration patterns
- [[vite-migration]] — Build tool upgrade strategies
- [[feedback-loops]] — Universal growth mechanism
- [[cross-disciplinary-patterns]] — Connections across domains
- [[ai-literacy]] — Tool skills vs access
- [[emotional-processing]] — Guilt as intuition

### New Entities

- [[Jennifer Parnell]] — History teacher, AI integration
- [[Ricardo Galliano Court]] — Northwestern, AI equity researcher

---

## [2026-04-09] ingest | Technical references batch — Connection pattern

**Processed 1 technical guide** from `raw/02_reference/approaches/`

### Source Summaries Created

| Source | Wiki Page |
|--------|-----------|
| connection-pattern-pagination.md | [[connection-pattern-pagination]] |

### New Concepts

- [[cursor-pagination]] — Opaque cursor navigation
- [[infinite-scroll]] — Scroll-triggered loading
- [[relay-connections]] — GraphQL pagination standard

---

## [2026-04-09] ingest | System files from raw/06_system/

**Processed 20 system files** from `raw/06_system/`

### Documentation (7 files)

| Source | Wiki Page |
|--------|-----------|
| README.md | [[system-tools-automation]] |
| tasks.md | [[system-tasks-master-list]] |
| ARTICLE-WORKFLOW.md | [[system-article-workflow]] |
| LEVI-ARTICLE-WORKFLOW.md | [[system-levi-article-workflow]] |
| UNIVERSAL-MINING.md | [[system-universal-mining-framework]] |
| session-logs/README.md | [[system-session-logs-guide]] |
| daily-notes-automation/README.md | [[system-daily-notes-automation]] |

### Session Logs (1 file)

| Source | Wiki Page |
|--------|-----------|
| session-logs/session-2026-03-05-obsidian-session-logging.md | [[system-session-obsidian-logging]] |

### Skills (1 file)

| Source | Wiki Page |
|--------|-----------|
| skills/SKILL-resume.md | [[system-skill-resume]] |

### Templates (11 files)

| Source | Wiki Page | Type |
|--------|-----------|------|
| templates/README.md | [[system-templates-guide]] | documentation |
| templates/article-template.md | [[system-template-article]] | template |
| templates/session-log-template.md | [[system-template-session-log]] | template |
| templates/daily-note-template.md | [[system-template-daily-note]] | template |
| templates/daily-note-quick.md | [[system-template-daily-note-quick]] | template |
| templates/case-study-template.md | [[system-template-case-study]] | template |
| templates/service-documentation-template.md | [[system-template-service-doc]] | template |
| templates/process-documentation-template.md | [[system-template-process-doc]] | template |
| templates/general-documentation-template.md | [[system-template-general-doc]] | template |
| templates/technical-documentation-style-guide.md | [[system-template-style-guide]] | documentation |
| templates/conventions-documentation-template.md | [[system-template-conventions-doc]] | template |

### New Concepts

- [[progressive-disclosure]] — Layered vault navigation (4 layers)
- [[spatial-editing]] — Inline edit instruction pattern
- [[universal-mining]] — Two-layer content extraction
- [[session-logging]] — Claude Code session continuity
- [[article-pipeline]] — Four-stage knowledge processing
- [[vault-ops]] — Unified vault command interface

**Deleted:** `raw/06_system/` folder after successful ingestion

---

## [2026-04-09] ingest | Tools folder from raw/02_reference/tools/

**Processed 36 files** from `raw/02_reference/tools/` (root files + clawdbot/ subdirectory)

### Source Summaries Created — Root Tools

| Source | Wiki Page | Type |
|--------|-----------|------|
| claude-code-power-user-patterns.md | [[claude-code-power-user-patterns]] | guide |
| color-psychology-guide.md | [[color-psychology-guide]] | guide |
| layer-3-audit-summary.md | [[layer-3-audit-summary]] | audit |
| layer-3-heading-standards.md | [[layer-3-heading-standards]] | standards |
| moltbot-clawdbot-patterns.md | [[moltbot-clawdbot-patterns]] | guide |
| obsidian-claude-101.md | [[obsidian-claude-101]] | guide |
| obsidian-orphan-finder-report.md | [[obsidian-orphan-finder-report]] | audit |
| relay-alias-directive.md | [[relay-alias-directive]] | guide |
| remotion-video-creation-playbook.md | [[remotion-video-creation-playbook]] | guide |
| resume-session-skill.md | [[resume-session-skill]] | guide |
| session-2026-01-29-agentic-ai-transcript.md | [[session-2026-01-29-agentic-ai-transcript]] | transcript |
| session-2026-01-29-energy-transcript.md | [[session-2026-01-29-energy-transcript]] | transcript |
| session-2026-01-29-relay-fragments.md | [[session-2026-01-29-relay-fragments]] | transcript |
| session-2026-01-29-twitter-bookmarks.md | [[session-2026-01-29-twitter-bookmarks]] | transcript |
| sessionstart-tree-hook.md | [[sessionstart-tree-hook]] | guide |
| spatial-editing-workflow.md | [[spatial-editing-workflow]] | workflow |
| spatial-editing.md | [[spatial-editing]] | workflow |
| transcript-verification-checklist.md | [[transcript-verification-checklist]] | checklist |
| yaml-descriptions-layer-2.md | [[yaml-descriptions-layer-2]] | standards |
| zai-mcp-vision-server.md | [[zai-mcp-vision-server]] | guide |

### Source Summaries Created — Clawdbot

| Source | Wiki Page | Type |
|--------|-----------|------|
| clawdbot/AGENTS.md | [[clawdbot-agents]] | guide |
| clawdbot/CLAUDE.md | [[clawdbot-claude]] | guide |
| clawdbot/HEARTBEAT.md | [[clawdbot-heartbeat]] | system |
| clawdbot/IDENTITY.md | [[clawdbot-identity]] | profile |
| clawdbot/INTEGRATION-SUMMARY.md | [[clawdbot-integration-summary]] | integration |
| clawdbot/MEMORY.md | [[clawdbot-memory]] | memory |
| clawdbot/SOUL.md | [[clawdbot-soul]] | profile |
| clawdbot/TOOLS.md | [[clawdbot-tools]] | reference |
| clawdbot/USER.md | [[clawdbot-user]] | profile |
| clawdbot/tasks.md | [[clawdbot-tasks]] | tracking |
| clawdbot/claude-code-monorepo-documentation-prompt.md | [[clawdbot-monorepo-prompt]] | prompt |
| clawdbot/obsidian-vault-setup-status.md | [[clawdbot-obsidian-vault-setup]] | status |
| clawdbot/relay-eslint-rules-guide.md | [[clawdbot-relay-eslint-rules]] | guide |
| clawdbot/yaml-tag-fix-workflow.md | [[clawdbot-yaml-tag-fix]] | workflow |
| clawdbot/Debt Validation Letters/README.md | [[debt-validation-letters]] | documentation |

### Key Categories Found

1. **Claude Code Patterns** — Power user workflows, skills, hooks
2. **Obsidian Vault Management** — Progressive disclosure, YAML standards, editing workflows
3. **Session Transcripts** — Processing summaries for energy, AI, Relay, Twitter bookmarks
4. **Clawdbot Configuration** — Agent identity, memory, tasks, tools
5. **Relay Documentation** — ESLint rules, @alias directive
6. **Video Creation** — Remotion playbook for AI-generated content
7. **MCP/AI Tools** — Z.ai vision server, QMD search

### New Concepts

- [[spatial-editing]] — Inline edit instruction pattern
- [[session-resume]] — Context restoration skill
- [[proactive-ai]] — Autonomous agent operation
- [[self-improvement-loop]] — HEARTBEAT.md pattern
- [[cron-jobs]] — Automated scheduled tasks
- [[mcp-servers]] — Model Context Protocol integrations
- [[progressive-disclosure]] — Four-layer navigation
- [[claim-based-titles]] — Note naming convention

**Deleted:** `raw/02_reference/tools/` folder after successful ingestion

---

## [2026-04-09] ingest | Approaches folder from raw/02_reference/approaches/

**Processed 14 files** from `raw/02_reference/approaches/` (root files + subdirectories)

### Source Summaries Created — Root Files

| Source | Wiki Page | Type |
|--------|-----------|------|
| airbnb-react-patterns-summary.md | [[airbnb-react-patterns]] | style guide |
| connection-pattern-pagination.md | [[connection-pattern-pagination]] | technical guide |
| data-masking-in-relay.md | [[data-masking-in-relay]] | technical guide |
| fragment-references-relay.md | [[fragment-references-relay]] | technical guide |
| orchestration-observability-auditability-governance.md | [[orchestration-observability-auditability-governance]] | framework |
| redux-vs-relay.md | [[redux-vs-relay]] | architecture guide |
| relay-compiler-build-setup.md | [[relay-compiler-build-setup]] | technical guide |
| relay-environment-setup.md | [[relay-environment-setup]] | technical guide |
| relay-fragment-composition.md | [[relay-fragment-composition]] | technical guide |
| relay-fragment-naming-and-typing.md | [[relay-fragment-naming-and-typing]] | technical guide |
| relay-mutations-guide.md | [[relay-mutations-guide]] | technical guide |
| relay-subscriptions-guide.md | [[relay-subscriptions-guide]] | technical guide |
| relay-uselazyload-to-usefragment-migration.md | [[relay-uselazyload-to-usefragment-migration]] | migration guide |
| vite-rollup-tree-shaking-guide.md | [[vite-rollup-tree-shaking-guide]] | technical guide |

### Source Summaries Created — System Design Case Studies

| Source | Wiki Page | Type |
|--------|-----------|------|
| system-design/_index.md.md | [[frontend-system-design-index]] | reference index |
| system-design/case-studies/Autocomplete.md | [[autocomplete-system-design]] | case study |
| system-design/case-studies/Chat Application.md | [[chat-application-system-design]] | case study |
| system-design/case-studies/Design System Builder.md | [[design-system-builder]] | case study |
| system-design/case-studies/File Management System.md | [[file-management-system]] | case study |

### Source Summaries Created — Git Workflow

| Source | Wiki Page | Type |
|--------|-----------|------|
| git/Automated Branch Naming Standardizes Vulnerability Patching.md | [[automated-branch-naming]] | workflow guide |

### Key Categories Found

1. **Relay/GraphQL Patterns** — Fragment composition, data masking, pagination, mutations, subscriptions
2. **System Design Case Studies** — Autocomplete, chat, file management, design system builder
3. **Build Tools** — Vite/Rollup tree-shaking, Relay compiler setup
4. **State Management** — Redux vs Relay architecture decisions
5. **Git Workflow** — Dependabot branch naming conventions
6. **AI Governance** — OOAG (Orchestration, Observability, Auditability, Governance) framework

### New Concepts

- [[system-design]] — Frontend system design interview patterns
- [[cursor-pagination]] — GraphQL connection pattern pagination
- [[tree-shaking]] — Dead code elimination in bundlers
- [[dependabot]] — Automated dependency updates
- [[branch-naming-conventions]] — Git workflow standardization
- [[autocomplete]] — Search typeahead component patterns
- [[real-time-messaging]] — WebSocket-based chat architecture
- [[file-management]] — Drive/Dropbox-style file system UI

**Deleted:** `raw/02_reference/approaches/` folder after successful ingestion

---

**Wiki totals:** 128 source summaries, 35+ concept pages, 2 reference pages
**Remaining to process:** 184 technical references, 1,841 AI conversations, 100 daily notes

**Next:** Continue with remaining technical references or AI conversations.

---

## [2026-04-09] lint | Health check and fixes

**Second brain lint completed.** Found and fixed issues across the wiki.

### Issues Found

| Severity | Count | Description |
|----------|-------|-------------|
| Errors | 2 | Duplicate filenames, missing project pages |
| Warnings | 4 | Orphan pages, missing descriptions, missing index entries |
| Info | 3 | Red links, missing cross-refs, data gaps |

### Fixes Applied

1. **Duplicate filenames resolved**
   - Renamed `thinking/agentic-ai-maturity-gap.md` → `agentic-ai-maturity-gap-thinking.md`
   - Updated 4 wikilinks to point to new filename

2. **Missing project pages created**
   - Created `[[Active Projects]]` — Current work in progress
   - Created `[[Completed Work]]` — Archived projects

3. **Index updated**
   - Added `[[energy-spectrum-pattern]]` to Thinking section
   - Added `[[ai-education-landscape]]` to AI/Strategy section
   - Added `[[relay-fragments]]` to Relay section
   - Added `[[agentic-ai-maturity-gap-thinking]]` to Thinking section

4. **Descriptions added to source files**
   - Added `description:` field to 89 files in `wiki/sources/`
   - All source summaries now have proper YAML frontmatter

5. **Cross-references added**
   - `[[ai-education]]` → `[[new-ai-divide-tool-literacy-not-access]]`, `[[ai-education-landscape]]`
   - `[[relay]]` → `[[relay-overview]]`, `[[relay-fragments]]`
   - `[[atomic-design]]` → `[[atomic-design-methodology]]`, atomic design level pages

### Stats After Fix

- Total wiki files: 127
- Files with descriptions: 125 (98%)
- Index coverage: 100% of intended pages
- Broken wikilinks: 0 critical

---

## [2026-04-09] ingest | Software Engineering batch processing

**Processed 21 files** from `raw/02_reference/software-engineer/` (representative sample from 268 total files)

### Source Summaries Created — Frontend

| Source | Wiki Page |
|--------|-----------|
| Build Tools.md | [[build-tools]] |
| Package Management.md | [[package-management]] |
| Dynamic Routing.md | [[dynamic-routing]] |
| Streaming SSR.md | [[streaming-ssr]] |
| Modern Data Structures.md | [[modern-data-structures]] |
| Testing your apps.md | [[testing-types-overview]] |
| Runtime Optimization.md | [[runtime-optimization]] |
| Performance Patterns.md | [[performance-patterns]] |
| Test-Driven Development (TDD).md | [[tdd-python-guide]] |

### Source Summaries Created — Backend

| Source | Wiki Page |
|--------|-----------|
| REST API Architecture.md | [[rest-api-architecture]] |
| HTTP Methods and REST APIs.md | [[http-methods-rest-apis]] |
| Node.js.md | [[nodejs-fundamentals]] |

### Source Summaries Created — Architecture

| Source | Wiki Page |
|--------|-----------|
| Software Design and Modeling.md | [[software-design-modeling]] |
| Software Architecture and Design.md | [[software-architecture-design]] |
| OOP Principles.md | [[oop-principles]] |
| MVC Architecture.md | [[mvc-architecture]] |

### Source Summaries Created — Languages

| Source | Wiki Page |
|--------|-----------|
| JavaScript Types.md | [[javascript-types]] |
| Python Data Types and Syntax Reference.md | [[python-data-types-reference]] |

### Source Summaries Created — Concepts

| Source | Wiki Page |
|--------|-----------|
| Prompt Engineering as System Command.md | [[prompt-engineering-system-command]] |
| Self-Improvement Loop.md | [[self-improvement-loop]] |

### Source Summaries Created — Quick Reference

| Source | Wiki Page |
|--------|-----------|
| Git Checksheet.md | [[git-cheatsheet]] |

### Key Categories Found

1. **Frontend Patterns** — Build tools, package management, performance, testing
2. **Backend** — Node.js, REST APIs, HTTP methods
3. **Architecture** — OOP principles, MVC, software design
4. **Languages** — JavaScript types, Python syntax
5. **AI Concepts** — Prompt engineering, self-improvement loops
6. **Quick Reference** — Git cheatsheet

### New Concepts

- [[streaming-ssr]] — React 18+ progressive rendering
- [[prompt-engineering]] — System command approach to AI
- [[self-improvement-loop]] — Agent feedback cycles
- [[oop-pillars]] — Encapsulation, polymorphism, inheritance, abstraction

**Note:** Processed representative sample of 21 files from 268 total. Remaining files can be processed in future sessions as needed.

---

## [2026-04-09] ingest | Relay folder from raw/02_reference/relay/

**Processed 2 files** from `raw/02_reference/relay/`

### Source Summaries Created

| Source | Wiki Page | Type |
|--------|-----------|------|
| relay-main.md | [[relay-main]] | technical guide |
| relay-query-refactoring-guide.md | [[relay-query-refactoring-guide]] | technical guide |

### Key Content Found

**relay-main.md:**
- Core Relay principles: built for scale, quick iteration, automatic optimizations
- Query data fetching with `loadQuery` and `usePreloadedQuery`
- Fragment-based data declarations with `useFragment`
- GraphQL best practices: Connections, Global Object Identification
- Mutations with optimistic updates
- Subscriptions with WebSocket integration
- Ahead-of-time safety via Relay compiler

**relay-query-refactoring-guide.md:**
- Migration from multiple `useLazyLoadQuery` calls to single query + fragments
- Fragment keys (`$ref`) and data masking patterns
- Step-by-step refactoring strategy with before/after code examples
- Hook comparison table: useLazyLoadQuery, usePreloadedQuery, useQueryLoader, useFragment
- Fragment arguments with `@argumentDefinitions`
- useQueryLoader pattern for "render-as-you-fetch"
- Common pitfalls and migration checklist
- Performance impact: ~45% faster (450ms → 250ms)

### New Concepts

- [[relay-hooks-comparison]] — When to use each Relay hook
- [[relay-query-refactoring]] — Migration patterns for query consolidation
- [[fragment-arguments]] — Dynamic fragment behavior
- [[render-as-you-fetch]] — Preloading data before render

**Deleted:** `raw/02_reference/relay/` folder after successful ingestion

---

---

## [2026-04-09] lint | Verification after fixes

Verified all 8 previously orphaned pages now have inbound links from wiki/index.md.

**Status:**
- ✓ No orphan pages remaining in wiki/sources/
- ✓ No broken links detected
- ✓ All 8 fixed pages have 2-4 inbound links each

---

## [2026-04-09] ingest | You Might Not Need an Effect (React docs)

**Processed** from `raw/You Might Not Need an Effect – React.md`

### Source Summary Created

| Source | Wiki Page |
|--------|-----------|
| You Might Not Need an Effect – React.md | [[you-might-not-need-an-effect]] |

### Key Takeaways

- Effects are for external system synchronization only (DOM, network, non-React widgets)
- Don't use Effects for: data transformation, user event handling, or derived state
- Calculate derived values during render; use `useMemo` for expensive calculations
- Event handlers (not Effects) are the right place for user interaction logic

### New Concepts

- [[derived-state]] — Computing values from props/state without Effects
- [[event-handlers]] — Proper place for user event logic
- [[react-compiler]] — Auto-memoization coming to React

**Note:** Source file was truncated during capture. Full article available at https://react.dev/learn/you-might-not-need-an-effect

---

## [2026-04-09] ingest | React Design Patterns Research + Twitter Bookmarks

**Processed 2 files** from `raw/00_inbox/`

### Source Summaries Created

| Source | Wiki Page | Type |
|--------|-----------|------|
| React Design Patterns Research 2026.md | [[react-design-patterns-research-2026]] | research synthesis |
| Twitter Bookmarks 2026-03-14.md | [[twitter-bookmarks-2026-03-14]] | bookmark collection |

### Reference Pages Updated

| Page | Changes |
|------|---------|
| [[react-patterns]] | Added React Compiler patterns, concurrent rendering (useTransition), Container/Presentational pattern, Compound Components, list virtualization |
| [[performance-patterns]] | Added React Compiler section, concurrent rendering, list virtualization patterns |

### New Concepts

- [[react-compiler]] — Automatic memoization (2026 recommended)
- [[concurrent-rendering]] — Non-blocking UI with useTransition
- [[compound-components]] — Flexible UI composition pattern
- [[container-presentational-pattern]] — Data/UI separation
- [[list-virtualization]] — Performance for large lists

### Deleted

- `raw/00_inbox/Tasks.kanban.md` — Test data

### Skipped (Reference Files)

- `raw/00_inbox/README.md` — Inbox workflow documentation
- `raw/00_inbox/HEARTBEAT.md` — Knowledge architect processing framework

---

---

## [2026-04-09] ingest | HumanLayer AI agent patterns

**Processed 2 agent definitions** from `raw/` (humanlayer repository)

### Source Summary Created

| Source | Wiki Page |
|--------|-----------|
| codebase-pattern-finder.md + codebase-locator.md | [[humanlayer-ai-agent-patterns]] |

### Key Takeaways

- Specialist subagents with narrow scope (locator = WHERE, pattern-finder = HOW)
- "Documentarian, not critic" philosophy—show what exists without judgment
- Concrete examples with file:line references required
- Improvements, critiques, recommendations explicitly forbidden

### New Concepts

- [[specialist-subagents]] — Narrow-scope agents that do one thing well
- [[documentarian-mindset]] — Show patterns without evaluation
- [[structured-output]] — Templates for scannable agent results

### Entities

- [[humanlayer-ai-agent-patterns]] — AI agent framework for complex codebases

---

**Next:** Process remaining raw sources or run another lint in 10 ingests.

---

## [2026-04-09] ingest | Daily notes folder processed

**Analyzed 100 files** from `raw/00_inbox/daily/`

### Key Finding

Most daily notes were **empty templates** with no content. Only 2 files contained extractable knowledge:

| File | Content Type | Action |
|------|--------------|--------|
| `UI Libraries for Frontend engineers.md` | Curated resource list | ✓ Ingested → `wiki/reference/frontend/ui-component-libraries.md` |
| `job search.md` | Career tools list | ✓ Archived (not technical enough for wiki) |
| 98 daily log templates | Empty/ routine content | ✓ Archived to `raw/05_archive/daily/` |

### New Reference Page Created

**[[ui-component-libraries]]** — 23 free Tailwind CSS component libraries
- Organized by category (Animation, Full Libraries, Marketplaces, Specialized)
- Includes open source status and selection criteria
- Quick recommendations by use case

### Wiki Structure Updated

- Added **Frontend Reference** section to wiki index
- Created `wiki/reference/frontend/` directory

### Archive Operations

**Moved to `raw/05_archive/daily/`:**
- All 2025 daily notes (80+ files)
- All 2026 daily notes (18 files)
- `job search.md` (career focus, not technical)

### Deleted

- `raw/00_inbox/daily/` folder (now empty)

---

**Note:** Daily notes workflow still active — new daily notes should be created directly in the `📓 Daily Notes` folder outside of `raw/` using the established template system.

---

## [2026-04-09] ingest | Process folder processed

**Analyzed 15 files** from `raw/00_inbox/process/`

### Source Summaries Created (2 files)

| Source | Wiki Page | Type |
|--------|-----------|------|
| Frontend Vite 7 Upgrade Plan.md | [[vite-7-upgrade-plan]] | migration guide |
| Git Worktrees Setup for Parallel Ticket Work.md | [[git-worktrees-parallel-work]] | workflow guide |

### Archived (13 files)

Project-specific implementation plans archived to `raw/05_archive/process/`:
- Vector Explore UI/UX implementation plans
- Scaffolded Challenges system design
- TEAME-203 PR checklists
- Various feature implementation documents

### Wiki Sections Updated

- **Git & Workflow** — Added parallel worktrees guide
- **Build Tools & Upgrades** — New section with Vite 7 upgrade guide

### Folder Deleted

- `raw/00_inbox/process/` — All contents archived

---

## [2026-04-09] ingest | Work docs folder processed

**Analyzed 57 files** from `raw/00_inbox/work docs/`

### Source Summaries Created (6 files)

| Source | Wiki Page | Category |
|--------|-----------|----------|
| CLAUDE-frontend.md | [[nc-frontend-architecture]] | React architecture |
| imperative-seeking-goblet.md | [[brainbreak-mvc-refactor]] | State management |
| Experiment Lifecycle, QA + Code Review.md | [[ab-testing-lifecycle]] | A/B testing process |
| How to Use Unleash.md | [[unleash-feature-flags]] | Feature flags |
| Experiments - Technical Documentation.md | [[experiment-database-schema]] | Database schema |
| SQL.md | [[sql-style-guide]] | SQL conventions |
| KeepingHistoryClean.md | [[git-workflow-guide]] | Git workflow |

### Wiki Sections Added

- **Git & Workflow** — Coherent commits, clean history
- **Feature Flags & Experiments** — A/B testing, Unleash, experiment schema
- **Architecture Patterns** — Production React patterns, MVC refactor
- **Database & Standards** — SQL conventions

### Archive Operations

**Moved to `raw/05_archive/work docs/`:**
- All 57 work doc files
- Jira tickets (7 files)
- .doc file sources (14 files)
- Stub/markdown conversions

### Remaining in `raw/00_inbox/`

```
├── HEARTBEAT.md      (reference file — kept)
├── README.md         (reference file — kept)
└── process/          (16 items — not processed)
```

---

## [2026-04-09] ingest | Raw root files processed

**Processed 7 substantial files** from `raw/` root directory

### Source Summaries Created

| Source | Wiki Page | Type |
|--------|-----------|------|
| Advanced Context Engineering for Coding Agents.md | [[advanced-context-engineering]] | AI workflow guide |
| The Cognitive Load Theory in Software Development.md | [[cognitive-load-theory]] | Research article |
| Writing a good CLAUDE.md | [[writing-good-claude-md]] | Best practices |
| How to Build Your Second Brain.md | [[how-to-build-second-brain]] | Tutorial |
| The Git Commands I Run Before Reading Any Code.md | [[git-commands-before-reading-code]] | Technical reference |
| Why we banned React's useEffect.md | [[why-we-banned-useeffect]] | Engineering guideline |
| BrainBreak Context Refactoring Plan.md | [[teame-218-brainbreak-refactor]] | Work notes |

### Concept Pages Created

| Concept | Description |
|---------|-------------|
| [[ai-engineering]] | Weekly-updated hub for AI-assisted software engineering |
| [[context-engineering]] | Designing context windows for AI agents |
| [[cognitive-load]] | Managing mental overhead in software development |
| [[second-brain-pattern]] | Three-folder AI knowledge management system |
| [[git-codebase-analysis]] | Using git history for codebase diagnostics |
| [[react-useeffect-patterns]] | Five patterns replacing useEffect |
| [[state-context-reducer-pattern]] | Two-Context pattern for performant React |

### New Entities

- [[Dex]] — HumanLayer founder, context engineering researcher
- [[Kyle]] — HumanLayer, CLAUDE.md best practices
- [[Matthieu Cneude]] — Cognitive load theory author
- [[Ally Piechowski]] — Git codebase analysis expert
- [[@alvinsng]] — Factory, no-useEffect policy
- [[John Sweller]] — Cognitive load theory originator (1988)
- [[George Miller]] — Working memory researcher (1956)

### New Concepts

- frequent-intentional-compaction — Context management workflow
- research-plan-implement — Three-phase AI workflow
- 7±2-working-memory — Human cognitive limitation
- intrinsic-extraneous-germane-load — Types of cognitive load
- two-context-pattern — React performance optimization

### Work Documentation

- [[teame-218-brainbreak-refactor]] — Context + reducer pattern implementation
- Tracked under [[Active Projects]]

---


## [2026-04-09] lint | Health check and fixes

**Issues Found:**
- 2 duplicate concept pages (orphans with sources/ duplicates)
- 24 duplicate index entries
- 10 pages missing from index

**Fixes Applied:**

1. **Deleted orphan concept pages:**
   - `wiki/concepts/bundle-optimization.md` (duplicate of sources/ version)
   - `wiki/concepts/performance-patterns.md` (duplicate of sources/ version)

2. **Removed duplicate index entries:**
   - react-patterns, connection-pattern-pagination
   - bundle-optimization, performance-patterns
   - git-cheatsheet (removed duplicate section)
   - Multiple thinking notes (appear in Sources)
   - agi-timeline-2026 (kept in Sources)

3. **Added missing pages to index:**
   - Session Transcripts section (4 pages)
   - System Documentation section (4 pages)

**Status:** All duplicates resolved. Clean index structure.

---

## [2026-04-11] ingest | TEAME-218 BrainBreak documentation

**Processed 3 files** from `raw/` root and `raw/05_archive/`

### Source Summaries Created

| Source | Wiki Page | Type |
|--------|-----------|------|
| TEAME-218-BrainBreak-PostMortem.md | [[teame-218-brainbreak-postmortem]] | Post-mortem analysis |
| TEAME-218-GIT-CLEANUP-MASTER.md | [[teame-218-git-cleanup]] | Git workflow documentation |
| BrainBreak Code Cleanup Plan.md | [[TEAME-218 Code Cleanup - TEAME-177 (In-Platform Polling)]] | Code quality plan |

### Key Categories Found

1. **Post-Mortem Analysis** — 7 major refactoring approaches tried and learned:
   - Cooldown system implementation (LocalStorage → GraphQL + date-fns)
   - Context API refactoring for Rules of Hooks compliance
   - Redux migration from 7 useState hooks
   - useEffect anti-pattern elimination (key-based remount)
   - Modal redesign (portal → PrimeReact Dialog)
   - Slider redesign (buttons → continuous input with custom SVGs)
   - Recording service simplification (6-layer callbacks → direct hooks)

2. **Git Workflow** — Cleanup strategy for 19 → 5 commits:
   - Interactive rebase strategy with backup plan
   - Improved commit messages with detailed descriptions
   - Architecture reference for components, hooks, Redux actions
   - Verification checklist

3. **Code Quality** — Technical debt cleanup:
   - Barrel file anti-pattern removal (Vercel best practices)
   - State co-location principles (Kent C. Dodds)
   - Reducer naming conventions (domain-specific names)
   - Dead code elimination and import path standardization

### New Concepts

- [[rules-of-hooks]] — Hooks must be called unconditionally at top level
- [[state-co-location]] — Place code as close to where it's relevant as possible
- [[barrel-files]] — Anti-pattern causing tree-shaking issues
- [[key-based-remount]] — React pattern for clean component reset
- [[force-with-lease]] — Safer force push pattern

### Key Learnings

| Area | Learning |
|------|----------|
| State Management | Redux provides better traceability than multiple useState hooks |
| Date Handling | Use date-fns instead of manual math to avoid timezone bugs |
| React Patterns | Hooks must be called unconditionally at top level |
| UI Components | Use library components (PrimeReact Dialog) vs custom portals |
| Input Design | Continuous input > discrete buttons for measurement tasks |
| File Organization | Co-locate code with its consumer; avoid barrel files |

### Entities

- [[marlboro]] — Frontend repository
- [[TEAME-218]] — BrainBreak feature ticket

---

## [2026-04-15] ingest | Vite Rollup tree-shaking quick reference

**Updated** [[vite-rollup-tree-shaking-guide]] with content from `raw/02_reference/frontend/Vite Rollup tree-shaking.md`.

### Added
- Manual chunks configuration (vendor/ui splitting)
- Vite 4.4.1 tree-shaking Q&A (Rollup 3.x/4.x confirmation)

### Assessment
Mostly duplicate of existing wiki page. No new pages created.

---

## [2026-04-15] ingest | Recent raw files (hook research + ECC patterns)

**Updated** [[teame-218-brainbreak-postmortem]] — added Hook Architecture section covering useBrainBreakNavigation (two overloads, two-phase system, 7 placements) and useBrainBreakRecorder (6-step recording flow, race-safe, fire-and-forget).

**Created** [[ecc-coding-standards]] — hub page for 40 ECC language pattern files in `raw/02_reference/ecc-language-patterns-archived/`.

**No changes needed** — [[nc-frontend-architecture-research-2026-04-09]] was already fully ingested in prior session.

### Sources Processed
- `raw/2026-04-13-TEAME-218-useBrainBreakNavigation-hook.md` → folded into existing TEAME-218 page
- `raw/2026-04-13-TEAME-218-useBrainBreakRecorder-hook.md` → folded into existing TEAME-218 page
- `raw/02_reference/ecc-language-patterns-archived/` (40 files) → single hub page
- `raw/00_inbox/2026-04-09-frontend-ui-state-graphql-redux-tailwind.md` → already processed

---

## [2026-04-16] ingest | 15 raw files processed (patterns.dev + AI ecosystem)

**Processed 15 files** — 15 new source summaries, 2 existing pages updated.

### Group A: React Design Patterns (patterns.dev clippings)

| Source | Wiki Page | Topic |
|--------|-----------|-------|
| AI UI Patterns.md | [[ai-ui-patterns]] | Vercel AI SDK, streaming, Next.js vs Vite backend |
| Client-side Rendering.md | [[client-side-rendering]] | CSR basics, React 18 progressive hydration |
| Component Testing.md | [[component-testing]] | Testing Library, user-centric testing, mocking |
| ContainerPresentational Pattern.md | [[container-presentational-pattern]] | Data/UI separation, hooks replacing containers |
| Event Handling in React Interviews.md | [[event-handling-react-interviews]] | Synthetic events, delegation, event types |
| Flyweight Pattern.md | [[flyweight-pattern]] | Shared state for memory efficiency |
| MediatorMiddleware Pattern.md | [[mediator-middleware-pattern]] | Centralized communication, middleware chains |
| Mixin Pattern.md | [[mixin-pattern]] | Behavior extension (legacy, replaced by hooks) |
| Observer Pattern.md | [[observer-pattern]] | Pub/sub, useSyncExternalStore |
| Render Props Pattern.md | [[render-props-pattern]] | JSX through function props |

### Group B: AI/Claude Code Ecosystem

| Source | Wiki Page | Topic |
|--------|-----------|-------|
| Cursor Rules for Better AI Development.md | [[cursor-rules-ai-development]] | Matt Pocock's TypeScript cursor rules |
| Thread by @akshay_pachaar.md | [[karpathy-claude-md-stars]] | CLAUDE.md 15K stars, Karpathy-derived |
| Thread by @swyx.md | [[swyx-writing-skills-template]] | Anh's writing skills template for devtools HN |

### Group C: Other

| Source | Wiki Page | Topic |
|--------|-----------|-------|
| Modular embedding SDK - quickstart.md | [[metabase-embedding-sdk]] | Metabase React SDK setup |
| Frontend architecture prompt.md | [[frontend-architecture-prompt]] | 3-layer CLAUDE.md + rules + hooks |

### Existing Pages Updated

| Page | Changes |
|------|---------|
| [[writing-good-claude-md]] | Added Karpathy CLAUDE.md community validation section, Matt Pocock's Cursor Rules section |
| [[claude-code-power-user-patterns]] | Added 3-layer CLAUDE.md Architecture section (routing hub + path-scoped rules + hooks) |

### Wiki Index Updated

- React Patterns: Added 10 new entries (AI UI, CSR, testing, 6 design patterns, event handling)
- Claude Code: Added 3 new entries (cursor rules, Karpathy CLAUDE.md, frontend architecture)
- Writing & Content: New section with swyx writing template
- Tools & SDKs: New entry for Metabase embedding SDK

### Skipped (Empty/Stubs)

- Acting dumb...md (0 bytes), Observability as Competitive Advantage.md (0 bytes)
- Analyze why your website is slow.md (215 bytes), Untitled.md (108 bytes)
- Unleash presentation.md (237 bytes), Session Summary — 2026-03-07.md (878 bytes)
- LLM x Obsidian 2nd Brain.md (331 bytes)

---

## [2026-05-17] lint | Wiki health check and cleanup

Fixed 3 errors, 32 warnings, improved organization.

### Fixes Applied

**Errors fixed:**
- Renamed 5 space files to kebab-case (`Active Projects.md` → `active-projects.md`, etc)
- Consolidated duplicates: `learnosity.md` and `soapbox-labs.md` now redirect from concepts/ to entities/
- Created `sources/archive/` for 22 obsolete marvin/personal files

**Warnings addressed:**
- Archived 32 orphan pages to `sources/archive/` (mostly outdated marvin docs)
- Added `sources/README.md` documenting structure

**Organization improvements:**
- Organized `sources/` into 11 subdirectories (ai-ml, architecture, education, frontend, patterns, etc)
- 410 files remain at root for future categorization
- Created `sources/README.md` with structure documentation

### File Count Changes

- Before: 557 files flat in sources/
- After: 11 categorized folders + 410 root files
- Archived: 22 files
- Duplicates resolved: 2


## [2026-05-17] continued | Sources folder organized

**Completed organization of `sources/` folder:**

### Before
- 521 files flat in `sources/` root
- No categorization
- 22 marvin files mixed in

### After
- **0 files** at root — all organized
- **15 categories** with clear purpose
- **533 files** total categorized

### Categories by file count
1. `tools/` — 78 files (dev tools, workflows)
2. `education/` — 60 files (learning science)
3. `frontend/` — 59 files (React, Relay, CSS)
4. `archive/` — 58 files (outdated, session logs)
5. `research/` — 56 files (academic papers)
6. `software-engineering/` — 53 files
7. `articles/` — 36 files
8. `obsidian/` — 30 files (vault workflows)
9. `architecture/` — 30 files
10. `patterns/` — 27 files
11. `ai-ml/` — 24 files
12. `backend/` — 13 files
13. `career/` — 7 files
14. `psychology/` — 5 files
15. `books/` — 1 file

### Rules applied
- `session-*.md` → `archive/`
- `marvin-*`, `*-marvin.md` → `archive/`
- NC/BTech work → `education/btech/`
- Papers → `research/`
- All spaces in filenames → kebab-case

