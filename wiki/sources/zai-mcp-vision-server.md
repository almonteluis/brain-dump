---
description: "Z.ai MCP Vision Server setup and configuration"
tags: [tools, mcp, claude-code, zai, image-processing, automation, vision]
sources: [zai-mcp-vision-server.md]
created: 2026-04-09
updated: 2026-04-09
---

# Z.ai MCP Vision Server - Image Processing Setup

**Source:** raw/02_reference/tools/zai-mcp-vision-server.md
**Date ingested:** 2026-04-09
**Type:** tool-setup

## Summary

Research and setup guide for using Z.ai MCP Vision Server with Claude Code for automated image processing. Provides GLM-4.6V capabilities at 1/7th the cost of Anthropic Sonnet.

## Key Claims

- Z.ai MCP Vision Server provides GLM-4.6V capabilities for image/video analysis
- Cost is 1/7th of Anthropic Sonnet with 3x usage quota
- Auto-detects images pasted into Claude Code prompts
- 8 specialized tools for different image analysis tasks

## What Is It?

**Z.ai MCP Vision Server** is a Model Context Protocol (MCP) implementation that provides **Z.AI GLM-4.6V** capabilities for MCP-compatible clients like Claude Code, Cline, OpenCode, etc.

### Key Capabilities

- **`ui_to_artifact`** — Turn UI screenshots into code, prompts, specs, or descriptions
- **`extract_text_from_screenshot`** — OCR screenshots for code, terminals, docs
- **`diagnose_error_screenshot`** — Analyze error snapshots and propose fixes
- **`understand_technical_diagram`** — Interpret architecture, flow, UML, ER diagrams
- **`analyze_data_visualization`** — Read charts and dashboards for insights
- **`ui_diff_check`** — Compare two UI shots for visual drift
- **`image_analysis`** — General-purpose image understanding
- **`video_analysis`** — Inspect videos (≤8MB, MP4/MOV/M4V)

## Installation

### Method 1: One-Click Installation (Recommended)
```bash
claude mcp add -s user zai-mcp-server --env Z_AI_API_KEY=YOUR_API_KEY Z_AI_MODE=ZAI -- npx -y "@z_ai/mcp-server"
```

### Method 2: Manual Configuration

**Step 1: Get Z.ai API Key**
- Visit https://docs.z.ai/api-reference

**Step 2: Add to Claude Desktop Config** (`~/.claude.json`)
```json
{
  "mcpServers": {
    "zai-mcp-server": {
      "type": "stdio",
      "command": "npx",
      "args": ["-y", "@z_ai/mcp-server"],
      "env": {
        "Z_AI_API_KEY": "your_api_key_here",
        "Z_AI_MODE": "ZAI"
      }
    }
  }
}
```

## How It Works

### Automatic Image Processing
When you paste/attach an image to a Claude Code prompt, the MCP server automatically detects and processes it using the most appropriate tool.

### Manual Invocation
```
@zai-mcp-server extract_text_from_screenshot "path/to/screenshot.png"
@zai-mcp-server image_analysis "path/to/image.jpg"
```

## Pricing

- **Z.ai GLM-4.6V**: 1/7th price of Anthropic Sonnet
- **3x usage quota** compared to Anthropic
- **Cost-effective**: Significant savings for heavy image processing

## Use Cases

### For Food Orders
1. Screenshot order confirmation → Extract order details, prices, items
2. Screenshot menu → Extract dishes, descriptions, prices
3. Screenshot receipt → Extract totals, taxes, payment info
4. Create meal log → Use extracted data for daily tracking

### For Development
1. UI screenshots → Convert to component specs, CSS, design docs
2. Error logs → Analyze error screenshots and generate fixes
3. Terminal output → Extract command output for documentation
4. Documentation images → Extract and organize content

## Concepts Covered

- [[MCP]] — Model Context Protocol
- [[Z.ai]] — GLM-4.6V vision model
- [[Image Processing]] — Automated analysis
- [[OCR]] — Text extraction from images
- [[UI Analysis]] — Screenshot to code

## Related

- [[claude-code-power-user-patterns]]
- [[moltbot-clawdbot-patterns]]
