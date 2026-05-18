---
description: AI video creation with Remotion playbook
tags:
  - tools
  - remotion
  - video
  - claude/code
  - content-creation
  - startup
  - marketing
sources:
  - remotion-video-creation-playbook.md
created: 2026-04-09
updated: 2026-04-09
---

# Remotion Video Creation Playbook

**Source:** raw/02_reference/tools/remotion-video-creation-playbook.md
**Date ingested:** 2026-04-09
**Type:** guide

## Summary

Complete playbook for creating viral startup demo videos using Remotion + Claude Code. Covers setup, asset galleries, storyboarding research, prompts, sound integration, and real results.

## Key Claims

- Asset galleries (HTML screenshot of all assets) let Claude see everything at once
- Storyboarding research on Spielberg, Hitchcock, Pixar techniques improves output quality
- Never go straight to building — start in plan mode with scene breakdowns
- Full product demos can be created with 1 prompt for ~$5-15 in API calls

## The Setup

```bash
npx create-video@latest
npx skills add remotiondev/skills
# Select "claude code" when prompted
```

## Key Insight: Asset Gallery

**Before prompting**, create an HTML gallery of all assets:

```javascript
"i want to visualize all my assets in one html screen.
include the path to each one under each image as a gallery.
this will be a reference file for the remotion agent."
```

**Why this works:**
- Claude can only see ~10 images at once
- Gallery lets Claude see everything in one screenshot
- It knows file paths AND what assets look like visually

## Storyboarding Research

```javascript
"use exa mcp to do research on storyboarding because i want to know
how we can make viral videos using remotion. study existing films and
prolific filmmakers as they have great ways to tell stories.
use parallel agents for your tasks."
```

Researches:
- Spielberg's "face bomb theory"
- Hitchcock's suspense techniques
- Pixar's emotional beats
- MrBeast's 3-second hook tactics

## Prompts That Work

### Product Demos
```javascript
"make a promo video for [product]. use the actual logo from my assets.
source photos from [website url]. make sure brand colors and fonts are aligned.
key message: [your cta]."
```

### Showcases
```javascript
"i want a showcase of all my [characters/features].
make it feel like a slot machine reveal. fast, fun, creative. 15-20 seconds.
add sfx that match the beat."
```

### Vertical Social Content
```javascript
"create a vertical video (9:16). fast-paced brain rot style.
hook in first 3 seconds. use rapid cuts and zooms."
```

## Sound Integration

**Generate CLI tool for ElevenLabs SFX:**
```javascript
"look up the eleven labs sfx api. i want to make a local cli tool where i can
generate sfx and music from text. make it so you can generate sound effects
that match the beat of my remotion video."
```

## Real Results

| Video Type | Prompts Needed | Cost |
|------------|---------------|------|
| Full product demos with sourced footage | 1 prompt | ~$5-15 |
| Animated infographics | 3 prompts | ~$5-15 |
| Vertical social clips | 1-2 prompts | ~$5-15 |

## Use Cases

**Good for:**
- Product demos
- Feature showcases
- Animated infographics
- Data visualizations
- Social clips (shorts, reels, tiktoks)
- Landing page videos

**Not good for:**
- Full vlogs
- Long-form edited content
- Complex multi-camera footage

## Concepts Covered

- [[Remotion]] — React-based video creation
- [[Video Creation]] — AI-powered content generation
- [[Asset Galleries]] — Visual reference patterns
- [[Storyboarding]] — Film technique research
- [[Sound Integration]] — SFX and music generation

## Related

- [[claude-code-power-user-patterns]]
- [[moltbot-clawdbot-patterns]]
