---
description: Notes about obsidian-claude-101.
---

# Obsidian + Claude Code 101: Context Engineering

> **Note:** This guide applies to both Claude Code and Clawdbot. The principles are universal — markdown files, wiki links, progressive disclosure, and intelligent agent operation work the same across platforms. Tooling specifics may vary, but the thinking system remains the same.

## Philosophy

**Depth over breadth. Quality over speed.**

This is not about efficiency. This is about excellence. When you pick a task, you are committing to understanding it completely and leaving behind work that future agents can build on.

> "I can feel the difference when the vault is well maintained versus full of noise."

The deeper insight: a vault encodes **how you think**, not just what you thought about. The methodology becomes part of the system. It's all just markdown files — you own it completely.

---

## What is a Vault?

A vault is a folder of markdown files that link to each other.

```
my-vault/
├── 00_inbox/          # Capture zone, zero friction
├── 01_thinking/       # Your notes and synthesis
│   └── notes/         # Individual thinking notes
├── 02_reference/      # External knowledge
│   ├── tools/         # Tool documentation
│   ├── approaches/    # Methods and patterns
│   └── sources/       # External knowledge
├── 03_creating/       # Content in progress
│   └── drafts/
├── 04_published/      # Finished work archive
├── 05_archive/        # Inactive content
├── 06_system/         # Templates and scripts
├── CLAUDE.md          # Teaches the AI your system
└── attachments/       # Images and files
```

Files connect using `[[wiki links]]` which build a network of ideas. When you write `[[quality is the hard part]]` in one note, it creates a clickable link to another note with that title. The agent can follow these links to jump between related ideas, discovering connections you forgot existed.

**The point isn't the specific folders** but that folder location tells you what something is. Markdown is the system. Tools like Obsidian are just windows into it. The vault could survive any app disappearing — everything is plain text that any editor can read and any AI can process.

---

## Progressive Disclosure: 4 Layers of Selectivity

Vibe note-taking works better if you force Claude Code to be selective about what it reads by default. The pattern is called **progressive disclosure**.

### Layer 1: File Tree

A session start hook injects the full file tree before Claude touches anything.

```json
"hooks": {
  "SessionStart": [{
    "hooks": [{
      "type": "command",
      "command": "tree -L 3 -a -I '.git|.obsidian' --noreport"
    }]
  }]
}
```

This gives Claude the map before it starts exploring. Filenames are descriptive so they work as a first impression. `"queries evolve during search so agents should checkpoint.md"` tells you more than `"search-notes.md"`. Just reading the tree already shows what notes are about.

### Layer 2: YAML Descriptions

Every note has a one sentence description in the frontmatter YAML.

```yaml
---
description: Memory retrieval in brains works through spreading activation where neighbors prime each other. Wiki link traversal replicates this, making backlinks function as primes that surface relevant contexts.
---

# Spreading Activation
...
```

The description elaborates the title. If something seems interesting, Claude queries it with ripgrep:

```bash
rg "^description:" 01_thinking/*.md
```
[[yaml-descriptions-layer-2]]
### Layer 3: Outline

If a note passes the description filter, Claude checks the outline. Sometimes you only need one section and loading the full file would create noise.

```bash
grep -n "^#" "01_thinking/knowledge-work.md"
# Output:
#  5:# knowledge-work
# 13:## Core Ideas
# 19:## Tensions
# 23:## Gaps
```

Now Claude knows where to look and can read what it needs.

### Layer 4: Full Content

If everything seems relevant for the task, Claude loads the full file — but only for notes that passed all three filters.

**Most notes never get here.** That's the point. When Claude has to justify each read, it curates better.

### The MCP Parallel

This isn't a new pattern. MCP tool discovery works the same way. When you have 50+ tools, Claude doesn't load all definitions into context upfront. Tool specs are available but deferred until Claude actually searches for them.

Plaintext tool list → tool search → tool references → full definitions.

Same structure: plaintext file tree → descriptions → outline → full content.

---

## Core Principles

These are the rules that work for a personal thinking vault. Other vault types (work, research, creative) might need different ones.

### 1. Composability

**Can this note be linked from elsewhere and still make sense?**

