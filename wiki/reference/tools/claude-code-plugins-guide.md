---
description: Reference guide for all installed Claude Code plugins and when/how to use them
tags:
  - claude/code
  - plugins
  - reference
created: 2026-04-11
---

# Claude Code Plugins Guide

> Reference guide for all installed Claude Code plugins and when/how to use them.

---

## Installed Plugins Overview

| Plugin | Purpose | When to Use |
|--------|---------|-------------|
| **superpowers** | Complete software development workflow | Building anything from scratch |
| ~~**vercel-plugin**~~ | Vercel ecosystem knowledge & best practices | *(disabled)* |
| ~~**atomic-agents**~~ | Python agent framework | *(removed)* |
| **ecc** | TDD, Go, build errors, code reviews | Debugging, testing, reviews |
| **frontend-design** | Frontend UI creation | Building web interfaces |
| **context7** | Fetch current library docs | API questions, syntax check |
| **commit-commands** | Git workflow automation | Committing, pushing, PRs |
| **ralph-loop** | Iterative AI development loops | Long-running autonomous tasks |
| **code-review** | Automated PR reviews | Reviewing pull requests |
| **code-simplifier** | Code refactoring & cleanup | Simplifying complex code |
| **claude-md-management** | CLAUDE.md maintenance | Updating project docs |

---

## Plugin Details

### 1. Superpowers
**Purpose:** Complete software development workflow with TDD, planning, and subagent-driven development.

**When to use:**
- Starting any new feature or project
- Need systematic approach to building
- Want autonomous development sessions

**Key Skills Included:**
- `brainstorming` - Explore requirements before building
- `systematic-debugging` - Debug before fixing
- `test-driven-development` - TDD workflow
- `verification-before-completion` - Evidence before assertions
- `using-git-worktrees` - Isolated feature branches
- `subagent-driven-development` - Agent delegation workflow
- `writing-plans` - Create implementation plans
- `requesting-code-review` - Get reviews before completion

**How it works:**
1. Asks what you're trying to build
2. Creates spec chunks you can review
3. Generates implementation plan
4. Launches subagents to work through tasks
5. Reviews and continues autonomously

**Trigger:** Automatic when building something

---

### 2. Vercel Plugin
**Purpose:** Vercel platform knowledge, AI SDK, Next.js patterns, deployment best practices.

**When to use:**
- Deploying to Vercel
- Using AI SDK features
- Next.js development questions
- Writing vercel.ts/config
- Setting up environment variables

**Key Knowledge Areas:**
- Next.js 16 patterns (App Router, Cache Components, Turbopack)
- AI SDK v6 (streamText, useChat, AI Elements)
- AI Gateway (OIDC auth, model routing)
- Workflow DevKit (durable agents)
- Vercel CLI commands
- Edge Functions vs Fluid Compute
- Storage (Blob, Edge Config, Neon, Upstash)

**Trigger:** Automatically injects relevant docs based on context

---

### 3. ECC (Everything Claude Code)
**Purpose:** TDD enforcement, Go/Python specialists, build error resolution, code reviews.

**When to use:**
- Go or Python development
- Build errors that need fixing
- Need code review specialist
- TDD workflow enforcement

**Key Subagents:**
- `ecc:go-build-resolver` - Fix Go build errors
- `ecc:go-reviewer` - Go code review
- `ecc:python-reviewer` - Python code review
- `ecc:build-error-resolver` - General build errors
- `ecc:tdd-guide` - Test-driven development
- `ecc:code-reviewer` - General code review
- `ecc:planner` - Implementation planning
- `ecc:doc-updater` - Documentation updates

**Language Patterns:** TypeScript, Go, Python, PHP, Kotlin, Swift

---

### 4. Frontend Design Plugin
**Purpose:** Create production-grade frontend interfaces with high design quality.

**When to use:**
- Building web components or pages
- Creating dashboards or landing pages
- Styling React components
- Any frontend UI work

**Key Features:**
- Avoids generic AI aesthetics
- Generates creative, polished code
- Works with shadcn/ui patterns
- Handles responsive design

---

### 5. Context7
**Purpose:** Fetch current documentation for any library, framework, or API.

