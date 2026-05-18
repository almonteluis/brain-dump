---
description: Voice UI — interfaces where talking is the primary input. Not voice-only (no screen). Voice-first with visual backup.
tags:
  - voice-ui
  - vui
  - accessibility
  - speech-recognition
  - design/patterns
  - concept
created: 2026-04-30
updated: 2026-05-17
---

# Voice UI (Voice User Interface)

Voice UI is what happens when you make talking to your device the main way to interact with it. Not voice-*only* (like a smart speaker with no screen) — voice-*first*, with visuals backing it up. The screen's job is to show the kid when to speak, when the app's listening, and what happened after.

## Key Principles

- Voice is primary input, not sole input
- Visuals provide context, clarity, and direction
- Consistent listening indicators (introduced during onboarding)
- Real-time feedback that the system is listening
- Graceful handling of pauses and restarts — kids pause to think, don't cut them off
- Processing/thinking states so kids don't think the app froze
- Meaningful feedback showing their voice *made something happen*

## The 7-Step Interaction Flow

1. Present the experience (default/off state)
2. Start the voice interaction (instruction)
3. Show the app is listening (visual cue)
4. Let the user know they can be heard (audio-reactive animation)
5. End the voice interaction (stop recording cue)
6. Processing/thinking state
7. Provide feedback (celebratory or corrective)

The most powerful thing you can show a kid is that their voice actually determined the outcome. That's the magic moment — "whoa, *I* did that."

## Related

- [[voice-first-experiences-kids]] — SoapBox Labs guide for children's apps
- [[SoapBox Labs]] — speech recognition for kids
- [[accessibility]] — inclusive design patterns
