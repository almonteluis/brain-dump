---
tags:
  - claude-code
  - prompt
  - monorepo
  - documentation
  - relay
  - refactoring
date: 2026-02-01
---

# Claude Code Prompt: Monorepo Documentation + Relay Refactoring

**Use case:** Document monorepo services and identify Relay fragment refactoring opportunities

---

## Prompt

**Step 1: First, create a CLAUDE.md file at the monorepo root**

Write a comprehensive CLAUDE.md that includes:
- Tech stack for each service (frameworks, databases, tools)
- Directory structure showing all services and shared packages
- How services communicate (APIs, events, shared libraries)
- Any conventions or patterns the team uses (naming, file organization, etc.)

Explore the monorepo thoroughly using /explore mode and read key config files (package.jsons, tsconfigs, build configs) to build this understanding.

**Step 2: Document each service**

For each service directory, create or update its README.md with:
- **Purpose**: What this service does in 2-3 sentences
- **Tech stack**: Framework, language, database, key dependencies
- **Key files/modules**: Main entry points and important internal structure
- **API/External integrations**: What it exposes to other services or external APIs
- **Dependencies**: Which other services or shared packages it relies on

**Step 3: Create service connection diagram**

Create a docs/architecture.md with a Mermaid diagram showing how all services connect:
- Use flowchartTD or graphTD for service relationships
- Arrows showing dependencies (which service calls which)
- Label arrows with the communication type (REST API, GraphQL, events, shared library calls)
- Include a legend explaining the diagram if needed

**Step 4: Frontend refactoring analysis (Relay fragments)**

For the frontend service(s):
1. Search for all `useLazyLoadQuery` hooks across the codebase
2. For each component using `useLazyLoadQuery`, analyze if it would benefit from:
   - **Fragment extraction**: If the component receives parent data via props
   - **Fragment composition**: If multiple lazy queries could be combined into one parent query
   - **Fragment arguments**: If dynamic data fetching could be done via `@argumentDefinitions`
3. Create a list in docs/relay-refactoring-opportunities.md with:
   - File path and component name for each `useLazyLoadQuery`
   - Assessment: Good candidate / Needs investigation / Keep as-is
   - Brief rationale for the assessment
   - Suggested fragment pattern (useFragment, refetchable fragment, etc.)

Use the Relay Query Refactoring Guide's criteria:
- Does the component receive data from a parent? → Extract fragment
- Are multiple lazy queries fetching related data? → Combine into one query with fragments
- Is the query only used in one place? → May stay as lazy query
- Does the component need dynamic data on mount? → Consider refetchable fragments

**Important:**
- Use /plan mode and write the plan to PLAN.md before starting
- Use /explore to understand the structure first
- Focus on actionable, concrete outputs (READMEs, diagrams, lists)
- Ask clarifying questions if anything is ambiguous

---

## Notes

Generated based on research from last30days skill (web-only mode).

Key patterns applied:
- **CLAUDE.md first** — Structure the monorepo context upfront
- **Plan mode workflow** — Generate to PLAN.md → analyze → refine
- **Mermaid diagrams** — Use flowchart for service relationships
- **Explicit scoping** — Tell Claude exactly what to document
- **Cross-reference awareness** — Prompt Claude to identify shared dependencies and connections

## Related Resources

- [Relay Query Refactoring Guide](obsidian-vault/Software Engineering Notebook/relay-query-refactoring-guide.md)
- [Relay ESLint Rules Guide](obsidian-vault/Software Engineering Notebook/relay-eslint-rules-guide.md)
- [Anthropic Claude Code Best Practices](https://www.anthropic.com/engineering/claude-code-best-practices)
