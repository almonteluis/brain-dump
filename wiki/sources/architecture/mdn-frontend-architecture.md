---
description: MDN rebuilt from React SPA to Lit web components + server components + Rspack — flat name-based component structure, lazy-loading custom elements, Declarative Shadow DOM, CSS scoping per component
tags:
  - web-components
  - mdn
  - frontend/architecture
  - lit
  - rspack
  - server-components
sources:
  - Under the hood of MDN's new frontend.md
created: 2026-04-11
updated: 2026-04-11
---

# MDN Frontend Architecture Deep Dive

**Source:** MDN Blog (developer.mozilla.org) by Leo McArdle
**Type:** Architecture case study
**Date ingested:** 2026-04-11

## Summary

MDN rebuilt their entire frontend from a React SPA (called "yari") to a Lit web components + custom server components architecture built with Rspack. The rewrite solved three core problems: an unusable development environment (2 min startup), entangled CSS with no scoping, and a React wrapper that could not interact with static documentation content.

## Why They Rebuilt

The previous React SPA ("yari") had accumulated severe technical debt:

1. **Ejected Create React App** — Extremely complicated Webpack config with hacky build scripts
2. **Entangled CSS** — Mix of Sass and CSS variables with no scoping; changes in one component caused unintended effects in others
3. **Render-blocking CSS blob** — Could not split CSS because it was too entangled
4. **React wrapper problem** — React app was merely a wrapper around static content, using `dangerouslySetInnerHTML`. Adding interactivity required raw DOM APIs, leading to duplicate implementations (one React, one DOM API)
5. **2-minute dev startup** — Complex commands, unreliable restarts, no SSR by default

## Key Architectural Decisions

### 1. Web Components with Lit

MDN chose Lit over React for interactive elements within static content. Custom elements can be inserted directly into Markdown, skipping rendering steps and avoiding the wrapper problem entirely.

**Example component lifecycle:**
- Extend `LitElement` with static properties
- Use `willUpdate` lifecycle for computed values
- `html` template literal (no compilation needed, unlike JSX)
- Event binding via `@click`, `@close` annotations

### 2. Flat Name-Based Component Structure

Every component lives in a flat hierarchy under `./components/`:

```
components/example-component/
├── element.css    # Web component styles
├── element.js     # Web component (defines <mdn-example-component>)
├── global.css     # Styles loaded everywhere (for non-DSD fallbacks)
├── server.css     # Server component styles (auto-loaded)
└── server.js      # Server component (extends ServerComponent)
```

### 3. Automatic Lazy Loading of Custom Elements

Client-side code scans the DOM for `mdn-*` tags and dynamically imports each component:

```js
for (const element of document.querySelectorAll("*")) {
  const tag = element.tagName.toLowerCase();
  if (tag.startsWith("mdn-")) {
    const component = tag.replace("mdn-", "");
    import(`../components/${component}/element.js`);
  }
}
```

Engineers never need to manually import web components. Components only load if present on the page.

### 4. Custom Server Components

MDN built their own server component system using Lit's `html` template literal for server-side rendering. A `ServerComponent` base class tracks which components rendered content, then only includes CSS for those components:

```js
const styles = componentsUsed
  .flatMap((component) =>
    compilationStats.assets.filter(
      (name) => name === `${component.toLowerCase()}.css`
    )
  )
  .map((path) => html`<link rel="stylesheet" href=${path} />`);
```

### 5. Declarative Shadow DOM

Web components are SSR'd into Declarative Shadow DOM, rendering styled HTML before JavaScript loads. The `<mdn-dropdown>` component demonstrates progressive enhancement:

- **Before JS loads:** Dropdown is visible and interactive via CSS-only patterns
- **After JS loads:** Enhanced with JavaScript behavior
- Uses `[loaded]` attribute to toggle between CSS-only and JS-enhanced modes

### 6. Rspack Build Tool

Replaced Webpack with Rspack (webpack-compatible API, written in Rust). Dev startup went from 2 minutes to 2 seconds. Single command (`npm run start`) does everything.

## Performance Philosophy

MDN challenges the classical "bundle everything" wisdom:

- **HTTP/2 and HTTP/3** enable parallel downloads, making multiple small files advantageous
- Each component loads independently and asynchronously
- Cached components survive updates to other components
- Cold cache benchmarks showed bundling was only as good or slower than individual files

## Baseline Compatibility

MDN uses their own Baseline project for feature adoption:
- **Baseline Widely Available** — Just use it
- **Baseline Newly Available** — Talk first, consider polyfills
- **Baseline Limited Availability** — Think harder, then talk

## Key Takeaways

1. **Web components solve the "islands of interactivity" problem** — insert custom elements into static content without a framework wrapper
2. **Flat name-based structure** enables automatic lazy loading and CSS scoping per component
3. **Progressive enhancement with Declarative Shadow DOM** — components work before JS loads
4. **Server components + web components** — no SPA needed for content-heavy sites
5. **Multiple small files > one large bundle** in the HTTP/2+ era
6. **Rspack over Webpack** — 60x faster startup with webpack-compatible API

## Concepts

- [[web-components-architecture]] — Web components for production frontends
- [[barrel-files]] — Anti-pattern for tree-shaking (related to CSS entanglement)
- [[code-splitting]] — Component-level lazy loading
- [[performance-patterns]] — HTTP/2 small-file strategy

## Related

- [[performance-patterns]] — Frontend optimization patterns
- [[build-tools]] — Build tool comparison (Vite, ESBuild, SWC)
- [[atomic-design]] — Component hierarchy methodology
