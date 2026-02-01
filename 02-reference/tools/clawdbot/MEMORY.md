# MEMORY.md - Your Long-Term Memory

*This is your curated memory — distilled essence, not raw logs. Write significant events, thoughts, decisions, opinions, lessons learned.*

---

## System Configuration

### QMD - Local Document Search Engine

**Installed:** 2026-01-31
**Location:** `/home/ubuntu/.bun/bin/qmd`
**Index:** `~/.cache/qmd/index.sqlite`
**Models:** Auto-downloaded to `~/.cache/qmd/models/`

**Collections:**
- `obsidian` — `/home/ubuntu/clawd/obsidian-vault/**/*.md` (628 files)

**Search Modes:**
```bash
qmd search "query"              # BM25 full-text search (fast, keyword-based)
qmd vsearch "query"             # Vector semantic search (requires embeddings)
qmd query "query"               # Hybrid + reranking (best quality, requires embeddings)
```

**Key Commands:**
```bash
qmd status                      # Check index and embedding progress
qmd collection add <path> --name <name>  # Add collection
qmd embed                      # Generate vector embeddings
qmd get <file>                 # Retrieve document by path or docid
qmd multi-get "pattern"         # Get multiple docs by glob
qmd search "query" -c obsidian   # Search within collection
```

**Current Status (2026-02-01):**
- 628 docs indexed
- Embeddings in progress: ~32-52% (monitoring via sub-agent)
- BM25 search works immediately
- Hybrid/semantic search available after embeddings complete (~1-2 hours total)

**Use Cases:**
- Fast keyword search across entire vault
- Semantic search for "how do I..."
- Agent knowledge retrieval (JSON output for LLMs)
- Finding specific patterns, code examples, documentation

### Sub-Agent Workflow Patterns

**Established:** 2026-02-01
**Purpose:** Parallel task execution for documentation updates and maintenance

**Workflow Pattern:**
1. **Main session** identifies batch of related tasks
2. **Spawn sub-agents** in parallel using `sessions_spawn`
3. **Each agent** gets clear instructions and template to follow
4. **Agents complete independently** and report back with summaries
5. **Main session** synthesizes results and updates user

**Proven Effective For:**
- YAML frontmatter fixes across large file sets
- Documentation imports and restructuring
- Vault-wide audits and tagging improvements
- Testing and validation workflows

**Key Commands:**
```bash
# Spawn parallel agents
sessions_spawn --task "instructions" --label "agent-name"

# Monitor agent status
sessions_list --kinds "subagent"
```

**Best Practices:**
- Provide clear templates and file paths
- Request specific output format (markdown reports)
- Ask for sample outputs when categorizing
- Use consistent YAML frontmatter structure

### Relay Documentation - Knowledge Base Expansion

**Strategy:** Fragments-focused → Full Relay coverage

**Accomplished (2026-02-01):**
- ✅ Imported official Relay docs from relay.dev
- ✅ Created comprehensive guides:
  - **relay-mutations-guide.md** — useMutation, optimistic updates, directives, updaters
  - **relay-subscriptions-guide.md** — useSubscription, WebSockets, connection manipulation
  - **relay-environment-setup.md** — RelayEnvironment, auth, cache, error handling
  - **connection-pattern-pagination.md** — usePagination, cursors, infinite scroll
  - **relay-compiler-build-setup.md** — Code generation, TypeScript, fragment colocation
- ✅ Fixed YAML frontmatter across all Relay notes
- ✅ Created 5-phase stress testing plan:
  - Environment Setup → Mutations → Subscriptions → Pagination → Compiler
- ✅ Vault audit: 655 files scanned, improved searchability

**Relay Knowledge Base Now Covers:**
- Core concepts (data masking, fragment composition)
- Query patterns (refactoring, colocation, keys)
- Mutations (useMutation, optimistic updates, directives)
- Subscriptions (useSubscription, WebSockets, lifecycle)
- Environment setup and configuration
- Connection pattern and pagination
- Compiler configuration and build setup
- Testing strategies and ESLint rules

**Testing Plan:**
```markdown
Phase 1: Environment Setup
Phase 2: Mutations  
Phase 3: Subscriptions
Phase 4: Pagination
Phase 5: Compiler
```

**Documentation Workflow:**
1. Import official docs → Create comprehensive guide → Test in production
2. Update based on real usage (gotchas, missing patterns)
3. Link related notes for knowledge graph
4. Use consistent YAML frontmatter + tags

