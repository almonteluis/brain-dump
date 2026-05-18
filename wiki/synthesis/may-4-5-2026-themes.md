---
description: Five major themes from May 4-5 2026 notes — BrainBreak LTS bugs, dev-env friction, QA tooling, learning-product research, personal/wellness
tags:
  - synthesis
  - weekly-review
  - marvin/frontend/brain-break
  - may-2026
created: 2026-05-05
type: synthesis
---

# Themes — May 4-5, 2026

Two-day window. 16 new pages, 4 new concept pages, 5 concept pages updated. Five themes emerge.

## 1. BrainBreak LTS — closing out cooldown + speculative data bugs

Biggest cluster. Multiple debug iterations on two ticket lines blocking LTS conversion.

**Bug A: Broken ISO parser.** `cooldown.ts:29` splits `lastCompletedDate` on `-`, maps to `Number`. Recorder writes full ISO (`2026-04-25T10:51:00.000Z`); parser assumes `YYYY-MM-DD`. Third chunk = `'25T10:51:00.000Z'` → `NaN`. Invalid date → fail-open → modal surfaces wrong day.

**Bug B: Time-of-day boundary.** Even with valid parsing, recorder writes full timestamp. User completing at 3pm not eligible until after 3pm ten days later. Should be calendar-day arithmetic.

**Decision:** Ship Fix A + Fix B same commit. Tightly coupled — Fix A alone leaves off-by-hours edge.

**Manual QA on deer (user.id 364):** Day-9 modal appeared when should not. Redux state inconsistent — `hydrated: true` but no cooldown data. Rehydration path issue beyond parser.

**TEAME-287 (separate):** Speculative data bumps `created` column instead of `modified` on repeat BrainBreak. Insert-vs-update confusion. Quick fix.

**Follow-up:** Skip placement fetch during cooldown — ~10 days wasted compute per student.

Sources: [[brainbreak-lts-cooldown-speculative-bugs]], [[remaining-brain-break-tickets]], [[teame-287-speculative-data-created-bug]], [[work-status-may-5-2026]]
Concepts: [[cooldown-system]], [[experiment-speculative-data]]

## 2. Dev-env friction — every shortcut bites later

Three gotchas from this week.

**Docker volume mount on cross-platform `node_modules`.** Mounting host `node_modules` (macOS) into Linux container surfaces `esbuild.exe` because esbuild ships platform-specific binaries. Solution: don't mount `node_modules` — let container install fresh.

**Stale `origin/main` during rebase.** `git rebase origin/main` rebases against local cached ref. If teammate pushed migration files after last fetch, rebase silently misses them — Flyway fails on local stack. Always `git fetch` before rebase, or `git pull --rebase origin main`.

**Marvin local FE setup.** Run frontend outside Docker (`npm run dev:relay`) for hot-reload; stack in containers. Grade-selection page hang documented as real bug as of May 5, not setup issue.

**Worktree location:** inside vs outside repo doesn't affect git (same object DB). Outside preferred for IDE separation only.

Sources: [[docker-fe-esbuild-exe-error]], [[worktree-rebase-missed-flyway-migrations]], [[marvin-local-frontend-dev-setup]]
New concept: [[git-rebase-hygiene]]
Updated: [[docker]], [[flyway]], [[git-worktrees-parallel-work]]

## 3. ![[QA workflow + accessibility tooling self-evaluation]]



## 4. Learning-product / research foundations

Product-side thinking ramping up alongside the BrainBreak close.

**Math problem game concept:** math feels arbitrary to students. Good math game targets the eureka moment — pattern recognition click just before the answer. Abstraction tools (diagrams) frame worked examples to surface hidden patterns. Game mechanics should reward recognition, not just correct answers.

**Reverse scoring on self-efficacy questionnaire (Q8, Q9):** Maria asked about applicability. Psychometric technique — invert scale direction to detect response bias. Need to verify logic fully implemented.

**Knowledge tracing + teacher dashboards research:** Google Scholar search returning AI/ML algorithm papers, not pedagogical/classroom context. Only one school-relevant paper found. More digging needed.

**Teach to One tier disconnect:** Tier 1 (in-class math) and Tier 2 (math lab) teachers don't share curriculum view. Need per-student progress graph visible to both. Math lab feels like "study hall with rotating teachers" instead of dedicated TTO time.

Sources: [[captains-log-volume-one]], [[research-terms-recap]], [[work-status-may-5-2026]]
New concepts: [[math-problem-game]], [[reverse-scoring]]

## 5. Personal / wellness ledger

Voice-memo journals catching wellbeing alongside work.

**Meditation:** Kobe's 15-minute daily practice — morning stillness, visualization, restorative brain mode. New concept [[meditation-practice]].

**Type I vs Type II fun:** enjoyable throughout vs hard now / rewarding later. Useful taxonomy for evaluating activities and design decisions. New concept [[type-i-type-ii-fun]].

**NBA playoffs:** Knicks 137-98 over 76ers (Brunson 35, no 76er over 20). Wembanyama 12 blocks (playoff record). Desired finals: Knicks vs Timberwolves — no superstars, just squads.

**Drinking lesson:** Saturday R&B party, blacked out. Rule going forward: max 2 drinks, more water than alcohol.

**One-liner:** idea guys who are too busy to execute.

Sources: [[kobe-bryant-meditation-article]], [[caption-logs-may-4-2026]], [[nba-eastern-playoff-may-2-2026]], [[crazy-tweets]]

## Takeaway

Two-day window dominated by **closing the BrainBreak LTS conversion**. Multiple debug iterations + Docker rebuilds + stale-rebase pain show the close is friction-heavy, not feature-heavy. Three new hygiene concepts ([[git-rebase-hygiene]], Docker volume pitfall, axe linter scope) emerged directly from pain points — pattern of converting daily friction into reusable concepts.

Product-side thinking ramping up: psychometrics ([[reverse-scoring]]), pedagogy ([[math-problem-game]]), research substrate ([[knowledge-tracing]]). Voice-memo journal cadence catching both work tasks and wellbeing in same stream — meditation, NBA, drinking-rule, R&B party — alongside the engineering pain.

Pattern across themes: **the second draft is where insight lives.** Refined BrainBreak write-up [[brainbreak-lts-cooldown-speculative-bugs]] surfaced fixes the voice-memo session [[remaining-brain-break-tickets]] only hinted at. Same shape on the math game concept (voice memo → [[math-problem-game]] concept page).

## Related

- [[Active Projects]] — TEAME-218 BrainBreak LTS now back here from Completed Work
- [[wiki/log|Processing Log]] — full ingest history
- [[BB being open in 2 sessions via different browser]] — earlier sprint snapshot before this debug cycle
