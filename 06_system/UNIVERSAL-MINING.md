---
description: Universal Mining Framework - systematically extract maximum value from meetings, articles, and links.
tags: ["system", "framework", "mining"]
---

# Universal Mining Framework

**Purpose:** Actively mine insights, frameworks, and actionable intelligence from any input type.

**Core Philosophy:** All inputs reveal new reality. Update the vault to match.

---

## The Mining Layers

### Layer 1: Explicit Content
What's directly stated or obvious:
- **Feature ideas:** "Wouldn't it be cool if...", "We could also..."
- **Project sparks:** New tool concepts, standalone initiatives
- **Frameworks:** Mental models, decision principles
- **Philosophies:** Core beliefs, working principles
- **Explicit decisions:** Choices made, direction set
- **Status updates:** "X is now live", "Y is on hold"
- **Action items:** Assigned tasks, next steps
- **Blockers:** What is preventing progress

### Layer 2: Implicit Content
What's embedded or unspoken:
- **Ideas embedded in problem discussions:** "The issue is we don't have X" → X is an idea
- **Philosophies expressed as asides:** "We always say..." → core principle
- **Decisions made by NOT deciding:** "Let's not wait for..." → decision
- **Implied priorities:** "This matters more than that" → value judgment

---

## Pre-Processing Planning Checklist

Before processing any content, create an extraction plan:

### Article/Link Checklist
1. ✅ Archive raw content (full text/link)
2. ✅ Create knowledge summary (core takeaways)
3. ✅ Identify applicable frameworks (add to framework library)
4. ✅ Extract specific ideas (add to ideas vault)
5. ✅ Tag relevant projects (update project notes)
6. ✅ Record citations and references (source management)
7. ✅ Connect to existing knowledge (bidirectional linking)
8. ✅ Identify action inspiration (personal/team application)

### Meeting Checklist
1. ✅ Archive raw transcript
2. ✅ Create meeting summary
3. ✅ Update Project A status (e.g., now live)
4. ✅ Update Project B status (e.g., blocked on X)
5. ✅ Create idea: Feature X for Project A
6. ✅ Create idea: Feature Y for Project A
7. ✅ Create idea: New tool concept Z
8. ✅ Add philosophy to team hub
9. ✅ Update project hubs with new decisions

---

## State Synchronization Protocol

All inputs reveal new reality. Update the vault to match.

### For Each Mentioned Project
1. **Read current hub** to understand existing state
2. **Identify discrepancies** between hub and discussion
3. **Update status** if changed (active → paused, prototype → live)
4. **Add decisions** to key decisions section
5. **Add meeting/article link** to recent updates
6. **Link new ideas** in ideas section

### For Each Framework/Philosophy
1. **Check if already exists** in framework library
2. **If new framework:** Create full entry (definition, source, application)
3. **If existing framework:** Add new insights or applications
4. **Tag relevant projects/ideas**

### For Each Idea
1. **Record full context** (source, proposer, discussion)
2. **Assess potential** (quick win? needs research?)
3. **Connect to relevant projects** and frameworks
4. **Tag potential owner**

---

## Quality Standards & Completion Verification

### Before Marking Processing Complete, Verify:

**General (All Input Types):**
- ✅ Read entire content (no skimming)
- ✅ All explicit decisions captured
- ✅ All implicit decisions captured
- ✅ All feature ideas extracted (including casual mentions)
- ✅ All frameworks/philosophies captured
- ✅ State sync complete (vault reflects post-processing reality)

### Meeting-Specific Red Flags (Incomplete Processing):
- ❌ Summary less than 1 page for 1-hour+ meeting
- ❌ Only 1-2 ideas extracted from brainstorming discussion
- ❌ No status changes identified in status-heavy meeting

### Article-Specific Red Flags (Incomplete Processing):
- ❌ Summary less than 1 paragraph for substantial article
- ❌ Only 1-2 ideas extracted from idea-rich article
- ❌ Article processing only summarizes, doesn't extract applicable frameworks

### Link-Specific Red Flags (Incomplete Processing):
- ❌ Link only saved, not analyzed for value and application
- ❌ No applicable scenarios identified
- ❌ No adoption barrier assessment

---

## Output Quality Standards

### For a 1-Hour 20-Minute Coordination Meeting:
- 3-5 pages of structured notes
- 6-12 specific ideas/feature suggestions
- All project statuses clearly updated
- Decisions and rationales explicitly recorded
- Action items assigned to specific people

### For a Deep Article (10-20 min read):
- Core arguments clearly deconstructed
- Applicable frameworks listed separately
- Connection points to existing knowledge
- Specific action inspiration (can implement this week)
- 3-7 key insights extracted
- Layer 1 AND Layer 2 content captured

### For Tool/Resource Links:
- Not just saving the link
- Analysis of applicable scenarios
- Adoption barrier assessment
- Priority tagging
- Specific application ideas

