---
description: "research-session-notes-2026-05-09"
tags: ['research']
raw_file: "research-session-notes-2026-05-09.md"
created: 2026-05-17
---

# Research Session Notes — 2026-05-09

## What We Tried & What Happened

### Semantic Scholar API
- **Hit hard by rate limiting (HTTP 429)** after just a few requests
- **Root cause**: No API key configured — unauthenticated rate limit is ~1 req/sec, and we were firing bursts
- **What worked**: Gamification + math education queries and math anxiety interventions returned results before getting locked out
- **What didn't**: Anything after the first few queries got 429'd for the rest of the session
- **Fix needed**: Get a Semantic Scholar API key (free) from https://www.semanticscholar.org/product/api#api-key — raises limit to 100 req/5min

### arXiv API
- **Problem**: Using `all:` prefix was too broad — returned unrelated ML/AI papers instead of education research
- **Education papers on arXiv are rare** — most ed research goes through ERIC, not arXiv
- **Fix**: Use specific category filters (`cs.HC`, `cs.CY`) and tighter keyword combos instead of `all:`

### Google Scholar (web)
- **Blocked by bot detection** — browser got captcha'd
- **No fix without residential proxies** — not worth it for now

### ERIC Database
- **Successfully loaded** search results page (~47K results for broad education queries)
- **Results were not scraped/parsed** — session ended before extraction
- **Descriptors found**: "High School Students" (12,962), "Middle School Students" (7,375), "Student Attitudes" (9,071)
- **Fix**: Use ERIC's public API (https://api.ies.ed.gov/eric/) instead of browser scraping

### Brave Search
- **No API key configured** in Hermes config (`search_backend: ''`)
- Web search fell back to a less capable backend
- **Fix**: Add Brave Search API key to Hermes config

### General Lessons
1. **Pace API calls** — 1-2 second delays between requests
2. **Batch queries strategically** — don't fire 10 queries at once
3. **Use delegate_task for parallel research** but split work to avoid shared rate limits
4. **Prioritize free APIs with higher limits** (ERIC, Google Scholar via web search) over limited ones
5. **Save intermediate results** as Obsidian notes before attempting more queries — don't wait until the end

## Papers Already Found (from previous session)

### Gamification + Math Education
- Moreira Parrales et al. (2024) — "Gamification for learning mathematics in secondary school" (6 cites)
- Origenes et al. (2025) — Meta-analysis of gamification effects on math learning
- Susilawati et al. (2025) — Integrating RME, AI, and gamification for motivation
- Malvasi et al. (2022) — Gamification and serious games in Italian secondary math (19 cites)
- Hossein-Mohand et al. (2021) — Flipped Learning + gamification in secondary math (76 cites)

### Math Anxiety Interventions
- Wang & Wei (2025) — Gen-AI assisted learning reducing primary students' math anxiety
- Schmitz et al. (2023) — Cognitive biases and math anxiety in adolescents
- Wang et al. (2024) — Parenting styles, self-control, and math anxiety

## Gaps Still To Cover
- Self-Determination Theory (SDT) applications in math
- Expectancy-Value Theory in secondary math motivation
- Growth Mindset interventions in math classrooms
- Math Identity formation in middle/high school
- Achievement Goal Orientation
- Spaced repetition for math facts
- Goal-gradient hypothesis in education
