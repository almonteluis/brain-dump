---
description: How to create custom simulated devices in browser DevTools for responsive testing
tags: ["devtools", "browser", "responsive-design", "testing", "device-emulation"]
sources: ["Create your own simulated devices.md"]
created: 2026-04-30
updated: 2026-04-30
---

# DevTools: Create Your Own Simulated Devices

**Source:** `Create your own simulated devices.md`
**Date ingested:** 2026-04-30
**Type:** clipping
**Original:** https://devtoolstips.org/tips/en/add-new-devices/
**Authors:** [[Patrick Brosset]], [[Kilian Valkhof]]
**Published:** 2022-05-15

## Summary

Browser DevTools allows simulating various devices to test how webpages render. Beyond the built-in device list, you can create custom simulated devices with specific dimensions, DPR, and user agent strings.

## How To

1. Open DevTools (F12), start device mode:
   - Edge/Chrome: Click **Toggle device emulation**
   - Firefox: Click **Responsive Design Mode**
2. In the device simulation screen, expand the device drop-down and click **Edit...**
3. From the device customization screen:
   - Check/uncheck devices to customize the device drop-down
   - Click **Add Custom Device...** to add your own
4. Choose a device name, dimensions, DPR, and user agent string, then submit
5. Your new device appears in the device drop-down

## Polypane Note

In Polypane, these steps are not needed. Double-click anywhere to add a new device and configure its settings from the **Emulation options**.

## Important Caveat

Device simulation only changes screen dimensions, touch event handling, and user agent string. The actual rendering is still done by the browser you are using — it does not emulate the browser engine of the target device.

## Concepts Covered

- [[responsive-design]] — Testing across device sizes
- [[browser-devtools]] — Development and debugging tools
- [[device-testing]] — Mobile and tablet testing strategies
