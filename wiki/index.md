---
description: Wiki index — entry point to the knowledge base
tags: ["index", "wiki"]
created: 2026-04-08
---

# Software Engineering Notebook — Wiki

This is the entry point to the processed knowledge base. All content is ingested from `raw/` sources and synthesized here.

### Entities
- [[gergely-orosz]] — Author, The Pragmatic Engineer
- [[boris-cherny]] — Claude Code founding engineer
- [[leonardo-de-moura]] — Creator of Lean and Z3

## Knowledge Structure

### Thinking Frameworks
- [[thinking-frameworks-collection]] — 17 thinking tools for decision-making, problem-solving, communication, systems thinking, and planning (untools.co)
- [[ai-as-management-skill]] — AI as management vs tool skill
- [[ai-coordination-gap]] — Orchestration challenges at scale
- [[critical-ai-literacy]] — Framework for discriminating AI use
- [[decision-velocity]] — Speed through governance and automation
- [[observability-competitive-advantage]] — Governance as speed
- [[process-over-outcome]] — Universal pattern for meaningful achievement
- [[universal-patterns]] — Patterns across physics, spirituality, psychology
- [[progressive-disclosure-in-practice]] — Layered vault navigation
- [[progressive-disclosure]] — Reveal information gradually, matching detail to need
- [[energy-spectrum-pattern]] — Energy spectrum universal pattern
- [[meditation-practice]] — Daily silence for mental clarity: morning stillness, visualization, restorative brain mode
- [[type-i-type-ii-fun]] — Fun taxonomy: Type I (enjoyable throughout) vs Type II (hard now, rewarding later)
- [[agentic-ai-maturity-gap-thinking]] — Thinking note on the agentic AI maturity gap
- [[agi-timeline-2026]] — AGI timeline predictions and analysis

*See [[wiki/log|Processing Log]] for full list.*


#### Relay / GraphQL
- [[relay]] — Meta's React GraphQL framework
- [[relay-fragments]] — Relay fragment patterns and best practices
- [[fragment-composition]] — Parent-child fragment patterns
- [[data-colocation]] — Keeping data declarations near usage
- [[data-masking]] — Hiding data from non-declaring components
- [[connection-pattern-pagination]] — Cursor-based pagination in Relay
- [[fragment-references]] — Opaque pointers linking parent queries to child fragments

#### React Patterns
- [[react-patterns]] — React best practices from Airbnb + 2026 React Compiler patterns
- [[react-design-patterns-research-2026]] — React Compiler, concurrent rendering, architecture patterns
- [[rules-of-hooks]] — Hooks must be called unconditionally at top level
- [[key-based-remount]] — Component reset pattern using React's key prop
- [[you-might-not-need-an-effect]] — When to avoid useEffect
- [[why-we-banned-useeffect]] — Five patterns that replace useEffect
- [[react-useeffect-patterns]] — Reference guide for useEffect alternatives
- [[state-context-reducer-pattern]] — Two-Context pattern for performant state
- [[relay-query-refactoring-guide]] — Multiple queries to single query + fragments migration (includes hooks comparison)
- [[designing-component-apis]] — Component API design patterns (props, slots, render props, compound components)
- [[container-presentational-pattern]] — Separating data logic (Container) from UI (Presentational)
- [[compound-components]] — Flexible composition with implicit shared state via Context
- [[component-architecture]] — Patterns for structuring React components
- [[state-management]] — Choosing the right state solution for each type of data
- [[render-props-pattern]] — Passing JSX through function props for maximum flexibility
- [[observer-pattern]] — Pub/sub pattern with useSyncExternalStore
- [[mediator-middleware-pattern]] — Centralized communication, Express middleware chain
- [[mixin-pattern]] — Extending behavior without inheritance (legacy, replaced by hooks)
- [[flyweight-pattern]] — Sharing state across similar objects for memory efficiency
- [[event-handling-react-interviews]] — Synthetic events, delegation, mouse/input/form/keyboard best practices
- [[client-side-rendering]] — CSR basics, React 18 progressive hydration, SSR/SSG preference
- [[ai-ui-patterns]] — AI chat UI with Vercel AI SDK, streaming, debouncing, Next.js vs Vite
- [[component-testing]] — Testing Library, user-centric testing, mocking, async, accessibility

#### Frontend Reference
- [[ui-component-libraries]] — Curated Tailwind CSS component libraries (23 free resources)
- [[modal-popover-tooltip-patterns]] — When to use Modal vs Popover vs Tooltip with decision flowchart
- [[overlay-patterns]] — Decision framework for Modal vs Popover vs Tooltip
- [[css-3d-rendering]] — Rendering 3D scenes with CSS transforms and math functions
- [[barrel-files]] — Why barrel files are anti-patterns
- [[atomic-design]] — Hierarchical component methodology
- [[design-systems]] — Reusable component libraries with shared tokens and patterns
- [[performance-patterns]] — Frontend optimization patterns
- [[bundle-optimization]] — Reducing JavaScript bundle size
- [[build-output-size-measurement]] — Eight methods for measuring build output sizes
- [[testing-patterns]] — Unit, integration, and E2E testing patterns
- [[web-components-architecture]] — Web components + server components for production (MDN architecture)
- [[mdn-frontend-architecture]] — MDN rebuilt from React SPA to Lit + Rspack
- [[fallow-dead-code-detection]] — 15 issue types for dead code detection in TS/JS
- [[browser-devtools]] — Device emulation and debugging tools
- [[frontend-performance]] — Performance optimization patterns
- [[hotjar]] — User behavior analytics
- [[sentry]] — Error tracking platform
- [[voice-ui]] — Voice user interface patterns

