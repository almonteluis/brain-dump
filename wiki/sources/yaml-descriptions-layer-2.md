---
description: "YAML description standards for Layer 2"
tags: [tools, layer-2, progressive-disclosure, yaml, obsidian, vault-standards]
sources: [yaml-descriptions-layer-2.md]
created: 2026-04-09
updated: 2026-04-09
---

# Layer 2: YAML Descriptions

**Source:** raw/02_reference/tools/yaml-descriptions-layer-2.md
**Date ingested:** 2026-04-09
**Type:** standards

## Summary

YAML descriptions are Layer 2 of progressive disclosure — they let agents decide what to read before loading full files.

## Key Claims

- Every note should have YAML frontmatter with one-sentence `description:` field
- The description elaborates the title — explains why it matters
- Most decisions can be made at description level without loading full files
- Layer 2 is where most filtering happens

## What This Is

Every note in this vault should have a YAML frontmatter with a one-sentence `description:` field.

**Example:**
```yaml
---
description: Memory retrieval in brains works through spreading activation where neighbors prime each other. Wiki link traversal replicates this, making backlinks function as primes that surface relevant contexts.
---

# Spreading Activation
...
```

## Why It Matters

**The description elaborates the title.**

- Title: "Spreading Activation"
- Description: "Memory retrieval in brains works through spreading activation where neighbors prime each other..."

When you see the title, you know the claim. When you read the description, you understand **why it matters**.

## How Agents Use This

**Step 1: Search descriptions first**
```bash
rg "^description:" 01_thinking/*.md
```

**Step 2: Read only what seems relevant**
```bash
# Output:
01_thinking/notes/memory-retrieval.md:description: Memory retrieval works through spreading activation...
01_thinking/notes/claim-based-titles.md:description: Claim-based titles make links part of sentences...
01_thinking/notes/network-topology.md:description: Small-world topology requires hubs and dense local links...
```

**Step 3: Check outline (Layer 3)**
```bash
grep "^#" "01_thinking/notes/claim-based-titles.md"
```

**Step 4: Load full content (Layer 4)**
Only if steps 1-3 confirm relevance.

## Most Decisions Happen at Layer 2

**Key insight:** You rarely need to load full files.

If you're looking for information about:
- **Testing** → Check descriptions for "test", "testing", "assertions"
- **React** → Check descriptions for "React", "components", "hooks"
- **Performance** → Check descriptions for "optimize", "performance", "speed"

The description tells you whether the note is worth loading context for.

## Quality Standards

A good description:
- ✅ **One sentence** (not a paragraph)
- ✅ **Elaborates the title** (explains why it matters)
- ✅ **Contains keywords** (makes it searchable)
- ✅ **Stands alone** (you don't need the note to understand it)

A bad description:
- ❌ Just repeats the title: `"description: This is about testing"` (useless)
- ❌ Too vague: `"description: This is a note"` (no value)
- ❌ Too long: Multiple sentences that should be one

## How to Write Good Descriptions

**Template:**
```
[What it is] [how it works / why it matters / what it affects]
```

**Examples:**
- React.memo is a higher-order component that prevents unnecessary re-renders for performance.
- Claim-based titles make wiki-links part of sentences instead of footnotes.
- Progressive disclosure reduces context noise by filtering before loading.

## Progressive Disclosure Pattern

```
Layer 1: File Tree
   → See folder structure, understand organization

Layer 2: YAML Descriptions (THIS)
   → Search descriptions, decide what's relevant
   → Most decisions happen here — don't need to load full files

Layer 3: Outline
   → Check headings for structure

Layer 4: Full Content
   → Load only if all previous layers confirm value
```

## Integration with Vault Ops

The `vault-ops.sh` script has Layer 2 built in:

```bash
# Search notes by description (Layer 2)
./vault-ops.sh find "memory"
./vault-ops.sh find "react"
./vault-ops.sh find "testing"
```

## Summary

**Layer 2 = Search before reading**

Descriptions are your discoverability layer. They:
- Elaborate on titles
- Make notes searchable without loading
- Enable progressive disclosure
- Reduce context noise

**Every note needs one.** Write good ones.

## Concepts Covered

- [[progressive-disclosure-in-practice]] — Four-layer content navigation
- [[Layer 2]] — YAML description layer
- [[YAML Frontmatter]] — Metadata standards
- [[Discoverability]] — Search without loading

## Related

- [[layer-3-heading-standards]]
- [[obsidian-claude-101]]
- [[sessionstart-tree-hook]]
