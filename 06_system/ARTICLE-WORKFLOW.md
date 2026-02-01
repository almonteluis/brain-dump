---
description: Complete workflow for capturing, processing, and organizing articles into your knowledge vault.
tags: ["system", "workflow", "article"]
---

# Article Processing Workflow

## The Pipeline

```
[Discover] → [Capture] → [Process] → [Integrate] → [Retrieve]
```

## 1. CAPTURE: Inbox Stage

### When You Find an Article
**Create note in:** `00_inbox/Links/`

**Use template:** `article-template.md`

**Minimum viable note:**
```yaml
---
description: 2-3 sentence summary
url: https://example.com/article
created: 2026-01-29
status: inbox
tags: ["to-process", "article"]
---

# Title

{{paste article content or summarize}}
```

### Capture Options

**Option A: Quick Capture (2 min)**
- Paste URL in article template
- Write 1-sentence description
- Save to `00_inbox/Links/`
- Tag `#to-process`

**Option B: Full Capture (10 min)**
- Read article immediately
- Fill out full template
- Extract key insights
- Already processed!

**Option C: AI-Assisted (recommended)**
- Ask Levi: "I found this article [URL]. Process it into my vault."
- Levi will fetch, summarize, extract insights, create structured note

## 2. PROCESS: Deep Read Stage

### When to Process
- During daily review (15-30 min block)
- When `#to-process` backlog grows >10 items
- Before starting related work

### Pre-Processing Planning Checklist
Before reading, create an extraction plan:

1. **Archive raw content** (full text/link saved)
2. **Scan for depth** - Is this surface-level or conceptual?
3. **Identify applicable frameworks** (add to framework library)
4. **Extract specific ideas** (add to ideas vault if applicable)
5. **Tag relevant projects** (update project notes if applicable)
6. **Record citations** (source management)
7. **Connect to existing knowledge** (bidirectional linking)
8. **Identify action inspiration** (personal/team application)

### Processing Steps

**Step 1: Quick Scan (2 min)**
- Read the `description` field first
- Does it still seem valuable?
- If no → delete or archive immediately

**Step 2: Deep Read (5-10 min)**
- Read the **entire** article (no skimming)
- Highlight key passages mentally or physically
- Take notes in the "Thoughts" section

**Step 3: Universal Mining - Layer 1: Explicit Content (5 min)**
Extract what's explicitly stated:
- **Feature ideas:** "Wouldn't it be cool if..." statements
- **Frameworks:** Mental models, decision principles
- **Philosophies:** Core beliefs, working principles
- **Explicit decisions:** Choices made, direction set
- **Status updates:** If related to projects
- **Tools:** Technologies mentioned with use cases

**Step 4: Universal Mining - Layer 2: Implicit Content (5 min)**
Mine deeper - look for what's not stated:
- **Embedded ideas:** "The issue is we don't have X" → X is an idea
- **Implicit philosophies:** "We always say..." → core principle
- **Decisions by omission:** "Let's not wait for..." → decision
- **Implied priorities:** "This matters more than that" → value judgment

**Step 5: Extract Core Insights (3-5 min)**
Fill in the template:
- **One-Sentence Summary:** The core insight
- **Key Insights:** 3-7 main takeaways (not just summary)
- **New Concepts:** Unfamiliar terms or ideas (create concept notes)
- **Frameworks:** Repeatable patterns or methods (with applications)
- **Tools:** Technologies mentioned (with use cases)

**Step 6: Make Connections (3-5 min)**
- Link to existing vault notes: `[[Concept Name]]`
- Create new note stubs if needed: `[[New Concept]]`
- Answer "Why This Matters" for future you
- Identify connection points to existing knowledge
- Note contradicting views

**Step 7: Action Inspiration (3 min)**
What will you DO with this knowledge?
- **Can do this week:** Specific small actions, quick experiments
- **Long-term impact:** Strategic significance, major initiatives
- **Apply to:** Specific projects or parts of work
- **Replace:** Existing solution because...

## 3. INTEGRATE: File & Link Stage

### File the Article

**Move from:** `00_inbox/Links/`

**Move to:** `02_reference/sources/articles/`

**Filename format:** `YYYY-MM-DD - Article Title.md`

Example: `2026-01-29 - Relay GraphQL Fragments.md`

### Create Concept Notes

For each new concept or framework:

**Create in:** `02_reference/software-engineer/concepts/`

**Filename:** `Concept Name.md`

**Template:**
```yaml
---
description: Brief definition and context for this concept
type: concept
category: {{category}}
tags: ["concept", "{{category}}"]
related_articles:
  - [[Article Name]]
---

# {{Concept Name}}

## Definition
{{What is it?}}

## Why It Matters
{{Why should you care?}}

## When to Use
{{Situations where this concept applies}}

## How It Works
{{Explanation in your own words}}

## Examples
{{Concrete examples or code}}

## Related
[[related concept]]
[[another related thing]]
```

### Update Link Template Articles

If you have old articles using the basic `link-template.md`:

**Option 1:** Update manually using article-template.md
**Option 2:** Ask Levi to migrate: "Migrate my old article notes to the new article template."

## 4. RETRIEVE: Use Your Knowledge

### Finding Articles Later

**By topic:**
```bash
./vault-ops.sh find "graphql"
```

**By tag:**
- Search `#article #graphql`
- Search `#concept #relay`

**By connection:**
- Check backlinks on concept notes
- Look at "Related Ideas" section

