---
description: Browser developer tools for debugging, profiling, and testing web applications
tags: ["devtools", "browser", "debugging", "testing", "performance", "concept"]
created: 2026-04-30
updated: 2026-04-30
sources: ["devtools-simulated-devices"]
---

# Browser DevTools

Browser DevTools are built-in debugging and profiling tools for web development, available in all major browsers.

## Device Emulation

### Built-In Device Simulation

- Toggle device emulation (Chrome/Edge: device toolbar button, Firefox: Responsive Design Mode)
- Pre-configured devices: iPhone, iPad, Pixel, etc.
- Simulates: screen dimensions, touch events, user agent string

### Custom Devices

Create custom simulated devices for testing:
1. Open device mode
2. Expand device drop-down, click **Edit...**
3. Click **Add Custom Device...**
4. Set name, dimensions, DPR, user agent
5. Submit — appears in device drop-down

**Important:** Simulation only changes viewport, touch, and UA. Rendering still uses your browser's engine — not the target device's engine.

### Polypane

Polypane simplifies device testing: double-click anywhere to add a new device, configure from **Emulation options**.

## Related

- [[devtools-simulated-devices]] — Custom device creation guide
- [[responsive-design]] — Designing for multiple screen sizes
- [[frontend-testing]] — Testing strategies for web applications
