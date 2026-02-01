---
description: Session summary from Twitter bookmarks processing — extracted insights on Claude Code workflows, Moltbot/Clawdbot patterns, Remotion video creation, AGI predictions, and business strategies from 85+ bookmarks.
tags: ["session-summary", "twitter", "bookmarks", "ai-coding", "claude-code", "moltbot", "to-process"]
created: 2026-01-29
---

# Session: Twitter Bookmarks (2026-01-29)

**Source:** Twitter/X bookmarks export (85+ tweets)
**Date Range:** 2026-01-22 to 2026-01-29
**Themes:** AI coding agents, Moltbot/Clawdbot, AGI, Business, Video Creation

## Notes Created

| Note | Location | Key Topic |
|------|----------|-----------|
| [[Claude Code Power User Patterns]] | `02_reference/tools/` | Workflows, plugins, best practices |
| [[Moltbot Clawdbot Patterns]] | `02_reference/tools/` | Proactive prompts, cron jobs, memory |
| [[Remotion Video Creation Playbook]] | `02_reference/tools/` | AI-generated viral videos |
| [[AGI Timeline 2026]] | `01_thinking/notes/` | AGI predictions and implications |
| [[AI as Management Skill]] | `01_thinking/notes/` | 6 senior-level skills for AI integration |

## Key Insights by Category

### 1. Claude Code Power User Patterns

**Superpowers Plugin** (`obra/superpowers-marketplace`)
- Test-driven development
- Systematic debugging with root cause analysis
- Design phases where Claude asks questions before coding
- Planning with 2-5 minute tasks and exact file paths
- Code review protocols with severity-based tracking
- Subagent-driven development

**Flowy Plugin** — Replaces ASCII charts with UI graphs for planning

**Plan Mode Infinite Context** (frankdegods):
```
>enter plan mode and write tasks
>yes, clear context, bypass permissions
new tasks = maintain context between compaction
```

**PreToolUse Hook for Memory** (PerceptualPeak):
- Inject semantic memory before each tool use
- Takes last 1,500 chars from thinking block
- Embeds and retrieves relevant memories
- Creates self-correcting Claude workflow
- Happens in <500ms

**Security Self-Review** (pipelineabuser):
- CLAUDE.md with pre-task checks (secrets, SQL injection, input validation)
- Prompts: "write 20 unit tests to break this", "find every security vulnerability"
- Tools: claude-code-action, claude-agent-sdk, factory.ai droids
- Stack: semgrep, bandit, ruff, mypy, snyk, gitleaks
- Pre-commit hooks block vulnerable code

**Obsidian + Claude Code**:
- Infrastructure for agents to think in
- Voice mode for linking ideas
- Active recall sections
- Stream-of-consciousness with @usemonologue skill

### 2. Moltbot/Clawdbot Patterns

**Proactive Prompt** (AlexFinn):
```
"I am a 1 man business. I work from wake to sleep. I need an employee taking as much off my plate and being as proactive as possible. Please take everything about me and just do work. I want to wake up and say 'wow, you got a lot done while I was sleeping.' Build things. Create PRs for review. Don't push live."
```

**Self-Improvement Loop** (jumperz):
```
HEARTBEAT.md (runs every hour):
- what sounded right but went nowhere?
- where did I default to consensus?
- what assumption didn't I pressure test?

Log to memory/self-review.md with tags: [confidence|uncertainty|speed|depth]

Startup prompt: read memory/self-review.md, prioritize recent MISS entries
```

**Cron Job Examples** (dabit3):
1. GitHub trending digest (top 10 repos with takes)
2. Daily motivation (10 motivational tweets)
3. Top Hacker News stories (summarized)
4. Product Hunt Daily Picks
5. YC Startup Spotlight (mini investor memo)
6. AI Twitter digest (top 20 viral tweets)
7. AI trend app builder (builds working apps)

**Memory Systems**:
- QMD — Fast private indexing of Obsidian vaults (96% token reduction)
- Supermemory — One command for perfect memory
- Telegram indexing — Google/OpenAI API for full chat history

**Skills Ecosystem** (Param_eth):
- 700+ community skills in one repo
- CLI Utilities, Git/GitHub, DevOps, Search, Coding Agents

**Deployment**:
- Digital Ocean — $7/month, best UX for beginners
- Mac mini — Fully functioning AI employee with own computer

**Monitoring**:
- Crabwalk — Live node graph of sessions, thinking states, tool calls

### 3. Remotion Video Creation

**Setup**:
```bash
npx create-video@latest
npx skills add remotiondev/skills
select "claude code"
```

**Key Patterns**:
1. Create HTML gallery of all assets (Claude sees everything in one screenshot)
2. Research agents for storyboarding (Spielberg, Hitchcock, Pixar techniques)
3. Start in plan mode first (mermaid diagram, timing, animation techniques)
4. Use specific prompts for different video types

**Prompts That Work**:
- Product demos: "make a promo video for [product]. use actual logo. source from [url]. key message: [cta]"
- Showcases: "slot machine reveal style. fast, fun, creative. 15-20 seconds"
- Social: "vertical 9:16. brain rot style. hook in 3 seconds. rapid cuts"

**Cost**: ~$5-15 per full video project

### 4. AGI Timeline Predictions

**rationalaussie**:
- AGI coming in 1-2 years
- Passport maxx, hard currency maxx
- Job titles become irrelevant
- Relationships, sports, morality, policy disproportionately matter
- Get close to decision makers in tangential industries (defence tech)

**Tinkerers vs Execs** (nikunj):
- Hire tinkerers, make it high status
- Let them roam org and fix automatable problems
- Execs will complain about "scale" and "rollout"
- Listen and ignore, or give execs budget for their own tinkerer

### 5. AI as Management Skill

**6 Skills That Matter** (Hesamation/Microsoft study):
1. Context assembly — knowing what info to provide from which sources
2. Quality judgement — when to trust AI, verifying outputs, spotting hallucinations
3. Task decomposition — break into manageable chunks, don't throw entire projects
4. Iterative refinement — trust first output or treat as starting point
5. Workflow integration — side tool vs integrated capability
6. Frontier recognition — knowing when operating outside AI capabilities

**The Shift**: "You wouldn't give a whole app idea to an intern and expect it to work. Chunk up the problem, delegate to right number of agents with right skills, orchestrate, quantify output."

### 6. Business Insights

**$19K/month Templates** (ecomchigga):
- 20-year-old selling Canva templates for real estate agents
- 50 templates, $47 per pack, 3 different packs
- Posts in 200 realtor Facebook groups (20 min/day)
- Found where buyers already exist, didn't build audience

**Polymarket Arbitrage** (marlowxbt):
- YES + NO should cost $1 together
- Fear makes prices slip (YES 48c, NO 49c = 97c total)
- Buy both, wait 15 minutes, collect $1, keep 3c
- 26,293 trades, $441K profit, 66% win rate

### 7. Technical Tools

**PageIndex RAG** — No vector DB, no embeddings, no chunking. Uses hierarchical tree structure and reasoning traversal. 98.7% on FinanceBench.

**QMD** (by @tobi) — Fast private indexing of Obsidian vaults, SQLite + BM25 keyword search + local embeddings.

**Ollama Launch** — Single command to run Claude Code/OpenCode/Codex locally. No env vars, no config.

**Exa MCP** — Completely free web search MCP.

---

## Related

[[Claude Code Power User Patterns]]
[[Moltbot Clawdbot Patterns]]
[[Remotion Video Creation Playbook]]
