---
description: "Spring 2026 co-design prototype for competency-based learning with North Dakota teachers"
tags: ['research']
raw_file: "Operation Endgame.md"
created: 2026-05-17
---

Spring 2026 co-design prototype for [[competency-based learning]] with North Dakota teachers; rapid prototype and sandbox favor iteration speed over polish.

## Context: North Dakota PCBL Initiative

North Dakota launched the **Personalized, Competency-Based Learning (PCBL) Initiative** in 2018, partnering with KnowledgeWorks and NDDPI. It has become one of the most comprehensive state-level CBL implementations in the U.S.

Key features relevant to this prototype:
- **Statewide Learning Continuum** — A competency framework with clear performance levels, developed by ND educators
- **Standards-Based Grading** — Multiple districts adopted SBG PreK-12
- **Teacher Co-Design** — Educators actively involved in developing learning continua and classroom practices
- **Peer Learning Networks** — Cross-district collaboration for sharing practices
- **Higher Education Partnerships** — Valley City State University advancing PCBL teacher preparation
- **5-Year Evaluation (WestEd 2024)** — Documents progress across four pilot districts

This positions North Dakota teachers as genuine co-design partners, not just test users — they bring lived experience implementing CBL at scale.

> Sources: WestEd (2024) *ND PCBL 5-Year Evaluation*; KnowledgeWorks (2024) *Key Findings from Five Years of PCBL in ND*; KnowledgeWorks (2026) *VCSU Partnership*

### What This is

A platform for exploring CBL classroom flows:

1. **Assessing what students can demonstrate.** → [[cbl-assessing-demonstrations]]
2. **Targeting each student's knowledge frontier.** → [[cbl-knowledge-frontier]]
3. **Providing differentiated adaptive support.** → [[cbl-differentiated-support]]

---

### 1. Assessing What Students Can Demonstrate

> Full research: [[cbl-assessing-demonstrations]]

CBL shifts assessment from seat-time and standardized tests to **demonstrated mastery of competencies** through multiple forms of evidence.

**Key research foundations:**
- **Black & Wiliam (1998)** — Formative assessment is among the most powerful interventions for learning; continuous low-stakes demonstration replaces high-stakes summative events
- **Hattie (2009)** — Feedback (d = 0.73), formative evaluation (d = 0.90), and mastery learning (d = 0.57) are highest-impact
- **Tobón et al. (2020)** — CBA rubric design must integrate domains beyond cognition (authenticity, interdisciplinarity, progression tracking)
- **Aurora Institute (2020)** — Assessment in CBL should be meaningful and a positive learning experience; multiple pathways to demonstrate mastery particularly benefit marginalized students

**How this connects to our existing work:**
- [[skill-tree-competency-structure]] provides the DAG structure for gap detection and progress estimation
- [[three-ring-mastery-system]] defines the mastery lifecycle (New → Practice → Mastered → Maintained) with skills/week as the primary metric
- [[insight-recall]] extends assessment beyond content to metacognitive demonstration (strategy reactivation)
- [[reverse-scoring]] ensures psychometric validity for affective measures like self-efficacy
- [[adaptive-feedback-education]] provides process-level feedback patterns that assess reasoning, not just answers

---

### 2. Targeting Each Student's Knowledge Frontier

> Full research: [[cbl-knowledge-frontier]]

CBL requires identifying **where each student's understanding ends** and targeting instruction at the edge of what they're ready to learn next.

**Key research foundations:**
- **Vygotsky (1978)** — Zone of Proximal Development: instruction should target the gap between independent and guided performance
- **Doignon & Falmagne (2011)** — Knowledge Space Theory: mathematical foundation for prerequisite relationships between competencies
- **Corbett & Anderson (1995)** — Bayesian Knowledge Tracing: four-parameter HMM for tracking mastery over time
- **Piech et al. (2015)** — Deep Knowledge Tracing: RNN-based KT with higher predictive accuracy
- **Sarsa et al. (2025)** — Combining DKT with cognitive load estimation for personalized path generation (Nature Scientific Reports)

**How this connects to our existing work:**
- [[skill-tree-competency-structure]] directly implements knowledge space theory — gap detection IS the frontier
- [[productive-struggle]] maps to ZPD: productive struggle = at the frontier; flailing = beyond; coasting = below. Knowledge tracing is the technical infrastructure for distinguishing these states
- [[adaptive-feedback-education]] — process-level feedback targets reasoning at the frontier; LLM zero-shot underperforms teacher-written feedback
- [[ai-math-tutoring]] — multi-skill combination problems (accuracy ≈ accuracy²) are more diagnostic of deep understanding at the frontier
- [[three-ring-mastery-system]] — empirical decay from 6yr data means maintained skills can decay back to Practice, re-entering the frontier
- [[insight-recall]] — bridge-aware triggers surface prerequisite insights *before* a student starts a new skill (proactive frontier targeting)