#### Claude Code
- [[claude-code]] — Hub for Claude Code ecosystem (workflows, config, prompts, plugins)
- [[workflows]] — Power user workflows and patterns
- [[claude-code-power-user-patterns]] — Superpowers plugin, PreToolUse hooks, security, 3-layer CLAUDE.md architecture
- [[resume-session-skill]] — /resume skill for context restoration
- [[sessionstart-tree-hook]] — SessionStart tree injection hook
- [[cursor-rules-ai-development]] — Matt Pocock's TypeScript cursor rules (workspace vs global)
- [[karpathy-claude-md-stars]] — CLAUDE.md derived from Karpathy's rules, 15K GitHub stars
- [[frontend-architecture-prompt]] — 3-layer CLAUDE.md + rules + hooks for frontend enforcement
- [[10-high-impact-claude-prompts]] — 10 practical prompts for writing, content strategy, SEO, SaaS building
- [[claude-code-patterns-reddit-synthesis]] — Reddit-sourced CLAUDE.md layering, path-scoped rules, skills, hooks
- [[claude-prompt-prefix-combos]] — 7 combo prompt patterns (stacking prefixes for triangulated output)
- [[claude-code-thinking-transparency]] — Adaptive thinking, effort levels, showThinkingSummaries setting
- [[claude-code-plugins-guide]] — ECC plugin installation and configuration guide
- [[claude-code-skills-reference]] — Claude Code skills catalog and reference
- [[claude-code-thinking-hn-discussion]] — HN discussion on Feb 2026 thinking changes (Boris Cherny response)
- [[claude-code-unusable-hn-discussion]] — HN discussion on adaptive thinking under-allocation, effort defaults, thinking faithfulness
- [[10-ai-prompts-workflow]] — 10 prompt templates (brutal code review, production debugging, content strategy)
- [[matt-pocock-skill-lineup]] — Matt Pocock's custom Claude Code skills (/domain-model, /to-prd, /to-issues)
- [[workflow-orchestration-prompt]] — Jack Culpan's 4-pillar Claude Code orchestration prompt
- [[coding-agent-batch-prompt]] — @kloss_xyz autonomous batch execution prompt for coding agents

### AI Engineering (Weekly Review)
- [[ai-engineering]] — Weekly-updated hub for AI-assisted software engineering
- [[context-engineering]] — Designing context windows for AI agents
- [[advanced-context-engineering]] — Frequent intentional compaction workflow
- [[writing-good-claude-md]] — CLAUDE.md best practices (with Cursor rules and Karpathy community validation)
- [[how-to-build-second-brain]] — AI-powered knowledge management
- [[second-brain-graphify-workflow]] — Graphify workflow for knowledge graph generation

#### Writing & Content
- [[swyx-writing-skills-template]] — Anh's open-sourced writing skills template for devtools HN

#### Tools & SDKs
- [[metabase-embedding-sdk]] — Metabase modular embedding SDK for React apps
- [[metabase-admin-dashboard-initiative]] — Metabase admin dashboard initiative
- [[metabase-modular-sdk-quickstart]] — Metabase modular SDK quickstart
- [[metabase-full-app-embedding]] — Metabase full app embedding guide
- [[metabase-modular-authentication]] — Metabase modular authentication (JWT/SAML)
- [[qwen-3-6-27b-release]] — Qwen 3.6-27B model release and benchmarks
- [[graphify-knowledge-graph-tool]] — Graphify knowledge graph generation tool
- [[powershell-get-childitem-guide]] — PowerShell Get-ChildItem equivalent of find
- [[voice-first-experiences-kids]] — Voice-first experiences for children guide

#### Concept Hubs
- [[metabase]] — Business intelligence platform
- [[qwen]] — Qwen LLM family
- [[unleash]] — Feature flag management
- [[vite]] — Build tool overview and upgrade patterns
- [[angular]] — Angular framework
- [[learnosity]] — Third-party assessment platform (entity)
- [[graphql]] — GraphQL query language
- [[docker]] — Docker containerization
- [[postgresql]] — PostgreSQL database
- [[powershell]] — PowerShell scripting
- [[backend-for-frontend]] — BFF pattern
- [[observability]] — Observability as competitive advantage

#### AI / Strategy
- [[agentic-ai-maturity]] — Organizational AI readiness framework
- [[ai-education]] — AI in education transformation
- [[ai-education-landscape]] — AI in education (NYT article synthesis)
- [[ai-coordination-gap]] — Gap between having AI and coordinating it
- [[ai-as-management-skill]] — Six critical skills for effective AI integration
- [[ai-code-generation]] — AI as primary code author, not assistant
- [[formal-verification]] — Mathematical proof of software correctness
- [[vibe-coding]] — Hobbyist app construction via AI prompts
- [[moltbot-clawdbot-patterns]] — Proactive AI agents, cron jobs, memory systems
- [[humanlayer-ai-agent-patterns]] — Specialist subagent definitions (codebase-locator, pattern-finder)
- [[ally-piechowski]] — Git codebase analysis expert and consultant
- [[agent-self-check-framework]] — MISS/FIX logging for continuous agent improvement
- [[prompt-engineering-5-layer-architecture]] — 5-layer prompt architecture + One-Day Protocol (Identity, Context, Task, Process, Output)
- [[buildflow-automated-research-pipeline]] — Automated URL-to-code pipeline (Chrome + Telegram + OpenCode)
- [[vibe-coding-games-threejs]] — AI-assisted game dev with progressive skill improvement loop
- [[street-fighting-mathematics]] — Six tools for educated guessing and opportunistic problem solving
- [[openclaw]] — Open-source AI agent framework
- [[soapbox-labs]] — Voice AI for children
- [[project-atlas]] — AI-native intelligence layer for Teach to One (sequencing, instruction, assessment loops)
- [[predecessor-skills]] — Foundational competencies that predict Algebra 1 success (13% → 58%)