### Creating New Content

When writing or building:
1. Search relevant concepts: `./vault-ops.sh find "data fetching"`
2. Read related articles linked to concepts
3. Use frameworks and patterns from articles
4. Reference tools mentioned

### Review & Maintenance

**Daily (5 min):**
- Check `00_inbox/Links/` for new articles
- Process 1-3 articles if backlog

**Weekly (15 min):**
- Review `02_reference/sources/articles/`
- Delete low-value articles (be ruthless)
- Update links to new concept notes
- Remove `#to-process` tags from processed notes

**Monthly (30 min):**
- Review top-rated articles (⭐ 4-5 stars)
- Re-read for deeper understanding
- Update with new connections or insights

## Automation Helpers

### Quick Processing with Levi

**Commands:**
- "Process this article: [URL]"
- "Summarize the article at [URL] and create a vault note"
- "Find articles about [topic] in my vault"
- "Review my article backlog and prioritize what to read"

### Bulk Operations

**List all inbox articles:**
```bash
./vault-ops.sh process
```

**Find unprocessed articles:**
```bash
grep -r "#to-process" 00_inbox/Links/
```

**Validate all articles have descriptions:**
```bash
./vault-ops.sh validate
```

## Quality Standards & Completion Verification

### Output Quality Standards

**Characteristics of Good Article Processing:**

For a **substantial article** (10-20 min read):
- Core arguments clearly deconstructed (not just summarized)
- 3-7 key insights extracted with supporting details
- Applicable frameworks listed separately (with applications)
- Layer 1 explicit content captured (ideas, philosophies, decisions)
- Layer 2 implicit content extracted (embedded ideas, implied beliefs)
- Connection points to existing knowledge made
- Specific action inspiration identified (can implement this week)
- Related notes linked bidirectionally via wiki-links
- Article rated (1-5 stars) with clear rationale

**Red Flags (Incomplete Processing):**
- ❌ Summary less than 1 paragraph for substantial article
- ❌ Only 1-2 ideas extracted from idea-rich article
- ❌ No frameworks extracted from conceptual article
- ❌ Article processing only summarizes, doesn't extract applicable frameworks
- ❌ No connection points to existing knowledge
- ❌ No actionable inspiration (what can I do with this?)
- ❌ Skimming instead of reading entire article

**Before marking complete, verify:**
- ✅ Read entire article (no skimming)
- ✅ All explicit content captured (ideas, frameworks, philosophies)
- ✅ All implicit content extracted (embedded ideas, unspoken beliefs)
- ✅ Applicable frameworks identified separately
- ✅ Connection points to existing knowledge made
- ✅ Specific action inspiration identified (can implement this week)
- ✅ Related notes linked bidirectionally
- ✅ Article rated (1-5 stars) with rationale

### DO ✅
- Start with a quick description (don't skip this!)
- Extract insights, don't just summarize
- Mine Layer 1 AND Layer 2 content
- Link to existing notes whenever possible
- Delete low-value articles (your time is expensive)
- Rate articles and revisit high-value ones
- Create concept notes for reusable ideas
- Identify action inspiration (this week + long-term)

### DON'T ❌
- Archive everything (be selective)
- Copy-paste entire articles (summarize instead)
- Skip the "Why This Matters" section
- Leave `#to-process` tags forever
- Create orphan notes (no links to/from)
- Only capture surface-level content
- Skip implicit content mining (Layer 2)

### Taxonomy Tags

**Categories:**
- `#frontend` - React, UI, UX, CSS, etc.
- `#backend` - APIs, databases, architecture
- `#system-design` - Architecture, scaling
- `#career` - Leadership, hiring, growth
- `#tooling` - Dev tools, automation
- `#ai` - AI, ML, LLMs
- `#management` - Team, processes

**Difficulty:**
- `#easy` - Introductory, quick read
- `#medium` - Requires some background
- `#hard` - Technical, dense, takes focus

**Status:**
- `#inbox` - New, not processed
- `#processing` - Currently reading
- `#processed` - Done, integrated
- `#archived` - Old but valuable

## Example: End-to-End Processing

### 1. Capture
You find: https://relay.dev/docs/tutorial/fragments-1/

```bash
# Create note from template
cp "06_system/templates/article-template.md" "00_inbox/Links/Relay GraphQL Fragments.md"
```

Fill in URL, quick summary, save.

### 2. Process
Read the article, fill in:
- One-Sentence Summary
- Key Insights (3-7)
- New Concepts (Fragment, Fragment Reference, Data Masking)
- Frameworks (Fragment Pattern)
- Thoughts on co-location vs prop drilling

### 3. Integrate
**Create concept note:** `02_reference/software-engineer/concepts/Relay Fragments.md`
**Move article:** `02_reference/sources/articles/2026-01-29 - Relay GraphQL Fragments.md`
**Remove tag:** Delete `#to-process`

### 4. Retrieve
Later, when working on GraphQL:
```bash
./vault-ops.sh find "graphql"
# Finds article + concept note
```

Read backlinks from concept note to related patterns.

## Getting Started

**Week 1:**
- Use article-template.md for new articles
- Process 1-2 articles per day
- Don't worry about backlog yet

**Week 2:**
- Create concept notes for key ideas
- Start using `./vault-ops.sh` commands

**Week 3+:**
- Build habit of daily processing
- Leverage Levi for automation
- Review and refine your workflow

---

The goal isn't to read everything. It's to **retain what matters** and **use it when you need it**.
