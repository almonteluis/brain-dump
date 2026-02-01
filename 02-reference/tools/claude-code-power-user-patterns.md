---
description: Claude Code power user patterns from Twitter bookmarks — Superpowers plugin, PreToolUse memory hooks, plan mode infinite context, security self-review, Obsidian workflows, Flowy planning, and best practices.
tags: ["claude-code", "ai-coding", "patterns", "workflows", "productivity"]
created: 2026-01-29
---

# Claude Code Power User Patterns

## Superpowers Plugin

**Install:**
```bash
/plugin marketplace add obra/superpowers-marketplace
/plugin install superpowers@superpowers-marketplace
```

**What it gives you:**
- Test-driven development
- Systematic debugging that finds root causes
- Design phases where Claude asks questions before coding
- Planning with 2-5 minute tasks and exact file paths
- Code review protocols with severity-based issue tracking
- Subagent-driven development (multiple Claude instances)

**The difference:**

| Old Way | Superpowers Way |
|---------|-----------------|
| "build me a user dashboard" | Same prompt → design phase first |
| Claude writes code immediately | Asks: what data? who uses it? what actions? |
| Probably doesn't match what you wanted | You approve design → then code |
| Spend 3x time debugging | Eliminates 80% of rewrites |

## Plan Mode Infinite Context

**Method** (frankdegods):
```
>enter plan mode and write tasks
>yes, clear context, bypass permissions
```

New tasks created during session maintain context between compaction.
Result: Basically infinite context for long workflows.

## PreToolUse Memory Hook

**The Problem** (PerceptualPeak):
- Relying only on UserPromptSubmit for memory causes workflow drift
- Memories injected at initiation become less relevant as workflow continues
- Claude goes down error-filled paths before figuring it out

**The Solution**:
```javascript
// PreToolUse hook fires before every tool use
// Takes last 1,500 chars from thinking block
// Embeds and retrieves relevant memories
// Injects back to Claude in <500ms
```

**Result**: Self-correcting Claude workflow that catches itself mid-stream.

**Files**:
- `HEARTBEAT.md` — Hourly self-check questions
- `memory/self-review.md` — Logged misses and fixes with tags

## Security Self-Review System

**Step 1: CLAUDE.md in repo root**
```markdown
before completing any task, run these checks:
- scan for hardcoded secrets, API keys, passwords
- check for SQL injection, shell injection, path traversal
- verify all user inputs are validated
- run the test suite
- check for type errors
```

**Step 2: Prompts that catch bugs**
```bash
"write 20 unit tests designed to break this function"
"find every security vulnerability in this file. think like a pentester."
"generate 50 edge cases: null, empty strings, negative numbers, unicode"
"audit this entire codebase for leaked secrets"
```

**Step 3: Tools**
- `github.com/anthropics/claude-code-action` — Reviews every PR automatically
- `pip install claude-agent-sdk` — Batch test directories programmatically
- `factory.ai droids` — Scans repo, opens PRs with fixes

**Step 4: Stack these scanners**
```bash
semgrep scan     # SAST - OWASP top 10
bandit -r .      # Python security
ruff check . --fix   # Linting + auto-fix
mypy . --strict  # Type errors
snyk test        # Dependency CVEs
gitleaks detect  # Leaked secrets
```

**Step 5: Pre-commit hooks**
```bash
pip install pre-commit
# Add all above to .pre-commit-config.yaml
# Now you physically can't commit vulnerable code
```

**The Loop**:
```
Claude writes code → CLAUDE.md forces self-review → automated scanners
→ pre-commit blocks garbage → GitHub action reviews PR
```

## Obsidian + Claude Code Workflows

**For Original Research** (Ashwinreads):
1. Populate markdown folder with source material
2. Enter stream-of-consciousness with @usemonologue
3. Ask "what's the idea I'm saying here?"
4. Let Claude help pull threads together
5. Use active recall section (@justinskycak approach)

**QMD Integration** (by @tobi):
- Fast private indexing of Obsidian vaults
- SQLite + BM25 keyword search + local embeddings
- 96% token consumption reduction
- Hybrid mode with query expansion, parallel retrieval, reciprocal rank fusion

## Flowy Plugin

**What it does**: Replaces Claude's ASCII chart with a UI graph you can customize and send back to AI.

**Why it matters**: AI coding will be transformed by simple creative techniques like visual planning.

## Karpathy Guidelines for Coding Agents

**Source**: @karpathy's post turned into agent skills

**Pattern**: Claude generated 800 lines, then used those skills to review itself → cut to 70 lines of clean, solid instructions.

## The Formula (0xDesigner)

```
"i want [goal/outcome]"
+ "interview me thoroughly to extract ideas and intent"
+ ultrathink
+ (plan mode on)
```

---

## Related

[[Moltbot Clawdbot Patterns]]
[[AI as Management Skill]]