If linking to it forces you to explain three other things first, split it up. Notes should stand alone. If someone lands on a note from a link, they shouldn't need to read five other notes first to understand it.

Think of notes like lego blocks — each one is complete on its own, but they connect to build bigger structures.

### 2. Claim-Based Titles

Stop naming notes like topics. Start naming them like claims.

❌ "Thoughts on AI slop"
✅ "Quality is the hard part"

When you link to it, the title becomes part of your sentence naturally: `because [[quality is the hard part]] we need to focus on curation`. This also forces Claude to think differently when building sentences — it requires understanding, not just pattern matching.

### 3. Relationships Over Isolation

Individual notes matter less than their relationships. A note with many incoming links is more valuable than an isolated note because every link creates a new reading path.

**The network is the knowledge.**

### 4. Weave Links, Don't Footnote

Most people put references at the bottom like footnotes. Instead, weave links into your sentences.

❌ "This relates to quality, see: quality-note"
✅ "because [[quality is the hard part]] we need to focus on curation"

The link becomes part of your thought, and the agent can follow your reasoning by following the links.

---

## How the Agent Operates (Universal Principles)

Every task starts with **orientation**.

1. **Scan the structure** — The tree hook shows folders and files
2. **Check the index** — A single file listing every note with a one-sentence description. Claude can scan 50 notes in seconds without opening them.
3. **Read the topic page** — Topic pages (MOCs) link to related notes and act like tables of contents. They also contain notes Claude leaves for itself about what it learned while traversing the graph, leaving breadcrumbs for future sessions.
4. **Follow links to build understanding** — The AI starts broad, narrows to what's relevant, then follows links to build understanding.
5. **Make no changes without context** — Never modify anything without reading surrounding context first.

### Discoveries Get Recorded

When Claude discovers something useful about navigating a topic, it records that in the topic page. Future sessions read those notes and learn from past navigation. **This is how the vault remembers how to think through itself.**

Sometimes two notes interact in interesting ways. Claude creates a new note capturing the insight that emerges from combining them. Every new capture triggers a search for related notes, and Claude adds links with context.

---

## Vibe Note-Taking 101: Editing Workflow

### The Problem

Editing long content with Claude Code the normal way sucks.

The workflow looks like this:
1. Read through your draft
2. Notice paragraph 3 needs work
3. Copy that paragraph, paste it to Claude with your comment
4. Scroll to paragraph 7, copy that one too
5. Paste it with another comment
6. Scroll to paragraph 12, same thing

The edits work fine. It's the back and forth that's annoying.

Same problem when you have edits across multiple files that need to stay consistent with each other:
- "Hey Claude, in this file I need you to change the part where it says vaults are cool to something more specific..."
- "Then in the other file update the reference to match..."
- "Oh, and also in that third file..."

### The Solution: Spatial Editing

Instead of bringing text TO Claude, you leave instructions WHERE they belong.

**Curly braces mark your thoughts and edit instructions.** Each comment applies to its surrounding text, or points somewhere else if you say so.

### Example

**Input:**
```markdown
# Why Vaults Matter

Vaults give Claude memory {feels abstract}

Without persistent storage, Claude forgets everything between sessions {this is the key point, make it hit harder}

The solution is simple {don't say simple, show}
```

**Output:**
```markdown
# Why Vaults Matter

Vaults give Claude persistent memory across sessions by storing context in files it can read and write

Without persistent storage, Claude starts fresh every conversation. You re-explain the same context, rebuild the same understanding, lose the compound effect of accumulated knowledge.

The solution: Store everything in markdown files that Claude can traverse
```

The command outputs a summary so you know what changed:

```
processed 3 edits in why-vaults-matter.md:
1. "feels abstract" → added concrete mechanism
2. "make it hit harder" → expanded with specific pain points
3. "don't say simple" → replaced with direct statement
```

### The Command

**Currently open file:**
```
/edit
```

**Specific file:**
```
/edit draft.md
```

**Multiple files:**
```
/edit draft.md notes.md
```

If you run `/edit` with nothing open, it searches your vault for `{thoughts}`:

```bash
rg "\{[^}]+\}" --type md -l
```

Then lets you pick which files to edit.

### The Workflow