---

## Application Templates

### Meeting Processing Template

```markdown
# Meeting: {Name} - {Date}

## Core Summary
{3-4 sentence high-level takeaways}

## Key Decisions
- **Decision:** {What}
  - **Rationale:** {Why}
  - **Impact:** {On whom/what}

## Status Changes
### Project A
- **Previous State:** {Previous state}
- **New State:** {Current state}
- **Reason for Change:** {Why changed}

## New Ideas Extracted
### Feature Ideas
1. {Idea description}
   - **Source:** {Who/discussion context}
   - **Potential:** {High/Medium/Low}
   - **Related Project:** {Project link}

### Project Sparks
1. {New project concept}
   - **Trigger:** {What sparked it}
   - **Next Step:** {Validation step}

## Frameworks/Philosophies
- "{Quoted principle}"
  - **Context:** {When/where said}
  - **Application:** {How to apply}

## Action Items
- [ ] {Task} @{Owner} ⏰{Due Date}

## Blockers Identified
- **Blocker:** {What}
  - **Impact:** {On what/who}
  - **Potential Solutions:** {Ideas}
```

### Article Processing Template

See `06_system/templates/article-template.md`

Key sections:
- Core insights (3-7, not just summary)
- Layer 1: Explicit content (ideas, frameworks, philosophies, decisions)
- Layer 2: Implicit content (embedded ideas, implied philosophies, decisions by omission)
- Applicable frameworks (with applications)
- Idea inspiration (how to apply to work)
- Key quotes (context + application)
- Connection points (related projects, similar frameworks, contradicting views)
- Action inspiration (can do this week + long-term impact)

### Link/Resource Processing Template

```markdown
# Resource: {Name/Tool}

## Value Proposition
{What problem it solves/what value it provides}

## Applicable Scenarios
- **Scenario 1:** {When to use}
- **Scenario 2:** {When NOT to use}

## Adoption Assessment
**Strengths:**
1. {Strength 1}
2. {Strength 2}

**Barriers:**
1. {Learning curve}
2. {Integration cost}

## Specific Application Ideas
1. Apply to {project}'s {specific part}
2. Replace {existing solution} because {reason}

## Validation Steps
- [ ] Test: {Small-scale test}
- [ ] Evaluate: {Success criteria}
- [ ] Decide: {Adopt/deprecate}
```

---

## Integration with Your Vault

### Where Things Live

**Meetings:**
- Raw transcripts: `02_reference/sources/meetings/`
- Processed notes: `00_inbox/daily/` → `02_reference/...`

**Articles:**
- Captured: `00_inbox/Links/`
- Processed: `02_reference/sources/articles/`

**Links/Resources:**
- Captured: `00_inbox/Links/`
- Processed: `02_reference/sources/tools/` or `02_reference/sources/articles/`

**Ideas:**
- Feature ideas: Link to relevant project notes
- Project sparks: `01_thinking/projects/`
- Standalone concepts: `02_reference/software-engineer/concepts/`

**Frameworks:**
- Framework library: `02_reference/software-engineer/frameworks/`
- Team philosophies: Project or team hub notes

### State Synchronization

**Project Hubs:** Always update status, decisions, recent changes
**Framework Library:** Add new frameworks or update existing entries
**Concept Notes:** Create for new ideas, link to sources
**Cross-links:** Everything connects bidirectionally

---

## Getting Started

### Week 1: Practice Deep Mining
- Process 2-3 articles using the full Universal Mining Framework
- Focus on extracting Layer 2 content (implicit ideas)
- Practice creating connection points to existing knowledge

### Week 2: State Synchronization
- Process a meeting or two
- Practice updating project hubs with status changes
- Extract frameworks and philosophies from discussions

### Week 3: Quality Gates
- Use red flags checklist to audit your processing
- Identify incomplete processing and fix it
- Build habit of verifying quality before marking complete

### Week 4+: Systematize
- Lean on Levi for automation
- Create custom workflows for recurring input types
- Refine based on what works for you

---

## Levi Integration

**Ask Levi to mine content:**
- "Deep mine this article: [URL]" (uses Layer 1 + Layer 2)
- "Extract all frameworks from this meeting transcript"
- "What implicit ideas are embedded in this discussion?"
- "Update Project X hub with this meeting's decisions"
- "Find all articles about [framework] and create a synthesis"

**Quality control:**
- Review Levi's mining output against quality standards
- Check for Layer 2 content (implicit ideas, philosophies)
- Verify state synchronization is complete

---

**The Goal:** Don't just consume content — mine it for value.

Every article, meeting, or link should either:
1. Change what you know (new insight)
2. Change what you do (new action)
3. Change what you have (new tool/resource)
4. Connect what you know (link existing ideas)

If none of these happen, the content wasn't mined properly.
