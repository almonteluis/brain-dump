# BuildFlow - Automate Research to Implementation

> Turn interesting links into working code. A browser extension + Telegram bot that sends URLs and X/Twitter posts to OpenCode for automated research, implementation, and report generation.

## Source
- **URL:** https://github.com/BowTiedSwan/buildflow
- **Author:** BowTiedSwan
- **Read Date:** 2026-01-30
- **Reading Time:** 8 min

## 🎯 Why This Matters

This project demonstrates the full "discovery → research → implementation → testing" automation pipeline. Instead of manually:
1. Finding interesting content
2. Reading and understanding it
3. Implementing examples
4. Testing the code
5. Writing up findings

BuildFlow automates all of this with **one click**.

**The breakthrough:** Custom OpenCode agent that:
- Reads content
- Identifies key concepts
- Implements working examples
- Runs tests
- Generates comprehensive report

## 📋 Key Insights

### Insight 1: One-Click Research Pipeline
**Manual workflow:** Click → Copy → Paste to AI → Wait for response → Copy code → Test → Write notes.

**BuildFlow workflow:** Click → Done.

**What this means:** Automation isn't about individual tasks — it's about orchestrating the entire pipeline from discovery to working output.

### Insight 2: Multi-Channel Capture
**Channels:**
- Chrome extension (popup button on any website)
- X/Twitter integration (🔨 button on tweets)
- Telegram bot (send URLs or forward X posts)

**Why this matters:** Capture anywhere. See something on Twitter? One click. Reading an article? One click. Found a GitHub repo? One click.

**The insight:** Automation only works when capture is frictionless.

### Insight 3: OpenCode as AI Engine, Not Custom AI
BuildFlow doesn't implement its own AI. It uses **OpenCode** as the AI engine.

**What this means:**
- Don't reinvent AI orchestration
- Leverage existing platforms (OpenCode, Clawdbot, etc.)
- Focus on workflow, not model
- Custom agents for specific patterns (research, implementation, testing)

### Insight 4: Structured Research Outputs
Each research task creates a folder:
```
research/article-title-abc123/
├── REPORT.md       # Summary, Key Concepts, Implementation, Tests, Assessment
├── src/            # Working implementation
└── repo/            # Cloned repositories (if applicable)
```

**Why this matters:**
- Not just summaries — working code
- Tests included (proven, not just proposed)
- Assessment (usefulness rating, recommendation)
- Research is actionable immediately

### Insight 5: Session-Based Research
BuildFlow uses OpenCode sessions, which means:
- Persistent context across research tasks
- Session history (GET /api/learn)
- Bound to OpenCode instance managing the session

**Why this matters:**
- Research builds on previous research
- Better than one-off prompts
- More sophisticated over time

## 💡 New Concepts

### Concept: Research-to-Implementation Pipeline
Automated workflow that takes a discovery (URL, tweet, repo) and produces working code, tests, and comprehensive report.

**Why it matters:**
- Reduces time from hours to minutes
- Ensures implementation (not just theory)
- Tests validate what was implemented
- Structured output is reusable

**When to use:** When learning new technologies, exploring new libraries, or analyzing interesting projects.

### Concept: Custom OpenCode Agent
BuildFlow includes a custom agent at `.opencode/agent/research-builder.md` optimized for research, implementation, and testing.

**Why it matters:**
- Generic OpenCode agents are good for general tasks
- Custom agents are optimized for specific workflows
- Tools: read, write, edit, bash, glob, grep, webfetch
- Permissions configured for safe, effective automation

**When to use:** When you have a repeatable workflow that standard agents don't handle well.

## 🔗 Frameworks & Patterns

### BuildFlow Architecture

**Description:** Chrome extension + Telegram bot + Backend + OpenCode integration.

**Components:**
- **Chrome Extension:** Popup button on any website, X/Twitter integration
- **Telegram Bot:** Receive URLs, confirm completion, show status/history
- **Backend (Express + SQLite):** API for learning, session management
- **OpenCode Integration:** Custom research agent

