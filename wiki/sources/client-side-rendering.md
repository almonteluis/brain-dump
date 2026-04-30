---
description: Client-side rendering in React, covering CSR basics, JavaScript bundle performance impact, and React 18+ improvements
tags: [react, rendering, performance, frontend]
sources: [Client-side Rendering.md]
created: 2026-04-16
updated: 2026-04-16
---

# Client-Side Rendering

**Source:** Client-side Rendering.md
**Date ingested:** 2026-04-16
**Type:** article

## Summary

Client-side rendering (CSR) is a pattern where only a barebones HTML container is rendered by the server, and all logic, data fetching, templating, and routing are handled by JavaScript in the browser. CSR became popular for building single-page applications (SPAs) that blur the line between websites and installed applications, offering navigation without page refreshes and fast subsequent interactions.

The primary drawback of CSR is performance on initial load. As application complexity grows, JavaScript bundle size increases, pushing back First Contentful Paint (FCP) and Time to Interactive (TTI). Users see a blank screen during the entire period between First Paint and FCP. The article notes that React 18+ introduces Progressive Hydration and Selective Hydration to mitigate the traditional TTI gap, and that pure CSR is now generally discouraged for large or public-facing apps in favor of SSR/SSG with hydration.

Performance improvements for CSR include JavaScript budgeting (under 100-170KB minified and gzipped for initial loads), preloading critical resources, lazy loading non-critical code, code splitting via bundlers like Webpack, and application shell caching with service workers. These techniques help CSR achieve faster SPA experiences with decent FCP and TTI metrics.

## Key Claims

- Pure CSR is generally discouraged for large apps; SSR/SSG with hydration is the recommended approach for initial content
- CSR bundle size is inversely proportional to performance -- larger bundles push FCP and TTI later
- React 18 introduced Progressive Hydration and Selective Hydration to mitigate TTI gaps
- An initial JavaScript bundle under 100-170KB minified and gzipped is a good starting budget
- SEO is more difficult with CSR because crawlers may not render JavaScript fast enough to index content

## Concepts Covered

- [[client-side-rendering]] -- Rendering UI entirely in the browser via JavaScript, with the server providing only an HTML shell
- [[streaming]] -- React 18 streaming SSR improves initial load by sending HTML in chunks as it becomes available
- [[code-splitting]] -- Breaking large bundles into smaller pieces loaded on demand to reduce initial payload
- [[lazy-loading]] -- Deferring non-critical resources until they are needed, improving initial page load time
- [[suspense]] -- React 18 feature for orchestrating loading states and deferred component loading
