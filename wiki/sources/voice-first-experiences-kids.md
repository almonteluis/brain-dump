---
description: Best practices for designing voice-first interactive experiences for children by SoapBox Labs
tags: [voice-ui, vui, kids, education, accessibility, design-patterns]
sources: [A beginner's guide to voice-first experiences for kids.md]
created: 2026-04-30
updated: 2026-04-30
---

# Voice-First Experiences for Kids

**Source:** A beginner's guide to voice-first experiences for kids.md
**Date ingested:** 2026-04-30
**Type:** article

## Summary

SoapBox Labs' guide to designing voice-first experiences for children, covering the distinction between voice-first and voice-only, input/output modalities, visual support for voice interactions, and a step-by-step sample app experience for a reading game.

## Key Claims

- Voice-first (not voice-only) means voice is the primary input, supplemented by touch, visuals, and audio
- Visuals are critical: children need to know when they can speak, when the system hears them, when it is acting, and the results
- The goal is a hands-free experience once the activity starts
- Audio prompts should complete before listening begins — loud audio impacts voice performance
- Be explicit that children should read out loud, not silently
- Consistent UI elements (like a listening indicator) should be introduced during onboarding
- Audio-reactive animations provide real-time feedback that the app is listening
- Do not immediately stop listening after speech ends — children may pause and resume
- Show a processing/thinking state so children understand speech is not available during that time
- Meaningful feedback showing that their voice determined the outcome is "magical" for children

## The 7-Step Voice Interaction Flow

1. **Present the Experience** — default/off state
2. **Start the Voice Interaction** — audio/visual instruction
3. **Show the App is Listening** — visual cue (scaled UI, color change)
4. **Let the Child Know They Can Be Heard** — audio-reactive animation
5. **Ending the Voice Interaction** — visual cue that recording is stopping
6. **Processing/Thinking State** — indicate speech is not available
7. **Provide Feedback** — celebratory or corrective response

## Entities Mentioned

- [[SoapBox Labs]] — speech recognition for kids
- [[Siri]] — voice-only comparison
- [[Alexa]] — voice-only comparison

## Concepts Covered

- [[voice-first-vs-voice-only]] — primary input vs sole input
- [[vui-visual-cues]] — listening indicators, feedback states
- [[child-centered-design]] — age-appropriate metaphors and instructions
- [[audio-reactive-ui]] — real-time amplitude visualization
- [[voice-feedback-loop]] — speak → hear → process → respond cycle
