---
description: Layer 3 heading standards define how notes should be structured with outlines that enable skimmable content organization before reading full text.
tags: ["layer-3", "outlines", "standards", "headings"]
---

# Layer 3: Heading Standards

Layer 3 is the **outline layer** — using heading structures (`grep "^#"`) to understand a note's organization before reading full content.

## Universal Rules

| Rule | Description |
|------|-------------|
| **1. Minimum headings** | Every note must have H1 + at least one H2 |
| **2. Max depth** | H4 maximum — deeper means split the note |
| **3. Section order** | Overview → Details → Examples → Related |
| **4. Related Concepts** | Not required — optional, add later if needed |

## Heading Standards by Note Type

### Quick Reference (Interview/Flashcard style)
*Purpose: Fast lookup during interviews or review*

```
# Topic Name

## Key Points
## Common Use Cases
## Edge Cases / Gotchas
## Best Practices
```

### Concept / Reference Notes
*Purpose: Deep understanding of a topic*

```
# Concept Name

## Overview
## How It Works
## Syntax Examples
## Common Patterns
## Related Concepts
```

### Debugging / Case Study Notes
*Purpose: Documenting problems and solutions*

```
# Problem Title

## Issue Summary
## Debugging Process
## Root Cause
## Solution
## Lessons Learned
```

### How-To Guides
*Purpose: Step-by-step instructions*

```
# Task Name

## Prerequisites
## Steps
### Step 1: Name
### Step 2: Name
## Verification
## Troubleshooting
```

### Pattern / Architecture Notes
*Purpose: Reusable design patterns*

```
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

When reviewing a note's outline:

- [ ] Has H1 + at least one H2
- [ ] No heading deeper than H4
- [ ] Sections follow logical order (Overview → Details → Examples → Related)
- [ ] No walls of text (headings every ~10-15 lines)
- [ ] Parallel structure within headings
- [ ] Descriptive, searchable heading names

## See Also

[[yaml-descriptions-layer-2]] — Layer 2 YAML description standards
[[obsidian-claude-101]] — Progressive disclosure overview
