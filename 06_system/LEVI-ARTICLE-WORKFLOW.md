---
description: Quick reference for processing articles with Levi's help.
tags: ["system", "levi", "workflow"]
---

# Article Processing with Levi

## Quick Commands

### Capture New Article
**You:** "Save this article to my vault: https://example.com/article"

**Levi does:**
- Fetches the article
- Creates note from `article-template.md` in `00_inbox/Links/`
- Extracts key points
- Adds `#to-process` tag

### Process Article Now
**You:** "Process this article: https://example.com/article"

**Levi does:**
- Full read and analysis
- Fills complete template:
  - One-sentence summary
  - 3-7 key insights
  - New concepts (creates concept notes if needed)
  - Frameworks and patterns
  - Tools mentioned
  - Your thoughts section
- Moves to `02_reference/sources/articles/`
- Links to related notes
- Removes `#to-process`

### Find Articles on Topic
**You:** "Find articles about [topic] in my vault"

**Levi does:**
- Searches `02_reference/sources/articles/`
- Lists relevant articles with summaries
- Shows related concepts

### Process Backlog
**You:** "Process my article backlog" or "What articles need processing?"

**Levi does:**
- Lists all `#to-process` articles
- Prioritizes by recency or topic
- Processes 1-3 articles if you ask

### Migrate Old Articles
**You:** "Migrate my link-template articles to the new article template"

**Levi does:**
- Finds all articles using `link-template.md`
- Converts to `article-template.md`
- Fills in missing metadata where possible
- Preserves existing content

## Advanced Workflows

### Create Concept Note from Article
**You:** "Extract the concept of [X] from this article and create a concept note"

**Levi does:**
- Creates note in `02_reference/software-engineer/concepts/`
- Defines the concept
- Links back to article
- Adds to taxonomy

### Research a Topic
**You:** "Research [topic] using my vault + web search"

**Levi does:**
- Searches vault for related articles and concepts
- Uses web search for new info
- Synthesizes findings
- Creates summary note

### Create Study Guide
**You:** "Create a study guide for [framework/tool] from my vault"

**Levi does:**
- Gathers all related articles and concepts
- Structures as learning path
- Prioritizes by difficulty or sequence

## Best Practices

### When to Use Levi
- **DO use** for:
  - Initial capture (saves time)
  - Full processing (Levi is thorough)
  - Research across multiple notes
  - Creating concept notes
  - Migrating old content

- **DON'T use** for:
  - Quick captures you'll process yourself later
  - Personal thoughts (you know best)
  - Very technical articles (read it yourself)

### Quality Control
After Levi processes an article:
1. ✅ Check the one-sentence summary
2. ✅ Review key insights (3-7 is the sweet spot)
3. ✅ Make sure related notes are linked
4. ✅ Add your personal thoughts
5. ✅ Rate the article (1-5 stars)

### Customization
You can customize Levi's output:
- **Focus on code:** "Extract the code examples from this article"
- **Focus on concepts:** "Focus on the theoretical concepts, not implementation"
- **Add specific tags:** "Tag this as #frontend and #system-design"
- **Skip certain sections:** "Don't worry about the tools section"

## Example Sessions

### Session 1: Quick Capture
**You:** Found an article on Relay fragments, but busy right now
**You:** "Save this for later: https://relay.dev/docs/tutorial/fragments-1/"

**Levi:** Creates note in `00_inbox/Links/`, marks as `#to-process`

### Session 2: Process Later
**You:** "Process the Relay fragments article I saved"

**Levi:**
- Reads full article
- Extracts insights about co-location, data masking
- Creates concept notes for "Relay Fragments", "Data Masking"
- Moves to `02_reference/sources/articles/`
- Removes `#to-process`

### Session 3: Research
**You:** "What do I know about GraphQL in my vault?"

**Levi:**
- Finds Relay fragments article
- Finds related GraphQL concepts
- Summarizes your current knowledge
- Suggests gaps or further reading

## Getting Started

**Day 1:**
- Try: "Save this article: [URL]"
- Levi creates note in inbox

**Day 2:**
- Try: "Process that article"
- Levi fills template and integrates

**Day 3:**
- Try: "Find articles about [topic]"
- Levi searches and presents

**Week 1:**
- Build habit of asking Levi to process articles
- Review Levi's work and provide feedback
- Customize to your preferences

---

Levi is your knowledge assistant. Use him to automate the boring parts so you can focus on the thinking and connecting.