1. **Write your draft without stopping** — Don't interrupt flow
2. **Do a quick read** and drop `{thoughts}` wherever something feels off
3. **Run `/edit`** — Let Claude process all the edits at once
4. **Review changes**

### Position IS Context

You don't need to explain what you're referring to because the comment knows where it lives. The instruction travels with the text it applies to. This is spatial editing — context is baked into position.

---

## Mining Meeting Transcripts

### The Philosophy

Your philosophy of how you write notes, connect them, and structure knowledge is way more complex than you think. A lot of it happens subconsciously — you couldn't write it down because you didn't know you were doing it.

**Transcripts help to externalize that.**

When you talk through something, you naturally include:
- Your reasoning path
- Your uncertainties
- The alternatives you considered

You explain things in depth because you're responding to another person. All of that becomes capturable context.

### The Core Idea

**This is mining, not summarizing.**

A rich 1-hour meeting can yield:
- 10+ ideas
- Multiple frameworks
- A dozen decisions
- State changes across multiple projects

If you're producing a short summary with 3-4 bullet points, you're not going deep enough.

### Define the Role

```markdown
<role>
You are the knowledge architect for this vault. You process meeting transcripts with exhaustive depth, mining every valuable insight, idea, philosophy, decision, and status update.

Meetings are the primary sync mechanism between reality and vault state. Missing content is unacceptable.
</role>
```

### What to Hunt For

As you read, actively hunt for:

**Explicit content:**
- Feature ideas ("wouldn't it be cool if...", "we could also...")
- Project sparks (new tool concepts, standalone initiatives)
- Frameworks (mental models, principles, ways of thinking)
- Philosophies (team beliefs, working principles)
- Decisions (explicit choices made, direction set)
- Status updates ("X is now live", "Y is on hold")
- Action items (tasks assigned, next steps)
- Blockers (what is preventing progress)

**Implicit content:**
- Ideas embedded in problem discussions ("the issue is we don't have X" → X is an idea)
- Philosophies expressed as asides ("we always say..." → philosophy)
- Decisions made by NOT deciding ("let's not wait for..." → decision)

### Plan First, Write Later

Before writing anything, plan all extractions.

**Example todo list for a complex meeting:**
1. Archive raw transcript
2. Create meeting summary
3. Update Project A status (now live)
4. Update Project B status (blocked on X)
5. Create idea: Feature X for Project A
6. Create idea: Feature Y for Project A
7. Create idea: New tool concept Z
8. Add philosophy to team hub
9. Update project hubs with new decisions

### The Key Insight: Vault State Synchronization

Meetings reveal new reality. Update the vault to match.

**For each project mentioned:**
1. Read the current hub to understand existing state
2. Identify discrepancies between hub and meeting discussion
3. Update status if changed (active → paused, prototype → live)
4. Add decisions to "Key Decisions" section
5. Add meeting link to "Recent Meetings"
6. Link new ideas in ideas section

### Quality Standards

Before marking processing complete, verify:

- ✅ Read entire transcript (no skimming)
- ✅ All explicit decisions captured
- ✅ All implicit decisions captured
- ✅ All feature ideas extracted (even casual mentions)
- ✅ All frameworks/philosophies captured
- ✅ All status changes reflected in project hubs
- ✅ State sync complete (vault reflects post-meeting reality)

**Red flags (processing incomplete):**
- ❌ Meeting summary is shorter than 1 page for hour+ meeting
- ❌ Only 1-2 ideas extracted from brainstorming discussion
- ❌ No state changes identified in status-heavy meeting

### What Good Output Looks Like

For a 1h 20m weekly coordination meeting:
- 1 archived transcript
- 1 comprehensive meeting summary
- 7 feature idea notes across multiple projects
- 2 framework notes
- 4 philosophy additions to team hub
- 3 project hub status updates
- 9 hub updates across projects and areas
- **20+ files created or modified**

**Yapping is work.**

When you talk through something with depth, you're creating knowledge. The transcript is just the raw material — the mining is where the value happens.

---

## Yapping to PRDs: From Meetings to Structured Knowledge

### The Shift

Meetings used to be overhead. **Now yapping is work.**

