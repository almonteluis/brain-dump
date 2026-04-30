---
description: Collection of thinking frameworks for decision-making, problem-solving, communication, systems thinking, and planning
tags: ["thinking-frameworks", "decision-making", "problem-solving", "systems-thinking"]
sources:
  - "OODA loop.md"
  - "Six Thinking Hats.md"
  - "Ishikawa Diagram.md"
  - "Concept map.md"
  - "Decision matrix.md"
  - "Conflict Resolution Diagram.md"
  - "Connection circles.md"
  - "Issue trees.md"
  - "Ladder of inference.md"
  - "Minto Pyramid.md"
  - "Productive Thinking Model.md"
  - "First principles.md"
  - "Reinforcing feedback loop.md"
  - "Balancing feedback loop.md"
  - "Situation-Behavior-Impact.md"
  - "Impact-Effort Matrix.md"
  - "Zwicky box.md"
created: 2026-04-22
updated: 2026-04-22
---

# Thinking Frameworks Collection

Thinking frameworks are structured approaches to reasoning that help you move from ambiguity to clarity. For software engineers, they are force multipliers -- whether you are diagnosing a production incident under time pressure, designing a system architecture, resolving a technical disagreement, or prioritizing a backlog. These frameworks reduce [[cognitive-load]] by providing reusable mental scaffolds so you can focus your mental energy on the problem itself rather than on how to approach it.

