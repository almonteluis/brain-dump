---
description: A structured 5-layer approach to prompting that maps to how AI models actually process and prioritize information — Identity, Context, Task, Process, Output.
type: framework
category: ai
tags: ["framework", "ai", "prompting", "architecture"]
related_articles:
  - [[2026-01-30 - Why You Suck at Prompting]]
related_concepts:
  - [[Prompt Engineering as System Command]]
---

# 5-Layer Prompt Architecture

## Definition
A structured approach to prompting that maps to how models actually process and prioritize information. Each layer serves a specific purpose, and missing any layer weakens the prompt structure.

## Problem Solved
Most prompts fail because they're missing critical information. Models fill gaps with assumptions, which leads to hallucinations or generic output. This architecture ensures all necessary information is present and properly structured.

## The 5 Layers

### Layer 1: Identity
**Who is the model in this conversation?**

Not just "you are a helpful assistant" but a specific, fine-tuned role with specific skills, expertise, and perspectives.

**Example:**
```
You are a senior product marketer who specializes in B2B SaaS positioning.
You have 10 years of experience converting technical features into emotional benefits.
You write in short, direct sentences.
You never use jargon without explaining it.
You believe the best copy is invisible: it feels like a conversation, not a pitch.
```

**Why it matters:**
- The model doesn't "become" this identity, but it accesses different clusters of training data
- Different roles trigger different stylistic patterns, skills, and reasoning approaches
- Specific roles = more accurate pattern matching

**Bad examples:**
- "You are an AI assistant" (too generic)
- "You are a writer" (too broad)

**Good examples:**
- "You are a senior conversion copywriter specializing in B2B SaaS"
- "You are a full-stack React engineer with experience in state management and performance optimization"

**When to use:** Every prompt. Never skip this layer.

---

### Layer 2: Context
**What does the model need to know to do this task incredibly well?**

This includes contextual background, prior decisions, constraints from earlier conversations, and anything obvious to a human but invisible to the model.

**Example:**
```
Context:
- Product: TaskFlow, a project management tool for remote teams
- Current state: MVP launched, 100 beta users, gathering feedback
- Target audience: Engineering managers at 50-200 person companies
- Pain point: Teams waste 50% of time in status update meetings
- Key value prop: Async workflows reduce meeting time by 50%
- Brand guidelines: Professional but approachable, avoid corporate jargon, no emojis
- Technical constraints: Must be mobile-responsive, load under 2 seconds
- Previous decision: We've decided to emphasize "time saved" over "features added"
```

**Why it matters:**
- The model pattern-matches relevance, not "remembers" context emotionally
- If you don't mark what are rules, what is editable, what is deprecated, it treats everything as equally optional
- This prevents the model from contradicting prior decisions or changing core logic

**Best practices:**
- **Order and label:** Don't dump context like a middle schooler's procrastinated essay
- **Scope it:** Include what's relevant, exclude what's not
- **Label it:** Mark rules vs suggestions vs background
- **Include constraints:** What must never change?

**When to use:** Every prompt, especially for complex tasks or ongoing projects.

---

### Layer 3: Task
**What specific action must be taken by the AI?**

Not "write something about X" but a precise, actionable task with clear success criteria.

**Example:**
```
Task: Create a landing page hero section that communicates the value proposition and encourages signup for TaskFlow.

Specific requirements:
- Primary message: Async workflows reduce meeting time by 50%
- Target audience: Engineering managers (not C-suite, not ICs)
- Goal: Encourage "Get Started Free" signup
- Length: 150-200 words total (headline + body)
- Include: One social proof element
```

**Bad example:**
```
Task: Write marketing copy.
```
(Too vague — what kind of marketing? For whom? To achieve what?)

**Why it matters:**
- The more precisely you define the task, the more precisely the model executes
- Clear success criteria prevent the model from going off-track
- Specificity reduces ambiguity and assumption-filling

**When to use:** Every prompt. Without it, the model will guess what you want.

---

### Layer 4: Process
**How should the model approach this task?**

This is where most prompts fail. Don't ask for text — ask for a process that produces text.