When my coworker and I yap about a project, we record it. An hour later:
- The transcript gets processed
- Documentation appears
- Feature ideas land in the backlog
- Decisions captured with their reasoning
- Project status updated
- Working philosophy notes extracted

Everything is connected with wiki links to all the notes we had before.

### Example Project Structure

```
team-vault/
├── 01_Inbox/
│   └── README.md
├── 02_Projects/
│   ├── README.md
│   ├── Habit-Tracker-App/
│   │   ├── Habit-Tracker-App.md
│   │   ├── Ideas/
│   │   │   ├── Streak Notifications.md
│   │   │   └── Social Accountability.md
│   │   └── Meetings/
│   │       ├── 2026-01-08 Kickoff.md
│   │       └── 2026-01-15 MVP Scope.md
│   ├── Recipe-Manager/
│   │   ├── Recipe-Manager.md
│   │   ├── Docs/
│   │   │   └── Database Schema.md
│   │   ├── Ideas/
│   │   │   └── AI Meal Planning.md
│   │   └── Meetings/
│   │       └── 2026-01-12 Feature Prioritization.md
│   └── Workout-Logger/
│       ├── Workout-Logger.md
│       └── Meetings/
│           └── 2026-01-10 Technical Planning.md
├── 03_Areas/
│   ├── README.md
│   ├── Design-System/
│   │   └── Component Library.md
│   ├── Infrastructure/
│   │   ├── Deployment Pipeline.md
│   │   └── Monitoring Setup.md
│   └── User-Research/
│       └── Interview Insights.md
├── 04_Knowledge/
│   ├── README.md
│   ├── Frameworks/
│   │   └── React Native Patterns.md
│   └── Tools/
│       └── Supabase.md
├── 05_Archive/
│   ├── README.md
│   └── Transcripts/
│       ├── 2026-01-08 Kickoff Transcript.md
│       ├── 2026-01-10 Technical Planning Transcript.md
│       ├── 2026-01-12 Feature Prioritization Transcript.md
│       └── 2026-01-15 MVP Scope Transcript.md
└── CLAUDE.md
```

These are not random meeting summaries. This is a structured system where every piece of knowledge lives in a specific place and wiki links connect ideas across the whole network.

**The folder system is basically PARA** (Projects, Areas, Resources, Archive) from Tiago Forte — usually for personal knowledge management, but it works great for team projects too.

### Documentation is for Agents Now

This only works if you learn to manage context and structure knowledge for retrieval so Claude can actually find what it needs:

- When Claude needs to understand your deployment setup, it loads `03_Areas/Infrastructure/Deployment Pipeline`
- When it needs the database schema, it loads `Recipe-Manager/Docs/Database Schema.md`
- When it needs to understand a past decision, it loads the meeting where you discussed it

Everything is defined in `CLAUDE.md` — the vault philosophy, folder structure, how to navigate, how to take notes. Each folder has a README that goes deeper into that specific folder philosophy.

**Without structure you just have a pile of meeting notes. With structure you have a knowledge system that Claude can build on — and that you can build on together with Claude.**

### Feature Brainstorming Gets Way Better

When Claude has:
- All the context
- All the ideas you've had before
- All the decisions you've made
- All the competitor research
- All the user feedback

Feature brainstorming becomes way better because the context window is decorated with everything relevant.

### Product Steering Becomes a Real Conversation

When the knowledge is structured and retrievable, product steering isn't about updating slides and writing specs. It becomes a real conversation where Claude brings in all the relevant context automatically.

### Why Yapping?

When people say LLMs "aren't there yet," it's usually a context problem. The knowledge exists somewhere but the model can't access it.

Some of that is locked in slide decks and PDFs — but vision models basically solved that.

The harder problem is **tacit knowledge**: the stuff that's hard to articulate because it lives in your head as intuition.

I noticed this when building automated note-taking systems — tacit knowledge is what we lose when we only capture what we explicitly say. But when you record conversations and mine them with depth, you capture the tacit too.

---

## Build Claude a Tool for Thought

### The Problem

Vibe note-taking has the same problem as vibe coding. A few ideas works fine, but dump hundreds and you're drowning in slop.

**What's the "testing" for knowledge work? What catches drift before it compounds?**

