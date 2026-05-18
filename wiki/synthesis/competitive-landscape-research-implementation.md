---
description: Competitive landscape analysis for each research-backed implementation opportunity in the TTO product. Maps competitors to the 7 Claude Code prompts in claude-code-prompts-research-implementation.
tags: ["synthesis", "tto", "competitors", "research", "implementation", "ed-tech"]
sources:
  - research-to-product-bridge
  - claude-code-prompts-research-implementation
  - three-ring-mastery-system
  - metacognitive-reflection
  - behavioral-nudges-education
  - productive-struggle
  - knowledge-tracing
created: 2026-05-10
updated: 2026-05-10
---

# Competitive Landscape: Research → Implementation

Maps each implementation opportunity from [[claude-code-prompts-research-implementation]] against what competitors already ship. Research conducted May 2026.

---

## Quick Reference: Competitive Gap Summary

| Opportunity | Closest Competitor | Gap Status | TTO Differentiation |
|---|---|---|---|
| Planning prompts in BrainBreak | MATHia (research-stage, not shipped) | 🟢 White space | First to ship lightweight pre-practice planning in math |
| Teacher progress nudges | Zearn (experimental, not permanent) | 🟢 White space | First permanent behaviorally-designed teacher nudge system |
| Confidence × performance divergence | Eedi + Eduphoria (manual, no automation) | 🟢 White space | First automated real-time divergence alert |
| Insight Recall forward-priming | **Nothing exists** | 🟢 Pure white space | Genuinely novel — no one combines insight capture + contextual recall in K-12 |
| Skill graph prerequisite validation | Math Academy (FIRe) + Prodigy (EdCAT) | 🟡 Partial | Math Academy is closest analog; TTO's 6yr data is the differentiator |
| Struggle detection → adaptive nudge | MATHia LiveLab + DreamBox IAL | 🟡 Partial | No one combines affect + KT + teacher orchestration at TTO's scale |
| Growth mindset → proximal target audit | No one audits this | 🟢 White space | Quick win — no competitor systematically audits messaging alignment |

**Key finding:** 5 of 7 opportunities are genuine white space. No competitor permanently ships what TTO would build in any of these areas.

---

## 1. Planning Prompts in BrainBreak

> **Research basis:** Tolvanen 2025 (f=221), metacognitive instruction ES=1.11
> **Related:** [[metacognitive-reflection]] §Explicit Prompts

### Who's Close

| Product | What They Do | Status |
|---|---|---|
| **MATHia** (Carnegie Learning) | Embeds planning + monitoring + reflection prompts within problem-solving flow. Both MC and open-ended. **IES-funded A/B test** (2,000+ students, Vanderbilt/Carnegie, UpGrade platform). Results pending. | Research-stage, NOT shipped product |
| **Third Space Learning** (Skye AI) | Students identify strategies *before* lesson; AI reminds them during lesson. Built on 2M+ hours of human tutoring data. Voice-based. | Shipped, but voice-only, not math-specific skill planning |
| **Khanmigo** | Socratic dialogue asks "what should we do first?" — but planning emerges organically from conversation, not explicit pre-practice prompt | Shipped, but different paradigm (conversational, not structured) |

### What No One Ships

A **lightweight, pre-practice planning prompt embedded in an existing check-in flow**. MATHia is closest but uses heavier MC + open-ended format and hasn't shipped it. BrainBreak's existing survey flow (emotion → confidence → **plan**) would be a 3-dimensional pre-practice check-in no competitor offers.

### Key Insight

The UK EEF Teaching & Learning Toolkit rates metacognition as **+7 months progress** — high-impact, low-cost. But implementation is nascent. TTO would be first-to-market.

---

## 2. Teacher Progress Nudge System

> **Research basis:** Zearn megastudy, +1.89% math progress (N≈3M)
> **Related:** [[behavioral-nudges-education]] §Teacher-Facing Nudges

### Who's Close

| Product | What They Do | Behavioral Science? |
|---|---|---|
| **Zearn** | Tower Alerts, Sprint Alerts, Progress Reports, LiveView. The megastudy email nudges (+1.89%) were a **research intervention, not a permanent feature**. In-product alerts are passive (teacher must check). | ✅ Yes (research only, 15 variants tested) |
| **IXL** | Notifications Center (Sept 2022), Real-Time Center (red tile = struggling, grey = idle >5min), Trouble Spots Report, auto Small Group Recommendations. In-app only. | ❌ No explicit behavioral design |
| **DreamBox** | Alerts & Achievements section, struggling student indicators, Lesson Highlights (deep insight into thinking process). In-app only. | ❌ No |
| **i-Ready** | Lesson Alerts, domain shutoff after 2 failures (implicit loss aversion), diagnostic deadline warnings. In-app only. | ⚠️ Implicit (shutoff = loss aversion) |
| **MATHia LiveLab** | Real-time "life preserver" icon for unproductive strugglers, milestone notifications. Most sophisticated in-class monitoring. In-app only. | ⚠️ Partial (productive vs unproductive) |
| **AllHere** | Purpose-built nudge platform (behavioral science + AI chatbot). But focused on **attendance/family engagement**, not instructional progress. SMS-based. | ✅ Yes, but different use case |