#### Sources (Links)
- [[agentic-ai-maturity-gap]] — The Agentic AI Maturity Gap (Dev.to)
- [[ai-in-education-nyt]] — How Teachers and Students Feel About AI (NYT)
- [[energy-spectrum-universal-pattern]] — Energy Spectrum Universal Pattern
- [[relay-graphql-fragments]] — Relay GraphQL Fragments (Official Docs)
- [[relay-fragment-composition]] — Fragment composition guide
- [[relay-fragment-naming-and-typing]] — Naming conventions
- [[relay-mutations-guide]] — Mutations and optimistic updates
- [[relay-subscriptions-guide]] — Real-time subscriptions
- [[relay-uselazyload-to-usefragment-migration]] — Migration guide
- [[data-masking-in-relay]] — Data masking explanation
- [[fragment-references-relay]] — Fragment references deep dive
- [[redux-vs-relay]] — State management architecture
- [[relay-compiler-build-setup]] — Relay compiler configuration
- [[relay-environment-setup]] — Environment and network layer
- [[relay-overview]] — Relay framework overview
- [[vite-rollup-tree-shaking-guide]] — Bundle optimization
- [[orchestration-observability-auditability-governance]] — OOAG framework
- [[atomic-design-methodology]] — Component hierarchy methodology
- [[airbnb-react-patterns]] — React style guide
- [[relay-fragment-research-presentation]] — Team presentation research
- [[relay-refactor]] — DashboardStudent refactoring plan
- [[vite-4-4-1-to-7-x-upgrade-gameplan]] — Vite migration guide
- [[color-psychology-guide]] — Color psychology for energy work
- [[twitter-bookmarks-2026-03-14]] — Twitter bookmarks — financial philosophy, CSS animations, tools
- [[twitter-bookmarks-connections-analysis]] — Cross-domain pattern synthesis from bookmarks
- [[vault-wide-connections-synthesis]] — Meta-patterns discovered across the vault
- [[relay-alias-directive]] — Relay @alias directive guide
- [[relay-query-refactoring-guide]] — Multiple queries to fragments migration guide
- [[relay-main]] — Relay framework overview and core principles
- [[remotion-video-creation-playbook]] — AI video creation guide
- [[zai-mcp-vision-server]] — Z.ai MCP Vision Server setup
- [[yaml-descriptions-layer-2]] — YAML description standards
- [[layer-3-heading-standards]] — Layer 3 heading standards
- [[layer-3-audit-summary]] — Heading audit results
- [[spatial-editing-workflow]] — Spatial editing workflow
- [[transcript-verification-checklist]] — Transcript processing checklist
- [[obsidian-claude-101]] — Obsidian + Claude Code 101
- [[obsidian-orphan-finder-report]] — Orphan finder results
- [[new-ai-divide-tool-literacy-not-access]] — New digital divide: tool literacy, not access
- [[if-ai-can-answer-it-question-quality-test]] — Framework for evaluating question quality
- [[guilt-as-intuition-not-shame]] — Guilt as intuition signal, not shame
- [[sessionstart-tree-hook]] — SessionStart hook pattern
- [[nc-frontend-architecture]] — New Classrooms React/Relay/Redux architecture
- [[nc-frontend-architecture-research-2026-04-09]] — Comprehensive NC frontend: React 18, Redux, Relay, PrimeReact, 319+ components
- [[teame-246-assignment-creation-logging]] — Assignment creation logging with readiness score tracking (GraphQL/Relay)
- [[brainbreak-mvc-refactor]] — React MVC state management refactor
- [[ab-testing-lifecycle]] — A/B testing lifecycle guide
- [[unleash-feature-flags]] — Unleash feature flag management
- [[experiment-database-schema]] — Experiment database schema
- [[sql-style-guide]] — SQL style guide and conventions
- [[git-workflow-guide]] — Git workflow and commit practices
- [[ai-should-elevate-your-thinking]] — AI should elevate your thinking, not replace it (Koshy John)
- [[graphify-knowledge-graph-tool-v5]] — Graphify v0.5.0 AI coding assistant skill
- [[how-i-use-llms-karpathy]] — Karpathy's "How I Use LLMs" (comprehensive transcript)
- [[karpathy-llm-wiki-day-job]] — Implementing Karpathy's LLM Wiki for AWS infrastructure

#### Session Transcripts
- [[session-2026-01-29-agentic-ai-transcript]] — Agentic AI governance discussion
- [[session-2026-01-29-energy-transcript]] — Energy spectrum patterns
- [[session-2026-01-29-relay-fragments]] — Relay fragment composition
- [[session-2026-01-29-twitter-bookmarks]] — Twitter bookmarks analysis

#### System Documentation
- [[system-daily-notes-automation]] — Daily notes automation system
- [[system-session-obsidian-logging]] — Session logging in Obsidian
- [[system-skill-resume]] — Skill resume system
- [[spatial-editing]] — Spatial editing workflow pattern

### System
- [[system-universal-mining-framework]] — Content extraction methodology
- [[system-levi-article-workflow]] — AI-assisted article processing
- [[system-session-logs-guide]] — Session logging documentation
- [[system-tasks-master-list]] — Aggregated vault-wide task list

#### Templates
- [[system-template-article]] — Article processing template
- [[system-template-session-log]] — Session log template
- [[system-template-daily-note-quick]] — Quick daily note template
- [[system-template-case-study]] — System design case study template
- [[system-template-service-doc]] — Service documentation template
- [[system-template-process-doc]] — Process documentation template
- [[system-template-general-doc]] — General documentation template
- [[system-template-conventions-doc]] — Coding standards template
- [[system-template-style-guide]] — Documentation style guide

#### Clawdbot
- [[clawdbot-agents]] — Agent onboarding and operation
- [[clawdbot-claude]] — Vault operating instructions
- [[clawdbot-heartbeat]] — Memory checkpoint loop
- [[clawdbot-identity]] — Agent identity (Levi)
- [[clawdbot-integration-summary]] — everything-claude-code integration
- [[clawdbot-memory]] — Long-term memory
- [[clawdbot-soul]] — Personality and tone
- [[clawdbot-tasks]] — Task tracking
- [[clawdbot-tools]] — MCP servers and QMD
- [[clawdbot-user]] — User profile (Master Lou)
- [[clawdbot-monorepo-prompt]] — Monorepo documentation prompt
- [[clawdbot-obsidian-vault-setup]] — Vault setup status
- [[clawdbot-relay-eslint-rules]] — Relay ESLint rules
- [[clawdbot-yaml-tag-fix]] — YAML fix workflow
- [[debt-validation-letters]] — Debt collection response

#### Software Engineering

**Frontend:**
- [[npm-package-setup-guide]] — Complete production NPM package setup (Git, TypeScript, Prettier, Vitest, Changesets)
- [[es-module-relative-imports]] — Why NodeNext requires .js extensions in imports
- [[atomic-design-atoms]] — Atomic Design: Atoms (building blocks)
- [[atomic-design-molecules]] — Atomic Design: Molecules (component groups)
- [[atomic-design-organisms]] — Atomic Design: Organisms (complex sections)
- [[atomic-design-templates]] — Atomic Design: Templates (layouts)
- [[atomic-design-pages]] — Atomic Design: Pages (instances)
- [[code-splitting]] — Code splitting patterns
- [[tree-shaking]] — Dead code elimination
- [[e2e-testing]] — End-to-end testing overview
- [[playwright-testing]] — Playwright browser automation and testing
- [[web-frameworks-guide]] — Node.js web frameworks (Express, NestJS, etc.)
- [[fullstack-graphql-workshop]] — GraphQL + Relay + .NET workshop
- [[streaming-ssr]] — Streaming Server-Side Rendering
- [[build-tools]] — JavaScript build tools (Vite, ESBuild, SWC)
- [[frontend-architecture-guide]] — Production frontend architecture guide (React, Angular, Auth0, Sentry)
- [[react-coding-standards]] — React coding standards and patterns
- [[angular-typescript-coding-standards]] — Angular TypeScript coding standards
- [[package-management]] — npm, yarn, workspaces
- [[package-manager-comparison]] — npm vs Yarn vs pnpm vs Bun: speed, disk, monorepo
- [[bun-runtime]] — All-in-one JS runtime: package manager, bundler, test runner
- [[dependency-bloat]] — Three pillars of JS dependency tree bloat
- [[dependency-injection]] — Manual DI pattern for Node.js/TypeScript without frameworks
- [[over-editing]] — AI models rewriting more code than necessary
- [[modern-data-structures]] — Map, Set, WeakMap, TypedArrays
- [[dynamic-routing]] — Client-side routing patterns
- [[runtime-optimization]] — Performance optimization techniques

