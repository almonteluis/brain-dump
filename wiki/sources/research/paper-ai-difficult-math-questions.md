---
description: "paper-ai-difficult-math-questions"
tags: ['research', 'paper', 'education-research']
raw_file: "paper-ai-difficult-math-questions.md"
created: 2026-05-17
---

## One-line signal
An AI-assisted pipeline can generate math questions that require combining multiple skills (MATH²), producing problems where even advanced models perform at roughly the square of their original accuracy — demonstrating scalable generation of genuinely difficult problems.

## Core ideas
- Proposes a pipeline using LLMs to generate math questions that require combining two distinct mathematical skills
- Created MATH² dataset from skills extracted from the original MATH dataset (Hendrycks et al., 2021)
- All tested models showed significantly lower performance on MATH² than on original MATH — an LLM's success rate on MATH² is roughly the square of its success rate on MATH
- Using MATH² exemplars as in-context examples improved model performance on the original MATH by up to 13.72% (Llama-3.1-70B)
- Methodology applicable beyond mathematics to other domains requiring structured reasoning
- Addresses the scarcity of diverse, challenging math questions for training and evaluation
- Key challenge: generating plausible distractors and incorrect reasoning paths that still test the right skills

## Why this matters for the Three-Ring project
Provides a concrete technical approach for generating appropriately challenging math problems at scale. Three-Ring could use similar multi-skill combination techniques to create problems calibrated to each student's level — hard enough to induce productive struggle but not so hard they become frustrating. The skill-combination approach naturally supports deliberate practice by targeting specific skill gaps.

[[paper-productive-struggle-ai-bellwether]] [[paper-productive-struggle-students]] [[paper-genai-math-meta-analysis-2026]]
