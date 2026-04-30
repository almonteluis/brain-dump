---
description: Example Learnosity API response for a skill assessment showing participant data, responses, scoring, and skill tagging
tags: [source, work, marvin, learnosity, assessment, json, example, skill-assessment]
sources: ["Example Skill Assessment JSON Response - Marvin.md"]
created: 2026-04-30
updated: 2026-04-30
---

# Marvin Example Skill Assessment JSON Response

**Source:** `Example Skill Assessment JSON Response - Marvin.md` (Confluence)
**Date ingested:** 2026-04-30
**Type:** Reference / example data
**Project:** Marvin assessment integration

## Summary

Example JSON response from Learnosity API for a completed skill assessment. Shows the structure of assessment participant data, individual item responses, and skill tagging used by the inference system.

## Assessment Overview

| Field | Value |
|-------|-------|
| Assessment Name | "Add Integers - Attempt 1" |
| Assessment ID | 390701 |
| Administration ID | 387070 |
| Student | Edgar Sanmartin Chamba (user_id: 73662) |
| Score | 10 / 10 (100%) |
| Responses | 5 / 5 answered |
| Testing Time | 2,839 seconds (~47 min) |
| Learnosity Session ID | `81859c3c-d07a-4f76-91d6-960ee2d2884c` |

## Response Structure

Each response item contains:

| Field | Example | Notes |
|-------|---------|-------|
| `item_id` | 26238 | Internal item identifier |
| `learnosity_reference` | `NEWfbc4e81f-...` | Learnosity item reference |
| `question_number` | 1-5 | Sequential question number |
| `response_value` | "", "A", "D" | Student's answer |
| `answered` | 1 | Boolean-like: 1 = answered |
| `score` | 2 | Points earned |
| `max_score` | 2 | Points possible |
| `auto_score` | 2 | Auto-graded score |
| `manual_score` | 0 | Manually adjusted score |
| `testing_time` | 119, 30, 22, 62, 37 | Seconds spent per question |
| `tags` | `["skill-182"]` | Skill association tags |

## Key Observations

### Skill Tagging
All 5 responses are tagged with `"skill-182"`, indicating this assessment covers a single skill. The inference system uses these tags to associate responses with skills.

### Scoring
- Each question is worth 2 points (max_score: 2)
- Total: 10 points across 5 questions
- All questions answered correctly (score == max_score for all)
- All scoring is auto-graded (auto_score matches score, manual_score = 0)

### Timing
- Total testing time: 2,839 seconds
- Per-question times: 119s, 30s, 22s, 62s, 37s
- First question took significantly longer (119s) — likely initial load/setup

### Response Values
- Question 1: empty string `""` (possibly interactive/non-text response)
- Questions 2-3: `"A"` (multiple choice)
- Question 4: `"A"` (multiple choice)
- Question 5: `"D"` (multiple choice)

## Pagination

```json
{
  "current_page": 1,
  "last_page": 1,
  "per_page": 100,
  "shown": 1,
  "total": 1
}
```

Single participant result with no additional pages.

## Relevance to Inferencing

This response format is consumed by:
- [[learnosity-result-fetcher]] — Retrieves and persists this data
- [[inference-engine]] — Uses `score`, `max_score`, and `tags` to determine skill states
- [[marvin-skill-assessment-inferencing-implementer-notes]] — Defines how score/maxScore >= 0.8 triggers inferencing

## Related

- [[learnosity]] — Learnosity platform overview
- [[learnosity-result-fetcher]] — Lambda that retrieves this data
- [[inference-engine]] — Consumes assessment results for skill state inference
- [[marvin-skill-assessment-inferencing-implementer-notes]] — Processing logic for this data