**Backend:**
- [[nodejs-fundamentals]] — Node.js runtime and Express.js
- [[rest-api-architecture]] — REST API constraints and patterns
- [[http-methods-rest-apis]] — HTTP methods and status codes
- [[database-postgresql-aurora-guide]] — PostgreSQL and AWS Aurora Serverless guide
- [[docker-best-practices]] — Docker containerization best practices

**Architecture:**
- [[software-architecture-design]] — Architecture patterns and best practices
- [[software-design-modeling]] — UML and design diagrams
- [[oop-principles]] — Four pillars of OOP
- [[mvc-architecture]] — Model-View-Controller pattern

**Languages:**
- [[javascript-fundamentals-collection]] — JS deep-dives: async, prototypes, types, data structures, design patterns, clean code (15 sources)
- [[big-o-notation]] — Algorithm complexity analysis
- [[big-o-complexity-cheatsheet]] — Big-O cheat sheet with 14 data structures + 13 sorting algorithms
- [[clean-code-javascript]] — Clean Code adapted for JavaScript (11 sections, SOLID principles)
- [[javascript-types]] — Primitive and reference types
- [[python-data-types-reference]] — Python syntax and data types

**Testing:**
- [[testing-types-overview]] — Unit, integration, and E2E testing overview
- [[tdd-python-guide]] — Test-driven development with Python

**AI/Concepts:**
- [[prompt-engineering-system-command]] — Structured prompt engineering
- [[self-improvement-loop]] — Agent feedback and improvement
- [[programmers-oath]] — 12 tenets for ethical software development
- [[claude-code-source-leak]] — Source leak analysis: anti-distillation, KAIROS, attestation
- [[back-button-hijacking-spam-policy]] — Google's new spam policy for deceptive navigation
- [[when-ai-writes-almost-all-code]] — Gergely Orosz on AI as primary code author
- [[when-ai-writes-worlds-software-who-verifies]] — Leonardo de Moura on formal verification for AI-generated code
- [[how-claude-code-is-built]] — Architecture deep-dive: 90% AI-written, 5 PRs/day
- [[real-world-engineering-challenges-cursor]] — 100x growth, Merkle trees, Anyrun orchestrator
- [[good-software-knows-when-to-stop]] — 37Signals principles: say no by default
- [[unwritten-laws-software-engineering]] — 7 unwritten rules every engineer learns the hard way
- [[farzapedia-personal-wiki-agents]] — Personal Wikipedia built for agents, not humans
- [[building-code-search-engine-turso]] — Local semantic code search with SQLite vectors
- [[karpathy-rendergit]] — Flatten GitHub repos to single HTML page
- [[karpathy-arxiv-sanity-lite]] — ArXiv paper recommender with SVM + TF-IDF
- [[accessibility-nc-wcag-deque]] — WCAG 2.1 AA with Deque axe tooling
- [[unleash-release-flag-management-ab-lts]] — A/B Test vs LTS release patterns
- [[claude-graphql-service]] — .NET 6 Hot Chocolate GraphQL guide
- [[claude-backend-for-frontend]] — .NET 6 BFF for Learnosity APIs
- [[tech-debt-infrastructure-opportunities]] — Frontend debt and testing automation tracking
- [[andrej-karpathy]] — OpenAI co-founder, Tesla AI director, Eureka Labs
- [[cognitive-load]] — Managing mental overhead in software development
- [[cognitive-load-theory]] — Working memory limitations (7±2)
- [[second-brain-pattern]] — AI-powered knowledge management system
- [[toctou]] — Time-of-check to time-of-use race condition
- [[distributed-locking]] — Patterns for mutual exclusion in distributed systems
- [[supply-chain-security]] — npm package integrity and maintainer protection
- [[third-party-version-management]] — Pinning, archive monitoring, self-hosting tradeoffs for vendor libraries
- [[lambda-service-pattern]] — Three-tier Lambda architecture: Function → Engine → DataService
- [[axe-deque]] — Deque axe-DevTools and axe Linter for WCAG accessibility testing
- [[wcag-2-1]] — Web Content Accessibility Guidelines 2.1 (A/AA/AAA)
- [[cloudwatch-logs-insights]] — AWS log query interface — fields, filter, sort, stats

**Writing & AI Ethics:**
- [[adding-correctness-conditions-code-changes]] — TDD for agents: verification before instructions (Jessica Kerr)
- [[fragments-april-14-2026]] — Martin Fowler on AI and laziness, TDD for agents, AI restraint
- [[three-pillars-javascript-bloat]] — Three causes of JS dependency bloat and cleanup tools
- [[css-is-doomed]] — Full DOOM rendered in CSS without Canvas/WebGL
- [[bun-v1-3-12]] — Bun v1.3.12 release: WebView, cron, 120 fixes
- [[coding-models-over-editing]] — Research on AI models rewriting too much code
- [[fastest-frontend-tooling]] — 2026 tooling stack: tsgo, Oxfmt, Oxlint, pnpm, Vite
- [[modal-vs-popover-vs-tooltip]] — UX decision framework for overlay patterns
- [[pnpm-vs-npm-vs-yarn-vs-bun-2026]] — Comprehensive 2026 package manager comparison
- [[choosing-right-js-package-manager-2025]] — Beginner guide to npm vs yarn vs pnpm vs Bun
- [[migrating-npm-to-pnpm]] — Step-by-step npm to pnpm migration guide
- [[dependency-injection-nodejs-typescript]] — Manual DI with factory functions + composition root
- [[lifelong-learning-resources]] — 88+ curated resources for senior engineers
- [[path-to-senior-engineer-handbook]] — 250+ career-progression resources (Jordan Cutler: newsletters, books, courses, papers, YouTube, podcasts, communities)
- [[console-log-to-job-hunting]] — Personal job hunt + JavaScript learning journal
- [[pnpm-vs-bun-vs-yarn-berry]] — Three-way comparison of npm alternatives
- [[pnpm-npm-yarn-bun-benchmarks]] — Speed, disk, and deployment benchmarks
- [[claude-code-source-leak]] — Analysis of leaked source: anti-distillation, KAIROS
- [[programmers-oath]] — 12-tenet ethical oath for programmers
- [[back-button-hijacking-spam-policy]] — Google's back button hijacking spam policy