This collection synthesizes 17 frameworks from [untools.co](https://untools.co), organized into five categories: Decision-Making, Problem-Solving, Communication, Systems Thinking, and Planning & Prioritization.

---

## Decision-Making

### OODA Loop

A four-phase cycle for making fast decisions with incomplete data, developed by military strategist John Boyd: **Observe, Orient, Decide, Act**. You gather available information, synthesize and analyze it, choose a course of action (treating it as a hypothesis), and implement. The key insight is that speed comes not from rushing a single decision but from cycling through the loop repeatedly -- each pass generates new feedback and creates unpredictability for competitors.

**How to use it:** Gather data quickly (observe), synthesize with your experience and challenge assumptions (orient), pick a course of action (decide), and implement immediately (act). Then re-enter the loop.

**SE Application:** Respond to a competitor shipping a similar feature. Observe customer feedback and market data, orient by assessing your product strategy, decide on a counter-feature, act by mobilizing the dev team, then loop back to observe customer reaction.

---

### Decision Matrix

A weighted scoring table for choosing between multiple options across several factors. List your options as rows and your decision factors as columns. Score each option on each factor, assign weights to factors based on importance, multiply scores by weights, and sum them. The highest total wins. This removes gut-feel bias and makes trade-offs explicit.

**How to use it:** (1) List options and factors. (2) Score each option per factor (1-5). (3) Weight each factor. (4) Multiply and sum. (5) Compare totals.

**SE Application:** Choosing between React, Vue, and Svelte for a new project. Factors might include ecosystem maturity, bundle size, team familiarity, and hiring pool. Weighting team familiarity higher reveals the pragmatic choice, even if another framework scores higher on technical merits.

---

### Six Thinking Hats

A method by Edward de Bono for examining a decision from six distinct perspectives, ensuring no angle is overlooked. Each "hat" represents a thinking style: Yellow (benefits/opportunities), Green (creativity/ideas), Red (emotions/intuition), White (data/facts), Black (risks/downsides), and Blue (process control). In groups, assign hats to individuals or cycle through them collectively.

**How to use it:** When facing a decision, deliberately "wear" each hat and generate input from that lens only. The Blue hat manages the process, ensuring all perspectives are covered before concluding.

**SE Application:** Evaluating whether to adopt a new CI/CD tool. White hat gathers benchmark data; Black hat identifies migration risks and downtime; Yellow hat highlights faster deploy times; Green hat brainstorm creative rollout strategies; Red hat gauges team morale about change; Blue hat synthesizes into a go/no-go decision.

---

## Problem-Solving

### Ishikawa Diagram (Fishbone)

A visual root-cause analysis tool created by Kaoru Ishikawa. You define the problem as the "head" of a fish skeleton, then draw "bones" for contributing factor categories (e.g., People, Methods, Tools, Environment), and brainstorm root causes under each category. The diagram forces structured exploration rather than jumping to a single cause. Combine with the "Five Whys" technique to dig deeper under each bone.

**How to use it:** (1) Define the problem. (2) Identify contributing factor categories. (3) Brainstorm root causes under each. (4) Analyze the complete diagram to identify the most likely causes.

**SE Application:** Debugging why a feature has low adoption. Categories: Discovery (users cannot find it), Usability (UI is confusing), Performance (load time too slow), Value (users do not understand the benefit). The diagram may reveal the real issue is discoverability, not the feature itself.

---

### Issue Trees

A structured decomposition of a problem into branches, following the MECE principle (Mutually Exclusive, Collectively Exhaustive). There are two types: **Problem trees** (ask "Why?" to find causes) and **Solution trees** (ask "How?" to find fixes). Start from the problem statement, break it into non-overlapping branches that cover the entire problem, then apply the 80/20 rule to focus on the most impactful branches.

**How to use it:** For problem trees -- break the problem into MECE categories, then sub-branches. For solution trees -- take a prioritized sub-problem and ask "How might we fix this?" Map out solution categories and generate ideas within each.

**SE Application:** "Our API response times have increased." Problem tree branches: Server-side processing, Network latency, Database queries, Client-side rendering. Each branch decomposes further. The tree reveals that 80% of the slowdown comes from unoptimized database queries, not the network as initially assumed.

---

### First Principles

A method for breaking a complex problem down to its most fundamental truths, then rebuilding a solution from those foundations rather than reasoning by analogy. Techniques include the **Five Whys** (repeatedly asking "why" to drill to root causes) and **Socratic questioning** (clarification, probing assumptions, probing evidence, examining implications, exploring alternatives, questioning the question itself).

**How to use it:** (1) Take your problem statement. (2) Break it into the most basic, irreducible truths. (3) Reconstruct a solution from those truths alone, ignoring how things are "normally done."

**SE Application:** Instead of asking "How do we make our deployment faster like Company X?" (reasoning by analogy), ask "What are the actual steps in our deployment pipeline? Which ones are necessary? What is the theoretical minimum time?" Then rebuild the pipeline from those constraints. See also [[context-engineering]] for applying first principles to AI-assisted development.

---

### Productive Thinking Model

A six-step framework by Tim Hurson for creative, structured problem-solving. Best used when the problem is already defined and you need to find creative solutions. Steps: (1) **"What's going on?"** -- understand the problem deeply. (2) **"What's success?"** -- define success criteria using the DRIVE framework (Do, Restrictions, Invest, Values, Essential Outcomes). (3) **"What's the question?"** -- formulate catalytic questions ("How might we...?"). (4) **Generate answers** -- brainstorm without judgment. (5) **Forge the solution** -- evaluate ideas against success criteria using a Decision Matrix. (6) **Align resources** -- assign people, actions, and timelines.

**How to use it:** Work through all six steps sequentially. Steps 1-3 are about understanding and framing. Step 4 is divergent thinking. Steps 5-6 are convergent thinking and execution planning.

**SE Application:** Solving high churn in a SaaS product. Step 1: Gather data on who churns and when. Step 2: Define success as reducing churn by 30% in one quarter. Step 3: "How might we make the first 30 days more valuable?" Step 4: Brainstorm onboarding improvements, guided tutorials, personalized outreach. Step 5: Evaluate with a Decision Matrix. Step 6: Assign engineers to build the top solution with a two-week sprint plan.

---

## Communication

### Minto Pyramid

A top-down communication structure: lead with the **conclusion** (the "bottom line up front" or BLUF principle), then provide **key arguments** that support it, and finally supply **detailed evidence** for anyone who needs to go deeper. This is the opposite of how we naturally build arguments (background then conclusion), but it respects the reader's time and lets them stop reading whenever they have enough information.

**How to use it:** (1) State your recommendation or conclusion first. (2) List 2-4 key arguments that justify it. (3) Provide detailed data, metrics, or evidence only as backup.

**SE Application:** Writing a tech RFC or architecture decision record. Start with "We will use PostgreSQL, not MongoDB" (conclusion). Then "It provides ACID compliance for our financial data, our team has deep SQL expertise, and our query patterns are relational" (key arguments). Then include benchmark comparisons, migration plans, and cost analysis in an appendix (details).

---

### Ladder of Inference

A seven-step model by Chris Argyris showing how we move from observable data to action: (1) Available data, (2) Selected data, (3) Interpretations, (4) Assumptions, (5) Conclusions, (6) Beliefs, (7) Actions. We typically jump from data to action unconsciously, skipping the middle steps. The tool helps you walk back down the ladder, questioning each step to avoid jumping to conclusions.

**How to use it:** When you catch yourself about to act on a conclusion, stop. Identify which rung you are on. Walk down using guiding questions: "What data did I ignore? Are my assumptions valid? What other meanings could this data have?" Then climb back up deliberately.

**SE Application:** A teammate missed three deadlines. Your reflex conclusion: "They are underperforming." Walk down the ladder: What data did you select? Only the missed deadlines. What did you ignore? They volunteered for the hardest tasks, and deadlines were set without their input. The real issue may be unrealistic estimation, not performance. This prevents a damaging conversation and leads to a better process fix.

---

### Situation-Behavior-Impact (SBI)

A feedback framework developed by the Center for Creative Leadership that removes judgment by structuring feedback into three parts: **Situation** (when and where), **Behavior** (what the person actually did, not your interpretation), and **Impact** (the effect it had). An optional fourth step is asking about **Intent** -- what the person meant to do -- which can reveal a gap between intent and impact worth discussing.

**How to use it:** (1) Describe the specific situation. (2) State the observable behavior without interpretation. (3) Explain the impact it had on you, the team, or the project. (4) Optionally ask about their intent. (5) Encourage reflection on how to close the gap.

**SE Application:** Code review feedback. Instead of "Your code is sloppy" (judgment), use: "In the PR for the payment module yesterday (situation), the error handling didn't cover network timeouts (behavior), which means we could silently fail transactions in production (impact). What was your reasoning there? (intent)."

---

### Conflict Resolution Diagram (Evaporating Cloud)

A tool from the Theory of Constraints (Eliyahu Goldratt) for finding win-win solutions. It works backwards from the surface conflict to the shared goal: (1) Identify each side's demands/proposals (these are usually mutually exclusive, creating the conflict). (2) Define the underlying need each side is trying to satisfy. (3) Find the shared goal that both needs serve. Once the shared goal is explicit, you can brainstorm new solutions that meet both needs simultaneously.

**How to use it:** Write down both sides' positions. Ask "What need does each position satisfy?" Then ask "What shared objective do those needs serve?" From the shared goal, build a new solution that satisfies both needs.

**SE Application:** One engineer wants to rewrite a legacy module; another wants to patch it. Demands: rewrite vs. patch. Needs: long-term maintainability vs. shipping the feature on time. Shared goal: deliver a reliable product on schedule. Solution: patch the critical path now, schedule the rewrite as a dedicated sprint with clear success metrics.

---

## Systems Thinking

### Connection Circles

A visual tool for mapping cause-and-effect relationships within a system. Draw a circle, place key system elements (nouns that increase or decrease) around it, then draw arrows between elements showing how one influences another (marked with "+" for increase or "-" for decrease). Closed loops in the diagram reveal feedback loops -- either reinforcing or balancing.

**How to use it:** (1) Draw a circle. (2) Identify key elements (max 10). (3) Map cause-and-effect relationships with arrows. (4) Mark each arrow with +/-. (5) Look for closed loops = feedback loops.

**SE Application:** Mapping why your product has unhappy customers despite shipping more features. Elements: unhappy customers, bugs, support tickets, response time, new features. The circle reveals a reinforcing loop: new features introduce bugs, bugs create support tickets, slow support creates unhappiness, unhappiness drives more feature shipping to compensate, which introduces more bugs.

---

### Reinforcing Feedback Loop

A system dynamic where the output of a cycle amplifies the next cycle, producing exponential growth or decline (not linear). Two or more variables inside the loop reinforce each other. Compound interest is the classic example: more money earns more interest, which adds to the balance, which earns even more interest. External variables may influence the loop but do not change its core mechanism. These loops often coexist with balancing loops in real systems.

**How to use it:** Identify the variables in the loop and the direction of their influence (+/+ or -/-). Understand that small changes will compound over time, for better or worse.

**SE Application:** Technical debt as a reinforcing loop. Rushed code produces bugs, bugs require hotfixes (also rushed), which produce more bugs. Without intervention, quality spirals downward exponentially. Recognizing the loop pattern is the first step to inserting a balancing mechanism (e.g., a dedicated refactoring sprint).

---

### Balancing Feedback Loop

A system dynamic that resists change and seeks stability. It has three components: a **goal** (desired level), the **actual level**, and the **gap** between them. When a gap exists, the loop triggers corrective actions to close it. A thermostat is the classic example -- it detects when temperature deviates from the set point and activates heating or cooling. These loops are self-correcting and often found alongside reinforcing loops.

**How to use it:** Identify the goal the loop is trying to reach, measure the actual level, and understand what corrective action the gap triggers. The goal may not always be explicit.

**SE Application:** Sprint velocity as a balancing loop. The team has a sprint commitment (goal), measures actual story points completed (actual), and adjusts backlog scope or estimation practices when there is a persistent gap. Code review processes also function as balancing loops -- they detect deviations from code quality standards and trigger corrections.

---

### Concept Map

A visual tool for making your understanding of a concept or system explicit. Unlike mind maps (which radiate from a center), concept maps use labeled connections between entities to show specific relationships (e.g., "contributes to," "is made of," "depends on"). Created by Joseph Novak and Alberto Canas, they are useful for learning, knowledge alignment in teams, identifying knowledge gaps, and designing new systems.

**How to use it:** (1) Formulate a focus question. (2) List key entities (15-25). (3) Sort from general to specific. (4) Place on a board and connect with labeled relationship arrows. (5) Verify that any two connected entities read as a meaningful sentence.

**SE Application:** Onboarding at a new company. Focus question: "How does our authentication system work?" Entities: user, session, token, auth service, database, refresh token. Labeled connections: "User authenticates via auth service," "Auth service issues token to user," "Token expires after 24 hours." The map reveals gaps (what happens when the auth service is down?) and aligns team understanding.

---

## Planning & Prioritization

### Impact-Effort Matrix

A 2x2 grid for prioritizing tasks by plotting them along two axes: **impact** (how much value it delivers) and **effort** (how much time/resources it requires). The four quadrants are: **Quick Wins** (high impact, low effort -- do these first), **Major Projects** (high impact, high effort -- plan carefully), **Fill-ins** (low impact, low effort -- do when time permits), and **Thankless Tasks** (low impact, high effort -- avoid or eliminate).

**How to use it:** List all tasks or projects. For each, estimate impact and effort. Place on the grid. Tackle Quick Wins immediately, schedule Major Projects, batch Fill-ins, and eliminate Thankless Tasks.

**SE Application:** Sprint planning with 20 backlog items. Plot each item: "Fix the login bug affecting 30% of users" is a Quick Win (high impact, one-line fix). "Migrate to a new CSS framework" is a Major Project. "Reorganize the /utils folder" is a Fill-in. "Rewrite the internal wiki" is a Thankless Task -- deprioritize. See [[cognitive-load]] for why eliminating low-value work matters.

---

### Zwicky Box (Morphological Box)

A creative thinking tool by Fritz Zwicky for generating novel solutions to complex, multi-dimensional problems. It works by decomposing the problem into key attributes (columns), listing multiple values for each attribute (rows), then systematically combining values across columns to produce complete solution ideas. The power comes from forced association -- combining options you would never naturally pair. Not all combinations work, but some will be genuinely innovative.

**How to use it:** (1) Define the problem. (2) Identify 4-8 key attributes (logically independent). (3) List as many values/options as possible for each attribute. (4) Pick one value from each column to form a complete solution. (5) Evaluate promising combinations.

**SE Application:** Designing a new developer onboarding program. Attributes: delivery format (video, docs, pairing, workshop), timing (day 1, week 1, month 1), mentorship (buddy, team lead, none), assessment (quiz, PR review, none). Combining "workshop + week 1 + buddy + PR review" produces a structured onboarding sprint that looks nothing like your current ad-hoc approach.

---

## Cross-References

These frameworks connect to several existing concepts in this wiki:

- [[cognitive-load]] -- Frameworks reduce cognitive load by externalizing reasoning structure, freeing mental bandwidth for the problem itself.
- [[context-engineering]] -- First principles thinking is foundational for effective context engineering in AI-assisted development.
- [[systematic-debugging]] -- Ishikawa diagrams and Issue trees are structured approaches to debugging complex failures.
- [[testing-patterns]] -- The OODA loop applies directly to TDD cycles (observe test results, orient to what needs fixing, decide on next test, act by writing it).
- [[second-brain-pattern]] -- Concept maps and Connection circles are useful for modeling the relationships in a knowledge base.
- [[fragment-composition]] -- Issue trees and First principles help decompose data requirements when designing GraphQL fragments.
- [[universal-patterns]] -- Reinforcing and balancing feedback loops are universal patterns found across natural and engineered systems.
- [[ai-engineering]] -- Six Thinking Hats and the Decision Matrix are valuable for structured evaluation of AI architecture choices.

---

## Quick Reference Table

| Framework | Best For | Key Question | Category |
|-----------|----------|--------------|----------|
| OODA Loop | Fast decisions under uncertainty | Observe-Orient-Decide-Act -- what does the next cycle tell me? | Decision-Making |
| Decision Matrix | Choosing between multiple options | Which option scores highest across weighted factors? | Decision-Making |
| Six Thinking Hats | Multi-perspective evaluation | What does this look like through each lens (data, risk, benefit, creativity, emotion, process)? | Decision-Making |
| Ishikawa Diagram | Root cause analysis | Why is this happening -- what are all the contributing causes? | Problem-Solving |
| Issue Trees | Systematic problem decomposition | Why is this happening (problem tree) or How do we fix it (solution tree)? | Problem-Solving |
| First Principles | Breaking through conventional thinking | What are the fundamental truths here, and what can I build from them? | Problem-Solving |
| Productive Thinking Model | Creative, structured problem-solving | What's going on, what's success, what's the question, and how do we get there? | Problem-Solving |
| Minto Pyramid | Clear, efficient communication | What is my conclusion, and what are the key arguments supporting it? | Communication |
| Ladder of Inference | Avoiding premature conclusions | What data did I ignore, and are my assumptions valid? | Communication |
| Situation-Behavior-Impact | Non-judgmental feedback | What happened, what did they do, and what was the impact? | Communication |
| Conflict Resolution Diagram | Finding win-win solutions | What is the shared goal behind both sides' demands? | Communication |
| Connection Circles | Mapping system relationships | Which elements influence each other, and where are the feedback loops? | Systems Thinking |
| Reinforcing Feedback Loop | Understanding exponential change | What variables amplify each other in this system? | Systems Thinking |
| Balancing Feedback Loop | Understanding self-correction | What is the goal, and what corrective action closes the gap? | Systems Thinking |
| Concept Map | Making mental models explicit | How do the entities in this system relate to each other? | Systems Thinking |
| Impact-Effort Matrix | Prioritizing work | Which tasks give the most value for the least effort? | Planning & Prioritization |
| Zwicky Box | Generating innovative combinations | What novel solutions emerge from systematically combining attributes? | Planning & Prioritization |