### Obsidian Vault Location

**Root Path:** `/home/ubuntu/clawd/obsidian-vault/`
**Active Notebook:** `Software Engineering Notebook/` (primary workspace)

**Purpose:** Personal knowledge management and thinking system (vibe note-taking with AI agents)

**Folder Structure (Restructured 2026-01-29):**
- `/Software Engineering Notebook/` — Primary workspace for engineering work
  - `/00_inbox/` — Capture zone, zero friction
    - `/Links/` — Link dump with template for web content
      - `link-template.md` — Template: URL, summary, tags, key points, thoughts, related ideas
    - `/daily/` — Daily notes (format: MM-DD-YYYY.md)
  - `/01_thinking/` — Your notes and synthesis
    - `/notes/` — Individual thinking notes
  - `/02_reference/` — External knowledge & reference material
    - `/tools/` — Tool documentation and guides
      - `/clawdbot/` — Clawdbot-specific content
      - `obsidian-claude-101.md` — Complete guide on building AI-powered knowledge systems
    - `/approaches/` — Methods, patterns, methodologies
      - `/system-design/` — System design notes
    - `/software-engineer/` — Complete SE knowledge base
      - `/Frontend/`, `/Backend/`, `/Architecture/`, `/Cloud/`, `/Languages/`, `/CS50/`, `/Quick Reference/`
    - `/sources/` — External knowledge sources
      - `/readwise/` — Readwise highlights
  - `/03_creating/` — Content in progress
    - `/drafts/` — Drafts, works-in-progress
  - `/04_published/` — Finished work archive
    - `/blogs/` — Published blog posts
  - `/05_archive/` — Inactive content
  - `/06_system/` — Templates and automation
    - `/templates/` — Note templates
    - `/daily-notes-automation/` — Daily note automation tools
  - `/attachments/` — Images, PDFs, media files
  - `CLAUDE.md` — Teaches AI how to navigate and operate in the vault
- `/2nd Brain/` — Secondary notebook (unchanged)

**Vault Operating System (PARA-style):**
- **00_inbox** — Capture first, zero friction
- **01_thinking** — Your synthesis and new ideas
- **02_reference** — External knowledge, tools, patterns
- **03_creating** — Work in progress
- **04_published** — Finished, shareable content
- **05_archive** — Inactive but kept content
- **06_system** — Templates, scripts, automation

**Link Dump Workflow:**
1. Paste links into `00_inbox/Links/` using template
2. Add summary of core idea
3. Tag with `#to-process`
4. Process later: connect to existing notes, categorize, or archive

**How to add content:**
- Copy markdown files to `/home/ubuntu/clawd/obsidian-vault/`
- Files appear in Obsidian after refresh (Syncthing handles sync to Mac)
- Use `[[wiki-link]]` syntax for connections
- Add YAML frontmatter with `description:` for discoverability
- PARA system structure (Projects, Areas, Resources, Archive) where applicable

---

## Claude Code Hooks & Vault Automation

**Project Hooks:** `~/.claude/projects/obsidian-vault/hooks.json`

**What hooks do:**
- **SessionStart:** Run vault tree generator (`vault-tree-generator.sh`) to inject structure before agent starts
- **PreToolUse:**
  - Check YAML descriptions exist before reading vault notes
  - Ensure new notes have YAML frontmatter with description (BLOCK if missing)
  - Suggest removing `#to-process` tag when editing inbox items
- **PostToolUse:**
  - Notify when CLAUDE.md updated (review vault changes)
  - Notify when obsidian-claude-101.md updated (consider sharing learnings)
- **Stop:** Optional vault health check at session end

**Vault Operations Script:** `06_system/vault-ops.sh`

Commands available:
```bash
./06_system/vault-ops.sh tree              # Layer 1: Show vault structure
./06_system/vault-ops.sh find "claim"      # Layer 2: Search by description
./06_system/vault-ops.sh outline [note]    # Layer 3: Show note headings
./06_system/vault-ops.sh process             # List #to-process items
./06_system/vault-ops.sh orphans             # Find notes with no links
./06_system/vault-ops.sh broken              # Find broken wiki-links
./06_system/vault-ops.sh validate            # Check YAML frontmatter
```

