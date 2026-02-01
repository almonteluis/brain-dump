---
description: Complete playbook for creating viral startup demo videos using Remotion + Claude Code — setup, asset galleries, storyboarding research, prompts, sound integration, and real results.
tags: ["remotion", "video", "claude-code", "content-creation", "startup", "marketing"]
created: 2026-01-29
---

# Remotion Video Creation Playbook

**Source**: @om_patel5 complete guide

## The Setup

```bash
npx create-video@latest
npx skills add remotiondev/skills
# Select "claude code" when prompted
```

That's it. You now have a video editor controlled by AI.

## Key Insight: Asset Gallery

**Before prompting**, create an HTML gallery of all your assets:

```javascript
"i want to visualize all my assets in one html screen.
include the path to each one under each image as a gallery.
this will be a reference file for the remotion agent."
```

**Why this works**:
- Claude can only see ~10 images at once
- Gallery lets Claude see everything in one screenshot
- It knows file paths AND what assets look like visually

**Take screenshot of gallery → paste into Claude Code**

Claude has eyes. Most people forget this.

## Storyboarding Research (Optional but 10x Better)

```javascript
"use exa mcp to do research on storyboarding because i want to know
how we can make viral videos using remotion. study existing films and
prolific filmmakers as they have great ways to tell stories.
use parallel agents for your tasks."
```

**This will research**:
- Spielberg's "face bomb theory"
- Hitchcock's suspense techniques
- Pixar's emotional beats
- MrBeast's 3-second hook tactics

Now Claude knows filmmaker terminology. When you say "Spielberg face moment" or "reverse cause-effect," Claude understands exactly.

## Never Go Straight to Building

**Start in plan mode first**:

```javascript
"use /remotion best practices. i want to create a [type] video for [product].
here are my assets [paste screenshot]. create a plan with scene breakdown first."
```

**Claude generates**:
- Mermaid diagram of scenes
- Timing for each segment
- Animation techniques to use

**Review before building**:
- Change the order
- Remove boring scenes
- Front-load the action

## Prompts That Actually Work

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

**Prompt Claude to create CLI tool**:

```javascript
"look up the eleven labs sfx api. i want to make a local cli tool where i can
generate sfx and music from text. make it so you can generate sound effects
that match the beat of my remotion video."
```

**Then tell Remotion**:

```javascript
"use the sfx tool to generate chip tune music. align the beat yourself.
add sound effects that match each transition."
```

Claude generates music, matches SFX to animation timing, stitches everything together.

## Live Iteration

Claude can control a browser to verify its work:

```javascript
"during development, add debug grids to get animation and positioning
pixel perfect."
```

**Feedback example**:

```javascript
"at the 12 second mark, the character is kicking towards the wrong direction.
the field needs to be rotated so the goal line is horizontal, not vertical."
```

Claude fixes it in real-time.

## Export

**Via browser interface**:
1. Click "render"
2. Select format (mp4 recommended)
3. Export

**Via CLI**:
```bash
npx remotion render [composition-name] out/video.mp4
```

## Real Results

| Video Type | Prompts Needed |
|------------|---------------|
| Full product demos with sourced footage | 1 prompt |
| Animated infographics | 3 prompts |
| Vertical social clips | 1-2 prompts |

**Total cost**: ~$5-15 in API calls for full video project

## The Compound Effect

Every time you build something, save it as a skill:
- Storyboarding research → skill file
- ElevenLabs SFX tool → CLI tool
- Asset gallery generator → reusable prompt

**Next time**: You type 3 slash commands and it's done.

## Use Cases

**Good for**:
- Product demos
- Feature showcases
- Animated infographics
- Data visualizations
- Social clips (shorts, reels, tiktoks)
- Landing page videos

**Not good for**:
- Full vlogs
- Long-form edited content
- Complex multi-camera footage

**Think**: After Effects, but controlled by prompts.

## For Startups

Demo videos used to cost:
- $500-2000
- Take weeks

**Now**:
- Make in an afternoon
- $15

> "The entire world is a markdown file now. Your skill is a markdown file."

---

## Related

[[Claude Code Power User Patterns]]
[[Moltbot Clawdbot Patterns]]
