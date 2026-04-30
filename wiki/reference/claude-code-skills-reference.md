---
description: Complete guide to all installed Claude Code skills and when to use them
tags: ["claude-code", "skills", "reference"]
created: 2026-04-11
---

# Claude Code Skills Reference

> Complete guide to all installed skills and when to use them.

---

## Skills Overview

### Second Brain Suite (4 skills)
Your knowledge management system for processing and querying Obsidian vaults.

| Skill | Purpose | When to Use |
|-------|---------|-------------|
| **second-brain** | Onboarding wizard for new vaults | Setting up new knowledge base |
| **second-brain-ingest** | Process raw sources into wiki pages | After clipping articles |
| **second-brain-query** | Search and synthesize from wiki | Asking questions from your knowledge |
| **second-brain-lint** | Health-check the wiki | Monthly maintenance |

### Superpowers (15 sub-skills)
Complete software development workflow with TDD, planning, debugging.

**Sub-skills included:**
- `brainstorming` - Explore requirements before building
- `systematic-debugging` - Debug before proposing fixes
- `test-driven-development` - TDD workflow
- `verification-before-completion` - Evidence before assertions
- `using-git-worktrees` - Isolated feature branches
- `subagent-driven-development` - Agent delegation
- `writing-plans` - Create implementation plans
- `requesting-code-review` - Get reviews before completion
- And more...

### Review & Quality (5 skills)

| Skill | Purpose | When to Use |
|-------|---------|-------------|
| **devils-advocate** | Challenges AI plans/code before commit | Pre-mortem analysis, finding blind spots |
| **ux-expert** | UX review & redesign for dashboards | Auditing pages, data-heavy interfaces |
| **code-review** *(plugin)* | Automated PR reviews with confidence scoring | Reviewing pull requests |
| **web-design-guidelines** | Review UI against Vercel guidelines | "Review my UI", accessibility check |
| **vercel-react-best-practices** | React/Next.js performance patterns | Writing/reviewing React code |

### Frontend (3 skills)

| Skill | Purpose | When to Use |
|-------|---------|-------------|
| **frontend-design** *(plugin)* | Create production-grade UI | Building web interfaces |
| **frontend-slides** | HTML presentations from scratch/PPT | Creating presentations, converting PPT |
| **use-effect-killer** | Fix React useEffect anti-patterns | Auditing/cleaning useEffect usage |

### Writing & Communication (2 skills)

| Skill | Purpose | When to Use |
|-------|---------|-------------|
| **writing-clearly-and-concisely** | Apply Strunk's rules to prose | Documentation, commit messages, explanations |
| **find-skills** | Discover and install skills from ecosystem | Finding skills for specific tasks |

### Discovery (1 skill)

| Skill | Purpose | When to Use |
|-------|---------|-------------|
| **superpowers** (using-superpowers) | Ensures skills are used before action | Automatic - invokes other skills |

### Personal Notes