**Progressive Disclosure for Agents:**
1. **Layer 1: `tree`** — See folder structure and organization (PARA-style)
2. **Layer 2: `find`** — Search YAML descriptions before loading full files
   - Every note has `description:` field in YAML frontmatter
   - One sentence that elaborates on title
   - Most decisions can be made at this level without loading full content
   - Guide: `02_reference/tools/yaml-descriptions-layer-2.md`
3. **Layer 3: `outline`** — Check headings for relevance
4. **Layer 4: Read full content** — Only if all layers confirm value

**How to trigger vault operations:**
- In Claude Code: Hooks run automatically when working on vault files
- In Clawdbot: Run `vault-ops.sh` commands or ask Levi to run them
- Manual: Execute scripts directly from terminal

---

## Session: 2026-01-27 (Performance Optimization Session)

### Work Completed

**Tiny Homes Project - Performance Optimization**

**Task 1: React.memo Optimization** ✅ COMPLETE
- Branch: `feat/performance-optimization`
- Model: GLM-4.7 (via z.ai)
- Added `React.memo` to BudgetCard components
- Wrapped `AnimatedNumber` and `WallGridIcon` components
- Build passes (TypeScript compilation)
- Commit: `0dce93c perf: add React.memo to BudgetCard components`
- **Pushed to remote:** ✅ `feat/performance-optimization`
- GitHub PR: Created

**Remaining Tasks (Performance Optimization):**
- Task 2: Code splitting for 3D libraries
- Task 3: Global loading states and skeleton loaders
- Task 4: Debouncing for resize/scroll handlers
- Task 5: LOD (Level of Detail) for 3D furniture

### Setup Done

**Claude Code Configuration**
- ✅ Installed `everything-claude-code` plugin from marketplace
- ✅ Configured z.ai GLM-4.7 model via API endpoint
- API Key: Set in `~/.claude/settings.json`
- Base URL: `https://api.z.ai/api/anthropic`
- Model mappings: Sonnet/Opus → GLM-4.7, Haiku → GLM-4.5-Air

### Z.AI Integration

- API Key configured for Claude Code
- Base URL: `https://api.z.ai/api/anthropic`
- Model: GLM-4.7
- Cost-effective: 1/7th price of Anthropic with 3x usage quota

### Project Notes

**User Preferences:**
- **Tailwind over SCSS/CSS** for mobile design (stressed preference)
- **5 separate commits** — one per task
- **Full cycle before each commit:** build + lint check

### Technical Decisions

**React.memo Implementation:**
- Added `memo` import to `src/components/ui/BudgetCard.tsx`
- Wrapped functional components with `memo()`
- No TypeScript errors after changes
- Build time: ~7 seconds (normal)

### Files Modified
- `src/components/ui/BudgetCard.tsx` — Added React.memo

### Commits Made
```
0dce93c perf: add React.memo to BudgetCard components
c813801 chore: complete Task 1 - React.memo optimization for BudgetCard
```

### Lessons Learned

**What Worked Well:**
- ✅ Direct terminal access to Claude Code gave full control
- ✅ Task 1 completed and committed quickly
- ✅ z.ai GLM-4.7 model is fast and cost-effective
- ✅ Everything-claude-code plugin installed successfully

**What Didn't Work:**
- ❌ everything-claude-code `/plan` command — Too slow for practical use (~8-10 minutes)
- ❌ Bash command transmission — Snap packages interfering with task text
- ❌ Session restarts — TMUX session management was unreliable
- ❌ Task 2 not started — `/plan` command took too long

**Recommendations:**
1. **Skip `/plan` for complex tasks** — Implement directly with specific instructions
2. **Use simple, direct commands** — Avoid multi-step planning commands
3. **Manual implementation for simple tasks** — Code splitting, loading states can be done with direct edits
4. **Continue with Tailwind focus** — Use Tailwind classes for all mobile design work
5. **Z.ai model is solid** — GLM-4.7 performs well and saves cost
6. **Commit frequently** — One task per commit for better tracking

### Next Steps

**Priority Actions:**
1. Task 3: Implement global loading states and skeleton loaders (fast win)
2. Task 4: Implement debouncing for resize/scroll handlers
3. Task 5: Add LOD for 3D furniture (major performance boost)
4. Merge all tasks to main branch
5. Create comprehensive PR

---

*Updated 2026-01-27 01:10 UTC*
