---
description: "A 6-month report from someone who runs the pattern on real infrastructure, not a weekend project."
tags: ['research', 'ai']
source: "https://tomnguyenit.medium.com/i-built-karpathys-llm-wiki-for-my-day-job-here-s-what-actually-works-0d4ec6d1e433"
raw_file: "I Built Karpathy’s LLM Wiki for My Day Job — Here’s What Actually Works.md"
created: 2026-05-17
---

*A 6-month report from someone who runs the pattern on real infrastructure, not a weekend project.*

![](https://miro.medium.com/v2/resize:fit:1400/format:webp/1*UkN2Xw98Yx84saXSJ10a6A.png)

In April 2025, Andrej Karpathy published a gist called “LLM Wiki” — a pattern for building personal knowledge bases using LLMs. The idea is simple: instead of using RAG to retrieve from raw documents every time, you have the LLM **incrementally build and maintain a persistent wiki** — a structured collection of markdown files that compounds over time.

The gist went viral. 5,000+ stars. The comments split into two camps: people calling it brilliant, and people calling it a glorified markdown graveyard that can’t scale.

I’ve been running this pattern since October 2024 — before the gist existed. Not as a toy project. As my actual knowledge management system for managing AWS infrastructure across dozens of accounts. 77 wiki pages, 30+ ingested source documents, 13 custom AI skills that read from and write to the wiki.

Here’s what I’ve learned.

## What I Actually Built

The architecture matches Karpathy’s description almost exactly, because the pattern is natural once you start doing it:

**Three layers:**

- **Raw sources** — Confluence exports, meeting transcripts, architecture docs. Immutable. The AI reads them but never touches them.
- **The wiki** — Obsidian vault with structured markdown pages. The AI writes and maintains all of it. I review and browse.
- **The schema** — A file called `AGENTS.md` that tells the AI how the wiki is organized, what conventions to follow, and what workflows to run.

**Three operations:**

- **Ingest** — I drop a document, the AI reads it, creates wiki pages, updates the index, cross-links everything. One source typically touches 5–15 pages.
- **Query** — I ask questions. The AI reads the index, finds relevant pages, synthesizes an answer with citations.
- **Lint** — Periodic health checks. Find orphan pages, contradictions, missing cross-links.

The wiki covers AWS architecture, Terraform standards, deployment pipelines, customer environments, security remediation — everything my team needs to operate.

## What Actually Works

## 1\. The AI Remembers What You Forget

Before the wiki, my workflow was: read a Confluence doc, take some notes (maybe), forget the details two weeks later, spend 30 minutes hunting for the same doc again.

Now when I ask “what’s the deployment order for production changes?”, the AI doesn’t search the internet. It reads my wiki’s index, finds the relevant page, and gives me the exact answer — with the progressive rollout order, which environments need change requests, and which customers are most critical. All synthesized from documents I ingested months ago.

The wiki is my external memory. The AI is the librarian.

## 2\. Cross-Referencing Is the Killer Feature

This is where the LLM wiki genuinely beats RAG. When I ingest a document about “PR review standards,” the AI doesn’t just create one page. It:

- Creates the main knowledge page
- Links it to the existing “deployment workflow” page
- Links it to the “change management” page
- Links it to the “Terraform coding standards” page
- Updates the index

A human would never maintain these cross-references. I certainly wouldn’t. But the AI does it every single time, and the Obsidian graph view shows a genuinely useful knowledge network.

## 3\. The Schema File Is Everything

Karpathy mentions the schema briefly. In practice, it’s the most important file in the entire system.

My `AGENTS.md` defines:

- Directory structure (where different types of notes go)
- Frontmatter conventions (every page has type, domain, tags, status, source)
- Naming conventions (knowledge notes are concept-based, meetings are date-based)
- Quality standards (knowledge notes must be standalone, meeting notes under 150 lines)
- Workflows for each operation (ingest, query, lint)

Without this file, the AI produces inconsistent, unstructured output. With it, every page follows the same pattern. The schema is what turns a chatbot into a disciplined wiki maintainer.

## 4\. Specialized Skills Solve Real Problems

The wiki alone is useful. But the real power comes when you build **skills** — reusable instruction sets that read from the wiki to do specific jobs. Each skill exists because I hit a real pain point.

I have 13 skills. Here are the problems they solve:

**Problem: “Which AWS account is this error from, and how do I investigate it?”**

We have dozens of AWS accounts across multiple organizations. When something breaks, the first 10 minutes are wasted figuring out which account, which profile, which region. My **AWS troubleshoot** skill reads the error, matches the account ID against profiles in my AWS config, resolves the region, and starts investigating — all read-only. It knows our account structure because it reads the wiki page about our organization hierarchy.

## Get Tom Nguyen’s stories in your inbox

Join Medium for free to get updates from this writer.

**Problem: “I’m working on 3 security tickets across 13 accounts and I can’t remember what I’ve done where.”**

Vulnerability remediation at scale is a tracking nightmare. Each ticket touches multiple accounts, multiple environments, multiple deployment stages. My **ticket tracker** skill creates a structured page per ticket with progress tables, error logs, and verification checklists. When I hit an error during remediation, it logs it. When the error is something others might hit too, it extracts a knowledge note to the wiki so the lesson isn’t lost.

**Problem: “Reviewing a PR means understanding changes across 3 repos and checking 15 things.”**

Our infrastructure code lives in 3 layers — a Terraform module, a Terragrunt template, and a customer environment config. One change flows through all three. My **PR review** skill takes a branch name, scans all three layers, traces the version chain, and checks the diff against our team’s coding standards and operational checklists — all stored in the wiki. It produces a structured review that both the dev team (code quality) and SRE (operational safety) can use.

**Problem: “Someone shared a Confluence doc in a meeting and now I can’t find it.”**

Confluence is where documentation goes to die. My **knowledge ingestion** skill takes any document — Confluence export, meeting transcript, tutorial — and transforms it into structured, interlinked wiki pages. One document might produce 3–5 knowledge notes, each standalone, each cross-linked to related concepts. The document is findable forever because it’s woven into the knowledge graph.

**Problem: “I keep making the same mistake because I forgot I solved this 2 months ago.”**

This is the meta-problem the whole system solves. Every error logged, every lesson learned, every gotcha discovered gets filed into the wiki. Next time I hit the same issue, the AI finds the existing knowledge note instead of me spending an hour re-debugging. The wiki is institutional memory that actually works.

Each skill is just a markdown file with instructions. The AI reads the skill + the wiki + the current context, and does the job. The wiki is the shared memory that makes all skills smarter over time.

## What Doesn’t Work

## 1\. The AI Forgets to Use Its Own Wiki

This is the biggest surprise. You’d think an AI with access to a carefully maintained knowledge base would always check it before answering. It doesn’t.

I regularly have to remind it: “check the knowledge base first.” Sometimes it gives me a generic answer when the exact answer is sitting in a wiki page it helped write last week. The AI doesn’t have a habit of checking its own notes — you have to build that habit into every skill’s instructions.

## 2\. The AI Doesn’t Track Its Own Mistakes

When I hit an error during work — say, a Terraform plan fails because of a region-specific limitation — the AI helps me fix it. But it doesn’t automatically think “this is a reusable lesson, I should save it to the wiki.”

I have to explicitly say: “log this error as a knowledge note.” If I forget, the lesson is lost in chat history. The wiki only compounds if the human remembers to feed it.

I’ve partially solved this by building error tracking into my ticket skill — it has an “Errors Encountered” table, and errors marked as “reusable” get extracted to knowledge notes. But it still requires me to flag them.

## 3\. Index-Based Navigation Has a Ceiling

Karpathy acknowledges this: “your wiki might be small enough that the index file is all you need.” At 77 pages, my index still works. The AI reads it, finds relevant pages, drills in. No embeddings, no vector search.

But I can feel the ceiling approaching. The index is getting long. Sometimes the AI picks the wrong page because the one-line summary wasn’t specific enough. I haven’t needed search infrastructure yet, but I will.

## 4\. You Are the Quality Gate

The AI writes the wiki, but you have to review it. I’ve caught:

- Summaries that missed the key point of a document
- Cross-links that connected unrelated concepts
- Pages that duplicated existing content instead of updating it

The wiki is only as good as your review process. “The LLM writes and maintains all of it” is aspirational. In practice, it’s “the LLM drafts and you approve.”

## The Critics Are Half Right

The loudest criticism of LLM Wiki is that it’s “just RAG with extra steps” and “doesn’t scale.” Let me address both.

**“It’s just RAG with extra steps”** — No. RAG retrieves fragments and synthesizes on every query. The wiki pre-synthesizes once and keeps the synthesis current. When I ask about our deployment workflow, the AI reads one well-structured page instead of piecing together five raw documents. The cross-references are already there. The contradictions have already been flagged. That’s genuinely different.

**“It doesn’t scale”** — This is fair, but misses the point. The pattern works beautifully for personal and small-team knowledge bases (tens to low hundreds of pages). It’s not trying to replace enterprise knowledge management systems. It’s replacing the notebook you never maintain and the bookmarks you never organize.

The real limitation isn’t scale — it’s that **the human is still the bottleneck**. The AI can maintain the wiki, but only the human knows which documents matter, which errors are worth saving, and which cross-references are meaningful. The AI is a tireless librarian, but you’re still the curator.

## Practical Advice If You Want to Try This

1. Start with the schema, not the wiki. Write your `AGENTS.md` first. Define your directory structure, naming conventions, and frontmatter. This is the foundation everything else builds on.
2. Ingest one document at a time. Stay involved. Read the summaries, check the cross-links, guide the AI on what to emphasize. Batch ingestion produces lower quality.
3. Build skills early. A wiki you only query is useful. A wiki that powers specialized workflows is transformative. Start with one skill that solves a daily pain point.
4. Accept that you’re the editor-in-chief. The AI proposes, you approve. Don’t expect zero maintenance — expect dramatically reduced maintenance.
5. Use Obsidian. The graph view, the backlinks, the instant preview — it’s the best way to browse what the AI builds. The AI writes; Obsidian is how you read.

## Six Months In

My wiki has 77 pages across 9 knowledge domains. It tracks 3 active security remediation tickets across 13 AWS accounts. It powers 13 AI skills that handle everything from troubleshooting to PR reviews.

Is it perfect? No. The AI forgets to check its own notes. It doesn’t self-improve without prompting. The index will eventually need replacing with proper search.

But every week, the wiki gets a little richer. Every document I ingest makes every future question easier to answer. Every error I log prevents the same mistake from happening twice.

That’s the promise of the LLM Wiki pattern: **knowledge that compounds.** Not because the AI is magic, but because the AI handles the part humans are worst at — the boring, relentless bookkeeping that makes a knowledge base actually useful over time.

The human’s job is to curate, direct, and think. The AI’s job is everything else.

And that division of labor actually works.

*I’m a platform engineer working with AWS, Terraform, and Kubernetes. I built this system using Kiro CLI with Obsidian. If you want to see how the skills work in practice, I’m planning follow-up posts on the PR review skill and the ticket tracking workflow.*