| Folder | Contents |
|--------|----------|
| **learned/** | Your personal learned patterns (notes, not a skill) |
| - `adaptive-quality-3d-mobile.md` | Mobile 3D quality patterns |
| - `react-memo-touch-controls.md` | React touch control patterns |
| - `relay-fragment-refactoring-strategy.md` | Relay fragment strategies |
| - `relay-fragment-typing.md` | Relay fragment typing |
| - `typescript-cache-build-errors.md` | TS cache build errors |
| - `yaml-tag-collision-fix.md` | YAML collision fix |

---

## Skill Deep Dives

### Devil's Advocate
**Purpose:** The skill that asks "are you sure about that?" — finds blind spots, hidden assumptions, failure modes.

**When to use:**
- After Claude generates a plan or code
- Before committing to an approach
- "Challenge this" / "Review this decision"
- Paired with other skills as a review layer

**What it does:**
1. Steel-mans the approach (articulates why it's reasonable)
2. Applies questioning frameworks (pre-mortem, inversion, Socratic)
3. Checks blind spots: security, scalability, failure modes, etc.
4. Verdict: Ship it / Ship with changes / Rethink this

---

### UX Expert
**Purpose:** Professional UX review for B2B SaaS, dashboards, data-heavy applications.

**When to use:**
- "Review this page's UX"
- "Redesign this dashboard"
- "Why does this feel off?"
- Help choosing UI components

**8 Audit Dimensions:**
- Information architecture
- Visual hierarchy
- Cognitive load
- Interaction cost
- Screen real estate usage
- Context-aware color
- Grouping (user mental model vs data source)
- Tab overuse

**Output:** ASCII wireframes + actionable spec

---

### Frontend Slides
**Purpose:** Create stunning, animation-rich HTML presentations.

**When to use:**
- "Create a pitch deck"
- "Convert my slides.pptx to web"
- "Make presentation for my talk"

**Key Features:**
- Zero dependencies (single HTML files)
- Style discovery (shows 3 preview options)
- PPT conversion support
- Critical: **Every slide fits exactly in viewport** (no scrolling within slides)

**Style presets:** Bold Signal, Dark Botanical, Neon Cyber, Swiss Modern, etc.

---

### use-effect-killer
**Purpose:** Audit React code for useEffect anti-patterns.

**When to use:**
- "Clean up my useEffect usage"
- "Review for React best practices"
- "Why is this re-rendering?"

**Anti-patterns detected:**
1. Derived state (compute inline instead)
2. Expensive computation (use useMemo)
3. Reset state on prop change (use key instead)
4. Event logic in effects (move to handler)
5. POST in effect (call directly from handler)
6. Effect chains (consolidate)
7. App initialization in effect (guard with flag)
8. Notify parent in effect (call in handler)
9. External store subscription (useSyncExternalStore)
10. Initialize state from props (pass to useState)

---

### Vercel React Best Practices
**Purpose:** React/Next.js performance optimization from Vercel Engineering.

**45 rules across 8 categories:**

| Priority | Category | Example Rules |
|----------|----------|---------------|
| CRITICAL | Waterfalls | async-parallel, Promise.all() |
| CRITICAL | Bundle | Avoid barrel imports, dynamic imports |
| HIGH | Server | React.cache(), LRU cache |
| MEDIUM-HIGH | Client | SWR for deduplication |
| MEDIUM | Re-render | Memo, stable callbacks, derived state |
| MEDIUM | Rendering | content-visibility, hoist JSX |
| LOW-MEDIUM | JS | Batch DOM changes, cache lookups |
| LOW | Advanced | useLatest for stable refs |

**Trigger:** Automatically activates for React/Next.js tasks.

---

### Writing Clearly and Concisely
**Purpose:** Apply Strunk's rules for clearer, stronger writing.

**When to use:**
- Writing documentation
- Commit messages
- Error messages
- UI text
- Explanations

**Strunk's Key Rules:**
- Use active voice
- Put statements in positive form
- Use definite, specific, concrete language
- Omit needless words
- Place emphatic words at end

**AI patterns to avoid:**
- Puffery: pivotal, crucial, vital, testament
- Empty "-ing" phrases: ensuring, showcasing, highlighting
- Promotional adjectives: groundbreaking, seamless, robust
- Overused AI words: delve, leverage, multifaceted, foster, realm

---

### Find Skills
**Purpose:** Discover and install skills from the open ecosystem.

**When to use:**
- "Is there a skill for X?"
- "How do I do X?"
- "Find a skill for PR reviews"

**Commands:**
```bash
npx skills find [query]        # Search for skills
npx skills add <package>        # Install a skill
npx skills check              # Check for updates
npx skills update             # Update all skills
```

**Browse skills:** https://skills.sh/

---

## Quick Reference: When to Use What

| Situation | Use Skill |
|-----------|-----------|
| Set up new knowledge base | `second-brain` |
| Process clipped articles | `second-brain-ingest` |
| Ask your knowledge base | `second-brain-query` |
| Check wiki health | `second-brain-lint` |
| Starting new feature | Superpowers → brainstorming |
| Debugging issue | Superpowers → systematic-debugging |
| Need TDD | Superpowers → test-driven-development |
| Challenge AI plan/code | `devils-advocate` |
| Review dashboard/page | `ux-expert` |
| Clean up useEffect | `use-effect-killer` |
| Create presentation | `frontend-slides` |
| Improve writing clarity | `writing-clearly-and-concisely` |
| Find more skills | `find-skills` |
| Review PR | `code-review` (plugin) |
| React performance | `vercel-react-best-practices` |

---

## Skills to Keep vs Consider Removing

### ✅ Keep (Core to your workflow)
- **second-brain*** - Your knowledge management system
- **superpowers** - Development workflow
- **devils-advocate** - Critical review layer
- **ux-expert** - Dashboard/UX review
- **frontend-slides** - Presentations
- **use-effect-killer** - React cleanup
- **writing-clearly-and-concisely** - Writing improvement
- **vercel-react-best-practices** - React/Next.js work
- **web-design-guidelines** - UI review
- **find-skills** - Discover more skills
- **learned/** - Your personal notes

### ❌ Consider Removing
None currently - you use all of these!

---

## Symlinked Skills

These are symlinks to `~/.agents/skills/`:
- `find-skills` → `../../.agents/skills/find-skills`
- `frontend-design` → `../../.agents/skills/frontend-design`
- `remotion-best-practices` → `../../.agents/skills/remotion-best-practices`
- `second-brain*** → `../../.agents/skills/second-brain*`
- `superpowers` → `../../.agents/skills/superpowers`
- `use-effect-killer` → `../../.agents/skills/use-effect-killer`
- `writing-clearly-and-concisely` → `../../.agents/skills/writing-clearly-and-concisely`

---

*Last updated: 2026-04-11*
