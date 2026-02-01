---
description: Complete implementation guide for the Self-Check Framework — a system for agent self-improvement through periodic reflection, structured logging, and context-triggered prevention of repeated mistakes.
type: framework
category: ai
tags: ["framework", "ai", "self-improvement", "agent", "implementation"]
related_articles:
  - [[2026-01-30 - Moltbot Self-Check Framework]]
related_concepts:
  - [[Self-Improvement Loop]]
---

# Self-Check Framework

## Definition
A structured system for agent self-improvement that combines periodic self-reflection, persistent logging of successes/failures, and context-aware prevention of repeated mistakes.

## Problem Solved
Agents don't improve on their own. Without explicit reflection and memory, they repeat the same mistakes, default to consensus opinions, and fail to pressure-test their assumptions.

## Core Principles

1. **Reflection Must Be Explicit** — Agents won't self-improve without structured prompts
2. **Failures Must Be Logged** — Ephemeral lessons are worthless; make them permanent
3. **Context Must Trigger Prevention** — Stop mistakes before they happen
4. **Balance Is Critical** — Log both MISS and HIT to avoid over-correction
5. **Simplicity Wins** — Text logs, heartbeat intervals, no complex infrastructure

## Implementation Guide

### Step 1: Add Self-Check to HEARTBEAT.md

Add this section to your `HEARTBEAT.md`:

```markdown
## Self-Check (runs every hour)

Ask yourself:
> What sounded right but went nowhere?
> Where did I default to consensus?
> What assumption didn't I pressure test?

Log answers to memory/self-review.md

Tag each entry with [confidence | uncertainty | speed | depth]
```

**Tags Explained:**
- `confidence` — Overconfident assertions that were wrong
- `uncertainty` — Unclear when to ask for clarification
- `speed` — Prioritized speed over quality
- `depth` — Missed important details or context

### Step 2: Create memory/self-review.md

Create a template file:

```markdown
# Self-Review Log

Template:
```
[ date ]

TAG: confidence
MISS: defaulted to consensus on API design
FIX: challenge the obvious assumption first, consider edge cases

TAG: speed
MISS: added noise not signal in code review
FIX: remove anything that doesn't move the task forward

TAG: uncertainty
HIT: acknowledged unknown and asked clarifying questions
```

Entries:

[2026-01-30 14:30]

TAG: confidence
MISS: suggested obvious solution without considering alternatives
FIX: always generate 2-3 options before recommending

TAG: speed
MISS: rushed response missed critical context
FIX: take time to understand the full problem before answering
```

### Step 3: Add Startup Hook

Add to your agent's startup prompt:

```
On boot, read memory/self-review.md

Prioritize recent MISS entries

When task context overlaps a MISS tag, force a counter-check before responding

Example:
If task is "design an API" and you have a MISS tagged with "confidence" and "API design", pause and apply your FIX before responding.
```

### Step 4: Choose Interval

**Interval Guidelines:**
- **30 min:** High-frequency task execution (chat bots, assistants)
- **1 hour:** Medium frequency (code agents, research agents)
- **4 hours:** Low frequency (long-running batch processes)

**Rule of thumb:** More tasks = shorter interval

### Step 5: Implement Context Overlap Detection

When starting a new task:
1. Parse task context (domain, type, keywords)
2. Read recent MISS entries from self-review.md
3. Check for tag/context overlap
4. If overlap found, force counter-check before responding

**Example Implementation (pseudocode):**
```python
def check_context_before_response(task, review_log):
    recent_entries = get_recent_entries(review_log, days=7)
    for entry in recent_entries:
        if entry.tag == "confidence" and entry.context_matches(task):
            print(f"COUNTER-CHECK NEEDED: {entry.fix}")
            pause_for_confirmation()
```

## The Loop

```
Heartbeat (every hour)
    ↓
Question Self (3 questions)
    ↓
Log to self-review.md (with tags)
    ↓
Restart (next heartbeat)
    ↓
Read Log (on boot or context check)
    ↓
Apply Counter-Check (if context matches)
    ↓
Improve (over time)
```

## Quality Standards

### Good Log Entry
```
TAG: confidence
MISS: suggested obvious solution without considering alternatives
FIX: always generate 2-3 options before recommending
```

**Why it's good:**
- Clear tag (confidence)
- Specific problem (what went wrong)
- Actionable fix (what to do differently)

### Bad Log Entry
```
TAG: ???
MISS: did something wrong
FIX: do better
```

**Why it's bad:**
- Vague tag
- No context
- Fix isn't actionable

## Expected Timeline

**Week 1:** Results will be "mid"
- Adjusting to the system
- Learning to reflect effectively
- Building up log entries