---

### 3. Providing Differentiated Adaptive Support

> Full research: [[cbl-differentiated-support]]

Getting each student to their next frontier requires **the right support, at the right time, for the right student** — differentiated, equitable, and objectively-grounded.

**Key research foundations:**
- **Tomlinson (1999)** — Differentiated instruction framework: readiness, interest, learning profile → differentiate content, process, product, environment
- **Wood, Bruner & Ross (1976)** — Scaffolding: contingent, faded, aimed at transfer of responsibility
- **Belland et al. (2017)** — Meta-analysis of 56 studies: scaffolding effect g ≈ 0.50 across age levels
- **Chen et al. (2025)** — Systematic review of AI-driven ITS in K-12 (Nature): lower-performing students benefit most
- **Brookings (2024)** — AI tutoring produces substantial learning gains; Khanmigo reached 65,000 students by March 2024
- **Ladson-Billings (1995)** — Culturally relevant pedagogy: academic achievement, cultural competence, sociopolitical consciousness

**How this connects to our existing work:**
- [[self-determination-theory]] — CBL naturally satisfies autonomy (choice in pace), competence (mastery-gated), relatedness (teacher relationships). Autonomy support is the critical active ingredient (Wang et al. 2024)
- [[math-anxiety]] — anxiety pushes away from STEM, self-efficacy pulls toward; both must be addressed. CBL's mastery orientation is protective against performance-goal anxiety
- [[math-identity]] — co-constructed through teacher positioning; when teachers position students as capable thinkers, flexibility increases
- [[behavioral-nudges-education]] — streak counters increase math achievement (Chile RCT); teacher email nudges +1.89% (Zearn megastudy, N≈3M)
- [[productive-struggle]] — students value emotional and cognitive scaffolding equally; AI over-scaffolding traps to avoid
- [[three-ring-mastery-system]] — adaptive credit weighting (struggle bonus 1.2x), equity design (quiet adaptation, frictionless opt-down)
- [[ai-math-tutoring]] — human-AI copilot +4 p.p. mastery, +9 p.p. for students of lower-rated tutors
- [[adaptive-feedback-education]] — three feedback types (instructional, motivational, scaffolding) as differentiated support components
- [[research-to-product-bridge]] — 6 implementation gaps identified, with teacher nudges and planning prompts as highest-priority opportunities

---

## Cross-Cutting Themes

### Self-Determination Theory as the Unifying Framework
[[self-determination-theory]] connects all three pillars:
- **Assessment** → competence satisfaction through mastery-gated progression
- **Frontier** → autonomy through personalized pathways and ZPD-aligned challenge
- **Support** → relatedness through teacher-student collaboration and human-AI copilot model

### The Human-AI Copilot Model
Across all pillars, research converges on AI **augmenting** human facilitators rather than replacing them:
- [[ai-math-tutoring]] — copilot produces +4 p.p. gains; [[adaptive-feedback-education]] — AI improves human tutor behavior
- [[research-to-product-bridge]] — highest-impact path layers AI onto existing ITS infrastructure

### Equity as Structural, Not Additive
- [[cbl-assessing-demonstrations]] — multiple pathways to demonstrate mastery benefit marginalized students
- [[cbl-differentiated-support]] — Aurora Institute: equity embedded in structure, culture, and pedagogy
- [[three-ring-mastery-system]] — equity design: students who can't hit 2/week quietly adapt; ahead-of-pace is student choice

### The 6-Year Data Moat
[[competitive-landscape-teach-to-one]] identifies TTO's longitudinal data as unreplicable:
- Enables empirical decay (6yr forgetting curves) rather than algorithmic defaults
- Per-skill difficulty modeling, cohort-prior inheritance, "skills at risk" prediction
- No competitor can replicate this data asset

---

## Privacy Constraints

- All student data is anonymous.
- Students are assigned random IDs.
- Server-side teachers hold de-anonymized keys locally.
- Browser-side pre-screening of student-submitted text/images may auto-redact names and items and identify words before anything leaves the client.

### Tech Stack

- Frontend: Next.js 16, React 19, TypeScript, Tailwind v4, Node.js server mode. See frontend/next.config.ts.
- Database: AWS Aurora PostgreSQL with Drizzle ORM for schema and migrations.
- Hosting: AWS ECS Fargate behind an ALB; static assets via CloudFront and S3.
- CI/CD: GitHub Actions with OIDC to AWS
- Package Manager PNPM10: frozen-log file installs everywhere.
- local dev: Docker Compose: Postgres, Drizzle Mine Grader, and Next.js Dev Server with Live Reload.

The AI API choice between REPLIC8 and Azure Model Frontier is undecided. It will live behind an abstraction so the provider can be swapped.
