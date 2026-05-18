---
description: Layer 3 heading standards for vault organization
tags:
  - tools
  - layer-3
  - outlines
  - standards
  - progressive/disclosure
  - obsidian
sources:
  - layer-3-heading-standards.md
created: 2026-04-09
updated: 2026-04-09
---

# Layer 3: Heading Standards

**Source:** raw/02_reference/tools/layer-3-heading-standards.md
**Date ingested:** 2026-04-09
**Type:** standards

## Summary

Defines heading structure standards for notes in the vault. Layer 3 is the outline layer — using heading structures to understand a note's organization before reading full content.

## Key Claims

- Every note must have H1 + at least one H2
- H4 maximum depth — deeper means split the note
- Section order: Overview → Details → Examples → Related
- Headings should appear every ~10-15 lines to prevent walls of text

## Universal Rules

| Rule | Description |
|------|-------------|
| **1. Minimum headings** | Every note must have H1 + at least one H2 |
| **2. Max depth** | H4 maximum — deeper means split the note |
| **3. Section order** | Overview → Details → Examples → Related |
| **4. Related Concepts** | Not required — optional, add later if needed |

## Heading Templates by Type

### Quick Reference (Interview/Flashcard)
```markdown
# Topic Name
## Key Points
## Common Use Cases
## Edge Cases / Gotchas
## Best Practices
```

### Concept / Reference
```markdown
# Concept Name
## Overview
## How It Works
## Syntax Examples
## Common Patterns
## Related Concepts
```

### Debugging / Case Study
```markdown
# Problem Title
## Issue Summary
## Debugging Process
## Root Cause
## Solution
## Lessons Learned
```

### How-To Guides
```markdown
# Task Name
## Prerequisites
## Steps
### Step 1: Name
### Step 2: Name
## Verification
## Troubleshooting
```

### Pattern / Architecture
```markdown
# Pattern Name
## Problem It Solves
## Implementation
## Code Example
## Trade-offs
## When to Use
```

## Heading Level Conventions

| Level | Usage | Frequency |
|-------|-------|-----------|
| H1 (#) | One per note, matches the core concept | 1x per note |
| H2 (##) | Main sections | 4-8 per note |
| H3 (###) | Subsections, details within H2s | As needed |
| H4 (####) | Rare — only for deeply nested details | Avoid if possible |

## Quality Checklist

- [ ] Has H1 + at least one H2
- [ ] No heading deeper than H4
- [ ] Sections follow logical order (Overview → Details → Examples → Related)
- [ ] No walls of text (headings every ~10-15 lines)
- [ ] Parallel structure within headings
- [ ] Descriptive, searchable heading names

## Concepts Covered

- [[progressive-disclosure-in-practice]] — Four-layer content navigation
- [[Layer 3]] — Outline/heading layer
- [[Note Structure]] — Standardized formats by type
- [[Vault Quality]] — Standards and checklists

## Related

- [[yaml-descriptions-layer-2]] — Layer 2 YAML description standards
- [[obsidian-claude-101]] — Progressive disclosure overview
- [[layer-3-audit-summary]] — Audit results
