---
description: Forgetting curve — Ebbinghaus's exponential decay model of memory retention over time, formalized as p = 2^(-Δ/h), foundation for spaced repetition algorithms
tags: [learning, memory, ebbinghaus, forgetting-curve, retention, concept]
sources: ["spaced-repetition-wikipedia.md", "duolingo-half-life-regression.md", "teachers-guide-spaced-repetition.md"]
created: 2026-05-03
updated: 2026-05-10
---

# Forgetting Curve

The **forgetting curve** describes the exponential decay of memory retention over time without reinforcement. Discovered by [[hermann-ebbinghaus]] in 1885 through self-experiments, it is the empirical foundation for [[spaced-repetition]].

## The Equation

```
p = 2^(-Δ/h)
```

Where:
- `p` = probability of correct recall
- `Δ` = elapsed time since last practice
- `h` = half-life (time for retention to fall to 50%)

Three diagnostic points:
- `Δ=0` → just practiced → almost certainly recall
- `Δ=h` → 50% recall probability
- `Δ≫h` → too long → likely forgotten

## Ebbinghaus's Findings

> Soon after the learning of new information, these memories decay quickly and then at a slower rate over time. People forget most newly learned information unless reinforced.

Decay rate is steepest immediately after learning, then flattens. **Each successful retrieval lengthens the half-life** (extending the curve).

## Combat Strategy

The forgetting curve cannot be avoided — but it can be flattened:

1. **Active recall** — retrieving info from long-term memory strengthens it more than re-reading
2. **Spaced retrieval** — review just before forgetting maximizes reinforcement per session
3. **Expanding intervals** — successful recalls earn longer intervals (Pimsleur, Leitner, HLR)

## Modern Refinement: Half-Life Regression

[[half-life-regression]] (Settles 2016, Duolingo) makes `h` a *learned* quantity:

```
h = 2^(Θ·x)
```

Where `Θ` = learned weights, `x` = features (word, learner history, item difficulty).

Result: per-word half-life predictions. Words like *camera* (cognate) get long half-lives. Words like *war* (German irregular) get short ones.

## Why Half-Life Decay Is Universal

Half-life decay isn't unique to memory:

- Radiocarbon dating
- Drug metabolism
- Beer froth dissipation
- Radioactive decay

Common pattern: probability of survival = `2^(-t/h)`.

## Classroom Validation: Spaced Retrieval Near the Decay Threshold

Recent STEM classroom research validates the forgetting curve's practical implications:

- [[paper-spaced-retrieval-calculus-desirable-difficulty-2022|Lyle et al. (2022)]] showed that spaced retrieval in calculus (scheduling retrieval near the forgetting threshold) produced better final exam scores despite worse quiz performance — the forgetting curve predicts this: retrieval at the steep part of the curve produces stronger reconsolidation
- [[paper-spaced-retrieval-nine-STEM-courses-2024|Bego et al. (2024)]] found that precalculus spacing produced 3–5% retention gains, confirming that the curve is steep enough in the 1–2 week range to make spaced retrieval worthwhile
- These studies confirm the practical prescription: schedule retrieval just before the predicted forgetting point (`Δ ≈ h`) to maximize reinforcement per review session
- See [[desirable-difficulty]] for the motivational framing challenge this creates

## Application to Three-Ring Mastery System

The [[three-ring-mastery-system]] needs a decay model for the Practice ring. Without decay, mastery is monotonic and the tree fills in — no reason to maintain anything. With Ebbinghaus-style decay (per-skill, learner-specific), the mastery tree becomes a living artifact.

Decision: which `h` model to use?
- **Constant `h`** — simplest, ignores per-skill variation
- **Per-skill `h`** — fits TTO's existing skill graph
- **HLR-style learned `h`** — best fit but requires training data infrastructure

## Related

- [[spaced-repetition]] — Core technique countering forgetting curve
- [[half-life-regression]] — Trainable per-item half-life prediction
- [[hermann-ebbinghaus]] — Discoverer
- [[testing-effect]] — Why retrieval beats re-reading
- [[three-ring-mastery-system]] — Application to TTO
