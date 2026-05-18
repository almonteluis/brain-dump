---
description: SoapBox Labs — voice AI built specifically for kids' voices. General-purpose speech recognition breaks on children; SoapBox trained on kid-voice corpora.
tags:
  - entity
  - organization
  - company
  - voice-ai
  - kids
  - education/technology
  - speech-recognition
sources:
  - voice-first-experiences-kids.md
created: 2026-05-09
updated: 2026-05-17
---

# SoapBox Labs

SoapBox Labs builds speech recognition technology designed specifically for children's voices. Not "adult ASR tuned down" — models trained on kid-voice corpora from scratch. If you're building any voice-first product where the primary users are children, SoapBox is the relevant reference.

## Why Kid-Specific ASR Matters

Children's speech breaks general-purpose ASR:

- Higher-pitched fundamental frequencies
- Less consistent enunciation
- Shorter utterances, more pauses
- Wide vocal range across age (a 4-year-old and a 12-year-old sound nothing alike)
- Classroom background noise — chatter, HVAC, home distractions

Most speech-recognition models are trained on adult corpora and degrade significantly on kid voices. SoapBox built models on kid-voice data.

## What They've Published

- **"A Beginner's Guide to Voice-First Experiences for Kids"** — Declan Moore (Head of UX) + Ronan Tumelty (Senior Software Engineer). Covers voice-first vs voice-only, listening/processing/feedback states, audio-reactive animations, visual cues.
- Best-practice patterns for microphone usage, scoring, gamification of voice-first products.

## Why It Matters for TTO

If [[insight-recall]] ever integrates voice capture ("what clicked?" prompt at BrainBreak cooldown), kid-specific ASR matters. A generic ASR layer degrades enough on younger voices to make capture unreliable. The voice-first design patterns are also directly applicable to [[voice-first-ui-patterns]] for the Marvin product.

## Related

- [[voice-first-ui-patterns]] · [[voice-ui]] · [[insight-recall]]
