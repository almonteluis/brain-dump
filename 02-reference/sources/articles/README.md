---
description: Processed articles organized by date with rich metadata, insights, and connections to concepts.
tags: ["system", "articles"]
---

# Articles

This folder contains processed articles with extracted insights, frameworks, and links to related concepts.

## Naming Convention

`YYYY-MM-DD - Article Title.md`

Example: `2026-01-29 - Relay GraphQL Fragments.md`

## What Goes Here

Articles moved from `00_inbox/Links/` after full processing:
- Complete metadata (author, source, URL, read date)
- One-sentence summary
- Key insights extracted (3-7)
- New concepts defined and linked
- Frameworks documented
- Your thoughts and reactions
- Action items (if any)
- Related vault notes linked via `[[wiki-links]]`
- Rating (1-5 stars)

## Processing Workflow

See `06_system/ARTICLE-WORKFLOW.md` for the complete pipeline:
1. Capture → 2. Process → 3. Integrate → 4. Retrieve

## Quick Commands

**List all articles:**
```bash
ls -1 02_reference/sources/articles/
```

**Find by topic:**
```bash
./vault-ops.sh find "topic"
```

**Backlinks to this article:**
Check the "Related Ideas" section in the article note.

## Quality Standards

Articles in this folder should:
- ✅ Have complete YAML frontmatter
- ✅ Include 3-7 key insights
- ✅ Link to concept notes when applicable
- ✅ Include your thoughts/reactions
- ✅ Be rated (1-5 stars)
- ✅ Remove `#to-process` tag

If an article doesn't meet these standards, either:
- Process it fully before moving here
- Delete it if low-value
- Keep in `00_inbox/Links/` if still processing
