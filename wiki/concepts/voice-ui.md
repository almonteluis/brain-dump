---
description: User interfaces where voice is the primary input modality, often supplemented by visual and tactile feedback
tags: [voice-ui, vui, accessibility, speech-recognition, design-patterns, concept]
created: 2026-04-30
updated: 2026-04-30
---

# Voice UI (Voice User Interface)

Interface paradigm where users interact with systems primarily through spoken language. Distinct from voice-only (screenless) experiences — voice-first supplements voice with visual, tactile, and audio feedback.

## Key Principles

- Voice is primary input, not sole input
- Visuals provide context, clarity, and direction
- Consistent listening indicators (introduced during onboarding)
- Real-time feedback that the system is listening
- Graceful handling of pauses and restarts
- Processing/thinking states to manage user expectations
- Meaningful feedback showing voice determined the outcome

## The 7-Step Interaction Flow

1. Present the experience (default/off state)
2. Start the voice interaction (instruction)
3. Show the app is listening (visual cue)
4. Let the user know they can be heard (audio-reactive animation)
5. End the voice interaction (stop recording cue)
6. Processing/thinking state
7. Provide feedback (celebratory or corrective)

## Related

- [[voice-first-experiences-kids]] — SoapBox Labs guide for children's apps
- [[SoapBox Labs]] — speech recognition for kids
- [[accessibility]] — inclusive design patterns
