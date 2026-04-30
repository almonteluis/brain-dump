---
description: "Progressive disclosure framework for vault navigation"
tags: [progressive-disclosure, obsidian, claude-code, layer-1, layer-2, layer-3, layer-4]
sources: ["Progressive disclosure in practice.md"]
created: 2026-04-09
updated: 2026-04-09
---

# Progressive Disclosure in Practice

**Source:** raw/01_thinking/notes/Progressive disclosure in practice.md
**Date ingested:** 2026-04-09
**Type:** thinking note

## Summary

Framework for efficiently navigating and understanding an Obsidian knowledge vault with Claude Code using four progressive layers: file tree, YAML descriptions, outlines, and full content. Reduces cognitive load by filtering information at each layer.

## Key Claims

- Most decisions should happen at Layer 2 (YAML descriptions)
- If descriptions are well-written, you rarely need Layers 3 or 4
- Progressive disclosure reduces context noise and improves navigation efficiency
- Layer 4 (full content) is only needed for ~10% of notes

## The Four Layers

| Layer | Tool | Question | Decision Point |
|-------|------|----------|----------------|
| **1** | File tree (injected at SessionStart) | What exists and where? | Skip entire categories |
| **2** | YAML descriptions (grep frontmatter) | What is this about? | Most decisions happen here |
| **3** | Outlines (grep "^#") | How is it structured? | Jump to specific section |
| **4** | Full content | Read the details | ~10% of notes make it here |

## Real-World Example

**Task:** Find information about React hooks

**Layer 1: File Tree**
```
02_reference/software-engineer/
├── Frontend/React/
│   ├── Hooks.md
│   ├── useState.md
│   └── UseEffect Detailed Examples.md
```
→ *Relevant folder identified*

**Layer 2: YAML Descriptions**
```
Hooks.md: "React hooks reference covering useState, useEffect..."
useState.md: "Local state management that triggers re-renders..."
useEffect.md: "Side effects like data fetching..."
```
→ *useEffect = what I need*

**Layer 3: Outline**
```
# useEffect Hook
## Key Points
## Best Practices
### Dependencies
### Cleanup
```
→ *Jump to "## Cleanup" section*

**Layer 4: Full Content**
Read the cleanup function example.
→ *Done, without reading the entire note*

## Performance Impact

| Without progressive disclosure | With progressive disclosure |
|-------------------------------|----------------------------|
| Open 10+ files to find answer | Read 10 descriptions, open 1 file |
| Parse full content to filter | Filter by filename/description |
| Re-explore vault each session | Tree injected once at start |

## Connection to Energy Spectrum

| Progressive Disclosure | Energy Spectrum |
|------------------------|-----------------|
| Layer 1 (File Tree) | Red (Root) — What exists? Am I safe? |
| Layer 2 (Descriptions) | Orange/Yellow — What is this? What do I need? |
| Layer 3 (Outlines) | Green (Heart) — How is it structured? |
| Layer 4 (Full Content) | Blue/Purple — Deep understanding, transcendence |

Skipping layers in progressive disclosure is like trying to access crown chakra with blocked root — you get "stuck" in information overload rather than understanding.

## Concepts Covered

- [[progressive-disclosure-in-practice]] — Layered information revelation
- [[Information Architecture]] — Structuring knowledge for efficient access
- [[Cognitive Load Reduction]] — Minimizing mental effort in navigation
- [[SessionStart Pattern]] — Injecting context at session beginning

## Related

- [[sessionstart-tree-hook]]
- [[layer-3-heading-standards]]
- [[yaml-descriptions-layer-2]]
- [[obsidian-claude-101]]
- [[energy-spectrum-universal-pattern]]
- [[vault-wide-connections-synthesis]]
