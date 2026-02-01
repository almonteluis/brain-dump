---
description: React notes and reference about zai-mcp-vision-server.
title: Z.ai MCP Vision Server Setup
date: 2026-01-28
tags: [tools, mcp, claude-code, zai, image-processing, automation]
category: tool-setup
status: completed
---

# Z.ai MCP Vision Server - Image Processing Setup

> Research and setup guide for using Z.ai MCP Vision Server with Claude Code (and other MCP clients) for automated image processing.

---

## 🔍 What Is It?

**Z.ai MCP Vision Server** is a Model Context Protocol (MCP) implementation that provides **Z.AI GLM-4.6V** capabilities for MCP-compatible clients like Claude Code, Cline, OpenCode, etc.

### Key Capabilities

- **`ui_to_artifact`** - Turn UI screenshots into code, prompts, specs, or descriptions
- **`extract_text_from_screenshot`** - OCR screenshots for code, terminals, docs, and general text
- **`diagnose_error_screenshot`** - Analyze error snapshots and propose actionable fixes
- **`understand_technical_diagram`** - Interpret architecture, flow, UML, ER, and system diagrams
- **`analyze_data_visualization`** - Read charts and dashboards to surface insights and trends
- **`ui_diff_check`** - Compare two UI shots to flag visual or implementation drift
- **`image_analysis`** - General-purpose image understanding when other tools don't fit
- **`video_analysis`** - Inspect videos (local/remote ≤8MB; MP4/MOV/M4V) to describe scenes, moments, and entities

---

## 🛠️ Installation Methods

### Method 1: One-Click Installation (Recommended)
```bash
claude mcp add -s user zai-mcp-server --env Z_AI_API_KEY=YOUR_API_KEY Z_AI_MODE=ZAI -- npx -y "@z_ai/mcp-server"
```

### Method 2: Manual Configuration

**Step 1: Get Z.ai API Key**
- Visit https://docs.z.ai/api-reference to get your key

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

**Step 3: Restart Claude Desktop** for changes to take effect

---

## 🎯 How It Works

### Automatic Image Processing
When you paste/attach an image to a Claude Code prompt, the MCP server automatically detects and processes it using the most appropriate tool.

### Manual Invocation
You can also invoke tools directly:

```
@zai-mcp-server extract_text_from_screenshot "path/to/screenshot.png"
@zai-mcp-server image_analysis "path/to/image.jpg"
```

---

## 💰 Pricing

- **Z.ai GLM-4.6V**: 1/7th price of Anthropic Sonnet
- **3x usage quota** compared to Anthropic
- **Cost-effective**: Significant savings for heavy image processing

---

## 📚 Documentation Links

- [Official Z.ai MCP Docs](https://docs.z.ai/devpack/mcp/vision-mcp-server)
- [Claude Desktop MCP Guide](https://code.claude.com/docs/en/mcp)
- [MCP Official Spec](https://modelcontextprotocol.io/)
- [MCP Servers Registry](https://github.com/modelcontextprotocol/servers)

---

## ⚠️ Important Notes

### Auto-Detection
The server **automatically detects images** pasted into Claude Code prompts — you don't need to manually invoke it for basic use cases.

### Screenshot Focus
The **`ui_to_artifact`** tool is specifically designed for:
- Converting screenshots to code
- Extracting UI text and specifications
- Analyzing designs and layouts
- Converting terminal output to text

Perfect for: Food order screenshots, receipts, menus, interfaces

### OCR Capabilities
The **`extract_text_from_screenshot`** tool provides:
- Full OCR text extraction
- Code recognition from screenshots
- Terminal/command line text extraction
- General text from any image

---

## 🔧 Troubleshooting

### Common Issues

**Issue:** Server not responding
- Verify API key is correct
- Check network connection
- Restart Claude Desktop

**Issue:** Image not processed
- Ensure image file exists and is accessible
- Check Claude Desktop MCP server status via `/mcp` command
- Check logs for errors

**Issue:** Permission denied
- Verify `~/.claude.json` has correct permissions
- Check that API key doesn't contain special characters
- Try reinstalling server

---

## 🎯 Use Cases

### For Food Orders
1. **Screenshot order confirmation** → Extract order details, prices, items
2. **Screenshot menu** → Extract dishes, descriptions, prices
3. **Screenshot receipt** → Extract totals, taxes, payment info
4. **Create meal log** → Use extracted data for daily tracking

### For Development
1. **UI screenshots** → Convert to component specs, CSS, design docs
2. **Error logs** → Analyze error screenshots and generate fixes
3. **Terminal output** → Extract command output for documentation
4. **Documentation images** → Extract and organize content

---

**Last updated:** 2026-01-28
**Status:** Research complete, ready for implementation