**Example:**
```
Process:
1. First, analyze the target audience (engineering managers at 50-200 person companies) and identify their primary pain points.
2. Then, define positioning that addresses those pain points, emphasizing "time saved" over "features added."
3. Next, draft 3 headline variations that communicate the positioning.
4. Choose the strongest headline based on clarity and emotional impact.
5. Write supporting body copy that reinforces the headline.
6. Review the copy against constraints (no jargon, mobile-friendly length, 150-200 words).
7. Generate a final CTA button variation that fits the "professional but approachable" tone.

Show your reasoning at each step. Do not skip steps. Audit your work following.
```

**Bad example:**
```
Process: Write the copy.
```
(No process — just asking for output)

**Why it matters:**
- You're not asking for answers. You're asking for HOW the answer is formed.
- The best prompts describe thinking order, decision checkpoints, and internal validation
- This mirrors how humans work: research → plan → execute → revise
- Showing reasoning lets you audit the model's thinking

**When to use:** Every complex task. Simple tasks can skip this, but it's better to include it.

---

### Layer 5: Output
**What does "done" actually look like to you?**

Be explicit about the exact format, structure, and requirements.

**Example:**
```
Output format: Return as JSON with these exact fields:
{
  "headline": "string",
  "body_copy": "string",
  "cta_text": "string",
  "social_proof": {
    "type": "string", // e.g., "customer_quote", "statistic"
    "content": "string"
  },
  "reasoning": {
    "audience_pain_points": ["string", "string"],
    "positioning_strategy": "string",
    "headline_selection_rationale": "string",
    "constraint_audit": "string"
  }
}

Do not return any messaging, chat, notes, or explanations outside this JSON structure.
```

**Bad example:**
```
Output format: Give me the copy.
```
(Assumes model knows what format you want)

**Alternative formats:**
- **JSON:** For structured data, APIs, programmatic use
- **Markdown:** For documentation, notes, articles
- **Code blocks:** For code, scripts, configs
- **Table:** For comparison, structured data
- **Bullet list:** For quick reference, summaries

**Why it matters:**
- If you don't tell it exactly, you'll get whatever the model decides to default to
- Sometimes that's fine. Usually, it's not.
- Exact formats enable programmatic use and consistency

**When to use:** Every prompt. Always specify output format.

---

## The Architecture in Practice

### Complete Example (All 5 Layers)

```
Role:
You are a senior conversion copywriter with 10 years of experience in B2B SaaS.
You specialize in clear, benefit-driven copy that converts.
You write in short, direct sentences.
You never use jargon without explaining it.

Context:
- Product: TaskFlow, a project management tool for remote teams
- Current state: MVP launched, 100 beta users, gathering feedback
- Target audience: Engineering managers at 50-200 person companies
- Pain point: Teams waste 50% of time in status update meetings
- Key value prop: Async workflows reduce meeting time by 50%
- Brand guidelines: Professional but approachable, avoid corporate jargon, no emojis
- Technical constraints: Must be mobile-responsive, load under 2 seconds
- Previous decision: Emphasize "time saved" over "features added"

Task:
Create a landing page hero section that communicates the value proposition and encourages signup.
Primary message: Async workflows reduce meeting time by 50%.
Target audience: Engineering managers.
Goal: Encourage "Get Started Free" signup.
Length: 150-200 words total.

Process:
1. First, analyze the target audience and identify primary pain points.
2. Then, define positioning that addresses pain points, emphasizing time saved.
3. Next, draft 3 headline variations.
4. Choose the strongest headline based on clarity and impact.
5. Write supporting body copy (max 150 words).
6. Add one social proof element.
7. Review against constraints (no jargon, mobile-friendly, tone check).
8. Show reasoning at each step.

Output format:
{
  "headline": "string",
  "body_copy": "string (max 150 words)",
  "cta_text": "string",
  "social_proof": {"type": "string", "content": "string"},
  "reasoning": {
    "audience_pain_points": ["string", "string"],
    "positioning_strategy": "string",
    "headline_selection_rationale": "string",
    "constraint_audit": "string"
  }
}

Do not return any chat, notes, or explanations outside this JSON.
```

---

## The Stability Rule

**Miss one layer, structure wobbles.**
**Miss two, it collapses.**

