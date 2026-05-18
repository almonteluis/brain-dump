---
description: "Qwen Studio offers comprehensive functionality spanning chatbot, image and video understanding, image generation, document processing, web search inte"
tags: ['research']
source: "https://qwen.ai/blog?id=qwen3.6-27b"
raw_file: "Qwen Studio.md"
created: 2026-05-17
---

![Qwen3.6-27B Main Image](https://qianwen-res.oss-accelerate.aliyuncs.com/Qwen3.6/Figures/3.6_27b_banner.png)

Qwen3.6-27B Main Image

[QWEN STUDIO](https://chat.qwen.ai/) [HUGGING FACE](https://huggingface.co/Qwen/Qwen3.6-27B) [MODELSCOPE](https://modelscope.cn/models/Qwen/Qwen3.6-27B) [DISCORD](https://discord.gg/yPEP2vHTu4)

Following the launch of [Qwen3.6-Plus](https://qwen.ai/blog?id=qwen3.6) and [Qwen3.6-35B-A3B](https://qwen.ai/blog?id=qwen3.6-35b-a3b), we are excited to open-source **Qwen3.6-27B** — a dense 27-billion-parameter multimodal model at the scale the community has been asking for most. Still supporting both multimodal thinking and non-thinking modes, Qwen3.6-27B delivers flagship-level agentic coding performance, **surpassing the previous-generation open-source flagship Qwen3.5-397B-A17B** (397B total / 17B active MoE) across all major coding benchmarks. As a dense architecture, it is straightforward to deploy without MoE routing complexity, making it an ideal choice for developers who need top-tier coding capabilities at a practical, widely-deployable scale. Qwen3.6-27B is now live on Qwen Studio, available through our API, and released as open weights for the community.

- **Qwen3.6-27B** is a fully open-source dense model (27B parameters), featuring:
	- flagship-level agentic coding that surpasses Qwen3.5-397B-A17B
		- strong text and multimodal reasoning ability
- You can chat interactively on [Qwen Studio](https://chat.qwen.ai/), call via API on [Alibaba Cloud Model Studio API](https://modelstudio.alibabacloud.com/) (coming soon), or download weights from [Hugging Face](https://huggingface.co/Qwen/Qwen3.6-27B) and [ModelScope](https://modelscope.cn/models/Qwen/Qwen3.6-27B).
![](https://qianwen-res.oss-cn-beijing.aliyuncs.com/Qwen3.6/Figures/qwen3.6_27b_score.png)

## Performance

Below we present comprehensive evaluations of Qwen3.6-27B against both dense and MoE baselines, including our previous-generation open-source flagship Qwen3.5-397B-A17B. Qwen3.6-27B delivers remarkable improvements across agentic coding benchmarks, surpassing models with up to 15x its total parameter count.

### Language

Qwen3.6-27B achieves a breakthrough in agentic coding for dense models. With only 27B parameters, it outperforms the Qwen3.5-397B-A17B (397B total / 17B active) on every major coding benchmark — including SWE-bench Verified (77.2 vs. 76.2), SWE-bench Pro (53.5 vs. 50.9), Terminal-Bench 2.0 (59.3 vs. 52.5), and SkillsBench (48.2 vs. 30.0). It also surpasses all peer-scale dense models by a wide margin. On reasoning tasks, Qwen3.6-27B achieves 87.8 on GPQA Diamond, competitive with models several times its size.

<table><thead><tr><th></th><th>Qwen3.5-27B</th><th>Qwen3.5-397B-A17B</th><th>Gemma4-31B</th><th>Claude 4.5 Opus</th><th>Qwen3.6-35B-A3B</th><th>Qwen3.6-27B</th></tr></thead><tbody><tr><td colspan="7">Coding Agent</td></tr><tr><td>SWE-bench Verified</td><td>75.0</td><td>76.2</td><td>52.0</td><td>80.9</td><td>73.4</td><td>77.2</td></tr><tr><td>SWE-bench Pro</td><td>51.2</td><td>50.9</td><td>35.7</td><td>57.1</td><td>49.5</td><td>53.5</td></tr><tr><td>SWE-bench Multilingual</td><td>69.3</td><td>69.3</td><td>51.7</td><td>77.5</td><td>67.2</td><td>71.3</td></tr><tr><td>Terminal-Bench 2.0</td><td>41.6</td><td>52.5</td><td>42.9</td><td>59.3</td><td>51.5</td><td>59.3</td></tr><tr><td>SkillsBench <sub><small>Avg5</small></sub></td><td>27.2</td><td>30.0</td><td>23.6</td><td>45.3</td><td>28.7</td><td>48.2</td></tr><tr><td>QwenWebBench</td><td>1068</td><td>1186</td><td>1197</td><td>1536</td><td>1397</td><td>1487</td></tr><tr><td>NL2Repo</td><td>27.3</td><td>32.2</td><td>15.5</td><td>43.2</td><td>29.4</td><td>36.2</td></tr><tr><td>Claw-Eval <sub><small>Avg</small></sub></td><td>64.3</td><td>70.7</td><td>48.5</td><td>76.6</td><td>68.7</td><td>72.4</td></tr><tr><td>Claw-Eval <sub><small>Pass^3</small></sub></td><td>46.2</td><td>48.1</td><td>25.0</td><td>59.6</td><td>50.0</td><td>60.6</td></tr><tr><td>QwenClawBench</td><td>52.2</td><td>51.8</td><td>41.7</td><td>52.3</td><td>52.6</td><td>53.4</td></tr><tr><td colspan="7">Knowledge</td></tr><tr><td>MMLU-Pro</td><td>86.1</td><td>87.8</td><td>85.2</td><td>89.5</td><td>85.2</td><td>86.2</td></tr><tr><td>MMLU-Redux</td><td>93.2</td><td>94.9</td><td>93.7</td><td>95.6</td><td>93.3</td><td>93.5</td></tr><tr><td>SuperGPQA</td><td>65.6</td><td>70.4</td><td>65.7</td><td>70.6</td><td>64.7</td><td>66.0</td></tr><tr><td>C-Eval</td><td>90.5</td><td>93.0</td><td>82.6</td><td>92.2</td><td>90.0</td><td>91.4</td></tr><tr><td colspan="7">STEM & Reasoning</td></tr><tr><td>GPQA Diamond</td><td>85.5</td><td>88.4</td><td>84.3</td><td>87.0</td><td>86.0</td><td>87.8</td></tr><tr><td>HLE</td><td>24.3</td><td>28.7</td><td>19.5</td><td>30.8</td><td>21.4</td><td>24.0</td></tr><tr><td>LiveCodeBench v6</td><td>80.7</td><td>83.6</td><td>80.0</td><td>84.8</td><td>80.4</td><td>83.9</td></tr><tr><td>HMMT Feb 25</td><td>92.0</td><td>94.8</td><td>88.7</td><td>92.9</td><td>90.7</td><td>93.8</td></tr><tr><td>HMMT Nov 25</td><td>89.8</td><td>92.7</td><td>87.5</td><td>93.3</td><td>89.1</td><td>90.7</td></tr><tr><td>HMMT Feb 26</td><td>84.3</td><td>87.9</td><td>77.2</td><td>85.3</td><td>83.6</td><td>84.3</td></tr><tr><td>IMOAnswerBench</td><td>79.9</td><td>80.9</td><td>74.5</td><td>84.0</td><td>78.9</td><td>80.8</td></tr><tr><td>AIME26</td><td>92.6</td><td>93.3</td><td>89.2</td><td>95.1</td><td>92.7</td><td>94.1</td></tr></tbody></table>

\* SWE-Bench Series: Internal agent scaffold (bash + file-edit tools); temp=1.0, top\_p=0.95, 200K context window. We correct some problematic tasks in the public set of SWE-bench Pro and evaluate all baselines on the refined benchmark.  
\* Terminal-Bench 2.0: Harbor/Terminus-2 harness; 3h timeout, 32 CPU/48 GB RAM; temp=1.0, top\_p=0.95, top\_k=20, max\_tokens=80K, 256K ctx; avg of 5 runs.  
\* SkillsBench: Evaluated via OpenCode on 78 tasks (self-contained subset, excluding API-dependent tasks); avg of 5 runs.  
\* NL2Repo: Others are evaluated via Claude Code (temp=1.0, top\_p=0.95, max\_turns=900).  
\* QwenClawBench: A real-user-distribution Claw agent benchmark; temp=0.6, 256K ctx.  
\* QwenWebBench: An internal front-end code generation benchmark; bilingual (EN/CN), 7 categories (Web Design, Web Apps, Games, SVG, Data Visualization, Animation, and 3D); auto-render + multimodal judge (code/visual correctness); BT/Elo rating system.  
\* AIME 26: We use the full AIME 2026 (I & II), where the scores may differ from Qwen 3.5 notes.

### Vision Language

Qwen3.6-27B is natively multimodal, supporting both vision-language thinking and non-thinking modes in a single unified checkpoint — the same as Qwen3.6-35B-A3B. It handles images and video alongside text, enabling multimodal reasoning, document understanding, and visual question answering.

<table><thead><tr><th></th><th>Qwen3.5-27B</th><th>Qwen3.5-397B-A17B</th><th>Gemma4-31B</th><th>Claude 4.5 Opus</th><th>Qwen3.6-35B-A3B</th><th>Qwen3.6-27B</th></tr></thead><tbody><tr><td colspan="7">STEM & Puzzle</td></tr><tr><td>MMMU</td><td>82.3</td><td>85.0</td><td>80.4</td><td>80.7</td><td>81.7</td><td>82.9</td></tr><tr><td>MMMU-Pro</td><td>75.0</td><td>79.0</td><td>76.9</td><td>70.6</td><td>75.3</td><td>75.8</td></tr><tr><td>MathVista <sub><small>mini</small></sub></td><td>87.8</td><td>--</td><td>79.3</td><td>--</td><td>86.4</td><td>87.4</td></tr><tr><td>DynaMath</td><td>87.7</td><td>86.3</td><td>79.5</td><td>79.7</td><td>82.8</td><td>85.6</td></tr><tr><td>VlmsAreBlind</td><td>96.9</td><td>--</td><td>87.2</td><td>--</td><td>96.6</td><td>97.0</td></tr><tr><td colspan="7">General VQA</td></tr><tr><td>RealWorldQA</td><td>83.7</td><td>83.9</td><td>72.3</td><td>77.0</td><td>85.3</td><td>84.1</td></tr><tr><td>MMStar</td><td>81.0</td><td>83.8</td><td>77.3</td><td>73.2</td><td>80.7</td><td>81.4</td></tr><tr><td>MMBench <sub><small>EN-DEV-v1.1</small></sub></td><td>92.6</td><td>--</td><td>90.9</td><td>--</td><td>92.8</td><td>92.3</td></tr><tr><td>SimpleVQA</td><td>56.0</td><td>67.1</td><td>52.9</td><td>65.7</td><td>58.9</td><td>56.1</td></tr><tr><td colspan="7">Document Understanding</td></tr><tr><td>CharXiv <sub><small>RQ</small></sub></td><td>79.5</td><td>80.8</td><td>67.9</td><td>68.5</td><td>78.0</td><td>78.4</td></tr><tr><td>CC-OCR</td><td>81.0</td><td>82.0</td><td>75.7</td><td>76.9</td><td>81.9</td><td>81.2</td></tr><tr><td>OCRBench</td><td>89.4</td><td>--</td><td>86.1</td><td>--</td><td>90.0</td><td>89.4</td></tr><tr><td colspan="7">Spatial Intelligence</td></tr><tr><td>ERQA</td><td>60.5</td><td>67.5</td><td>57.5</td><td>46.8</td><td>61.8</td><td>62.5</td></tr><tr><td>CountBench</td><td>97.8</td><td>97.2</td><td>96.1</td><td>90.6</td><td>96.1</td><td>97.8</td></tr><tr><td>RefCOCO <sub><small>avg</small></sub></td><td>90.9</td><td>92.3</td><td>--</td><td>--</td><td>92.0</td><td>92.5</td></tr><tr><td>EmbSpatialBench</td><td>84.5</td><td>--</td><td>--</td><td>--</td><td>84.3</td><td>84.6</td></tr><tr><td>RefSpatialBench</td><td>67.7</td><td>--</td><td>4.7</td><td>--</td><td>64.3</td><td>70.0</td></tr><tr><td colspan="7">Video Understanding</td></tr><tr><td>VideoMME <sub><small>(w sub.)</small></sub></td><td>87.0</td><td>87.5</td><td>--</td><td>77.7</td><td>86.6</td><td>87.7</td></tr><tr><td>VideoMMMU</td><td>82.3</td><td>84.7</td><td>81.6</td><td>84.4</td><td>83.7</td><td>84.4</td></tr><tr><td>MLVU</td><td>85.9</td><td>86.7</td><td>--</td><td>81.7</td><td>86.2</td><td>86.6</td></tr><tr><td>MVBench</td><td>74.6</td><td>77.6</td><td>--</td><td>67.2</td><td>74.6</td><td>75.5</td></tr><tr><td colspan="7">Visual Agent</td></tr><tr><td>V*</td><td>93.7</td><td>95.8</td><td>--</td><td>67.0</td><td>90.1</td><td>94.7</td></tr><tr><td>AndroidWorld</td><td>64.2</td><td>--</td><td>--</td><td>--</td><td>--</td><td>70.3</td></tr></tbody></table>

\* Empty cells (--) indicate scores not yet available or not applicable.

## Build with Qwen3.6-27B

Qwen3.6-27B is coming soon to Alibaba Cloud Model Studio. Please stand by until we are fully ready.

Qwen3.6-27B is available as open weights on [Hugging Face](https://huggingface.co/Qwen/Qwen3.6-27B) and [ModelScope](https://modelscope.cn/models/Qwen/Qwen3.6-27B) for self-hosting, and through the [Alibaba Cloud Model Studio](https://modelstudio.alibabacloud.com/) API. You can also try it instantly on [Qwen Studio](https://chat.qwen.ai/).

The model can be seamlessly integrated with popular third-party coding assistants, including OpenClaw, Claude Code, and Qwen Code, to streamline development workflows and enable efficient, context-aware coding experiences.

### API Usage

This release supports the `preserve_thinking` feature: preserving thinking content from all preceding turns in messages, which is **recommended for agentic tasks**.

#### Alibaba Cloud Model Studio

Alibaba Cloud Model Studio supports industry-standard protocols, including chat completions and responses APIs compatible with OpenAI’s specification, as well as an API interface compatible with Anthropic.

Example code for chat completions API is provided below:

```
python"""
Environment variables (per official docs):
  DASHSCOPE_API_KEY: Your API Key from https://modelstudio.console.alibabacloud.com
  DASHSCOPE_BASE_URL: (optional) Base URL for compatible-mode API.
    - Beijing: https://dashscope.aliyuncs.com/compatible-mode/v1
    - Singapore: https://dashscope-intl.aliyuncs.com/compatible-mode/v1
    - US (Virginia): https://dashscope-us.aliyuncs.com/compatible-mode/v1
  DASHSCOPE_MODEL: (optional) Model name; override for different models.
"""
from openai import OpenAI
import os
api_key = os.environ.get("DASHSCOPE_API_KEY")
if not api_key:
    raise ValueError(
        "DASHSCOPE_API_KEY is required. "
        "Set it via: export DASHSCOPE_API_KEY='your-api-key'"
    )
client = OpenAI(
    api_key=api_key,
    base_url=os.environ.get(
        "DASHSCOPE_BASE_URL",
        "https://dashscope-intl.aliyuncs.com/compatible-mode/v1",
    ),
)
messages = [{"role": "user", "content": "Introduce vibe coding."}]
model = os.environ.get(
    "DASHSCOPE_MODEL",
    "qwen3.6-27b",
)
completion = client.chat.completions.create(
    model=model,
    messages=messages,
    extra_body={
        "enable_thinking": True,
        # "preserve_thinking": True,
    },
    stream=True
)
reasoning_content = ""  # Full reasoning trace
answer_content = ""  # Full response
is_answering = False  # Whether we have entered the answer phase
print("\n" + "=" * 20 + "Reasoning" + "=" * 20 + "\n")
for chunk in completion:
    if not chunk.choices:
        print("\nUsage:")
        print(chunk.usage)
        continue
    delta = chunk.choices[0].delta
    # Collect reasoning content only
    if hasattr(delta, "reasoning_content") and delta.reasoning_content is not None:
        if not is_answering:
            print(delta.reasoning_content, end="", flush=True)
        reasoning_content += delta.reasoning_content
    # Received content, start answer phase
    if hasattr(delta, "content") and delta.content:
        if not is_answering:
            print("\n" + "=" * 20 + "Answer" + "=" * 20 + "\n")
            is_answering = True
        print(delta.content, end="", flush=True)
        answer_content += delta.content
```

For more information, please visit the [API doc](https://modelstudio.console.alibabacloud.com/?tab=doc#/doc/?type=model&url=2840915).

### Coding & Agents

Qwen3.6-27B features excellent agentic coding capabilities and can be seamlessly integrated into popular third-party coding assistants, including OpenClaw, Claude Code, and Qwen Code.

#### OpenClaw

Qwen3.6-27B is compatible with [OpenClaw](https://openclaw.ai/) (formerly Moltbot / Clawdbot), a self-hosted open-source AI coding agent. Connect it to [Model Studio](https://www.alibabacloud.com/help/en/model-studio/openclaw) to get a full agentic coding experience in the terminal. Get started with the following script:

```
bash# Node.js 22+
curl -fsSL https://molt.bot/install.sh | bash   # macOS / Linux
# Set your API key
export DASHSCOPE_API_KEY=<your_api_key>
# Launch OpenClaw
openclaw dashboard # web browser
# openclaw tui # Open a new terminal and start the TUI
```

On first use, edit `~/.openclaw/openclaw.json` to point OpenClaw at Model Studio. Find or create the following fields and merge them — **do not overwrite the entire file** to preserve your existing settings:

```
json{
  "models": {
    "mode": "merge",
    "providers": {
      "modelstudio": {
        "baseUrl": "https://dashscope-intl.aliyuncs.com/compatible-mode/v1",
        "apiKey": "DASHSCOPE_API_KEY",
        "api": "openai-completions",
        "models": [
          {
            "id": "qwen3.6-27b",
            "name": "qwen3.6-27b",
            "reasoning": true,
            "input": ["text", "image"],
            "contextWindow": 131072,
            "maxTokens": 16384
          }
        ]
      }
    }
  },
  "agents": {
    "defaults": {
      "model": {
        "primary": "modelstudio/qwen3.6-27b"
      },
      "models": {
        "modelstudio/qwen3.6-27b": {}
      }
    }
  }
}
```

#### Qwen Code

Qwen3.6-27B is compatible with [Qwen Code](https://qwen.ai/qwencode), an open-source AI agent designed for the terminal and deeply optimized for the Qwen Series. Get started with the following script:

```
bash# Node.js 20+
npm install -g @qwen-code/qwen-code@latest
# Start Qwen Code (interactive)
qwen
# Then, in the session:
/help
/auth
```

On first use, you’ll be prompted to sign in. You can run `/auth` anytime to switch authentication methods.

#### Claude Code

Qwen APIs also support the Anthropic API protocol, meaning you can use it with tools like **Claude Code** for elevated coding experience:

```
bash# Install Claude Code
npm install -g @anthropic-ai/claude-code
# Configure environment
export ANTHROPIC_MODEL="qwen3.6-27b"
export ANTHROPIC_SMALL_FAST_MODEL="qwen3.6-27b"
export ANTHROPIC_BASE_URL=https://dashscope-intl.aliyuncs.com/apps/anthropic
export ANTHROPIC_AUTH_TOKEN=<your_api_key>
# Launch the CLI
claude
```

## Summary

Qwen3.6-27B demonstrates that a well-trained dense model can surpass much larger predecessors on the tasks that matter most for developers. At 27 billion parameters — the most widely deployed open-source scale — it outperforms the 397B-parameter Qwen3.5-397B-A17B on every major agentic coding benchmark, while remaining straightforward to deploy and serve. With Qwen3.6-27B joining the roster, the Qwen3.6 open-source family now offers a comprehensive range of models, underscoring a generation where agentic coding achieved breakthroughs across every scale — from the 3B-active Qwen3.6-35B-A3B to the API-accessible Qwen3.6-Plus and Qwen3.6-Max-Preview. We are grateful for the community’s feedback and look forward to seeing what you build with these models. Stay tuned for more from the Qwen team!

## Citation

Feel free to cite the following article if you find Qwen3.6-27B helpful:

```
bibtex@misc{qwen36_27b,
    title = {{Qwen3.6-27B}: Flagship-Level Coding in a 27B Dense Model},
    url = {https://qwen.ai/blog?id=qwen3.6-27b},
    month = {April},
    year = {2026}
}
```