**Workflow:**
```
┌──────────────────────────────────────────────────────────────────┐
│ YOU DISCOVER                                               │
│ 📄 Interesting article 🐦 Cool X post 📦 GitHub repo    │
└──────────────────────────────────────────────────────────────────┘
                        │
                        ▼
┌──────────────────────────────────────────────────────────────────┐
│ ONE CLICK                                                   │
│ │                                                            │
│ 🔘 Browser extension popup 🔨 Button on X tweets           │
│ 📱 Send URL to Telegram bot                              │
└──────────────────────────────────────────────────────────────────┘
                        │
                        ▼
┌──────────────────────────────────────────────────────────────────┐
│ OPENCODE WORKS                                              │
│ │                                                            │
│ 📖 Reads content                                          │
│ 💡 Identifies key concepts                                  │
│ 🛠️ Implements examples                                       │
│ 🧪 Runs tests                                             │
│ 📝 Generates report                                       │
└──────────────────────────────────────────────────────────────────┘
                        │
                        ▼
┌──────────────────────────────────────────────────────────────────┐
│ YOU GET                                                     │
│ │                                                            │
│ research/                                                    │
│ └── project-name-abc123/                                  │
│     ├── REPORT.md # What it is, how it works           │
│     ├── src/ # Working implementation                    │
│     └── repo/ # Cloned repositories                │
└──────────────────────────────────────────────────────────────────┘
```

**When to use:** When you want to automate learning new things from web content.

### OpenCode Agent Pattern

**Description:** Custom agent definition optimized for specific workflow (research, implement, test).

**Agent Structure:**
```
.opencode/agent/research-builder.md
├── description: Researches URLs, articles, tutorials, X posts...
├── mode: subagent
├── tools: read, write, edit, bash, glob, grep, webfetch
└── permissions: bash: allow (except destructive), webfetch: allow
```

**What this enables:**
- Automated research (webfetch)
- Content analysis (read, grep for key info)
- Implementation (write code)
- Testing (bash to run tests)
- Report generation (write REPORT.md)

**When to use:** When building specialized automation workflows for AI agents.

## 🛠️ Tools Mentioned

### OpenCode (AI Coding Assistant)
**What it does:** AI-powered coding assistant with session management and agent orchestration.

**When to use:** Core AI engine for BuildFlow's research agent.

### Sisyphus Agent (Recommended)
**What it does:** Enhanced orchestration capabilities, parallel task execution, smarter delegation patterns.

**When to use:** For better agentic experience with OpenCode.

### Chrome Extensions (Manifest V3)
**What it does:** Browser automation, popup buttons, content injection (X/Twitter).

**When to use:** Capture content from websites and social media.

### Telegram Bot (Telegraf)
**What it does:** Receive URLs, send status updates, show history.

**When to use:** Trigger research from anywhere via Telegram.

## 💭 My Thoughts