**When to use:**
- Need current API syntax
- Checking if your knowledge is outdated
- Looking up library documentation
- Version-specific questions

**How to use:**
```
"Check the latest React docs for useTransition"
"What's the current Next.js revalidate syntax?"
```

---

### 6. Commit Commands
**Purpose:** Automate git workflow - commit, push, create PRs.

**Commands:**
| Command | What it does |
|---------|--------------|
| `/commit` | Stages files and creates commit with auto-generated message |
| `/commit-push-pr` | Commits, pushes, and creates PR in one step |

**When to use:**
- After completing work
- Want to avoid manual git commands
- Need PR created automatically

---

### 7. Ralph Loop
**Purpose:** Iterative AI development loops using self-referential feedback.

**When to use:**
- Long-running autonomous tasks
- Need Claude to iterate until completion
- Tasks that benefit from repeated refinement

**Command:**
```bash
/ralph-loop "Build a REST API for todos. Requirements: CRUD operations, input validation, tests. Output <promise>COMPLETE</promise> when done." --completion-promise "COMPLETE" --max-iterations 50
```

**How it works:**
1. Works on the task
2. Tries to exit
3. Stop hook blocks exit
4. Feeds same prompt back
5. Repeats until completion promise

---

### 8. Code Review Plugin
**Purpose:** Automated PR reviews using multiple parallel agents with confidence scoring.

**When to use:**
- Need PR reviewed
- Want automated feedback
- Multiple perspectives on changes

**Command:**
```bash
/code-review
```

**How it works:**
1. Launches 4 parallel agents
2. Agent # 1-2: CLAUDE.md compliance
3. Agent #3: Bug detection
4. Agent #4: Git blame/history analysis
5. Scores each issue 0-100
6. Posts only high-confidence issues (≥80)

---

### 9. Code Simplifier
**Purpose:** Refactor code for clarity, consistency, and maintainability.

**When to use:**
- Code is overly complex
- Need to clean up after modifications
- Want to improve maintainability

**Trigger:** Runs after writing code to check for simplification opportunities

---

### 10. CLAUDE.md Management
**Purpose:** Maintain and improve CLAUDE.md files.

**Tools:**
| Tool | Purpose | When to Use |
|------|---------|-------------|
| `claude-md-improver` (skill) | Audit CLAUDE.md against codebase | Periodic maintenance |
| `/revise-claude-md` (command) | Capture session learnings | End of session |

**When to use:**
- "Audit my CLAUDE.md files"
- "Check if my CLAUDE.md is up to date"
- After a session revealed missing context

---

### 11. Atomic Agents
**Purpose:** Python framework for building modular AI applications (LEGO-like components).

**When to use:**
- Building Python AI agents
- Need modular, composable agent components
- Working with Pydantic/Instructor

**Note:** Primarily for Python development. If you don't build Python agents, this won't be frequently used.

---

## Quick Reference: When to Use What

| Situation | Use |
|-----------|-----|
| Starting a new feature | Superpowers → brainstorming |
| Deploying to Vercel | Vercel Plugin |
| Need current API docs | Context7 |
| Committing work | `/commit` |
| Creating PR | `/commit-push-pr` |
| Reviewing a PR | `/code-review` |
| Long autonomous task | `/ralph-loop` |
| Debugging issue | Superpowers → systematic-debugging OR ECC → build-error-resolver |
| Building UI | Frontend Design Plugin |
| Updating project docs | `/revise-claude-md` |
| Python agent development | Atomic Agents |
| Go/Python specific questions | ECC language patterns |

---

## Commands Cheat Sheet

```bash
# Workflow
/commit                          # Create commit with auto message
/commit-push-pr                  # Commit, push, create PR
/code-review                     # Review current PR
/revise-claude-md                # Capture session learnings to CLAUDE.md

# Development
/ralph-loop "<prompt>"           # Start iterative loop
--completion-promise "<text>"    # End loop when this appears
--max-iterations <n>             # Limit iterations
```

---

## Notes

- **Context7** is called automatically when library questions are detected
- **Superpowers** skills trigger automatically based on task type
- **Vercel Plugin** injects docs based on file patterns (vercel.ts, next.config, etc.)
- **ECC** subagents can be called explicitly or triggered by errors

---

*Last updated: 2026-04-11*
