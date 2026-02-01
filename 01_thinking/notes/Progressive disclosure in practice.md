---
description: Progressive disclosure in practice — using file tree, YAML descriptions, outlines, and full content to efficiently navigate and understand an Obsidian knowledge vault with Claude Code.
tags: ["progressive-disclosure", "layer-1", "layer-2", "layer-3", "layer-4", "obsidian", "claude-code"]
created: 2026-01-29
---

# Progressive Disclosure in Practice

## The Four Layers

| Layer | Tool | Question | Decision Point |
|-------|------|----------|----------------|
| **1** | File tree (injected at SessionStart) | What exists and where? | Skip entire categories |
| **2** | YAML descriptions (grep frontmatter) | What is this about? | Most decisions happen here |
| **3** | Outlines (grep "^#") | How is it structured? | Jump to specific section |
| **4** | Full content | Read the details | ~10% of notes make it here |

## Real-World Example

**Task:** Find information about React hooks

### Layer 1: File Tree
```
02_reference/software-engineer/
├── Frontend/React/
│   ├── Hooks.md
│   ├── useState.md
│   ├── UseEffect Detailed Examples.md
│   └── practice useRef hooks.md
└── Quick Reference/
    └── What is the difference between "useState" and "useEffect"...
```

→ *Relevant folder identified, multiple hook-related notes exist*

### Layer 2: YAML Descriptions
```
Hooks.md: "React hooks reference covering useState, useEffect, useContext..."
useState.md: "Local state management that triggers re-renders..."
useEffect.md: "Side effects like data fetching, subscriptions..."
```

→ *Hooks.md = reference, useState = specific, useEffect = what I need*

### Layer 3: Outline (grep "^#")
```
# useEffect Hook
## Key Points
## Best Practices
### Dependencies
### Cleanup
### Performance
```

→ *Jump to "## Cleanup" section*

### Layer 4: Full Content
Read the cleanup function example and explanation.

→ *Done, without reading the entire note*

## Key Insight

> **Most decisions should happen at Layer 2.** If descriptions are well-written, you rarely need Layers 3 or 4.

## Performance Impact

| Without progressive disclosure | With progressive disclosure |
|-------------------------------|------------------------------|
| Open 10+ files to find answer | Read 10 descriptions, open 1 file |
| Parse full content to filter | Filter by filename/description |
| Re-explore vault each session | Tree injected once at start |

## Related

[[sessionstart-tree-hook]]
[[layer-3-heading-standards]]
[[yaml-descriptions-layer-2]]
[[obsidian-claude-101]]
[[Energy Spectrum Universal Pattern]]
[[vault-wide-connections-synthesis]]
