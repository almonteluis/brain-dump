---
description: Psychometric technique — invert scale direction on certain questionnaire items to check for response bias
tags:
  - psychometrics
  - questionnaires
  - assessment
  - marvin/frontend/brain-break
  - concept
sources:
  - work-status-may-5-2026.md
created: 2026-05-05
updated: 2026-05-05
---

# Reverse Scoring

Psychometric technique used in questionnaires to detect response bias (e.g., acquiescence bias — agreeing with everything). Some items are phrased in opposite direction; responses must be inverted before aggregation.

## Brain Break Application

From [[work-status-may-5-2026]] — reverse scoring applies to:

- **Self-efficacy questions** (questions 8 and 9)
- Maria asked which questions reverse score applies to — need to verify logic fully implemented

## How It Works

On a 1–5 Likert scale:

| Raw Response | Reverse Scored |
|-------------|----------------|
| 1 (Strongly disagree) | 5 |
| 2 | 4 |
| 3 | 3 |
| 4 | 2 |
| 5 (Strongly agree) | 1 |

## Purpose

- Detects respondents who agree/disagree without reading
- Ensures scale validity
- Common in psychological assessments

## Competency-Based Assessment

In [[competency based learning]] systems that assess both academic and affective outcomes, [[reverse-scoring]] ensures **psychometric validity for non-cognitive measures**:

- **Affective measures alongside academic competencies** — CBL assessment increasingly includes self-efficacy, growth mindset, and persistence measures alongside content mastery. Without reverse scoring, these affective scales are vulnerable to acquiescence bias (agreeing with everything), producing inflated or meaningless scores.
- **Assessment integrity** — if affective measures influence placement decisions, pacing recommendations, or teacher interventions (as they do in systems like BrainBreak), invalid scores could systematically disadvantage students. Reverse scoring is a minimal-cost safeguard against this.
- **Multi-dimensional assessment validity** — [[performance-based-assessment]] rubrics in CBL often include affective dimensions (effort, self-regulation, collaboration). Reverse scoring ensures these dimensions are measured reliably, not confounded by response patterns.
- **Connection to equity** — the Aurora Institute (2020) emphasizes that CBL assessment must be valid for all student groups. Response bias patterns can vary by cultural background, age, and reading level, making reverse scoring an equity-relevant psychometric practice.

## Related

- [[cooldown-system]] — Feature using reverse scoring
- [[work-status-may-5-2026]] — Implementation status
