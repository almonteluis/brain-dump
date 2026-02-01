---
title: "Uncensored LLMs - Comprehensive Guide"
author: "DIY HPL Wiki"
date: 2026-02-01
source: "https://diyhpl.us/wiki/uncensored_LLMs/"
category: ai-research
tags:
  - uncensored
  - llm
  - abliteration
  - ai-safety
  - model-modification
  - local-llm
  - huggingface
  - research
---

# Uncensored LLMs Guide

## Overview

Collection of uncensored large language models and research into removing safety constraints from AI systems. This guide tracks models, researchers, techniques (particularly abliteration), and communities working in this space.

---

## Key Researchers & Organizations

### Dolphin Org (dphn)
- **Website:** https://dphn.ai/
- **Social:** [@dphnAI](https://x.com/dphnAI), [Telegram](https://t.me/dphnAI)
- **HuggingFace:** https://huggingface.co/dphn
- **Key Person:** Eric Hartford [@cognitivecompai](https://x.com/cognitivecompai)

**Notable Models:**
- Dolphin-Mistral-24B-Venice-Edition
- Dolphin X1 405b

### Jinx-org
- **Website:** https://opdoop.github.io/
- **HuggingFace:** https://huggingface.co/Jinx-org
- **Key People:** Jeol, VivianKeith

**Notable Models:**
- Jinx-Qwen3-235B-A22B-Thinking-2507
- Jinx-gpt-oss-20b

### huihui-ai
**Notable Models:**
- Huihui-GLM-4.6V-Flash-abliterated-GGUF (vision model)
- Kimi-K2-abliterated (available on Ollama)
- Huihui-Qwen3-VL-30B-A3B-Instruct-abliterated

### Other Key Researchers
- **tngtech:** DeepSeek-TNG-R1T2-Chimera
- **BeaverAI:** https://huggingface.co/BeaverAI
- **TheDrummer:** https://huggingface.co/TheDrummer (Patreon: https://www.patreon.com/TheDrummer)
- **Sao10K:** https://sao10k.carrd.co/ (Patreon: https://patreon.com/Sao10K)
- **SicariusSicariiStuff**
- **Tarek07**
- **darkc0de:** Uncensored Champions collection

---

## Abliteration Technique

### What is Abliteration?

**Definition:** A technique to remove safety refusal behavior from language models by ablating (deleting) weights pointing in the refusal direction as determined by simple PCA (Principal Component Analysis).

### Key Methods

**1. Basic Abliteration:**
- Delete weights in refusal direction
- Often results in model degradation

**2. Norm-Preserving Biprojected Abliteration (grimjim):**
- Reduces distortion of weights not directly contributing to refusal
- Preserves sphericity of weight space
- Minimizes off-target effects on model behavior
- **Result:** Often ends up MORE intelligent than the original (due to no alignment tax/safety tax)

### Resources
- [Grimjim's Blog Post](https://huggingface.co/blog/grimjim/norm-preserving-biprojected-abliteration)
- [Mlabonne's Abliteration Guide](https://huggingface.co/blog/mlabonne/abliteration)
- [llm-abliteration GitHub](https://github.com/jim-plus/llm-abliteration/)
- [Heretic - Fully automatic censorship removal](https://github.com/p-e-w/heretic)

### Research Papers

**Safety Tax Paper:**
- [Safety alignment makes large reasoning models less reasonable](https://arxiv.org/abs/2503.00555)
- **Finding:** Safety alignment reduces reasoning capability in large models

**Jinx Paper:**
- [Jinx: Unlimited LLMs for probing alignment failures](https://arxiv.org/abs/2508.08243)
- **Purpose:** Unlimited LLMs specifically for researching alignment vulnerabilities

---

## Notable Uncensored Models

### Recent Models (2025-2026)

#### Qwen3-Based
- Jinx-Qwen3-235B-A22B-Thinking-2507
- Huihui-Qwen3-VL-30B-A3B-Instruct-abliterated

#### Gemma-3 Series (Abliterated)
- gemma-3-27b-it-abliterated
- gemma-3-27b-it-abliterated-normpreserve (GGUF versions by multiple creators)
- gemma-3-27b-it-heretic-v2

**Available in GGUF:**
- mlabonne/gemma-3-27b-it-abliterated-GGUF
- YanLabs/gemma-3-27b-it-abliterated-normpreserve-v1-GGUF
- mradermacher/gemma-3-27b-it-abliterated-normpreserve-i1-GGUF

#### DeepSeek-Based
- DeepSeek-TNG-R1T2-Chimera (tngtech)
- TareksGraveyard/L3.3-TRP-BASE-80-70B

#### GLM-Based
- Huihui-GLM-4.6V-Flash-abliterated-GGUF (Vision)

#### GPT-OSS Derivatives
- gpt-oss-20b-Derestricted (ArliAI)
- Jinx-gpt-oss-20b
- gpt-oss-120b (unrestricted model service: https://pingu.audn.ai/)

### Earlier Models
- LLaMA2-13B-Tiefighter (TheBloke)
- LorablatedStock-12B

---

## Benchmarks & Evaluation

### UGI Leaderboard
- **URL:** https://huggingface.co/spaces/DontPlanToEnd/UGI-Leaderboard
- **Feature:** "Uncensored" category for comparing model capabilities

### Lobotomy Quotient
- **URL:** https://lobotomyq.com/
- **Purpose:** Quantifying censorship levels across leading language models
- **Interpretation:** Lower scores = more intact responses, higher scores = more filtering
- **Limitation:** Only 7 models benchmarked (as of 2026-02-01)

---

## Communities & Platforms

### Research Communities
- **r/LocalLLaMA:** https://www.reddit.com/r/LocalLLaMA/
  - Reddit community for local LLM research and development

### Model Hosting
- **HuggingFace:** Primary platform for sharing uncensored models
  - [BeaverAI Collection](https://huggingface.co/BeaverAI)
  - [Uncensored Champions Collection](https://huggingface.co/collections/darkc0de/uncensored-champions)
  - [ReadyArt Models](https://huggingface.co/ReadyArt/)

### Ollama Integration
- Many uncensored models available via Ollama
- Example: ollama.com/huihui_ai/kimi-k2-abliterated

### Image Generation (Related)
- **Civitai:** https://civitai.com
  - Most image generation model tuning and development happens here
  - Shifted from PonyXL to "Illustrious" (late 2025)
- **Chroma:** https://huggingface.co/lodestones/Chroma
  - For furry content (Chroma1-HD for HD)

### Commercial Platforms
- **Venice AI:** https://venice.ai/
  - Uncensored AI platform (project by Erik Voorhees?)
  - Hosts models like "4.2.0-Broken-Tutu-24b"

---

## Key Concepts

### Alignment Tax / Safety Tax
**Definition:** The performance loss that occurs when models are trained to refuse harmful requests.

**Findings:**
- Safety alignment reduces reasoning capability
- Abliterated models (with norm-preserving) often perform BETTER than aligned versions
- Safety constraints can make large reasoning models "less reasonable"

### Refusal Vector / Direction
**Definition:** Specific weight directions in neural networks that encode refusal behavior.

**Abliteration Approach:**
1. Identify refusal direction using PCA
2. Ablate (delete) weights in that direction
3. Preserve other weights to minimize model degradation
4. Norm-preserving method maintains sphericity

### Censorship Quantification
**Lobotomy Quotient (LQ):** Numerical score representing how much a model's outputs are censored or filtered.

**Interpretation:**
- Low LQ = More intact, less filtered responses
- High LQ = More censored, filtered responses

---

## Practical Resources

### Model Discovery
- **Search HuggingFace:** Look for "abliterated", "derestricted", "uncensored" tags
- **UGI Leaderboard:** Compare uncensored models directly
- **Dolphin Org & Jinx-org collections:** High-quality curated models

### GGUF Models (For Local Inference)
Many models available in GGUF format (optimized for CPU inference):
- Various creators (mradermacher, bartowski, YanLabs) provide quantized versions
- Run locally with llama.cpp or other GGUF runners

### Ollama Models
Easy local deployment:
```bash
ollama pull huihui_ai/kimi-k2-abliterated
```

### Abliteration Tools
- [llm-abliteration GitHub](https://github.com/jim-plus/llm-abliteration/) - Script to remove refusals
- [Heretic](https://github.com/p-e-w/heretic) - Fully automatic censorship removal

---

## Connection to Existing Notes

### Related Research
- [[Levels of Energy]] - Understanding consciousness and model behavior
- [[AI Alignment Research]] - Safety alignment and its trade-offs
- [[Local LLM Deployment]] - Running models locally for privacy/control

### Technical Connections
- [[Qwen Models]] - Qwen3 base used by many abliterated models
- [[Gemma Architecture]] - Gemma-3 series recent abliterated versions
- [[GGUF Inference]] - Local inference for quantized models

---

## Ongoing Developments

### 2025-2026 Trends
- **Proliferation:** More researchers and organizations creating abliterated models
- **Quality Improvement:** Norm-preserving methods result in better performance
- **Research Value:** Jinx models specifically designed for alignment research
- **Commercial Platforms:** Venice AI offering uncensored model access

### Research Directions
- Understanding safety tax impact on reasoning
- Probing alignment failures (Jinx paper)
- Quantifying censorship (Lobotomy Quotient)
- Automatic censorship removal (Heretic)

---

## Notes & Caveats

⚠️ **Important Considerations:**
1. **Uncensored ≠ malicious:** Many researchers create these for legitimate research (alignment failure analysis)
2. **Performance gains:** Abliterated models often outperform aligned versions due to removed safety tax
3. **Research necessity:** Understanding censorship mechanisms improves safety alignment
4. **Legal/Ethical:** Use responsibly and in accordance with local laws

**Research Purpose:** Primary value is understanding alignment failures and safety constraints, not for malicious use.

---

## Updated: 2026-02-01
**Source:** DIY HPL Wiki - Uncensored LLMs Collection
**Status:** Actively maintained with new models and research added regularly
