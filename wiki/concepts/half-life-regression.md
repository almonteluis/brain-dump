---
description: Half-Life Regression (HLR) — Duolingo's spaced repetition algorithm. Combines Ebbinghaus forgetting curve with logistic regression to predict per-word memory half-life. Beat Leitner by ~50% in error rate.
tags:
  - learning
  - spaced/repetition
  - machine-learning
  - duolingo
  - algorithms
  - concept
sources:
  - duolingo-half-life-regression.md
created: 2026-05-03
updated: 2026-05-17
---

# Half-Life Regression (HLR)

Half-Life Regression is Duolingo's answer to "when should we show this word again?" Developed by [[burr-settles]] (ACL 2016), it takes Ebbinghaus's [[forgetting-curve]] and adds per-word feature weights via logistic regression, trained on billions of practice events. The result: a spaced repetition algorithm that knows "camera" is easier for English speakers than "writing" and adjusts review timing accordingly.

## The Two Equations

Recall probability (Ebbinghaus, 1880s):
```
p = 2^(-Δ/h)
```

Half-life prediction (HLR's contribution):
```
h = 2^(Θ·x)
```

Where `Θ` = learned model weights, `x` = feature vector encoding the learner's history with the word + word-level features. The forgetting curve gives you the shape. HLR gives you the *parameters* — and they're different for every word.

## Why It Beats Earlier Algorithms

| Algorithm | Adaptability | Per-Item Features |
|---|---|---|
| **Pimsleur** | Fixed schedule | None |
| **Leitner** | Adaptive doubling/halving | None |
| **HLR** | Per-event update | Yes — word-level |

HLR adds per-item features to per-event adaptation. Result: error rate **~50% lower** than Leitner on 12M+ practice events.

## What the Feature Weights Reveal

The trained `Θ` weights tell you what makes words hard:

| Easier (+ weights) | Harder (- weights) |
|---|---|
| Cognates | Rare words |
| Short common words | Irregular forms |
| Regular grammar | Past/present participles, imperfective aspect |

English examples: `camera` (+0.77), `circle` (+0.08), `rose` (-0.09), `writing` (-0.81). That's not a grammar rule anyone wrote — the model discovered it from data.

## Real-World Results

| Metric | Lift |
|---|---|
| Practice session retention | +9.5% |
| Lesson retention | +1.7% |
| Overall activity | +12% |

Duolingo switched entirely to HLR after A/B validation. Code + dataset: [github.com/duolingo/halflife-regression](https://github.com/duolingo/halflife-regression).

## Production Reality

- **Data infrastructure**: Duolingo updates ~3,000 stats/sec across billions of (user, word) pairs
- **Feature engineering**: per-word features must be tracked and extensible without retrain
- **Cold start**: new learners or new words lack history — fallback model needed
- **Drift**: language [[pedagogy]] evolves → periodic retrain

## For TTO's Three-Ring System

[[three-ring-mastery-system]] could borrow HLR's per-skill half-life approach:
- Track per-(student, skill) pairs
- Update half-life based on assessment performance
- Trigger Practice ring drop when `Δ` approaches `h`

Tradeoffs:
- **Pro**: empirically validated, beat Leitner ~50%, principled
- **Con**: requires ML infrastructure (training, serving, drift monitoring)
- **Alternative**: empirical decay curves from 6 years of TTO data (uses data without ML)

The open thread: HLR predicts *when* to review. [[insight-recall]] predicts *what* to surface. Two different questions. The Three-Ring maintenance ring needs both — HLR for cadence, insight recall for content. Right now most systems only solve the "when."

## Related

- [[spaced-repetition]] — Algorithm class
- [[forgetting-curve]] — Underlying decay model
- [[duolingo-half-life-regression]] — Source page (Settles blog post)
- [[duolingo]] — Production deployment context
- [[burr-settles]] — Algorithm author
- [[fsrs-algorithm]] — Modern open-source counterpart
- [[three-ring-mastery-system]] — Potential TTO application
