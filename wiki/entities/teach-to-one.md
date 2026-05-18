---
description: Teach to One is New Classrooms' personalized math platform — algorithmically-generated daily playlists combining multiple learning modalities. Every student gets a different schedule, every day.
tags:
  - entity/new-classrooms/teach-to-one
  - product
  - personalized-learning
  - ed-tech
sources:
  - https://www.newclassrooms.org/teach-to-one
created: 2026-05-16
updated: 2026-05-16
---

# Teach to One

Teach to One is the product. It's a personalized math platform where every student gets a daily playlist — a unique schedule mixing online work, small-group instruction, collaborative tasks, and independent practice. The algorithm picks what each kid works on and *how* they work on it, based on where they are in the [[skill-graph]] and what [[knowledge-tracing]] says about their mastery.

The key shift from traditional math class: there's no "today we're all doing chapter 5." A room of 30 kids might be working on 15 different skills across 5 different modalities. The teacher isn't lecturing to the whole group — they're pulling small groups for targeted instruction while the rest of the class works through their playlists.

## Origin Story

Teach to One grew out of **School of One**, a 2009 NYC pilot program. Joel Rose and Chris Rush built a summer school program that used algorithms to generate daily schedules for each student. The pilot showed promising results, and in 2011 they spun it out as [[new-classrooms]] — a nonprofit that could scale the model beyond a single city.

The name change (School of One → Teach to One) signals the shift: it's not just about personalizing the *student* experience, it's about redefining what teaching looks like when a machine handles the logistics.

## How the Playlist Gets Built

1. **Assessment** → [[learnosity]] serves items, student answers come back
2. **Mastery estimate** → [[knowledge-tracing]] updates the model of what the student knows
3. **Sequencing** → the algorithm picks the next skill from the [[skill-graph]], respecting prerequisites
4. **Modality matching** → based on the student's learning profile and available resources, assign a modality (teacher-led small group, online, collaborative, independent)
5. **Schedule generation** → the daily playlist, delivered to students and teachers each morning

The whole cycle runs daily. It's not a static learning path set at the beginning of the year — it adjusts every single day based on what happened yesterday.

## What [[project-atlas]] Changes

Teach to One's current system is powerful but batch-oriented — the playlist updates once a day. Project ATLAS is the next generation: real-time adaptive sequencing, multimodal assessment (not just multiple choice), misconception detection, and engagement optimization. Think of TTO as the infrastructure and ATLAS as the intelligence layer that makes it adaptive *within* a session, not just between sessions.

## The Open Question

TTO handles the logistics of personalized learning brilliantly. What it doesn't do — what no system does well yet — is the relational, culturally responsive side of teaching. [[ladson-billings]] would say the algorithm can pick the right problem, but it can't build the trust that makes a kid *willing to struggle* with that problem. That's still the teacher's job, and the design challenge is making sure the platform supports that relationship instead of crowding it out.
