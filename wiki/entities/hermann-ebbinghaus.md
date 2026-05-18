---
description: Hermann Ebbinghaus — the 1880s German psychologist who discovered the forgetting curve by memorizing nonsense syllables and tracking how fast he forgot them. The grandparent of every spaced repetition algorithm running today.
tags:
  - entity/ebbinghaus
  - person
  - psychology
  - memory
  - history-of-science
  - spaced/repetition
sources:
  - spaced-repetition-wikipedia.md
  - duolingo-half-life-regression.md
  - teachers-guide-spaced-repetition.md
created: 2026-05-03
updated: 2026-05-17
---

# Hermann Ebbinghaus

Hermann Ebbinghaus (1850–1909) ran one of the first rigorous self-experiments in psychology. He memorized thousands of nonsense syllables, tested himself at increasing intervals, and plotted how fast the memories decayed. The result was the **[[forgetting-curve]]** — exponential decay of retention without reinforcement. He also discovered that **distributed practice beats massed study**, which is the empirical foundation of [[spaced-repetition]].

The man basically invented the methodology of experimental memory research. Everything from [[paul-pimsleur|Pimsleur's]] graduated intervals to [[burr-settles|Settles']] Half-Life Regression to Anki's SM-2 traces back to Ebbinghaus's curve.

## Major Contributions

- **Forgetting curve** — exponential decay of memory without reinforcement
- **Spacing effect** — distributed practice > massed practice. The most robust finding in cognitive science.
- **Nonsense syllables** — removing semantic content from stimuli to study memory in isolation. Methodologically brilliant: you can't use prior knowledge to "cheat" a nonsense syllable.
- **Self-experimentation** — systematic, quantitative study of his own learning. N=1 but rigorous.

## The Core Equation (Modern Form)

```
p = 2^(-Δ/h)
```

Where `p` = recall probability, `Δ` = elapsed time, `h` = half-life. This is the equation that [[half-life-regression]] directly optimizes.

## Influence Timeline

| Year | Who | What |
|------|-----|------|
| 1885 | Ebbinghaus | Forgetting curve + spacing effect |
| 1939 | H. F. Spitzer | Empirical validation in Iowa schools (3,600 students) |
| 1967 | [[paul-pimsleur]] | Graduated-interval recall for language learning |
| 1972 | [[sebastian-leitner]] | Flashcard box system |
| 1985 | Leitner system | Anki, SuperMemo, and every SRS app |

## Why He Matters for TTO

Every adaptive learning system depends on a model of memory decay. Ebbinghaus gave us the shape of that decay. The [[knowledge-tracing]] models running in Teach to One are descendants of his curve — they just add more features (item difficulty, student ability) to the same exponential backbone.

The open thread: Ebbinghaus's curve describes *fact* memory — nonsense syllables, vocabulary words, isolated items. Math isn't facts. The decay curve for procedural skills (how to solve an equation) and conceptual understanding (why the equation works) may have a different shape entirely. That's the frontier [[project-atlas]] is exploring.

## Related

- [[forgetting-curve]] · [[spaced-repetition]] · [[half-life-regression]] · [[burr-settles]] · [[paul-pimsleur]] · [[sebastian-leitner]]