**Quick Reference:**
- [[git-cheatsheet]] — Git commands reference
- [[tmux-cheatsheet]] — Tmux session, window, and pane commands
- [[neovim-0-12-hn-discussion]] — Neovim 0.12.0 release discussion (AI setup, LazyVim, DAP debugging)

#### System Design
- [[frontend-system-design-index]] — Frontend system design reference
- [[autocomplete-system-design]] — Autocomplete component design
- [[chat-application-system-design]] — Real-time chat architecture
- [[design-system-builder]] — Design system builder patterns
- [[file-management-system]] — File management (Drive/Dropbox style)

#### Git & Workflow
- [[automated-branch-naming]] — Dependabot branch naming convention
- [[git-workflow-guide]] — Coherent commits, commit messages, clean history
- [[git-worktrees-parallel-work]] — Parallel ticket work with isolated sessions
- [[git-codebase-analysis]] — Five commands for codebase diagnostics
- [[git-commands-before-reading-code]] — Churn, bus factor, bug clusters
- [[git-commands-hn-discussion]] — HN discussion with Jujutsu equivalents for git forensic commands
- [[git-rebase-hygiene]] — Always fetch before rebasing — cached origin/main is stale

#### Build Tools & Upgrades
- [[vite-7-upgrade-plan]] — Vite v4 to v7 migration guide

#### Feature Flags & Experiments
- [[ab-testing-lifecycle]] — Three-stage A/B testing process (Design → Test → LTS)
- [[unleash-feature-flags]] — Unleash hierarchy, naming conventions, lifecycle
- [[unleash-local-development-setup]] — Docker compose setup, flag JSON import/export, marvin/.env wiring
- [[unleash-one-pager-product]] — Team agreement: Accelerated CR/QA + per-experiment release management
- [[feature-flagging-quick-reference]] — Quick-reference card with lifecycle, containment rules, FlagSwitch + ExperimentTracker code
- [[experiment-database-schema]] — Flag history, observations, speculative data tables