**What's brilliant:**
- Full pipeline automation (not just individual automation)
- Multi-channel capture (web + Telegram = anywhere)
- OpenCode as platform (don't build AI, orchestrate it)
- Structured outputs (REPORT.md + src/ + repo/)
- Custom agent optimization (specific workflow > general tool)

**Connection to my vault:**
- **Universal Mining Framework:** This is automated Universal Mining! BuildFlow literally does Layer 1 + Layer 2 extraction and generates REPORT.md
- **5-Layer Prompt Architecture:** Custom OpenCode agent is engineered (Identity: research builder, Process: read → identify → implement → test → generate)
- **Self-Check Framework:** BuildFlow could log research quality for self-review

**What's missing:**
- No direct integration with Obsidian vault (outputs to filesystem, not vault)
- No bidirectional linking (BuildFlow outputs don't link back to vault notes)
- No action tracking (doesn't connect to daily notes or tasks)

**Application to my workflow:**
This is basically what I just did manually (processing articles into vault), but automated. Imagine:
- You send article URL to Telegram bot
- BuildFlow researches it using OpenCode
- Generates REPORT.md with insights, concepts, implementation
- I or bot reads REPORT.md and creates vault note
- Links to related concepts and frameworks
- Updates daily note

This would be end-to-end automation!

## 🎬 Action Inspiration

### Can Do This Week
- [ ] Clone BuildFlow and explore architecture
- [ ] Try research workflow with one article
- [ ] Evaluate how custom OpenCode agent works
- [ ] Consider adding Obsidian integration (auto-create vault notes)

### Long-Term Impact
- [ ] Build similar pipeline for Clawdbot integration
- [ ] Create Telegram bot to trigger vault operations (create daily note, search, process article)
- [ ] Build custom OpenCode agent for Universal Mining Framework
- [ ] Add bidirectional linking (vault notes → BuildFlow → updated vault notes)

## 🔗 Related Ideas

**Connection to Universal Mining Framework:**
- **Automated mining:** BuildFlow literally implements Universal Mining Framework
- **Layer 1 + Layer 2 extraction:** Custom agent does this automatically
- **REPORT.md structure:** Summary, Key Concepts, Implementation, Tests, Assessment
- **Action inspiration:** "What can I do with this?" section in reports

**Connection to 5-Layer Prompt Architecture:**
- **Custom agent = Engineered prompt:** BuildFlow's agent at `.opencode/agent/research-builder.md`
- **Process defined:** read → identify concepts → implement examples → run tests → generate report
- **Optimized for research:** Not general assistant, but specialized workflow

**Connection to Self-Check Framework:**
- **Quality assessment:** BuildFlow generates "Assessment" section (usefulness rating, recommendation)
- **Could feed self-review.md:** Log research quality, identify patterns in what works/doesn't

**Connection to coding-agent skill:**
- **Background process:** OpenCode agent runs as subagent
- **Tools access:** read, write, edit, bash, glob, grep, webfetch
- **Permissions:** Configured for safe automation

## 🧠 Deep Mining

### Applicable Frameworks

**BuildFlow Architecture**
- **Definition:** Chrome ext → Telegram bot → Backend → OpenCode → Structured output
- **Application:** Automate research-to-implementation pipeline
- **Source:** This GitHub repo

**Custom OpenCode Agent Pattern**
- **Definition:** Specialized agent with tools, mode, permissions for specific workflow
- **Application:** Research, implementation, testing, report generation
- **Source:** This repo's `.opencode/agent/research-builder.md`

### Idea Inspiration
1. **Apply to my workflow:** Automate article processing (URL → BuildFlow → REPORT.md → vault note with Universal Mining)
2. **Telegram bot for vault operations:** Create bot that triggers Clawdbot to create daily notes, search vault, process articles
3. **Bidirectional linking:** BuildFlow outputs link to vault notes, vault notes trigger BuildFlow research
4. **Self-Check integration:** BuildFlow logs research quality to self-review.md for automatic MISS/FIX logging

### Key Quotes

> "Turn interesting links into working code"
> Context: Core value proposition
> Application: Not just research — working, tested code

> "A browser extension + Telegram bot that sends URLs and X/Twitter posts to OpenCode for automated research, implementation, and report generation."
> Context: Multi-channel capture system
> Application: Capture anywhere (web, Telegram), process centrally

> "Generates a comprehensive report"
> Context: Output quality
> Application: Not just summary — working code, tests, assessment

### Connection Points
- **Related Frameworks:** [[BuildFlow Architecture]], [[Custom OpenCode Agent Pattern]], [[Universal Mining Framework]]
- **Similar Patterns:** Browser automation, AI agent orchestration, research workflows
- **Complementary Tools:** [[coding-agent]], [[Why You Suck at Prompting]], [[5-Layer Prompt Architecture]]

## ⭐ Rating
**Value:** 5/5

**Why:**
- Complete automation pipeline (discovery → implementation → testing → report)
- Multi-channel capture (web + Telegram)
- OpenCode integration (smart: don't build AI, orchestrate it)
- Custom agent optimization (specialized > generic)
- Structured outputs (actionable immediately)
- Clear architecture and documentation

---

## Architecture

```
┌─────────────────────┐ ┌───────────────────────┐ ┌─────────────────────────┐
│ Chrome Extension  │ │   Telegram Bot        │ │   Backend Server      │
│ │ │                       │ │   (Express + SQLite)  │
│ • Popup button    │ │ • Send any URL       │ │ • Express API         │
│ • X.com injection  │ │ • /status command    │ │ • SQLite history      │
│ (🔨 on tweets)  │ │ • /history command    │ │ • Session polling     │
└───────────┬────────┘ └───────────┬────────────┘ └───────────┬──────────────┘
            │                      │                      │
            └──────────────┬───────────┘                      │
                           │                                 │
                           ▼                                 │
┌─────────────────────────────────────────────────────────────────────┐
│                  OpenCode Server                              │
│                  (localhost:4096)                             │
│ │                                                           │
│ • Creates session                                          │
│ • Runs research agent                                      │
│ • Generates output                                          │
└───────────┬────────────────────────────────────────────────────┘
            │
            ▼
┌─────────────────────────────────────────────────────────────────────┐
│              ./research/[slug]/                              │
│ │                                                           │
│ ├── REPORT.md # What it is, how it works             │
│ ├── src/ # Working implementation                      │
│ └── repo/ # Cloned repositories                     │
└─────────────────────────────────────────────────────────────────────┘
```

## Research Output Structure

Each research task creates:
```
research/article-title-abc123/
├── REPORT.md                 # Summary, Key Concepts, Implementation, Tests, Applications, Assessment
├── src/                      # Working implementation
│   └── example.ts
└── repo/                     # Cloned repositories (if applicable)
    └── cloned-repo/
```

### Sample REPORT.md Structure

```markdown
# Research Report: [Topic]

## Summary
Comprehensive guide explaining mental model, use cases, implementation patterns.

## Key Concepts
- Server Components run only on server
- Client Components are marked with "use client"
- Data fetching happens at component level

## Implementation Details
### What I Built
Demo app showing server/client component interaction.

### Key Files
- `src/app/page.tsx` - Server component with data fetching
- `src/components/Counter.tsx` - Client component with state

### How to Run
`cd src && npm install && npm run dev`

## Test Results
- [x] Server component renders correctly
- [x] Client component hydrates properly
- [ ] Streaming not tested (requires specific setup)

## Assessment
**Quality:** ⭐⭐⭐
**Usefulness:** ⭐⭐⭐⭐
**Recommendation:** Essential reading for React developers

## Applications
How to apply this knowledge to your projects.
```

## Packages

| Package | Description |
|---------|-------------|
| @build-learn/shared | Shared types, prompt templates, utilities |
| @build-learn/chrome-extension | Chrome Extension (Manifest V3) |
| @build-learn/telegram-bot | Telegram bot (Telegraf) |
| @build-learn/backend | Express server with SQLite |

## Prerequisites

- Node.js 20+
- pnpm 9+
- **[OpenCode](https://opencode.ai/)** - AI-powered coding assistant (required)
- **[Sisyphus Agent](https://github.com/code-yeongyu/oh-my-opencode)** - Enhanced agentic experience (recommended)
- Telegram Bot Token (optional, for Telegram integration)

## Installation

### 1. Clone and Install
```bash
git clone https://github.com/BowTiedSwan/buildflow.git
cd buildflow
pnpm install
```

### 2. Build All Packages
```bash
pnpm build
```

### 3. Configure Environment
```bash
cp .env.example .env

# Edit .env:
TELEGRAM_BOT_TOKEN=your_token_from_botfather
OPENCODE_URL=http://localhost:4096  # Default works if running locally
PORT=3456
```

## Running

### Step 1: Start OpenCode
OpenCode must be running for research to work.

```bash
cd ~/my-research-workspace
opencode serve --port 4096
```

### Step 2: Start Backend
```bash
pnpm backend
```

### Step 3: Load Chrome Extension
1. Open `chrome://extensions/`
2. Enable Developer mode
3. Click "Load unpacked"
4. Select `packages/chrome-extension/dist/`

### Step 4: Start Telegram Bot (Optional)
```bash
pnpm bot
```

## Usage

### Chrome Extension - Any Website
1. Navigate to any webpage (article, tutorial, GitHub repo)
2. Click BuildFlow extension icon
3. Click "Research & Build"
4. Check OpenCode for progress

### Chrome Extension - X/Twitter
1. Browse X.com (twitter.com)
2. Find an interesting tweet
3. Click 🔨 button next to tweet's timestamp
4. Tweet text and any URLs are sent for research

### Telegram Bot
1. Start a chat with your bot
2. Send any URL: `https://example.com/interesting-article`
3. Or forward/paste an X post URL
4. Bot confirms and notifies when complete

## API Endpoints

### POST /api/learn
Start a new research session.

**Request (URL):**
```json
{
  "type": "url",
  "source": "chrome_extension",
  "url": "https://example.com/article"
}
```

**Request (X post):**
```json
{
  "type": "x_post",
  "source": "telegram",
  "text": "Tweet text here...",
  "containedUrls": ["https://github.com/example/repo"],
  "telegramChatId": 123456789
}
```

**Response:**
```json
{
  "success": true,
  "requestId": "uuid",
  "sessionId": "ses_xxxxx",
  "title": "Build & Learn: Example Article"
}
```

### GET /api/learn
List research sessions.

**Query:** `?limit=50`

**Response:**
```json
{
  "sessions": [
    {
      "id": "uuid",
      "title": "Build & Learn: ...",
      "status": "completed",
      "createdAt": "2024-01-07T..."
    }
  ],
  "total": 1
}
```

### GET /api/learn/:id
Get specific session details.

### GET /api/health
Health check.

**Response:**
```json
{
  "status": "ok",
  "opencode": "connected",
  "activePolls": 0
}
```

## Custom OpenCode Agent

BuildFlow includes a custom agent at `.opencode/agent/research-builder.md`:

```markdown
description: Researches URLs, articles, tutorials, and X posts...
mode: subagent
tools:
  - read
  - write
  - edit
  - bash
  - glob
  - grep
  - webfetch
permissions:
  bash: allow (except destructive commands)
  webfetch: allow
```

**Optimized for:**
- Fetching and reading web content
- Cloning repositories
- Running tests
- Generating structured reports

## Development

### Run All in Development Mode
```bash
pnpm dev
```

### Run Individual Packages
```bash
pnpm backend       # Backend server
pnpm bot           # Telegram bot
pnpm extension:dev  # Chrome extension (watch mode)
```

### Type Checking
```bash
pnpm typecheck
```

### Build for Production
```bash
pnpm build
```

## Troubleshooting

### "Cannot connect to backend"
1. Verify backend is running: `pnpm backend`
2. Check port 3456 is available
3. Verify OPENCODE_URL matches (default: `http://localhost:4096`)

### "Sessions not appearing in OpenCode TUI"
Multiple OpenCode instances can only serve one port at a time. If you have multiple TUI windows open:
- Only ONE can serve port 4096
- Sessions created via API will be bound to whichever instance owns the port
- For best results, use a single dedicated OpenCode instance

### "Chrome extension button not appearing"
1. Verify extension is loaded (`chrome://extensions/`)
2. Check Developer mode is enabled
3. Reload the page
4. Check console for errors

## Repository

https://github.com/BowTiedSwan/buildflow

---

**Raw GitHub Content** (truncated at 10,000 chars)