### What No One Ships

**Behaviorally-designed, data-driven, proactive nudges to teachers about student math progress.** Every competitor has passive dashboards requiring teachers to opt-in to checking data. Zearn proved the concept (+1.89% to +5.06%) but didn't productize it. The most effective nudge was the simplest: "Log in to see how your students are doing this week."

### Key Insight

Personalized (classroom-specific data) outperformed generic messages by **+2.26%**. Loss aversion and social norm framing have **not been deployed by any competitor** for teachers — open territory.

---

## 3. Confidence × Performance Divergence

> **Research basis:** Dunning-Kruger from KST maps, metacognitive calibration research
> **Related:** [[metacognitive-reflection]]

### Who's Close

| Product | What They Do | Divergence Alert? |
|---|---|---|
| **Eedi** (Craig Barton) | Always-on 5-point confidence emojis on every question. 120M+ answers, 7,302 students. Published Dunning-Kruger patterns (boys overconfident, girls underconfident). Teachers see confidence + correctness. | ❌ Manual teacher filtering, no automated alert |
| **ASSISTments** | Confidence items embedded in problem sets (Lang et al. 2015 RCT). 18+ RCTs on confidence effects. Research infrastructure for controlled experiments. | ❌ Research-only, not productized |
| **Eduphoria Aware** | Face-icon confidence scale during assessments. Teachers filter students by confidence × correctness. Single-Test Analysis view. | ❌ Manual teacher filtering |
| **McGraw Hill SmartBook 2.0** | 3-point confidence after each question. Cumulative confidence threshold triggers forced review when overconfident wrong answers accumulate (4+ points). | ⚠️ Internal algorithmic (adaptive relearning), no teacher-facing alert |
| **Foster & Renie (2024)** | Research showing 6 low-stakes confidence assessments over 2 months **improved calibration** in 12-13 year olds. Reward scheme incentivizes accurate self-assessment. | Research methodology, not a product |

### What No One Ships

**An automated, real-time divergence alert** that combines confidence + performance to flag overconfident/underconfident students to teachers. Eduphoria comes closest with manual filtering. SmartBook uses the signal internally for adaptive relearning but doesn't surface it.

### Key Insight

Calibration **improves with repeated exposure** (Foster & Renie 2024). TTO's BrainBreak already captures confidence longitudinally — combining it with Learnosity performance data creates a unique longitudinal calibration signal no competitor has.

---

## 4. Insight Recall Forward-Priming

> **Research basis:** iRec paper (Hou & Tan 2025), transfer research
> **Related:** [[metacognitive-reflection]] §Just-in-time Recall

### Competitive Positioning Matrix

| Product | Student-Generated | Algorithmic Recall | Contextual Trigger | Skill Tagging | K-12 Math |
|---|---|---|---|---|---|
| **iRec (proposed)** | ✅ | ✅ | ✅ | ✅ | ✅ |
| Readwise | ✅ (highlights) | ✅ (Mastery) | ❌ | ❌ | ❌ |
| RemNote | ✅ (notes→cards) | ✅ (SM-2) | ❌ | ❌ | ❌ |
| Anki | ✅ (cards) | ✅ (FSRS) | ❌ | ❌ | ❌ |
| Duolingo | ❌ (system) | ✅ (HLR) | ❌ | ✅ | ❌ |
| Khan Academy | ❌ (system) | ✅ (Mastery) | ❌ | ✅ | ✅ |
| Eedi | ❌ (system) | Partial | ❌ | ✅ | ✅ |

### What No One Ships

**Anything.** No product combines student-generated insight capture + algorithmic recall + contextual triggering + math skill tagging in K-12. This is **pure white space**.

### Best Precedents to Borrow From

- **Duolingo's HLR model** (Settles & Meeder 2016) — proven algorithm for modeling memory decay per item per student. Could model when a student's insight should be re-surfaced.
- **Readwise's Daily Review + Mastery + Themed Reviews** — closest UX pattern for resurfacing personal content. Stochastic for new items, SRS for reviewed items.
- **Khan Academy's Mastery Challenges** — closest K-12 math spaced review. But system-generated problems only, no student insights.
- **Eedi's misconception tagging** — tagging insights to the same skill taxonomy would enable contextual matching.