#### Architecture Patterns
- [[nc-frontend-architecture]] — React 18 + Relay + Redux production architecture
- [[brainbreak-mvc-refactor]] — React state management MVC refactor pattern
- [[teame-218-brainbreak-refactor]] — Context + reducer pattern (work notes)
- [[teame-218-brainbreak-postmortem]] — 7 refactoring approaches, key learnings
- [[teame-218-git-cleanup]] — 19 commits → 5 logical commits strategy
- [[TEAME-218 Code Cleanup - TEAME-177 (In-Platform Polling)]] — Barrel file removal, reducer naming plan
- [[brainbreak-context-cleanup-implementation]] — Implementation plan for BrainBreak context cleanup
- [[nc-frontend-architecture-research-2026-04-09]] — Comprehensive NC frontend: React 18, Redux, Relay, PrimeReact, 319+ components
- [[unified-search-component-pattern]] — Facade + strategy pattern for combining PrimeReact AutoComplete and MultiSelect
- [[teame-246-assignment-creation-logging]] — Assignment creation logging with readiness score tracking (GraphQL/Relay)
- [[teame-169-update-color-definitions]] — Update frontend color definitions from Figma design system
- [[teame-173-calculator-skill-challenge]] — Calculator not working for some skill challenge questions
- [[teame-177-in-platform-polling-cleanup]] — In-platform polling cleanup for assessment state
- [[teame-182-footer-updates]] — Footer updates (screenshot attached, no description)
- [[teame-188-timeline-reset-skill-resource]] — Timeline reset skill resource implementation
- [[teame-189-skill-assessment-refresh-failure]] — Skill assessment refresh failure investigation
- [[teame-203-assignment-creation-logging]] — Assignment creation logging and readiness score tracking
- [[teame-204-performance-assignment-status]] — 15s delay on assignment status change after skill assessment
- [[teame-213-expand-student-flow-metrics]] — Expand student-flow and pace guardrail metrics
- [[teame-218-code-cleanup-lts-conversion]] — Convert in-platform polling to LTS feature
- [[teame-235-dropdowns-overlapping-footer]] — Practice Problems dropdowns overlapping footer
- [[teame-265-brain-brake-login]] — Brain Brake at login (resolved April 2026)
- [[teame-267-brain-brake-practice-problems]] — Brain Brake in Practice Problems (resolved April 2026)
- [[teame-268-brain-brake-retry-cooldown]] — Brain Brake cooldown not enforced on retry
- [[teame-272-scrollbar-usability]] — Brain Break scrollbar drag not responsive
- [[teame-277-brain-break-two-minute-trigger]] — Brain Break triggered within 2 minutes (resolved 2026-05-01)
- [[teame-284-emotion-picker-responsiveness]] — BB Q2 emotion-picker green options cut off on 1366×768 (release-blocking)
- [[BB being open in 2 sessions via different browser]] — Sprint status snapshot (BB tickets, QA findings, TEAME-284)
- [[teamf-296-vite-upgrade]] — Vite build tool upgrade initiative
- [[bb-cross-browser-session-lock]] — Two-layer client-side mutex with TOCTOU three-phase handshake (TEAME-218)
- [[BB being open in 2 sessions via different browser]] — BrainBreak session lock update implementation
- [[cross-browser-toctou-window-analysis]] — Cross-browser TOCTOU window timing analysis
- [[brainbreak-knowledge-graph-analysis]] — 303-node merged graph revealing god objects and community structure
- [[jumpcloud-django-user-sync-pipeline]] — Bidirectional JumpCloud/Django/Auth0/Roadmaps sync every 15 minutes
- [[user-bridge-analysis-orphaned-assets]] — User entity as cross-community bridge + 4 orphaned PNG assets
- [[assessmentauditor-assignmentchecker-pattern-analysis]] — Lambda Service Pattern duplication analysis
- [[classesroster-graphql-performance-issue]] — GraphQL over-fetching fix for ClassesRoster (30s → 2s)
- [[bff-learnosity-bridge]] — Backend-for-Frontend service for Learnosity APIs
- [[inference-engine]] — Lambda service for assessment inference
- [[learnosity-result-fetcher]] — Lambda service for fetching Learnosity assessment results
- [[graphql-schema]] — GraphQL schema definitions and types
- [[graphql-service]] — .NET Hot Chocolate GraphQL service implementation
- [[general-graphql-conventions]] — GraphQL naming and structure conventions
- [[ab-testing-logging-rollout]] — A/B test logging rollout plan
- [[devtools-simulated-devices]] — Chrome DevTools device emulation guide
- [[cooldown-system]] — Time-based eligibility gating
- [[experiment-speculative-data]] — Pattern for experiment transient data
- [[global-object-ids]] — GraphQL global object identification
- [[graphql-over-fetching]] — GraphQL query bloat and optimization
- [[hot-chocolate-graphql]] — .NET GraphQL framework
- [[lts-transition]] — Long-Term Support conversion process
- [[relay-connections]] — Relay connection pattern and pagination
- [[telemetry]] — Event tracking and observation logging
- [[cognitive-learning-model-product]] — Cognitive learning model design notes
- [[in-platform-polling-design-notes-product]] — In-platform polling UI/UX design notes
- [[learnosity-access-product]] — Learnosity API access and integration notes
- [[learnosity-swap-out-notes-product]] — Learnosity swap-out planning notes
- [[logging-conventions]] — Marvin logging conventions and patterns
- [[marvin-architecture]] — Marvin system architecture overview
- [[marvin-diagnostic-inferencing-functional-requirements]] — Diagnostic inferencing functional requirements
- [[marvin-example-skill-assessment-json-response]] — Example skill assessment JSON response
- [[marvin-frontend]] — Marvin frontend architecture and patterns
- [[marvin-graphql-service]] — Marvin GraphQL service (Hot Chocolate .NET, ECS)
- [[marvin-inferencing-v2]] — Marvin inferencing v2 design
- [[marvin-skill-assessment-inferencing-implementer-notes]] — Skill assessment inferencing implementer notes
- [[query-filters]] — Query filters design for Marvin
- [[querying-graphql]] — GraphQL querying patterns and conventions
- [[relay-connections]] — Relay connection pattern and pagination
- [[team-e-onboarding-product]] — Team E onboarding documentation
- [[teamd-1010-embedding-prototype-metabase]] — Metabase embedding prototype (SSO, row/column security)
- [[teamf-556-chromebook-touchscreen-tap]] — Chromebook touchscreen tap display shift bug
- [[teamf-fe-package-updates]] — TEAMF-539 Dependabot fixes (5 high-sev npm audit) + deferred PNPM migration
- [[tech-debt-infrastructure-opportunities-product]] — Tech debt and infrastructure opportunities
- [[learnosity-cdn-incident-2026-02-24]] — Feb 2026 Items API CDN archive post-mortem (pin v1.132.3 / v2025.1.LTS)
- [[cloudwatch-logs-insights-queries]] — CloudWatch query reference for BFF, GraphQL Service, Inference Engine
- [[qa-frontend-automated-test-workflow]] — GitHub Actions runbook for qa-frontend-automated-tests (5x recommended, ~20min)
- [[nc-tech-stack-overview]] — One-line stack summary: React+Relay, GraphQL, .NET, Python tests, PostgreSQL, AWS CDK, GitLab
- [[accessibility-marvin-wcag]] — Marvin WCAG 2.1 AA setup with Deque axe Linter
- [[skill-resource-phase2-extract-graphql-hook]] — Phase 2: extract 6 Relay ops into useSkillResourceQueries
- [[skill-resource-phase2-extract-modals-hook]] — Phase 2: consolidate modal flags into useSkillModals via reducer + discriminated union
- [[skill-resource-phase2-extract-timeline-hook]] — Phase 2: extract step navigation state machine into useSkillTimeline
- [[brainbreak-lts-cooldown-speculative-bugs]] — Refined write-up: cooldown parser bug, TEAME-287, proposed fixes
- [[teame-287-speculative-data-created-bug]] — TEAME-287: speculative data `created` column bug
- [[remaining-brain-break-tickets]] — Debug session: root cause analysis of cooldown date parsing bugs
- [[work-status-may-5-2026]] — Daily status: grade selection bug, reverse scoring, Docker rebuild
- [[docker-fe-esbuild-exe-error]] — Cross-platform node_modules in Docker volume mount pitfall
- [[qa-fe-automation-local-workflow]] — Personal WezTerm + Playwright + PG Admin three-pane workflow
- [[question-axe-linter]] — Axe IDE linter vs browser extension: ~20% coverage, custom component mapping
- [[research-terms-recap]] — Scholar search for knowledge tracing + teacher dashboards
- [[marvin-local-frontend-dev-setup]] — Runbook: local Marvin FE dev with Docker + seeded test user
- [[worktree-rebase-missed-flyway-migrations]] — Gotcha: stale origin/main causes missing migration files

#### Security
- [[toctou-wikipedia]] — Formal definition of time-of-check to time-of-use race conditions
- [[toctou-explained-deepstrike]] — Practical TOCTOU guide with attack methods and mitigation
- [[lock-it-or-lose-it-race-conditions]] — Distributed locking: pessimistic locks, timeouts, fence tokens
- [[axios-supply-chain-compromise-postmortem]] — March 2026 axios npm compromise via social engineering + RAT
- [[auth0]] — Authentication platform
- [[jwt]] — JSON Web Tokens

#### Database & Standards
- [[sql-style-guide]] — In-house SQL conventions and best practices
- [[ecc-coding-standards]] — Cross-language coding standards hub (TypeScript, Go, Kotlin, Python, PHP, Swift)
- [[aws-aurora-serverless]] — AWS Aurora Serverless database
- [[flyway]] — Database migration tool

### Synthesis
- [[may-4-5-2026-themes]] — Five themes from May 4-5: BrainBreak LTS bugs, dev-env friction, QA tooling, learning-product research, personal/wellness
- [[speculative-data-as-state-machine]] — Speculative data writes are a state-management problem; state-machine refactor proposal for TEAME-287
- [[trust-boundaries-formal-verification-and-bloat]] — Formal verification + dependency reduction as twin strategies for the trust boundary problem; 5-tier code provenance framework
- [[prompts-for-ai-unit-test-generation]] — Prompt templates for AI-generated unit tests (error states, edge cases)
- [[unified-search-component-pattern]] — Facade + strategy pattern for combining PrimeReact AutoComplete and MultiSelect
- [[thinking-frameworks-for-debugging]] — Which thinking framework to use at each debugging phase (OODA, Ishikawa, Issue Trees, First Principles, Ladder of Inference, Connection Circles)
- [[thinking-frameworks-for-code-review]] — Frameworks for code review: Cognitive Load, SBI feedback, Six Hats review lenses, Minto Pyramid comments, conflict resolution, clean code checklist
- [[claude-code-prompts-research-implementation]] — 7 ready-to-paste Claude Code prompts for investigating the Marvin codebase to implement research findings (planning prompts, teacher nudges, confidence divergence, insight recall, skill graph, struggle detection, mindset audit)