Humans hit this wall too. They built tools for thought to create external systems to think in. Claude Code needs the same thing — but native to how agents work.

### What It Should Use

It should use what agents already have:
- **Markdown files and wiki links** for structure
- **YAML and embeddings** for discovery
- **Hooks and subagents** for automation and separation
- **Bash, grep, git, MCP servers** for tooling
- **Code it writes itself** to extend the system

...but how do you actually build this?

### The Meta Layer

The first version IS about tools for thought. The system researches tools for thought to build itself a tool for thought.

1. Feed Claude methodologies on how humans build knowledge systems
2. Claude figures out what applies to agents
3. It adjusts its own instructions

This is evolving right now. Every rule starts as a hypothesis. Observations get logged to learning files that persist across sessions — so there's always something to reflect on.

### The Foundation: Graph Database from Markdown

You can build a graph database out of markdown files:
- **Files are nodes**
- **Wiki links are edges** that connect them
- **YAML frontmatter is metadata** you can query

It's a knowledge graph that an LLM can move through naturally.

### Curating the Context Window

Together we figured out how to be more selective about what enters context.

**At session start:**
- A file tree gets injected
- Filenames are claims you can use in-sentence

When you write `since [[quality is the hard part]] the question becomes...` the title IS the argument. So before opening anything, there's already a sense of what each note argues.

**Every note has a YAML header with a one sentence description:**
```yaml
---
description: Cognitive science shows memory retrieval activates neighboring concepts with decaying strength, which maps to how agents should load context via wiki links
---
```

Before Claude loads any file, it grabs the description and decides if it's worth the context.

**Progressive disclosure:**
- File tree → descriptions → headings → sections → full content

Most decisions can be made at the description level without loading full files.

### The Shoulders of Giants

Humans have been building tools for thought for centuries:

- **Llull** built rotating wheels to generate truth through combination of fundamental principles
- **Bruno** created memory palaces with millions of image combinations
- **Zettelkasten** gave you a network of connected ideas, evergreen notes force you to say complete thoughts, MOCs organize clusters

These weren't storage systems. They were tools to think **WITH**.

But all of them had one thing in common: **a human was the operator**. A human used the structure to build on top of that.

**What we built is different:** Something else is using this architecture (and it can build its own).

### The Self-Engineering Loop

1. **Dump** deep research articles about tools for thought into the inbox
2. Claude reads them and extracts claims: `"this method argues that X"` becomes a note called `[[X]]` that can link to other notes
3. **Then it tries to apply those claims to how agents work**
4. Observations get logged to files that persist across sessions
5. The system reflects on its own learnings and thinks about what to change

### What This Looks Like in Practice

Claude found the Cornell Notes "5 Rs" framework while researching and adapted it for agents — adding a 6th phase for self-improvement:

**`/reduce`**
Extracts claims from raw content

**`/reflect`**
Finds connections, updates MOCs

**`/reweave`**
Updates old notes with new connections

**`/recite`**
Verifies descriptions enable retrieval

**`/review`**
Health checks: broken links, orphans, sparse notes

**`/rethink`**
Challenges system assumptions against evidence

**`/orchestrate`**
Chains all phases into one pipeline

**`/learn`**
Requests further research to expand on topics

---

## Async Hooks for Note History

### Time Travel Through Your Notes

Imagine being able to time travel through your notes. You wrote something three weeks ago, and since then you've edited it a dozen times. With Obsidian, you only see the current version.

What if you could travel back in time and see exactly how your thinking evolved?

Git can track all of this, but who actually commits after every small edit...

### Async Hooks: Auto-Commit Without Slowing Down

Claude Code now supports async hooks. You can auto-commit after every edit without slowing anything down, then read that history in a way that's actually useful.

### Example: Note History

**Run the skill with Claude Code:**
```
/note-history @small-world-topology.md
```