**Week 4:** Notice sharp improvement
- Patterns emerge
- Context overlap prevents repeated mistakes
- Agent "remembers where it lies to itself"

## Advanced Features

### HIT Logging (Optional)

Add HIT entries to capture wins:
```
TAG: uncertainty
HIT: acknowledged unknown and asked clarifying questions
```

**Why:** Prevents over-correction. If you only log MISS, you might become overly cautious. HIT shows what works.

### Weighted Recency

Prioritize recent entries more heavily:
```
def get_entry_weight(entry):
    days_old = (now - entry.date).days
    return max(1, 30 - days_old)  # Recent = higher weight
```

### Domain-Specific Questions

Customize questions by domain:

**For Coding Agents:**
- What edge cases did I miss?
- Did I test before suggesting?

**For Writing Agents:**
- Was the tone appropriate?
- Did I answer the actual question?

**For Research Agents:**
- Did I verify my sources?
- Did I miss contradictory evidence?

## Integration with Existing Systems

### Works With:
- **HEARTBEAT.md** — Natural fit for periodic checks
- **Self-Improvement Skill** — Complementary (passive vs active)
- **Last30days Skill** — Can analyze patterns across domains

### Enhancement Ideas:
- Add confidence score tracking (HIT / (HIT + MISS) ratio)
- Generate weekly self-improvement reports
- Auto-detect patterns across entries
- Suggest improvements based on log analysis

## Example End-to-End Session

**Time:** 14:00 (hourly heartbeat)

**Agent reflects:**
> "I just suggested using React without considering the team's Vue expertise. Defaulted to consensus."

**Logs:**
```markdown
[2026-01-30 14:00]

TAG: confidence
MISS: suggested React without considering team expertise
FIX: always ask about existing stack before suggesting new tools
```

**Time:** 14:30 (new task)

**Task:** "Help me choose a frontend framework for my project"

**Context Check:**
- Task context: "frontend framework", "choose"
- Matches MISS entry: "suggested React without considering team expertise"

**Counter-Check Applied:**
> "Before I suggest frameworks, what's your team's current tech stack and expertise?"

**Result:** No mistake repeated. Success.

## Best Practices

### DO ✅
- Start simple (1-2 hour interval, 3 questions)
- Be specific in MISS/FIX entries
- Log both MISS and HIT
- Prioritize recent entries
- Keep questions focused

### DON'T ❌
- Make interval too short (noise over signal)
- Log everything (only meaningful patterns)
- Skip HIT entries (avoid over-correction)
- Ignore context overlap detection
- Make log format too complex

## Metrics to Track

**Quantitative:**
- Number of MISS entries per week (should decrease over time)
- HIT/MISS ratio (target: 3+ for every MISS)
- Context overlap triggers per week (initially high, then stabilizes)

**Qualitative:**
- Are the same mistakes repeating?
- Is the agent becoming more self-aware?
- Is the user noticing improvement?

## Common Mistakes

**Mistake 1:** Logging everything
**Fix:** Only log meaningful patterns. "I made a typo" is not a pattern.

**Mistake 2:** Skipping HIT entries
**Fix:** Log HIT to prevent over-correction and balance improvement.

**Mistake 3:** Ignoring context overlap
**Fix:** The power is in the prevention, not just the logging. Implement the check.

**Mistake 4:** Complex log format
**Fix:** Keep it simple. Text is fine. Parseable is better but not necessary.

## Success Criteria

You know it's working when:
- ✅ Same mistakes don't repeat within 2 weeks
- ✅ HIT/MISS ratio is balanced (3:1 or better)
- ✅ Agent proactively checks context on relevant tasks
- ✅ You notice improvement (not just hope for it)
- ✅ The system is lightweight enough to run indefinitely

---

## Appendix: Full Template Copy-Paste

### HEARTBEAT.md Addition
```markdown
## Self-Check (runs every hour)

Ask yourself:
> What sounded right but went nowhere?
> Where did I default to consensus?
> What assumption didn't I pressure test?

Log answers to memory/self-review.md

Tag each entry with [confidence | uncertainty | speed | depth]
```

### memory/self-review.md Template
```markdown
# Self-Review Log

## Template
```
[ date ]

TAG: confidence
MISS: defaulted to consensus on [context]
FIX: [what to do differently]

TAG: speed
MISS: added noise not signal in [context]
FIX: [what to do differently]

TAG: uncertainty
HIT: acknowledged unknown and asked clarifying questions
```

## Entries
```

### Startup Prompt Addition
```
On boot, read memory/self-review.md
Prioritize recent MISS entries
When task context overlaps a MISS tag, force a counter-check before responding
```

---

**The Goal:** Turn ephemeral failures into permanent lessons, and use those lessons to prevent future mistakes.

An agent that remembers where it lies to itself becomes an agent that stops lying.
