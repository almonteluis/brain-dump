---
description: React notes and reference about tasks.
title: Tasks Master List
date: 2026-01-28
tags: [tasks, projects, tracking]
category: tracking
status: active
priority: high
---

# Tasks Master List

> Central task tracking across all projects. Updated regularly with progress and next steps.

---

## 📚 Research & Setup

- [x] **Complete LLM-friendly note format research** ✅ (Jan 28, 2026)
  - [x] YAML frontmatter standards (title, date, tags, status, priority)
  - [x] llms.txt index file structure
  - [x] Note structure best practices (H1/H2, blockquotes, code blocks)
  - [x] Tag hierarchy strategy (work/*, tech/*, daily/*)
  - [x] Daily backup structure for Clawdbot folder
  - **Result:** Obsidian notes now LLM-optimized for better context

- [x] **Apply LLM best practices to existing notes** ✅ (Jan 28, 2026)
  - [x] Add YAML frontmatter to MEMORY.md, tasks.md
  - [x] Create llms.txt index file in Clawdbot folder
  - [x] Add hierarchical tags to daily memory files
  - [x] Cross-link related notes with [[wiki-links]]

- [x] **Set up daily note automation** ✅ (Jan 28, 2026)
  - [x] Create daily note template with YAML frontmatter
  - [x] Build Python script for auto-generation
  - [x] Set up cron job (runs at 7pm EST / midnight UTC)
  - [x] Create documentation in "Daily Notes Automation" folder
  - **Result:** Daily notes created automatically every day at 7pm EST

- [x] **Update all memory files with LLM frontmatter** ✅ (Jan 28, 2026)
  - [x] Created Python script to add YAML frontmatter
  - [x] Updated all 18 memory files (2026-01-25 through 2026-01-28)
  - [x] Added hierarchical tags based on content (debt, notion, api, trading, etc.)
  - [x] Extracted dates from filenames for metadata
  - **Result:** All memory files now LLM-parseable

---

## 💼 Debt Collection Response Project

---

## ✅ Completed Tasks

- [x] Receive and photograph debt collection letter (Dec 9, 2025)
- [x] Research FDCPA rights and debt validation process (Jan 27, 2026)
- [x] Draft comprehensive debt validation letter (Jan 27, 2026)

---

## 🔄 In Progress

- [ ] **Mail debt validation letter** (Scheduled: Jan 29, 2026)
  - Printed and ready to drop off
  - Must use Certified Mail with Return Receipt
  - Keep tracking number for records

---

## 📌 Pending Tasks

### High Priority (Do ASAP)
- [ ] **Send debt validation letter via Certified Mail**
  - Must be sent within 30 days of initial communication
  - Use Certified Mail, Return Receipt Requested
  - Keep tracking number and receipt
  - Make 2 copies for records

- [ ] **Check credit reports** for this account
  - AnnualCreditReport.com (free)
  - Look for JPMorgan Chase account ending in 1525
  - Document if it's being reported

### Medium Priority (Within 2 weeks)
- [ ] **Research statute of limitations** for this debt
  - New York statute: 6 years for credit card debt
  - Determine date of last payment
  - Calculate if debt is time-barred

- [ ] **File complaints** if UCB violates FDCPA
  - CFPB: consumerfinance.gov/complaint
  - FTC: reportfraud.ftc.gov
  - NY Attorney General: ag.ny.gov/consumer-frauds

### Low Priority (After validation response)
- [ ] **Review UCB's response** (30 days after they receive letter)
  - Verify they provided requested documentation
  - Check for original contract with wet signature
  - Verify chain of custody
  - Confirm licensing/bonding

- [ ] **Decide next steps** based on their response
  - If they validate: Consider settlement or dispute with original creditor
  - If they can't validate: Demand removal from credit report
  - If they ignore: File FDCPA complaint

- [ ] **Consult consumer attorney** if needed
  - Free consultations available for FDCPA violations
  - Many attorneys work on contingency for debt collection cases

---

## 📄 Key Documents

- **Debt validation letter:** `/home/ubuntu/clawd/debt-validation-letter.md`
- **Original collection letter:** Image uploaded Jan 27, 2026
- **UCB reference #:** 82878374
- **Original creditor:** JPMorgan Chase Bank, N.A.

---

## 🔍 Research Findings

### FDCPA Key Rights (15 U.S.C. § 1692g)
1. **30-day dispute window** from initial communication
2. **Cease collection** - They must stop all collection activities once debt is disputed
3. **Verification requirement** - They must provide proof of debt validity
4. **Original creditor info** - Must provide name and address if requested
5. **No credit reporting** - Cannot report to credit bureaus until debt is validated

### New York Specific
- **Statute of limitations:** 6 years for credit card debt
- **Licensing required:** Debt collectors must be licensed in NY
- **Strong consumer protections:** NY General Business Law § 601

### Settlement Options (Only if debt is validated)
- Full payment by Dec 29, 2025: $1,324.30 (30% discount) ❌ **EXPIRED**
- 3 payments: $1,545.02 total (35% discount)
- 18 payments: $1,765.73 total (40% discount)

⚠️ **DO NOT PAY** until debt is properly validated!

---

## 📝 Notes

- **Never acknowledge debt** until it's validated
- **Never make partial payment** — resets statute of limitations
- **Keep all documentation** — every letter, every receipt, every call log
- **Send everything certified mail** — proof of delivery is critical
- **Document phone calls** — date, time, name, what was said

---

## 🚨 Red Flags to Watch For

- [ ] Phone harassment (calling repeatedly, calling at odd hours)
- [ ] Threats of arrest or legal action without intent to follow through
- [ ] Discussing debt with third parties (family, employer)
- [ ] Continuing collection after dispute letter is sent
- [ ] Reporting to credit bureaus without validation

**If any occur:** Document immediately and file FDCPA complaint.

---

**Last updated:** January 27, 2026  
**Next review:** After sending validation letter (track 30-day response window)

- [x] **Research Z.ai MCP Vision Server** ✅ (Jan 28, 2026)
  - [x] Document Z.ai MCP capabilities for image processing
  - [x] Research Claude Code MCP integration methods
  - [x] Create setup guide for Z.ai API key configuration
  - [x] Document auto-detection and manual invocation patterns
  - [x] List use cases for food orders (OCR, menu extraction, receipt analysis)
  - [x] Create comprehensive setup documentation
  - **Result:** Documentation ready for implementing image processing automation

