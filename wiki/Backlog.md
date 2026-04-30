---
description: Pending work items not yet started — TEAME tickets and cross-functional initiatives awaiting prioritization or unblocked start
tags: ["projects", "backlog", "work-in-progress", "meta", "TEAME", "metabase"]
created: 2026-04-30
updated: 2026-04-30
---

# Backlog

Work items not yet started, not actively in progress, or blocked waiting on dependencies. See [[Active Projects]] for current work and [[Completed Work]] for shipped initiatives.

---

## Team E — Pending Tickets

Tickets in "To Do" status, assigned but not yet started or actively worked.

| Ticket | Priority | Sprint | Assignee | Summary |
|--------|----------|--------|----------|---------|
| [[teame-169-update-color-definitions]] | High | 44, 45 | Luis Almonte | Update color definitions from Figma design system |
| [[teame-173-calculator-skill-challenge]] | Low | — | Luis Almonte | Calculator not working for some skill challenge questions |
| [[teame-182-footer-updates]] | Medium | — | Luis Almonte | Footer updates (screenshot attached, no description) |
| [[teame-188-timeline-reset-skill-resource]] | High | 48 | Luis Almonte | Timeline resets after leaving Skill Resource page with multiple assessment iterations |
| [[teame-189-skill-assessment-refresh-failure]] | High | 48 | Luis Almonte | Skill assessment fails to load after page refresh when timeline has previous attempts |
| [[teame-204-performance-assignment-status]] | Lowest | — | Luis Almonte | 15s delay before student sees assignment status change after submitting skill assessment |
| [[teame-213-expand-student-flow-metrics]] | High | 48 | Luis Almonte | Expand student-flow and pace guardrail metrics for A/B test insights |
| [[teame-235-dropdowns-overlapping-footer]] | Medium | — | Luis Almonte | Practice Problems dropdowns overlapping the footer |

### Ticket Details

#### [[teame-169-update-color-definitions|TEAME-169: Update Color Definitions in Frontend]]
- **Status:** To Do (since 2025-09-30, carried over from Sprint 44/45)
- **Parent:** PP-369 (Update Skill Selection Layouts and Navigation)
- **Blocker:** Figma design handoff — link in source ticket
- **Type:** Story, requires functional testing + LTS feature flag
- **Source:** [[teame-169-update-color-definitions]]

#### [[teame-173-calculator-skill-challenge|TEAME-173: Calculator Not Working for Some Skill Challenge Questions]]
- **Status:** To Do
- **Priority:** Low
- **Assignee:** Luis Almonte
- **Reporter:** Margaret Wang
- **Labels:** escalated
- **Parent:** PP-464 Bug Backlog 2026
- **Blocked by:** TEAME-166 (Investigate Long-Term Learnosity Stability)
- **Attachments:** Screen recording + photo
- **Note:** No description text in ticket; may need reproduction steps from attachments

#### [[teame-182-footer-updates|TEAME-182: Footer Updates]]
- **Status:** To Do
- **Priority:** Medium
- **Assignee:** Luis Almonte
- **Reporter:** Valentina Scatoni
- **Created:** October 27, 2025
- **Note:** Screenshot attached but no description text

#### [[teame-188-timeline-reset-skill-resource|TEAME-188: Timeline Reset After Leaving Skill Resource Page]]
- **Status:** To Do
- **Parent:** TEAME-166 (Investigate Long-Term Learnosity Stability)
- **Root cause hypothesis:** Fragile `useEffect` dependency array causing missed re-renders
- **Behavior:** Intermittent — not consistently reproducible
- **Reporter:** Maria Canteras (QA), confirmed as regression on Demo
- **Source:** [[teame-188-timeline-reset-skill-resource]]

#### [[teame-189-skill-assessment-refresh-failure|TEAME-189: Skill Assessment Refresh Failure]]
- **Status:** To Do
- **Parent:** TEAME-166 (Investigate Long-Term Learnosity Stability)
- **Issue:** Practice Problems and Skill Assessment "Start" button fail to load after page refresh with previous attempts
- **Reporter:** Maria Canteras (QA)
- **Has video reproduction:** Yes (21MB MP4)
- **Source:** [[teame-189-skill-assessment-refresh-failure]]

