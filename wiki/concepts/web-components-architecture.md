---
description: Using web components (Lit) with server components for production frontends — MDN's architecture of flat name-based structure, automatic lazy loading, and Declarative Shadow DOM
tags: ["web-components", "lit", "server-components", "frontend-architecture", "concept"]
sources: ["wiki/sources/mdn-frontend-architecture.md"]
created: 2026-04-11
updated: 2026-04-11
---

# Web Components Architecture

A production architecture pattern for building content-heavy sites with islands of interactivity using web components, server components, and progressive enhancement.

## Core Pattern

**Problem:** Content-heavy sites (documentation, blogs, marketing) are mostly static HTML/CSS with isolated interactive elements (code editors, search, dropdowns). SPAs are overkill; raw DOM APIs are painful. Web components provide the middle ground.

**Architecture:**
1. **Server components** — Template static HTML on the server using Lit's `html` template literal
2. **Web components** — Custom elements for interactive islands, lazy-loaded when present in DOM
3. **Declarative Shadow DOM** — SSR web components so they render styled before JS loads

## When to Use

| Scenario | Use Web Components | Use SPA (React/Next.js) |
|----------|--------------------|--------------------------|
| Mostly static content with isolated interactivity | Yes | No |
| Complex app-like state management | No | Yes |
| Content authoring with embedded widgets | Yes | No |
| Heavy client-side routing | No | Yes |
| Documentation/knowledge base | Yes | Maybe |
| Dashboard with real-time data | No | Yes |

## Key Techniques

### Flat Name-Based Component Structure

Each component is a directory with convention-based files:
- `element.js` — Client-side web component
- `server.js` — Server-side rendering component
- `element.css` / `server.css` / `global.css` — Scoped CSS files

Automatic lazy loading scans DOM for custom element tags and imports matching modules.

### Progressive Enhancement with DSD

Components render styled HTML server-side. When JS loads:
- `[loaded]` attribute toggles CSS-only → JS-enhanced behavior
- Slots allow light DOM styling (no shadow DOM conflicts)
- Components are interactive before their JavaScript loads

### CSS Scoping Per Component

Each component has its own CSS file, loaded only when the component renders. No global CSS entanglement. The `componentsUsed` Set tracks which server components rendered content, then includes only matching stylesheets.

## Real-World Examples

- **MDN** — Rebuilt from React SPA to Lit + server components + Rspack. 2 min startup → 2 sec. See [[mdn-frontend-architecture]]
- **Lit playground** — Interactive code editors as web components
- **Scrimba embeds** — Lazy-loaded iframe within a web component

## Tools

| Tool | Purpose |
|------|---------|
| [Lit](https://lit.dev/) | Web component library with reactive properties and template literals |
| [Rspack](https://rspack.rs/) | Rust-based build tool with webpack-compatible API |
| Declarative Shadow DOM | Server-rendered shadow DOM (progressive enhancement) |
| Baseline | Cross-browser compatibility tracking |

## Trade-offs

**Advantages:**
- No framework lock-in (web components are standards)
- Components work across frameworks
- Automatic code-splitting at component level
- Progressive enhancement built-in
- Smaller bundles for content-heavy sites

**Disadvantages:**
- Shadow DOM complicates global styling
- Less ecosystem tooling than React
- Server rendering requires custom solution (no RSC equivalent)
- Team familiarity gap

## Related

- [[mdn-frontend-architecture]] — MDN's full architecture deep dive
- [[performance-patterns]] — HTTP/2 small-file strategy
- [[code-splitting]] — Component-level lazy loading
- [[build-tools]] — Build tool comparison