### Product Concepts
- [[three-ring-mastery-system]] — Three-ring progress system: spaced repetition + mastery stages + weekly goals (TTO feature concept)
- [[mastery-velocity-three-ring-feature-concept]] — Brainstorm source for three-ring system
- [[math-problem-game]] — Game design: abstraction tools trigger pattern-recognition "eureka moments"
- [[reverse-scoring]] — Psychometric technique: invert scale direction to detect response bias

### Learning Science (Research Foundations)

**Concepts:**
- [[spaced-repetition]] — Evidence-based learning via expanding-interval review
- [[forgetting-curve]] — Ebbinghaus exponential decay model `p = 2^(-Δ/h)`
- [[half-life-regression]] — Duolingo's trainable per-word HLR algorithm
- [[knowledge-tracing]] — Modeling student mastery from interaction history (BKT/DKT/SAINT)
- [[gamification]] — XP/streaks/leagues/goal-gradient mechanics + anti-patterns
- [[productive-struggle]] — Effortful grappling with challenging material; cognitive + emotional scaffolding
- [[ai-math-tutoring]] — AI-powered math tutoring: human-AI collaboration, multi-agent systems, adaptive difficulty
- [[adaptive-feedback-education]] — Process-level feedback on student reasoning, not just answer correctness
- [[its-llm-architecture]] — ITS + LLM integration pattern for motivational and instructional feedback
- [[skill-tree-competency-structure]] — Formal prerequisite DAGs for competency-based education
- [[knowledge-graph-education]] — Structured concept relationships for personalized learning and curriculum design
- [[bkt-fairness]] — Algorithmic fairness in Bayesian Knowledge Tracing (reading ability confound)
- [[behavioral-nudges-education]] — Low-cost behavioral interventions leveraging loss aversion, social norms, and goal-gradient for engagement
- [[metacognitive-reflection]] — Pausing to think about what and how you're learning; evidence base ES=1.11 for math achievement
- [[self-regulated-learning]] — Zimmerman's SRL cycle: plan → monitor → reflect; meta-analysis ES=1.27 for learning outcomes
- [[growth-mindset]] — Near-zero achievement effects (Macnamara 2023); distinct from self-efficacy and math identity
- [[self-determination-theory]] — Three basic needs (autonomy, competence, relatedness); 36-study meta-analysis
- [[math-anxiety]] — Longitudinal STEM gatekeeper; anxiety pushes away, self-efficacy pulls toward
- [[math-identity]] — Validated instrument grades 5–12; co-constructed via teacher positioning
- [[achievement-goal-theory]] — Mastery vs performance goals; latent profile heterogeneity
- [[expectancy-value-theory]] — Five EVT constructs; profile instability during transitions
- [[motivational-profiles]] — Person-centered approach; 5–6 distinct student motivation profiles
- [[desirable-difficulty]] — Bjork's framework; spacing creates productive short-term cost for durable retention
- [[math-fact-fluency]] — Intervention evidence; digital delivery validated equal to peer tutoring
- [[spaced-retrieval-practice]] — Classroom-level evidence; 3–5% precalculus gains, context-dependent
- [[peer-tutoring-math]] — Cross-age tutoring validated; modality equivalence finding
- [[competency based learning]] — Mastery-gated progression with transparent targets, continuous assessment, flexible pacing
- [[formative-assessment]] — Black & Wiliam (1998): continuous low-stakes demonstration replaces high-stakes summative events
- [[performance-based-assessment]] — Stiggins, Tobón: portfolios, rubric design, multiple evidence types for competency demonstration
- [[zone-of-proximal-development]] — Vygotsky (1978): optimal learning at the gap between independent and guided performance
- [[knowledge-space-theory]] — Doignon & Falmagne: mathematical prerequisite mapping between competencies (ALEKS)
- [[deep-knowledge-tracing]] — Piech et al. (2015): RNN/LSTM knowledge tracing with higher accuracy than BKT
- [[differentiated-instruction]] — Tomlinson (1999): readiness, interest, learning profile → content, process, product, environment
- [[scaffolding]] — Wood/Bruner/Ross (1976): contingent, faded support; Belland meta-analysis g ≈ 0.50
- [[culturally-responsive-pedagogy]] — Ladson-Billings (1995): academic achievement, cultural competence, sociopolitical consciousness