#### [[teame-204-performance-assignment-status|TEAME-204: Performance — 15s Delay on Assignment Status]]
- **Status:** To Do (may be resolved — needs confirmation)
- **Priority:** Lowest
- **Assignee:** Luis Almonte
- **Reporter:** Ben Valcour
- **Created:** April 25, 2025
- **Labels:** Functional_Testing, user-story-7
- **Note:** Meg Meyer-Daetsch asked in Sept 2025 if addressed in Aug release. Marilia reassigned to Sam in Jan 2026 for assessment. Still open pending confirmation.

#### [[teame-213-expand-student-flow-metrics|TEAME-213: Expand Student-Flow and Pace Guardrail Metrics]]
- **Status:** To Do
- **Goal:** Extend A/B test insights to allow checking student funnels through the platform
- **Type:** Story, labeled for automated regression checks
- **Reporter:** Sam Saarinen
- **Source:** [[teame-213-expand-student-flow-metrics]]

#### [[teame-235-dropdowns-overlapping-footer|TEAME-235: Dropdowns Overlapping Footer]]
- **Status:** To Do
- **Priority:** Medium
- **Assignee:** Luis Almonte
- **Reporter:** Maria Canteras
- **Created:** February 3, 2026
- **Note:** No description text in ticket

---

## In Progress / Active Work

Tickets currently being worked or in active QA iteration.

| Ticket | Priority | Sprint | Assignee | Summary |
|--------|----------|--------|----------|---------|
| [[teame-218-code-cleanup-lts-conversion]] | High | — | Luis Almonte | Convert in-platform polling to LTS feature (TEAME-177 cleanup) |
| [[teame-268-brain-brake-retry-cooldown]] | Medium | — | Luis Almonte | Brain Brake not shown on skill assessment retry despite 10+ day cooldown |
| [[teame-272-scrollbar-usability]] | Low | — | Luis Almonte | Brain Break scrollbar drag not responsive on first question |
| [[teame-277-brain-break-two-minute-trigger]] | Medium | — | Luis Almonte | Brain Break triggered twice for same student within 2 minutes |

### Ticket Details

#### [[teame-218-code-cleanup-lts-conversion|TEAME-218: Code Cleanup — Convert to LTS Feature]]
- **Status:** In Progress
- **Priority:** High
- **Parent:** PP-442 In-Platform Polling (LTS Feature?)
- **Progress:**
  - Cool-off period: Implemented
  - Per-emoji logging: Implemented
  - Brain break header coverage: Pending
  - Experiment guardrail logging: Pending
- **Coordinate with:** Vale S (design considerations from HotJar)
- **Source:** [[teame-218-code-cleanup-lts-conversion]]

#### [[teame-268-brain-brake-retry-cooldown|TEAME-268: Brain Brake Retry Cooldown]]
- **Status:** In Progress
- **Priority:** Medium
- **Assignee:** Luis Almonte
- **Reporter:** Maria Canteras
- **Created:** April 16, 2026
- **Issue:** Brain Brake modal does not appear on retry even after 10+ days
- **Next step:** Verify `experiments_speculative_data` cooldown entry in DB
- **Source:** [[teame-268-brain-brake-retry-cooldown]]

#### [[teame-272-scrollbar-usability|TEAME-272: Scrollbar Usability]]
- **Status:** Open (issue persists)
- **Priority:** Low
- **Assignee:** Luis Almonte
- **Reporter:** Maria Canteras
- **Created:** April 16, 2026
- **Last tested:** April 29, 2026 — issue still persists in qa-clam
- **Source:** [[teame-272-scrollbar-usability]]