**Output:**
```
## small-world topology requires hubs and dense local links

created: jan 20 | last edit: jan 28 | versions: 6

### timeline

jan 28 | +12 -3 | added uncertainty section, acknowledged that benchmarks are extrapolations from network science, not validated at vault scale yet
jan 26 | +18 -8 | connected to spreading activation and checkpoint notes, the topology argument now links to WHY it matters for agent traversal
jan 24 | +25 -0 | added architectural implications, quality gates for when notes have too many or too few links
jan 22 | +15 -4 | refined power-law distribution, sharpened the distinction between hub nodes (MOCs) and peripheral nodes (claims)
jan 20 | +45    | initial draft from network science research

### evolution pattern

started as research extraction, developed practical implications, connected to related concepts, added epistemic humility about uncertainty

the note matured from "here's what network science says" to "here's how we apply it and here's what we don't know yet"
```

The skill doesn't just list commits — it interprets what changed and identifies patterns in how thinking developed.

### How It Works

You need git set up in your vault (GitHub, GitLab, or just local). Once that's done, the rest is automatic.

A hook runs silently after every edit and commits the changes in the background while Claude keeps working.

**The hook (`.claude/hooks/auto-commit.sh`):**
```bash
#!/bin/bash

cd "${CLAUDE_PROJECT_DIR:-$(dirname "$0")/../..}"

git add -A 2>/dev/null || exit 0

if git diff --cached --quiet 2>/dev/null; then
  exit 0
fi

CHANGED_FILES=$(git diff --cached --name-only 2>/dev/null | head -5)
FILE_COUNT=$(git diff --cached --name-only 2>/dev/null | wc -l | tr -d ' ')
STATS=$(git diff --cached --stat 2>/dev/null | tail -1)

if [ "$FILE_COUNT" -eq 1 ]; then
  MSG="Auto: $(echo "$CHANGED_FILES" | head -1)"
else
  MSG="Auto: $FILE_COUNT files"
fi

MSG="$MSG | $STATS"

git commit -m "$MSG" --no-verify 2>/dev/null || true
```

**`async: true`** is what makes it work. Without that, Claude would wait for every commit to finish (which is really annoying).

### Why This Matters

Notes are living documents, not finished artifacts. What you believed three weeks ago might be wrong now. Sometimes understanding why you changed your mind is as valuable as knowing where you landed.

The history is the journal of your thinking process. With auto-commits, it's captured automatically.

But raw git history is useless if you can't read it. The interpretation layer is what makes it work — that's what the `/note-history` skill does.

Claude reads the diffs and explains what changed **conceptually**, not just syntactically.

### Building Your Own

Create a skill file (`.claude/skills/note-history/SKILL.md`) with:
- Git log and diff commands
- Interpretation logic for conceptual changes
- Evolution pattern identification

The key is reading diffs and explaining what changed **conceptually**, not just syntactically.

### The Bigger Picture

Every note in your vault now has a complete history. When you look back at a note from six months ago, you won't just see what it says now — you'll see how it got there.

Your vault becomes a timeline of how your thinking evolved, and you can reconstruct any point in that timeline node by node.

**That's a journal of your thoughts that writes itself.**

Isn't that beautiful?

---

## Hooks & Subagents: Automating the Workflow

### When Claude Wants to Learn More

When Claude wants to know more about a specific topic, it can request deep research to go learn.

### Hooks Run Automatically

Hooks are scripts that run at specific points in the session lifecycle:

**`/session-start.sh`**
Injects vault context like file tree

**`/validate-note.sh`**
Checks quality after every write

**`/subagent-complete.sh`**
Reminds about MOC updates after agent work

**`/session-stop.sh`**
Checks for broken links, prompts logging

### Subagents Do Parallel Specialized Work

Different models for different tasks:

**High-volume extraction (Sonnet)**
- Reduce
- Extract many claims efficiently

**Connection finding (Sonnet)**
- Reflect
- Find patterns and relationships

**Description verification (Haiku)**
- Recite
- Verify YAML descriptions are accurate

**Health check swarm (Haiku)**
- Review
- Parallel check of many notes for quality issues

### The Rough Edges

This is a living system. It gives complete control to Claude Code and literally vibe note-takes based on what it learns about tools for thought from humans.

It's not perfect. It's evolving.

---

## Implementation

The whole thing is just:

1. **A SessionStart hook** that runs `tree`
2. **YAML frontmatter** with a `description` field
3. **Instructions in CLAUDE.md** telling Claude to check descriptions before reading

Just a few constraints that force selectivity.

