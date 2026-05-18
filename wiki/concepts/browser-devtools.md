---
description: Browser developer tools for debugging, profiling, and testing web applications
tags: ["devtools", "browser", "debugging", "testing", "performance", "concept"]
created: 2026-04-30
updated: 2026-04-30
sources: ["devtools-simulated-devices"]
---

# Browser DevTools

Every modern browser ships with a full forensic toolkit baked in — network inspector, JS debugger, performance profiler, DOM explorer. Most developers use 10% of what's there. The device emulation mode alone is worth knowing: it lets you simulate iPhones, Pixels, iPads without owning any of them.

## Device Emulation

Toggle device mode (Chrome/Edge: device toolbar, Firefox: Responsive Design Mode) and you get pre-configured devices that simulate screen dimensions, touch events, and user agent strings. Need a device that isn't listed? Create a custom one — set name, dimensions, DPR, and UA string.

**Important caveat:** simulation changes viewport, touch, and UA — but rendering still uses *your* browser's engine. A layout that works in Chrome's simulated Safari might still break on actual Safari. Trust the sim for sizing, not for rendering bugs.

Polypane takes this further — double-click anywhere to add a device pane, configure from Emulation options. Useful when you need to see three breakpoints side by side.

## Related

- [[devtools-simulated-devices]] — Custom device creation guide
- [[responsive-design]] — Designing for multiple screen sizes
- [[frontend-testing]] — Testing strategies for web applications