#### [[teame-277-brain-break-two-minute-trigger|TEAME-277: Brain Break Triggered Within 2 Minutes]]
- **Status:** Open (reported April 29, 2026)
- **Priority:** Medium
- **Assignee:** Luis Almonte
- **Reporter:** Maria Canteras
- **Created:** April 29, 2026
- **Issue:** Cooldown system allowing re-trigger within 2 minutes
- **Source:** [[teame-277-brain-break-two-minute-trigger]]

---

## Near Release / In QA

Tickets in final QA or close to release. Consider moving to [[Completed Work]] if shipped.

### [[teame-177-in-platform-polling-cleanup|TEAME-177: In-Platform Polling → LTS Feature]]
- **Status:** Inbox / In QA (2nd round)
- **Priority:** Medium
- **Owner:** Luis Almonte
- **Progress:** Cool-off period implemented, per-emoji logging added. Brain break header coverage and experiment guardrail logging remaining.
- **Note:** File comment says "close to being released" — may graduate to [[Completed Work]] soon
- **Source:** [[teame-177-in-platform-polling-cleanup]]

---

## Recently Resolved

Tickets resolved in recent sprints, kept here briefly for reference before archiving.

### April 2026 Brain Brake Batch

| Ticket | Summary | Resolution |
|--------|---------|------------|
| [[teame-265-brain-brake-login]] | Brain Brake at login wasn't implemented | Implemented — student must spend 30s on dashboard before skill card click triggers modal. Verified by Maria in qa-clam. |
| [[teame-267-brain-brake-practice-problems]] | Brain Brake not shown after 30s in Practice Problems | Fixed — triggers from both "Take Challenge" buttons. Verified by Maria in qa-clam. |
| TEAME-157 | Multi-part questions showing as separate boxes | Resolved on authoring side (not code). Sam Martin confirmed academics team can fix. |

### [[teame-265-brain-brake-login|TEAME-265: Brain Brake at Login]]
- **Status:** Resolved (April 17, 2026)
- **Assignee:** Luis Almonte
- **Reporter:** Maria Canteras
- **Resolution:** After login, students must spend 30 seconds on dashboard before clicking a skill card triggers the Brain Brake modal. Verified by Maria in qa-clam.

### [[teame-267-brain-brake-practice-problems|TEAME-267: Brain Brake in Practice Problems]]
- **Status:** Resolved (April 17, 2026)
- **Assignee:** Luis Almonte
- **Reporter:** Maria Canteras
- **Resolution:** Modal now triggers from both "Take Challenge" buttons in the practice problem section. Verified by Maria in qa-clam.

---

## Cross-Functional Initiatives

Large programs spanning multiple teams, awaiting kickoff or unblocked start.

### Metabase Admin Dashboard Initiative
- **Target:** Aug 1, 2026 — universally useful admin dashboard for all partner districts
- **Status:** Discovery / Requirements phase
- **Technical Lead:** Joseph (Metabase strategy, security model, dashboard approach)
- **Product:** Marilia (requirements, prioritization, Jira structure)
- **Data Engineering:** Christina (data modeling, ETL, warehouse structure)
- **Developer:** Marcos (embedding implementation, authorization, role-level security)
- **Delivery paths under consideration:**
  1. Automated data sends (CSV exports, scheduled reports, email delivery)
  2. Embedded dashboards in product (Metabase dashboards via iframe or React SDK)
- **Current blockers:** Enterprise Metabase license/connection pending (per `raw/Metabase setup.md`)
- **Related wiki pages:** [[metabase-admin-dashboard-initiative]], [[metabase-embedding-sdk]], [[metabase-full-app-embedding]], [[metabase-modular-authentication]], [[metabase]]

---

## Backlog Stats

| Category | Count |
|----------|-------|
| Team E Pending (To Do) | 8 |
| In Progress / Active | 4 |
| Near Release / In QA | 1 |
| Recently Resolved | 3 |
| Cross-Functional Initiatives | 1 |

---

See also:
- [[Active Projects]] — Current work in progress
- [[Completed Work]] — Shipped initiatives and archived projects