### Key Insight

The research gap is also an opportunity: no published evidence exists on context-triggered retrieval of student-generated insights in K-12 math. TTO could contribute to the literature.

---

## 5. Skill Graph Prerequisite Validation

> **Research basis:** Bijl 2025 DAG formalization, ACE Framework (JEDM 2024)
> **Related:** [[skill-tree-competency-structure]], [[knowledge-graph-education]]

### Who's Close

| Product | Graph Type | Visible to Students? | SR Integration? | Validation? |
|---|---|---|---|---|
| **ALEKS** (McGraw Hill) | Knowledge Space Theory — formal partial order. ~25-30 question adaptive assessment identifies knowledge state. | ❌ (pie chart) | ❌ | ✅ (KST axioms enforce closure under union) |
| **Math Academy** (Justin Skycak) | Explicit DAG, ~2,500 topics, 3-4 knowledge points each. **FIRe algorithm** — fractional implicit repetition accounts for trickle-down reviews in prerequisite graph. | ❌ (dashboard) | ✅ (core feature) | ✅ (manual expert review) |
| **Khan Academy** | Courses → Units → Lessons → Skills. Legacy Knowledge Map (node-link graph) **removed ~2018-2020**. Implicit prerequisites in course sequence. | ❌ (removed) | ⚠️ (Mastery Challenges) | Unknown |
| **Prodigy Math** (EdCAT) | Explicit skill tree DAG with validation. Enforces no dependency cycles, no prerequisite with higher difficulty. "Healthy skill trees celebrated with confetti." | ❌ (game UI) | ❌ | ✅ (cycle detection + business rules) |
| **Century Tech** | AI-built knowledge graph connecting micro-lessons. AI learns individual learning patterns. | ❌ | ⚠️ | Unknown |
| **Squirrel AI** | Nanoscale knowledge graph — 30,000 knowledge components (10x ALEKS). BKT for modeling. | ❌ | ❌ | Unknown |
| **Knewton Alta** (discontinued) | Explicit prerequisite DAG. **Bayesian proficiency propagation** — evidence flows through graph to update beliefs about related topics. | ❌ | ❌ | Unknown |

### Key Pattern: No One Shows the Graph to Students

Khan Academy tried it and **removed it**. Most students and teachers prefer guided linear paths. The underlying prerequisite structure still exists but is hidden. This suggests TTO should focus on **teacher-facing graph views** for curriculum design, not student-facing graph exploration.

### What No One Does Well

**Prerequisite validation is rare.** Only ALEKS (KST axioms), Math Academy (manual review), and Prodigy (EdCAT cycle detection) validate graph integrity. Most platforms have implicit prerequisite ordering without formal validation.

### Key Insight

**Math Academy's FIRe algorithm is the closest analog to TTO's Path C.** It explicitly solves scheduling reviews in a prerequisite DAG. Justin Skycak has published extensive technical documentation. TTO's 6-year empirical decay data would strengthen what Math Academy does algorithmically.

---

## 6. Struggle Detection → Adaptive Nudge Timing

> **Research basis:** Productive struggle research, assistance dilemma, JITAI framework
> **Related:** [[productive-struggle]], [[knowledge-tracing]]

### Competitor Comparison Matrix

| Platform | Struggle Signals | Productive vs Unproductive? | Affect Detection | Evidence |
|---|---|---|---|---|
| **MATHia** (Carnegie Learning) | Error patterns, time-on-task, hint usage, wheel-spinning detection (~25% of student-skill pairs) | ✅ "Life preserver" alert for unproductive | ❌ | Strong (25+ yrs CMU research) |
| **DreamBox** | 48,000+ data points/hr per student, strategy evaluation (not just correctness), mouse patterns | ✅ Implicit (ZPD framework) | ❌ | Strong (ESSA Tier 1) |
| **ASSISTments** | Attempts, hints, response time, **HelpNeed predictor model** | ✅ Attempt-first vs hint-first classification | ❌ | Very Strong (extensive research) |
| **ALEKS** | Mastery/non-mastery, periodic reassessment | ❌ Binary only | ❌ | Strong (KST theory) |
| **MathSpring** (UMass) | Performance, **facial expressions**, body language, clickstream | ✅ Confusion vs frustration | ✅ Multi-modal | Strong (active research) |
| **AutoTutor** (Memphis) | Dialogue patterns, facial expression, body language, response latency | ✅ Productive vs unproductive confusion | ✅ Multi-modal | Strong (foundational research) |

