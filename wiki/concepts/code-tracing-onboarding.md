---
description: Tracing a feature from UI click to database write as the real, practiceable onboarding skill
tags: [onboarding, debugging, software-engineering, concept]
created: 2026-05-17
source: "[[My thoughts shipping faster code]]"
---

# Code tracing as the real onboarding skill

The advice every senior dev gives: "learn the codebase." Nobody explains what that actually means. It doesn't mean reading every file. It means being able to trace a feature from the UI click to the database write — jump into the event handler, follow the state update, find the GraphQL mutation, read the resolver, see the SQL. That's code tracing. And most developers never practice it deliberately.

NeoVim forces you to learn it because there's no file tree to browse and no "go to definition" button you can click without thinking. You learn the keybinds for jumping to references, searching symbols, switching between definition and implementation. After enough reps, you stop thinking about *how to navigate* and start thinking about *what the code is doing*. That's the crossover. When the editor disappears and you're just reading the codebase like a map.

The concrete skill: pick a feature you didn't write. Start at the UI. Trace it all the way down. Name every layer you pass through. If you can't name it, you found a gap in your understanding. That gap is more valuable than any onboarding doc.

This is the engineering equivalent of what [[context-engineering]] does for LLMs — the quality of your output depends on how well you can retrieve the right context. A dev who can trace code fast has a better mental context window than one who can't. Does this skill transfer across languages, or is it syntax-specific? Probably language-agnostic but framework-specific — tracing through Next.js is a different map than tracing through Express, even in the same language.

## Related Concepts
- [[context-engineering]]