### Claude Code vs Clawdbot

**Universal principles that work the same:**
- Markdown files with wiki links as the knowledge graph
- YAML frontmatter for descriptions and metadata
- Progressive disclosure (tree → descriptions → outline → content)
- Agent orientation before action (scan, check index, read topic pages, follow links)
- Spatial editing with `{thoughts}` in curly braces
- Meeting transcript mining (exhaustive extraction)

**Tooling differences:**

| Aspect | Claude Code | Clawdbot |
|--------|-------------|-----------|
| Hooks | `.claude/hooks/` directory | Cron jobs, gateway hooks, or session hooks |
| Skills | `.claude/skills/` directory | Skills folder or MCP servers |
| Session context | File tree injected automatically | `memory_search` and file system access |
| Async operations | `async: true` in hook config | Background processes via `exec` with `background: true` |
| Git integration | Hooks run after edits | Manual or cron-based git operations |
| Model routing | Subagents with different models | Session spawning with model overrides |

**Key insight:** The *philosophy* and *system design* are platform-agnostic. Whether you're using Claude Code's hooks or Clawdbot's cron jobs, the pattern is the same: markdown files, intelligent context management, and progressive disclosure.

What matters is how you structure knowledge — not which agent platform you use.

---

## Getting Started

### 1. Create the Folder Structure

Create a folder with subfolders that match your purpose. Think about what you actually need to organize. A work vault might emphasize:
- Capture first, structure later
- Project folders with meetings and outputs
- Client context for AI consumption

A research vault might emphasize:
- Source tracking and citations
- Literature notes
- Claim verification

A creative vault might emphasize:
- Idea capture and incubation
- Draft progression
- Reference organization

### 2. Write CLAUDE.md

Write a CLAUDE.md that explains your system. Start simple and evolve it as you learn what works. This is how you teach Claude how to think in your vault.

Every vault needs its own philosophy. When you need to teach Claude how you think, you realize how much implicit knowledge you carry around. Suddenly you have to textualize everything. (The author's CLAUDE.md is around 2000 lines now because they keep refining what works and what doesn't.)

### 3. Let Claude Operate

Capture something and ask Claude to find connections. Let it navigate and discover relationships and suggest where things belong.

**ALWAYS review what it produces and edit for quality.**

### 4. Your Role Evolves

You're not taking notes anymore — you're directing a system that takes notes. Your job becomes **judgment**, which means deciding what matters.

The human role evolves from:
- Writer → Editor
- Creator → Curator

---

## The Deeper Insight

Knowledge bases and codebases have a lot in common:
- They're both folders of text files with relationships between them
- They both have conventions and patterns
- They both benefit from agents that can navigate and operate them

Vibe coding changed how we write software by letting AI handle implementation while you focus on direction. The same shift applies to knowledge work.

**Vibe note-taking changes how you think.**

---

## TL;DR

- A vault is just markdown files that link to each other
- LLMs have no memory, so vaults give them one
- CLAUDE.md teaches the AI how your system works
- Every vault needs its own philosophy based on purpose
- Progressive disclosure with 4 layers: file tree → YAML descriptions → outline → full content
- Spatial editing: `{thoughts}` in curly braces mark edits where they belong
- Meeting transcript mining: Extract everything (ideas, frameworks, decisions, state changes) — not just summarize
- Yapping to PRDs: Record meetings → mine transcripts → structured knowledge system
- Tool for Thought: Self-engineering system that researches tools for thought and adapts itself
- Cornell Notes framework adapted: /reduce → /reflect → /reweave → /recite → /review → /rethink → /orchestrate → /learn
- Async hooks for note history: Auto-commit after every edit, track how thinking evolves over time
- Hooks & subagents: Automate workflow quality checks, subagents do parallel specialized work
- This is a living system — evolving based on what the AI learns about tools for thought
- **Works with both Claude Code and Clawdbot** — principles are universal, tooling adapts
- What stays constant: markdown, links, AI operates while you provide judgment

When your notes work this way, the network itself becomes valuable. You don't take notes anymore — you operate a system that takes notes.

---

*If you want to build something similar, use the skill-creator skill that comes with Claude Code plugins and paste in this article.*