### Key Framework: The Assistance Dilemma (Koedinger & Aleven 2007)

Core tension: too much help → shallow learning; too little → frustration and disengagement. Students are **not good at self-regulating help-seeking** — they both over-use and under-use hints. The optimal timing is student-dependent and context-dependent.

### What No One Does

**Combines real-time struggle detection + productive/unproductive classification + adaptive intervention timing + teacher-facing orchestration at scale.** MATHia comes closest but is limited to within-software hints + teacher alerts. Multi-student orchestration (deciding which of 30 students to intervene on first) is barely addressed.

### Key Insight

**Affect detection is mostly research-grade** (MathSpring, AutoTutor) and hasn't been productized commercially. TTO could use less invasive signals (BrainBreak emotion data + Learnosity clickstream + timing) as affect proxies — BrainBreak already captures emotion at session boundaries.

---

## 7. Growth Mindset → Proximal Target Audit

> **Research basis:** Macnamara 2023 meta-analysis (near-zero effects), SDT (autonomy support as key lever)
> **Related:** [[growth-mindset]], [[math-anxiety]], [[self-determination-theory]]

### The Research Is Clear

| Target | Effect on Achievement | Source |
|---|---|---|
| Generic growth mindset messaging | **Near-zero** when design flaws controlled | Macnamara 2023 meta-analysis |
| Self-efficacy ("I can do this specific problem") | **Strong positive** | Math anxiety longitudinal studies |
| Math identity ("I'm someone who can learn math") | **Positive** | Math identity instrument (grades 5-12) |
| Math anxiety reduction | **Strong** (longitudinal STEM gatekeeper) | 3-year longitudinal study |
| Autonomy support (student choice) | **Strongest SDT ingredient** | 36-study SDT meta-analysis |

### What No One Does

No competitor systematically **audits their motivational messaging against research** to distinguish generic growth mindset from proximal, effective constructs. This is a quick-win audit, not a build.

### Key Insight

The audit itself is the differentiator. Finding and fixing misaligned messaging costs near-zero engineering effort but could prevent wasted design cycles on ineffective interventions.

---

## Cross-Cutting Patterns

### 1. Passive Dashboards Dominate, Proactive Nudges Don't Exist

Every major competitor (IXL, DreamBox, i-Ready, Zearn, MATHia) has teacher dashboards. **None** proactively pushes data-driven behavioral nudges to teachers. They all require teachers to opt-in to checking. The Zearn megastudy proved proactive nudges work but didn't productize them.

### 2. Student-Facing Graphs Were Tried and Removed

Khan Academy's Knowledge Map was the most prominent student-facing skill graph. It was removed around 2018-2020 because most students and teachers preferred guided linear paths. This is a strong signal for TTO's Three-Ring visualization: **don't make the graph the primary student view.**

### 3. Confidence Calibration Is Measurable But Not Productized

ASSISTments, Eedi, Eduphoria, and SmartBook all collect confidence × performance data. None has automated the divergence detection into a teacher-facing alert. The research proving calibration improves with repeated exposure (Foster & Renie 2024) makes this a clear opportunity.

### 4. Affect-Aware Intervention Is Research-Grade Only

MathSpring and AutoTutor detect confusion vs frustration using multi-modal signals (facial expressions, body language). No commercial math platform has productized affect detection at scale. TTO's BrainBreak emotion data is a lighter-weight alternative.

### 5. The 6-Year Data Asset Is Underutilized

Most research papers operate in data-scarce environments. Competitors like ALEKS and DreamBox have large datasets but use them primarily for adaptive assessment. TTO's 6 years of empirical decay data, cohort priors, and per-skill forgetting curves is a rare asset that competitors can't replicate quickly.

---

## Related

- [[claude-code-prompts-research-implementation]] — Claude Code investigation prompts for each opportunity
- [[research-to-product-bridge]] — Gap analysis and opportunity map
- [[three-ring-mastery-system]] — Product container
- [[metacognitive-reflection]] — ES=1.11 — the single largest effect size
- [[behavioral-nudges-education]] — Nudge taxonomy + TTO applications
- [[productive-struggle]] — Practice ring foundation
- [[knowledge-tracing]] — Student modeling infrastructure
- [[growth-mindset]] — Near-zero effects — why proximal targets matter
- [[math-anxiety]] — Longitudinal STEM gatekeeper
- [[skill-tree-competency-structure]] — DAG traversal formalization
- [[self-determination-theory]] — Autonomy support as key active ingredient

---

*Competitive research conducted May 2026. Market moves fast — re-verify key claims before major product decisions. Sources: product websites, published research, ESSA evidence tiers, company blog posts.*
