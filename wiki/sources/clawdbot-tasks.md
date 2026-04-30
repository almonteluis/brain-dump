---
description: "Task tracking system"
tags: [clawdbot, tasks, projects, tracking, debt-collection, zai]
sources: [clawdbot/tasks.md]
created: 2026-04-09
updated: 2026-04-09
---

# Tasks Master List

**Source:** raw/02_reference/tools/clawdbot/tasks.md
**Date ingested:** 2026-04-09
**Type:** task tracking

## Summary

Central task tracking across all projects for Clawdbot. Updated regularly with progress and next steps.

## Research & Setup (Completed)

### LLM-Friendly Note Format Research ✅
- [x] YAML frontmatter standards (title, date, tags, status, priority)
- [x] llms.txt index file structure
- [x] Note structure best practices (H1/H2, blockquotes, code blocks)
- [x] Tag hierarchy strategy (work/*, tech/*, daily/*)
- [x] Daily backup structure for Clawdbot folder

### Apply LLM Best Practices ✅
- [x] Add YAML frontmatter to MEMORY.md, tasks.md
- [x] Create llms.txt index file
- [x] Add hierarchical tags to daily memory files
- [x] Cross-link related notes with [[wiki-links]]

### Daily Note Automation ✅
- [x] Create daily note template with YAML frontmatter
- [x] Build Python script for auto-generation
- [x] Set up cron job (runs at 7pm EST / midnight UTC)
- [x] Create documentation in "Daily Notes Automation" folder

### Z.ai MCP Vision Server ✅
- [x] Document Z.ai MCP capabilities
- [x] Research Claude Code MCP integration
- [x] Create setup guide for API key configuration
- [x] Document use cases for food orders (OCR, menu extraction)

## Debt Collection Response Project

### Completed Tasks
- [x] Receive and photograph debt collection letter (Dec 9, 2025)
- [x] Research FDCPA rights and debt validation process (Jan 27, 2026)
- [x] Draft comprehensive debt validation letter (Jan 27, 2026)

### In Progress
- [ ] **Mail debt validation letter** (Scheduled)
  - Must use Certified Mail with Return Receipt
  - Keep tracking number for records

### Pending Tasks

#### High Priority
- [ ] **Send debt validation letter via Certified Mail**
  - Must be sent within 30 days of initial communication
  - Use Certified Mail, Return Receipt Requested
  - Keep tracking number and receipt

- [ ] **Check credit reports** for this account
  - AnnualCreditReport.com (free)
  - Look for JPMorgan Chase account ending in 1525

#### Medium Priority
- [ ] **Research statute of limitations** for this debt
  - New York statute: 6 years for credit card debt
  - Determine date of last payment

- [ ] **File complaints** if UCB violates FDCPA
  - CFPB: consumerfinance.gov/complaint
  - FTC: reportfraud.ftc.gov
  - NY Attorney General: ag.ny.gov

## Key Documents

- **Debt validation letter:** `/home/ubuntu/clawd/debt-validation-letter.md`
- **UCB reference #:** 82878374
- **Original creditor:** JPMorgan Chase Bank, N.A.

## FDCPA Key Rights (15 U.S.C. § 1692g)

1. **30-day dispute window** from initial communication
2. **Cease collection** — They must stop all collection activities once debt is disputed
3. **Verification requirement** — They must provide proof of debt validity
4. **Original creditor info** — Must provide name and address if requested
5. **No credit reporting** — Cannot report to credit bureaus until debt is validated

## New York Specific

- **Statute of limitations:** 6 years for credit card debt
- **Licensing required:** Debt collectors must be licensed in NY
- **Strong consumer protections:** NY General Business Law § 601

## Important Notes

- **Never acknowledge debt** until it's validated
- **Never make partial payment** — resets statute of limitations
- **Keep all documentation** — every letter, every receipt, every call log
- **Send everything certified mail** — proof of delivery is critical

## Red Flags to Watch For

- [ ] Phone harassment (calling repeatedly, calling at odd hours)
- [ ] Threats of arrest or legal action without intent to follow through
- [ ] Discussing debt with third parties (family, employer)
- [ ] Continuing collection after dispute letter is sent
- [ ] Reporting to credit bureaus without validation

**If any occur:** Document immediately and file FDCPA complaint.

## Concepts Covered

- [[Task Tracking]] — Project management
- [[Debt Validation]] — FDCPA process
- [[Consumer Rights]] — Legal protections
- [[Z.ai Integration]] — MCP vision server

## Related

- [[clawdbot-memory]]
- [[zai-mcp-vision-server]]
- [[debt-validation-letters]]