**Source pages:**
- [[teachers-guide-spaced-repetition]] — Classroom SR playbook (1/3/6/10/14/18 wk schedule, 7 techniques)
- [[spaced-repetition-wikipedia]] — Algorithm family + history canonical reference
- [[duolingo-half-life-regression]] — Burr Settles ACL 2016 paper (9.5% retention bump vs Leitner)
- [[duolingo-new-learning-path]] — Path-as-SRS UI pattern (Nov 2022 redesign)
- [[duolingo-learning-strategy]] — Gamification + AI synthesis (15-20min sessions, Crown hovering)
- [[geometry-of-learning-kst-mastery-maps]] — KST 0-5 rubric, Dunning-Kruger drop, depth-vs-breadth
- [[deep-knowledge-tracing-practical-evaluation]] — EDM 2025 KT production-realities paper
- [[irec-metacognitive-scaffolding-arxiv]] — Critique of de-contextualized SRS, JITAI alternative
- [[apple-watch-psychology-gamification]] — Goal-gradient rings, social reinforcement, automaticity
- [[tutor-copilot-2025]] — Human-AI tutoring RCT: +4/+9 p.p. mastery gains at $20/tutor/year
- [[genai-math-meta-analysis-2026]] — Meta-analysis of 22 GenAI math studies (N=5,232)
- [[ai-difficult-math-questions]] — MATH² multi-skill combination problems for calibrated difficulty
- [[mathedu-adaptive-feedback-2025]] — MathEDU dataset: process-level feedback with teacher benchmarks
- [[llm-education-systematic-review-2025]] — 88 empirical studies on LLMs in education
- [[ai-math-tutoring-2025]] — Multi-agent adaptive math tutoring platform
- [[its-llm-motivational-feedback-2025]] — ITS-LLM architecture for motivational feedback (Llama 3.2)
- [[skill-trees-competency-2025]] — Formal skill tree DAGs for competency-based courses
- [[deep-learning-knowledge-tracing-2025]] — DLKT vs BKT comparison study (Nature Sci. Reports)
- [[bkt-fairness-math-2025]] — BKT fairness gap by reading ability (EDM 2025)
- [[knowledge-graph-education-slr-2024]] — SLR of knowledge graphs in education
- [[productive-struggle-ai-bellwether]] — AI risks undermining productive struggle
- [[productive-struggle-students]] — Student perceptions of teacher support for productive struggle
- [[nudge-meta-synthesis-2025]] — Meta-synthesis of nudge interventions across educational contexts
- [[streaks-math-engagement]] — RCT: streak mechanics boost math engagement + achievement (Chile, N≈1,500)
- [[nudge-math-megastudy-2025]] — Megastudy: personalized teacher nudges boost math progress 1.89% (Zearn, N≈3M)
- [[metacognition-math-modeling-ct-2024]] — Metacognition → critical thinking → math modeling (N=661)
- [[metacognitive-skills-math-problem-solving-2025]] — Structured reflective prompts enhance metacognition in math
- [[metacognitive-instruction-meta-analysis-2025]] — PRISMA meta-analysis: metacognitive instruction ES=1.11 for math
- [[growth-mindset]] — Near-zero achievement effects (Macnamara 2023); distinct from self-efficacy and math identity
- [[self-determination-theory]] — Three basic needs; 36-study meta-analysis validates autonomy support as key lever
- [[math-anxiety]] — Longitudinal STEM gatekeeper; anxiety pushes away, self-efficacy pulls toward
- [[math-identity]] — Validated instrument grades 5–12; co-constructed via teacher positioning
- [[achievement-goal-theory]] — Mastery vs performance goals; latent profile heterogeneity
- [[expectancy-value-theory]] — Five EVT constructs; profile instability during transitions
- [[motivational-profiles]] — Person-centered approach; 5–6 distinct student motivation profiles
- [[desirable-difficulty]] — Bjork's framework; spacing creates productive short-term cost for durable retention
- [[math-fact-fluency]] — Intervention evidence; digital delivery validated equal to peer tutoring
- [[spaced-retrieval-practice]] — Classroom-level evidence; 3–5% precalculus gains, context-dependent
- [[peer-tutoring-math]] — Cross-age tutoring validated; modality equivalence finding
- [[achievement-goal-profiles-math-2023]] — LPA of achievement goal profiles; instructional quality moderates
- [[evt-achievement-goals-2025]] — 6 homework motivation profiles integrating AGT + EVT + SRL (N=1,256)
- [[evt-math-profiles-2024]] — EVT profiles shift during secondary-to-tertiary STEM transition
- [[growth-mindset-chinese-math-2023]] — Chain mediation: mindset → self-efficacy → intrinsic motivation
- [[growth-mindset-differentiation-2025]] — Mathematical mindset ≠ growth mindset ≠ self-efficacy
- [[growth-mindset-meta-analysis-2023]] — Near-zero effects when design flaws controlled (Macnamara)
- [[math-anxiety-stem-choices-2024]] — 3-year longitudinal: anxiety vs self-efficacy STEM pathways
- [[math-identity-instrument-2023]] — First validated group-administrable math identity measure (grades 5–12)
- [[sdt-math-outcomes-2026]] — SDT need-satisfaction → lower anxiety, more STEM major choice
- [[sdt-meta-analysis-2024]] — 36-study meta-analysis: autonomy support is key active ingredient
- [[sdt-online-math-2024]] — SDT-based online math: competence/relatedness improved, autonomy harder digitally
- [[teacher-positioning-math-identity-2023]] — Teacher positioning → math identity via problem-solving flexibility
- [[spaced-retrieval-calculus-desirable-difficulty-2022]] — Spaced retrieval: worse quizzes, better final exams
- [[spaced-retrieval-nine-STEM-courses-2024]] — 9-course within-subjects: inconsistent but 3–5% precalculus gains
- [[math-fact-fluency-high-schoolers-2024]] — High schoolers = professionals for fluency delivery
- [[multiplication-fact-fluency-intervention-modality-2024]] — iPad = peer tutoring; retrieval practice is the active ingredient
- [[cbl-assessing-demonstrations]] — CBL Pillar 1: performance-based assessment, formative assessment, equity in evaluation
- [[cbl-knowledge-frontier]] — CBL Pillar 2: ZPD, KST, BKT/DKT, adaptive sequencing for frontier targeting
- [[cbl-differentiated-support]] — CBL Pillar 3: differentiated instruction, scaffolding, AI tutoring, culturally responsive teaching

**Entities:**
- [[hermann-ebbinghaus]] — Forgetting curve discoverer (1880s)
- [[sebastian-leitner]] — Leitner box system (1973)
- [[paul-pimsleur]] — Graduated-interval recall (1967)
- [[burr-settles]] — Half-Life Regression at Duolingo
- [[skill-resource-phase2-architecture]] — Target post-refactor structure for SkillResource god component split
- [[skill-resource-phase2-architecture-overview]] — SkillResource Phase 2 architecture overview (Container + View + hooks)
- [[vygotsky]] — Lev Vygotsky: ZPD, social constructivism, scaffolding origins
- [[tomlinson]] — Carol Ann Tomlinson: differentiated instruction framework
- [[ladson-billings]] — Gloria Ladson-Billings: culturally relevant pedagogy

### Personal
- [[captains-log-volume-one]] — May 3 journal: Teach to One tiers, math problem game concept
- [[caption-logs-may-4-2026]] — May 4 journal: NBA playoffs, work tasks, weekend recap
- [[nba-eastern-playoff-may-2-2026]] — Playoff predictions: Knicks vs 76ers, LeBron vs OKC
- [[kobe-bryant-meditation-article]] — Article clipping: Kobe's 15min daily meditation practice
- [[crazy-tweets]] — One-liner: idea guys who are too busy to execute

### Projects
- [[Active Projects]] — Current work in progress
- [[Backlog]] — Pending work items not yet started or in early stages
- [[Completed Work]] — Archived projects

## Recent Activity

See [[wiki/log|Processing Log]] for full history.

---

## Ingest Queue

Sources waiting to be processed:
- `raw/04_published/blogs/` — Published blog post
- `raw/How I use LLMs.md` — Karpathy transcript (129KB, low priority)

To process: Run `/second-brain-ingest`
