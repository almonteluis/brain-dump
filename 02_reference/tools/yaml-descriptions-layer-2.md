---
description: YAML descriptions are Layer 2 of progressive disclosure — they let agents decide what to read before loading full files.
tags: #progressive-disclosure #layer-2 #yamltags: ["layer-2", "progressive-disclosure", "yaml"]

---

# Layer 2: YAML Descriptions

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
- Description: "Memory retrieval in brains works through spreading activation where neighbors prime each other. Wiki link traversal replicates this..."

When you see the title, you know the claim. When you read the description, you understand **why it matters**.

## How Agents Use This

When Claude needs to find notes on a topic:

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

Claude reads descriptions from output, decides which notes are worth loading context for.

**Step 3: Check outline (Layer 3)**
```bash
grep "^#" "01_thinking/notes/claim-based-titles.md"
```

**Step 4: Load full content (Layer 4)**
Only if steps 1-3 confirm the note is relevant.

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
- ❌ Too long: `"description: Memory retrieval in brains works through spreading activation where neighbors prime each other and wiki link traversal replicates this and..." (should be one sentence)

## Examples

### Good Examples

**Claim-based title + elaborating description:**
```yaml
---
description: Claim-based titles make wiki-links part of sentences, forcing agents to think differently when building arguments.
---

# Claim-Based Titles Are Better Than Topics
```

**Technical concept + explanation:**
```yaml
---
description: Spreading activation explains why memory retrieval surfaces related ideas through network proximity.
---

# Spreading Activation Explains Memory
```

**Pattern + application:**
```yaml
---
description: Small-world topology requires hubs with many connections and dense local connections for efficient traversal.
---

# Small-World Topology
```

### Bad Examples

**Vague description:**
```yaml
---
description: This is about React hooks.
---

# React Hooks Use Cases
```
*(Should be: "React hooks let you add state and lifecycle features to function components without classes.")*

**Repetitive description:**
```yaml
---
description: This note discusses performance optimization.
---

# Performance Optimization
```
*(Should be: "Performance optimization requires focusing on render cycles, bundle size, and memory usage.")*

**Missing description (worst):**
```yaml
---

# Random Note
```
*(No context, no discoverability — agent has to load full file to know if it's relevant)*

## How to Write Good Descriptions

**Template:**
```
[What it is] [how it works / why it matters / what it affects]
```

**Examples using template:**
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

This searches descriptions across the entire vault and returns relevant notes without loading them.

## Summary

**Layer 2 = Search before reading**

Descriptions are your discoverability layer. They:
- Elaborate on titles
- Make notes searchable without loading
- Enable progressive disclosure
- Reduce context noise

**Every note needs one.** Write good ones.
