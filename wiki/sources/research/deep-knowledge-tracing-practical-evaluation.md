---
description: "Practical evaluation of Deep Knowledge Tracing (Piech et al. 2015) in real educational settings. DKT promised to replace BKT with RNNs — did it deliver outside the lab?"
tags: [source, dkt, knowledge-tracing, deep-learning, piech, evaluation]
sources:
  - Piech, C. et al. (2015). Deep Knowledge Tracing. NIPS 2015.
created: 2026-05-16
updated: 2026-05-16
---

# Practical Evaluation of Deep Knowledge Tracing

DKT (Piech et al., 2015) was supposed to be the next leap in [[knowledge-tracing]]: replace hand-crafted Bayesian models with an RNN that learns the student state representation directly from data. No more assuming skills are independent. No more hand-tuning guess/slip parameters. Just feed in the sequence of student responses and let the network figure it out.

In the lab: promising. In practice: mixed. DKT has a tendency to predict scores outside [0,1], struggles with sparse data on individual skills, and — the real problem — it's a black box. When BKT says a student has P(learned)=0.3, you can trace why. When DKT says 0.3, you can't explain it to a teacher. For [[project-atlas]], the explainability constraint is real: teachers need to trust the system's decisions.

The broader lesson: deep learning approaches to knowledge tracing haven't clearly beaten well-tuned classical models (BKT, PFA) in production settings. The gap between benchmark results and real-world performance is wide enough that the simpler, interpretable model is often the better engineering choice.

Cross-links: [[knowledge-tracing]], [[project-atlas]], [[adaptive-learning-systems]], [[teach-to-one]]