### Layer Impact Analysis

| Layer Missing | What Happens | Severity |
|---------------|---------------|-----------|
| **Identity** | Generic output, wrong tone, inappropriate skill level | HIGH |
| **Context** | Contradictions, ignoring constraints, wrong audience | HIGH |
| **Task** | Wrong action, off-track output, unclear what was requested | HIGH |
| **Process** | Skip reasoning, bad decisions, unstructured thinking | MEDIUM |
| **Output** | Wrong format, inconsistent structure, hard to use | MEDIUM |

## Implementation Guide

### Step 1: Assess the Prompt
Before writing, ask:
- What role should the model play?
- What context does it need?
- What specific action must it take?
- How should it approach the task?
- What format should the output be?

### Step 2: Build Layer by Layer
Don't try to write everything at once. Build each layer deliberately.

### Step 3: Review Against the Architecture
- Is Identity specific and relevant?
- Is Context ordered, scoped, and labeled?
- Is Task precise with clear success criteria?
- Is Process defined with checkpoints?
- Is Output format exact and explicit?

### Step 4: Test and Iterate
- If the result is bad, which layer is missing or weak?
- Fix that layer, test again
- Document what works (add to your library)

## Best Practices

### DO ✅
- Use all 5 layers for every important prompt
- Be specific in each layer (not "copywriter" but "B2B SaaS conversion copywriter")
- Order and label Context (rules vs suggestions vs background)
- Define Process with steps and checkpoints
- Specify Output format exactly (JSON schema, markdown structure)
- Review your prompt against the architecture before sending

### DON'T ❌
- Skip layers "to be flexible" (that's vagueness, not flexibility)
- Dump Context without structure
- Be vague about Task ("write something about X")
- Skip Process (just asking for output)
- Leave Output format unspecified
- Assume the model will "figure it out"

## Integration with Other Frameworks

### Prompt Engineering as System Command
The 5-Layer Architecture is the specific implementation of "Prompt Engineering as System Command."
- Mental model: Engineering vs conversation
- Architecture: How to execute that model

### Canonical Documentation
Context layer should reference canonical docs:
- PRDs for product decisions
- Design systems for style guidelines
- Constraints doc for universal rules

### Role Library
Identity layer can leverage pre-written roles:
- Copy-paste from library
- Adapt per task
- Never start from zero

### Output Format Library
Output layer can leverage pre-written formats:
- JSON schemas
- Markdown patterns
- Paragraph structures

## Example Prompt Templates

### Simple Task (All 5 Layers, Concise)

```
Role: You are a senior React engineer with expertise in state management and performance.

Context: Building a dashboard component for TaskFlow, an async project management tool. Target audience: engineering managers. Must handle 100+ items, filterable, sortable.

Task: Create a React component that displays project items with filtering and sorting.

Process:
1. Define state structure for items, filters, sort settings
2. Create component with hooks (useState, useMemo, useCallback)
3. Implement filtering logic
4. Implement sorting logic
5. Add loading and error states
6. Show key decisions at each step

Output format: React code in a code block with inline comments explaining key decisions.
```

### Complex Task (All 5 Layers, Detailed)

[See the Complete Example above]

---

## Quality Checklist

Before sending a prompt, verify:

**Identity:**
- [ ] Specific role (not generic "assistant")
- [ ] Relevant expertise mentioned
- [ ] Appropriate tone/style defined

**Context:**
- [ ] Ordered and labeled
- [ ] Includes relevant background
- [ ] Notes constraints (what must never change)
- [ ] References canonical docs if applicable

**Task:**
- [ ] Precise action with clear criteria
- [ ] Specific requirements listed
- [ ] Success criteria defined

**Process:**
- [ ] Step-by-step approach defined
- [ ] Decision checkpoints included
- [ ] Reasoning requested
- [ ] Audit step included

**Output:**
- [ ] Exact format specified
- [ ] Structure defined
- [ ] No "just give me X" language

---

**The Bottom Line:**

This isn't arbitrary. It maps to how models actually process and prioritize information. Use all 5 layers, and your prompts will work. Skip them, and you'll get mid results.

Prompting is engineering. Act like it.
