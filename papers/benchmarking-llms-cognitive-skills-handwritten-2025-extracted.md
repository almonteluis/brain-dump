---
source_file: "benchmarking-llms-cognitive-skills-handwritten-2025.pdf"
type: paper
---

# benchmarking-llms-cognitive-skills-handwritten-2025

Preprint. Under review.
Investigating Large Language Models in Diagnosing Students’
Cognitive Skills in Math Problem-solving
Hyoungwook Jin, Yoonsu Kim, Dongyun Jung, Seungju Kim & Juho Kim
School of Computing, KAIST
Daejeon, Republic of Korea
{jinhw,yoonsu16,djung2023,sjkim64891,juhokim}@kaist.ac.kr
Kiyoon Choi & Jinho Son
AlgorithmLabs
Seoul, Republic of Korea
{chlrldbs1,sjhfam}@algorithmlabs.co.kr
Abstract
Mathematics learning entails mastery of both content knowledge and cog-
nitive processing of knowing, applying, and reasoning with it. Automated
math assessment primarily has focused on grading students’ exhibition
of content knowledge by finding textual evidence, such as specific num-
bers, formulas, and statements. Recent advancements in problem-solving,
image recognition, and reasoning capabilities of large language models
(LLMs) show promise for nuanced evaluation of students’ cognitive skills.
Diagnosing cognitive skills needs to infer students’ thinking processes
beyond textual evidence, which is an underexplored task in LLM-based
automated assessment. In this work, we investigate how state-of-the-art
LLMs diagnose students’ cognitive skills in mathematics. We constructed
MATHCOG, a novel benchmark dataset comprising 639 student responses
to 110 expert-curated middle school math problems, each annotated with
detailed teachers’ diagnoses based on cognitive skill checklists. Using
MATHCOG, we evaluated 16 closed and open LLMs of varying model sizes
and vendors. Our evaluation reveals that even the state-of-the-art LLMs
struggle with the task, all F1 scores below 0.5, and tend to exhibit strong
false confidence for incorrect cases (rs = .617). We also found that model
size positively correlates with the diagnosis performance (rs = .771). Fi-
nally, we discuss the implications of these findings, the overconfidence
issue, and directions for improving automated cognitive skill diagnosis.
1
Introduction
Automatic assessment of students’ responses to mathematical problems can support learn-
ing at scale. Assessment can serve as feedback to guide students through problem-solving
processes, allowing them to refine their reasoning and correct misconceptions as they arise.
As teachers’ manual assessment is limited in scale and availability (Stankous, 2016), auto-
mated assessment is particularly instrumental in environments where human instructors
are unavailable or where student-to-teacher ratios are too high (e.g., MOOCs).
The advancement in AI technologies has expanded the automatic assessment to evaluate
more complicated forms of student responses. While early automated assessment methods
worked on grading categorical multiple-choice questions, current multimodal and reason-
ing AI models (e.g., GPT-o1) can process handwritten responses to constructed response
questions (Gao et al., 2024; Liu et al., 2024; Chamieh et al., 2024; Baral et al., 2023). As
opposed to multiple choices and short answers, these students’ handwritten constructed
responses capture students’ thinking processes (Livingston, 2009).
1
arXiv:2504.00843v1  [cs.AI]  1 Apr 2025


Preprint. Under review.
Evaluating students’ constructed responses with AI presents a promising opportunity to
diagnose their cognitive skills at scale. Cognitive skills are the abilities to know, apply, and
reason mathematical concepts and formulas (Mullis, 2017). Unlike traditional grading that
focuses primarily on final answers, cognitive diagnosis enables more granular feedback
by identifying where a student’s thinking process may have broken down (Jin et al., 2024;
Rahbarnia et al., 2014; Kheong, 1994). For instance, such evaluation can reveal whether a
student successfully recalled relevant concepts, represented a problem with an appropriate
model, determined a reasonable strategy, and implemented it correctly. These cognitive
skills (Mullis, 2017) (complete list in Table 3) often manifest in varied ways through texts
and graphics and in subtle ways without overt evidence in students’ responses.
However, such an in-depth diagnosis is challenging because AI models need to understand
complicated handwritten responses and need to infer students’ thinking processes beyond
visible cues. This diagnosis task involves perceiving graphics in students’ responses, inter-
preting mathematical notations, and reasoning about students’ problem-solving processes.
Existing work has focused on examining AI models’ performance on each of these capa-
bilities in math problem-solving (Didolkar et al., 2024; Fang et al., 2024; Ahn et al., 2024),
multimodal perception (Zhang et al., 2024b;a), and reasoning (Wang et al., 2023; Hao et al.,
2024) in diverse domains. Whereas previous research has asked how well LLMs can emulate
human cognition, our task inverts that perspective, challenging models to infer humans’
logical cognition from partial visual and textual evidence. The diagnosis task is precisely
the intersection of these capabilities that makes it particularly complex for current LLMs.
In this work, we investigate how well existing LLMs diagnose students’ cognitive skills in
mathematics. Specifically, we address two research questions:
RQ1. How accurately do state-of-the-art LLMs diagnose students’ cognitive skills?
RQ2. How do multimodal input, reasoning, and model size influence LLMs’ cognitive
skill diagnosis?
To answer these questions, we constructed MATHCOG, a benchmark dataset designed
to evaluate cognitive skill diagnosis. In collaboration with 5 education experts and 15
middle school teachers, we curated 12 middle school math problems, each with 50 student
responses diagnosed by teachers based on a diagnostic checklist. Each checklist is based
on a well-founded diagnosis framework (Mullis, 2017) and consists of 4 to 6 cognitive skill
check items (see Table 1).
Using MATHCOG, we evaluated the performance of 16 distinct closed and open models.
Given the math problem, answer, OCR transcribed student response, and diagnostic check-
list, we prompted LLMs to answer, with a Chain of Thought (Wei et al., 2022), the check
items. For RQ1, we tested the state-of-the-art LLMs from the GPT, Llama, Claude, Gemini,
and DeepSeek series. We found that the LLMs perform poorly on the task (all scored F1
below 0.5), and the accurate models tend to have high false confidence when they are wrong
(rs = .617). For RQ2, we compared LLMs with different capabilities and prompting settings.
We found that providing handwritten images in addition to OCR transcription or using
reasoning-oriented LLMs has a subtle impact on diagnosis performance. In contrast, the
model size has a strong correlation with the F1 score (rs = .771). Our contributions to COLM
are:
• Creating a benchmark dataset for evaluating cognitive skill diagnosis perfor-
mance, MATHCOG, composed of expert-reviewed diagnostic checklists and teacher-
diagnosed results for 639 student responses across 12 middle school math problems.
• Examining the performance of 16 state-of-the-art closed and open LLMs on diag-
nosing students’ cognitive skills using MATHCOG.
• Investigating the impact of multimodal input, reasoning, and model size on the
cognitive skill diagnosis task through a comparison study.
2


Preprint. Under review.
2
Related Work
We review the foundational framework underlying our cognitive diagnosis task, followed
by prior investigations into LLMs’ performance in math-related contexts, and existing
benchmarks, highlighting both their relevance and current gaps.
2.1
Cognitive Diagnosis in Mathematics Education
The TIMSS (Trends in International Mathematics and Science Study) framework (Mullis,
2017) provides a comprehensive and mathematics-specific approach to cognitive diagnosis,
comprising content and cognitive domains. The cognitive domain, which evaluates knowl-
edge application, is divided into three key areas: Knowing (recalling definitions, recognizing
mathematical entities, computing operations), Applying (determining strategies, representing
problems, implementing solutions), and Reasoning (analyzing, integrating, evaluating, justi-
fying). While other frameworks like Bloom’s taxonomy (Bloom et al., 1956) and Polya’s
problem-solving framework (Polya, 1957) exist, TIMSS’s mathematics-specific approach,
validated through its extensive use across approximately 70 countries since 1995 (Mullis
et al., 2023), provides more targeted and reliable guidance for assessing students’ math-
ematical thinking. Our cognitive skill diagnosis task is founded on this framework that
provides deeper insights into students’ mathematical thinking processes, addresses limi-
tations of knowledge-centered assessments, and offers specific guidelines for educational
interventions.
2.2
LLM Capabilities in Mathematical Tasks
LLMs have shown significant progress in mathematical problem-solving, with advanced
models achieving improved reasoning capabilities through reinforcement learning (Guo
et al., 2025; OpenAI, 2024; Zhong et al., 2024). While larger models and Chain-of-Thought
prompting further enhance mathematical reasoning capabilities (Li et al., 2024; Yang et al.,
2024a; Wei et al., 2022), current models still struggle with multimodal inputs such as visual
elements and handwritten content (Zhang et al., 2024b; Baral et al., 2025; Liu et al., 2024).
Although domain-specific models like MathGLM-Vision (Yang et al., 2024b) show promise
in addressing these challenges, their performance remains limited by data scarcity (Yan
et al., 2024). Beyond direct problem-solving, LLMs need metacognitive abilities to evaluate
student responses and identify misconceptions (Baral et al., 2024; Kaggle & Eedi, 2020), yet
current research focuses mainly on basic error identification rather than complex cognitive
diagnosis. We address a critical gap in the field by providing a comprehensive evaluation
of LLMs’ ability to track thinking processes and assess cognitive abilities in mathematical
contexts.
2.3
Benchmarks for Evaluating Mathematical Tasks
A diverse array of benchmarks exists for evaluating LLMs’ mathematical capabilities, in-
cluding GSM8K (Cobbe et al., 2021) for elementary school problems, MATH (Hendrycks
et al., 2021) for high school competition questions, MathOdyssey (Fang et al., 2024), and
DeepMind’s Mathematics dataset (Saxton et al., 2019). In the educational domain, special-
ized assessments have emerged, such as MathFish (Lucy et al., 2024), which aligns 9,900
problems with 385 K-12 standards to evaluate models’ capacity to recognize specific skills
and concepts, along with handwriting recognition (Baral et al., 2025) and misconception
detection in MCQs (Kaggle & Eedi, 2020). However, with few exceptions like (Hellman et al.,
2023), there is a notable gap in datasets designed for cognitive diagnosis in open-ended
responses. While existing research has mainly focused on simple error identification and
scoring, the diagnosis of students’ complex cognitive processes in open-ended questions has
been relatively less explored. For our novel cognitive skill diagnosis task, we constructed a
dataset that supports a comprehensive evaluation of LLMs’ ability to track implicit thinking
processes, identify root causes of errors, and assess students’ cognitive abilities.
3


Preprint. Under review.
3
Dataset: MATHCOG
To evaluate LLMs’ performance on the cognitive skill diagnosis, we first created a bench-
mark dataset composed of secondary school math problems, student responses, diagnostic
checklists, and verdicts (Table 1). The math problem and student response data are from
AI-Hub1, which contains 5,932 K-12 math problem types and 147,882 handwritten student
response images labeled with OCR transcriptions. Each problem type has 5 to 7 isomorphic
problems that have the same problem-solving procedures and differ only in the numbers in
the problem description (e.g., “Solve x2 + 2x −3 = 0” and “Solve x2 + x −2 = 0”). Among
the data, we chose the problem types and student responses corresponding to grades 7-9,
as the problems were complex enough to elicit cognitive processes. Among 2,605 problem
types from grades 7 to 9, we excluded the problem types that had fewer than 50 student
responses to ensure that we had enough student responses to use in our performance eval-
uation. Finally, we manually reviewed the remaining 35 problem types and removed the
problem types whose corresponding isomorphic problems require different mathematical
knowledge (e.g., “Solve x2 + 2x −3 = 0” (quadratic) vs. “Solve x3 + 4x −1 = 0” (trino-
mial)). The filtering process left us with 137 problems and 796 student responses from 15
problem types, each involving the same mathematical knowledge and problem-solving
procedures. The specific numbers at each stage of filtering are shown in Figure 1.
Figure 1: The dataset creation process and the number of problem types, problems, and
student responses at each filtering stage.
3.1
Diagnostic Checklist
For each problem type, we made a diagnostic checklist commonly applicable to isomorphic
problems. These checklists are a list of binary question items mapped to one of the 15
cognitive skills defined in the TIMSS 2019 assessment framework (Mullis, 2017). The authors
initially drafted the checklist items and refined them by requesting a review from five math
curriculum and evaluation experts with PhD degrees in education and practical experience
in making math assessment guidelines (e.g., TIMSS, Korean public school curriculum).
Experts gave feedback on the clarity, granularity, and validity of the checklist items. For
example, the experts suggested changing “square root term” into “irrational term” for
generality and combining items like “Were coefficients calculated correctly?” and “Were
addition and subtraction performed correctly?” into “Were the addition and subtraction
calculations of coefficients performed accurately?” for reasonable granularity: specific
enough to describe a distinct skill, yet general enough to accommodate diverse forms of
valid evidence. The experts also commented on the skills each problem can or cannot
assess. Experts pointed out that our math problems primarily focus on calculating numbers
and applying knowledge and, hence, are limited in assessing “reasoning” (e.g., justifying,
analyzing, generalizing) (Mullis, 2017) by their design. We scoped our check items to
“knowing” and “applying” cognitive domains only. We took two iterations to refine the
checklists, and each checklist was reviewed by two experts independently in each iteration.
1https://www.aihub.or.kr
4


Preprint. Under review.
Problem
Student Response
Diagnostic Checklist
Verdict
When P =
√
3
−7
√
5 + 2
√
3,
Q = 2
√
3 −
√
5
+2
√
5, find the
value of P + Q.
Recognize: Does the student
realize that if the numbers in
the radicals are the same, he
or she can perform the four
arithmetic operations on the
coefficients with the same
letters?
Vague
Yes
Compute: Were the addition
and subtraction calculations
of coefficients performed
accurately?
Evident
Yes
Determine: Does the student
choose a strategy to first
simply organize each equation
(e.g., put
√
5 terms together,
etc.) and then find the final
sum?
Evident
No
There is a trapezoid
with a lower side
length of 8 cm
and a height of 4
cm. If the area of
this trapezoid is not
less than 28 cm2,
find how much
more cm the length
of the upper side of
the trapezoid must be.
Recall: Does the student
remember the formula for
the area of a shape correctly
(e.g., the formula for the area
of a trapezoid)?
Evident
Yes
Compute: Has the student
calculated the linear and
constant terms correctly?
Vague
No
Determine: Did the student
know the need to set up an
equation and then solve it
to find the range of solutions
that meet the conditions?
Evident
Yes
Represent: Has the given
situation been expressed
correctly?
Evident
No
Implement: When simplifying
an expression, does the student
keep the expression correct by
performing the same operation
on both sides?
Vague
Yes
Table 1: Two samples from MATHCOG. Each data point is composed of a math problem,
student response, relevant diagnostic checklist, and verdict for each check item.
3.2
Teacher-generated Verdict
We recruited 15 middle school math teachers to evaluate 796 student responses based on pre-
defined diagnostic checklists. These teachers had an average of 6.1±4.3 years of experience
(range: 2.5–20 years). Each check item was assessed along two dimensions: “yes/no” and
“evident/vague” (see Table 1). A “yes” response indicated that the student fully demon-
strated the cognitive action specified, while a “no” indicated otherwise. “Evident” meant
there was clear evidence to support the judgment, whereas “vague” signified insufficient
evidence. For example, for the check item “Did the student calculate correctly?”, teachers
marked “evident yes” if the response showed a complete, error-free calculation process,
“evident no” if there were clear mistakes, and “vague no” if calculations were missing.
To account for the subjectivity in the diagnosis, we grouped three teachers to evaluate
approximately 160 student responses together. The diagnosis occurred in two phases:
first, each group collaboratively assessed 36 responses, resolving conflicts through majority
voting; second, each teacher independently assessed 18 responses. The second phase
included 18 overlapping responses, allowing us to measure inter-rater agreement (see Table
4 in Appendix). Based on the threshold established in prior literature (Graham et al., 2012),
5


Preprint. Under review.
we set a minimum agreement of 70% and excluded data from problem types 6, 13, and 14
accordingly. The distribution of the verdicts is presented in Table 5.
4
Experimental Setting
Using MATHCOG as a benchmark dataset, we explored two research questions. For RQ1,
we evaluated the state-of-the-art LLMs, testing GPT (Achiam et al., 2023), Gemini (Team
et al., 2023), Llama (Touvron et al., 2023), Claude (Anthropic, 2024), and DeepSeek (Guo
et al., 2025) series. For RQ2, we configured three experiments in which we compared the
performance of LLMs in different inputs, reasoning capabilities, and model sizes.
Task Definition. Our task for LLMs is essentially a single-label classification task. Formally,
we represent diagnosis result for a student’s response as a collection of tuples (c, r), where
c ∈C (i.e., check items) and r ∈{Evident Yes, Vague Yes, Evident No, Vague No}. The
combined judgment (c, r) provides both an evaluative decision and a confidence signal for
a skill. Given a context (P, S, R, C), where P is the problem, S is the answer, and R is the
student response, the task is to produce assessment tuples (c, r) for all c ∈C.
Prompting. We instructed LLMs to evaluate each check item based on a given math prob-
lem, its solution, a student’s response, and a diagnostic checklist. The LLMs processed
inputs in the form of OCR transcriptions, where mathematical formulas and visual cues
(e.g., strikethroughs) were represented using LaTeX. In the case of testing the effect of
multimodality, we supplied images of student responses. Since the original inputs were in
Korean, we machine-translated them into English to prevent possible performance degra-
dation due to language (Achiam et al., 2023). To enhance response accuracy, we employed
Chain-of-Thought prompting (Wei et al., 2022; Liu et al., 2024), guiding the LLM to system-
atically address each check item by first restating its content, identifying relevant evidence,
providing an explanation, and delivering a final verdict. The verdict followed one of the four
categories used by teachers in MATHCOG. We opted not to include few-shot examples, as
MATHCOG does not provide explicit evidence and explanations for reference. To minimize
randomness, all LLMs were run with a temperature setting of zero. A detailed description
of the system and user prompts can be found in the Appendix.
Models. We conducted our experiment using 16 distinct closed and open LLMs from various
vendors. To assess the impact of multimodal input, we tested GPT-4o (2024-08-06), Claude-
3.5-Sonnet (20240620), and Gemini-1.5-Flash under two conditions: one using text-only
prompts and another supplemented with an image. To examine the effect of reasoning
capabilities, we compared LLMs with reasoning capabilities—GPT-o1-Preview (2024-09-12),
Gemini-2.0-Flash-Thinking (exp-01-21), and DeepSeek-R1—with conventional LLMs of the
same model series—GPT-4o, GPT-4o-Mini (2024-07-18), Gemini-1.5-Pro (002), Gemini-1.5-
Flash, and DeepSeek-V3 (0324). Finally, we investigated model size differences: GPT-4o,
Gemini-1.5-Pro, Llama-3.1-450B (2024-07-23), and DeepSeek-V3 were categorized as large
models; Llama-3.3-70B (2024-07-23) and Qwen-2.5-72B (2024-09) as medium models; and
GPT-4o-Mini, Gemini-1.5-Flash-8B (001), Llama-3.1-8B (2024-07-23), Qwen-2.5-7B (2024-09),
and Mistral-7B (2024-08-22) as small models.
Metrics. We evaluated the outputs of the large language models (LLMs) against ground-
truth diagnostic results provided by human experts. Performance was assessed using both
macro F1 score and accuracy computed over verdicts (i.e., (c, r)) to quantify the effectiveness
of skill diagnosis. For a more nuanced analysis, we also examined the models’ tendencies
toward overconfidence and underconfidence. Specifically, overconfidence is defined as the
conditional proportion of “evident” verdicts produced by the LLMs that were incorrect.
Conversely, underconfidence is the conditional proportion of verdicts labeled as “vague”
by the LLMs that were, in fact, both correct and should have been classified as “evident.”
5
Results
In this section, we organize and interpret the findings to answer our research questions. The
complete results from our experiment are presented in Table 6 in the Appendix.
6


Preprint. Under review.
5.1
RQ1. How accurately do state-of-the-art LLMs diagnose students’ cognitive skills?
Overall, the results underscore the difficulty of the task (Table 2); no model surpassed an
F1 score of 0.5, indicating that even state-of-the-art models struggle to diagnose students’
cognitive skills accurately. Our manual error analysis on a few samples revealed that LLMs
largely failed when 1) student response flows in a non-directional, scattered layout, 2) a
student uses underscores, strikethroughs, and calculation notes, and 3) a response lacks
direct evidence for a skill, despite contextual information being sufficient for inference.
Furthermore, the high overconfidence rates observed across all models suggest a concerning
trend—models often make incorrect “evident” judgments with unwarranted certainty. Such
behavior can be particularly misleading for teachers and students, as these verdicts are
accompanied by confidently stated but erroneous rationales (Kim et al., 2025). Among the
evaluated models, Gemini-1.5-Pro achieved the strongest overall performance, attaining
the highest F1 score (.441) and accuracy (.707). However, this performance came at a cost
of reliability; we found a significant trade-off between accuracy and confidence. Accurate
LLMs tend to be more overconfident (rs = .617, p = .0048) and less underconfident (rs =
−.664, p = .0019). This trend was even stronger in the state-of-the-art LLMs (rs = .900, p =
.0374 and rs = −.900, p = .0373).
Models
Precision
Recall
F1
Accuracy
Overconfidence
Underconfidence
DeepSeek-V3
.406
.461
.417
.714
.818
.107
GPT-4o
.398
.476
.412
.672
.788
.110
Llama-3.1-405B
.415
.438
.384
.624
.778
.186
Claude-3.5-Sonnet
.329
.387
.332
.654
.812
.173
Gemini-1.5-Pro
.430
.496
.441
.707
.840
.132
Table 2: The performance of the five state-of-the-art LLMs on the cognitive skill diagnosis
task.
Analysis of skill-specific performance (Figure 2) reveals further insights into the limitations
of current LLMs. No skill category achieved a maximum F1 score above 0.5. Interestingly,
the skill Compute, which most closely resembles conventional grading tasks (i.e., evaluating
the correctness of mathematical procedures and calculations), still yielded only a moderate
F1 score across models. This moderate F1 score confirms LLMs’ struggle in verifying correct
computation in constructed student responses.
Contrary to expectations, there was no substantial performance gap between the “Knowing”
and “Applying” cognitive skills. Although we anticipated that “Knowing” skills (e.g., Recall,
Recognize) would be easier than “Applying” skills for LLMs due to their surface-level nature,
models performed comparably. An exception is found in the skill Classify/Order, which
shows a relatively high average accuracy but a lower F1 score. Closer inspection reveals that
“Evident Yes” is dominant in the ground truth dataset (Table 5), leading to the discrepancy
between F1 score and accuracy.
Figure 2: The performance of five state-of-the-art LLMs across cognitive skill types. The left
plot shows the minimum (bottom ×), maximum (top ×), and average (middle •) F1 scores
for each skill category, while the right plot presents the corresponding accuracy metrics.
7


Preprint. Under review.
5.2
RQ2. How do multimodal input, reasoning, and model size influence LLMs’
cognitive skill diagnosis?
We observed subtle impacts of multimodal input and reasoning on the performance, while
the impact of model size was significant.
Multimodal Input. Models supporting image input (e.g., GPT-4o-img, Claude-3.5-Sonnet-
img, Gemini-1.5-Flash-img) consistently outperformed their text-only counterparts in accu-
racy (up to 10.6%) and in reducing underconfidence (up to 4.9%) (Figure 3 left), although
the statistical difference between the pairs was not significant. Image input was particularly
beneficial in cases where OCR transcription introduced errors. For example, a student
underlined an arithmetic expression and wrote the corresponding calculation beneath it (see
Figure 5 a). The OCR system misinterpreted this layout as a fraction, leading Claude-3.5-
Sonnet (text-only) to incorrectly conclude that the student had set up an invalid equation.
In contrast, the same model with image input correctly inferred the student’s intention and
produced an accurate diagnosis.
Reasoning. The performance of reasoning-oriented models showed mixed results (Figure 3
right). DeepSeek-R1 achieved the highest F1 and accuracy scores among all models. How-
ever, other reasoning models, such as o1-Preview and Gemini-2.0-Flash-Thinking, did not
show clear advantages over standard models in either accuracy or F1 score. These results
suggest that reasoning capability alone does not guarantee better performance. For instance
(Figure 5 b), DeepSeek-R1 classified a response as “Vague No” because the student omitted
the factorization steps. However, the original expression was
√
48a, and the model failed to
detect a clear error in the variable term, indicating that the student’s reasoning was evidently
flawed. Throughout its reasoning process, the model focused on the constant term only and
overlooked other possible places of error. While current reasoning models excel at pushing
forward linear, step-by-step logic, effective cognitive diagnosis may also require divergent,
multi-perspective reasoning for thorough analysis.
Model Size. In general, larger models tend to outperform smaller ones in F1 score (Figure 4),
reflecting the expected benefit of increased parameter capacity for understanding complex
student responses (rs = .771, p = .0251). Notably, Qwen-2.5-72B significantly outperformed
its smaller counterpart Qwen-2.5-7B (bootstrapping method, p < .026), demonstrating the
measurable advantage of increased model size within the same architecture. Some small
models, such as GPT-4o-Mini and Mistral-7B, achieved performance levels comparable to
larger models, but they have markedly high overconfidence.
Figure 3: Impact of multimodal input (left) and reasoning capability (right) on LLMs’
performance in cognitive skill diagnosis. On the left, each adjacent pair of bars shows
performance with and without the image input from the same model family. On the right,
models with reasoning capabilities are grouped at the front.
8


Preprint. Under review.
Figure 4: Impact of model size on LLM performance in cognitive skill diagnosis. Models are
grouped into large, medium, and small categories.
6
Discussion
Our findings imply that current LLMs are not yet suitable for high-stakes cognitive skill
diagnosis. The models exhibit low recall and high overconfidence (Table 2), raising concerns
that LLM-based systems may frequently overlook students’ misconceptions. This shortcom-
ing is particularly problematic given that the primary goal of automated assessment is to
identify and address such misconceptions, and it can compromise teachers’ and students’
trust in automated systems (Shin, 2021). To responsibly integrate LLMs into real-world
assessment settings, practitioners should begin by evaluating their performance on small,
ground-truth samples. This process not only exposes limitations but also allows for fine-
tuning model judgments and confidence levels for downstream math topics and student
populations. In parallel, model developers may work to mitigate overconfidence during
training by encouraging more conservative, evidence-based decision-making.
Our manual analysis of failed cases reveals that inferring students’ thought processes from
handwritten responses presents distinct challenges. While mathematical problem-solving
is inherently procedural, students often express their reasoning in non-linear, spatially
scattered layouts that lack clear directionality. This ill-structured presentation differs sig-
nificantly from the format of most existing reasoning and problem-solving benchmarks.
Moreover, ambiguous notations (e.g., fractions misinterpreted as underscores) and un-
conventional layouts frequently result in OCR transcription errors, which hinder accurate
diagnosis unless image inputs are provided. To enable more reliable inference, future work
may require richer representations of math responses that capture high-level semantic intent
beyond surface-level positional and textual cues.
7
Limitations and Future Work
While MATHCOGrepresents a novel benchmark for evaluating LLMs on cognitive skill
diagnosis, it has several limitations. First, due to data-sharing restrictions from the source
provider (AIHub), the original math problems and student responses cannot be publicly
released outside Korea. To support future research despite this constraint, we release the
complete set of diagnostic checklists and expert-generated human annotations, which can
serve as references for researchers to develop similar datasets in their educational contexts.
In parallel, we are actively collecting new student response data under informed consent,
with the goal of constructing a fully public benchmark in the future.
This ongoing data collection effort will also address limitations in the diversity of problem
types represented in MATHCOG. Currently, the dataset focuses on nine problem types,
9


Preprint. Under review.
primarily centered around arithmetic equation solving. Other areas of mathematics—such
as geometry—often require interpreting visual representations and may further benefit from
the integration of multimodal input. Additionally, reasoning-oriented problems, which
explicitly ask students to generalize mathematical knowledge or justify their arguments, are
underrepresented. We plan to expand the dataset to include a broader range of content
areas and grade levels, enabling a more holistic evaluation of LLM performance across the
mathematics curriculum.
Our experimental results are also bound to zero-shot settings, without exploring the effects
of few-shot or test-time compute (Snell et al., 2024) prompting. Future work can investigate
whether more sophisticated prompting enhances diagnostic accuracy. For example, prompt-
ing an LLM to explicitly infer a student’s thinking process before answering each check item
may lead to more accurate judgments. We see our work as a first step toward automated
cognitive skill assessment, and we invite the community to build upon these directions.
Acknowledgments
This work was supported by Algorithm LABS. This research (paper) used datasets from
“The Open AI Dataset Project (AI-Hub, S. Korea).” All data information can be accessed
through “AI-Hub (www.aihub.or.kr).”
References
Josh Achiam, Steven Adler, Sandhini Agarwal, Lama Ahmad, Ilge Akkaya, Florencia Leoni
Aleman, Diogo Almeida, Janko Altenschmidt, Sam Altman, Shyamal Anadkat, et al.
Gpt-4 technical report. arXiv preprint arXiv:2303.08774, 2023.
Janice Ahn, Rishu Verma, Renze Lou, Di Liu, Rui Zhang, and Wenpeng Yin. Large lan-
guage models for mathematical reasoning: Progresses and challenges. arXiv preprint
arXiv:2402.00157, 2024.
Anthropic.
The claude 3 model family:
Opus,
sonnet,
haiku,
2024.
URL
https://www-cdn.anthropic.com/de8ba9b01c9ab7cbabf5c33b80b7bbc618857627/
Model Card Claude 3.pdf.
Sami Baral, Anthony Botelho, Abhishek Santhanam, Ashish Gurung, Li Cheng, and Neil
Heffernan. Auto-scoring student responses with images in mathematics. The Proceedings
of the 16th International Conference on Educational Data Mining., 2023.
Sami Baral, Eamon Worden, Wen-Chiang Lim, Zhuang Luo, Christopher Santorelli, and
Ashish Gurung. Automated assessment in math education: A comparative analysis of
llms for open-ended responses. In Benjamin Paa ˜A ¨Yen and Carrie Demmans Epp (eds.),
Proceedings of the 17th International Conference on Educational Data Mining, pp. 732–737.
International Educational Data Mining Society, July 2024. ISBN 978-1-7336736-5-5. doi:
10.5281/zenodo.12729932.
Sami Baral, Li Lucy, Ryan Knight, Alice Ng, Luca Soldaini, Neil T Heffernan, and Kyle
Lo. Drawedumath: Evaluating vision language models with expert-annotated students’
hand-drawn math images. arXiv preprint arXiv:2501.14877, 2025.
B. S. Bloom, M. B. Engelhart, E. J. Furst, W. H. Hill, and D. R. Krathwohl. Taxonomy of
Educational Objectives: The Classification of Educational Goals. Handbook 1: Cognitive Domain.
Longmans, Green, New York, NY, 1956.
Imran Chamieh, Torsten Zesch, and Klaus Giebermann. Llms in short answer scoring:
Limitations and promise of zero-shot and few-shot approaches. In Proceedings of the 19th
workshop on innovative use of nlp for building educational applications (bea 2024), pp. 309–315,
2024.
10


Preprint. Under review.
Karl Cobbe, Vineet Kosaraju, Mohammad Bavarian, Mark Chen, Heewoo Jun, Lukasz Kaiser,
Matthias Plappert, Jerry Tworek, Jacob Hilton, Reiichiro Nakano, et al. Training verifiers
to solve math word problems. arXiv preprint arXiv:2110.14168, 2021.
Aniket Didolkar, Anirudh Goyal, Nan Rosemary Ke, Siyuan Guo, Michal Valko, Timothy
Lillicrap, Danilo Jimenez Rezende, Yoshua Bengio, Michael C Mozer, and Sanjeev Arora.
Metacognitive capabilities of llms: An exploration in mathematical problem solving.
Advances in Neural Information Processing Systems, 37:19783–19812, 2024.
Meng Fang, Xiangpeng Wan, Fei Lu, Fei Xing, and Kai Zou. Mathodyssey: Benchmarking
mathematical problem-solving skills in large language models using odyssey math data.
arXiv preprint arXiv:2406.18321, 2024.
Rujun Gao, Hillary E Merzdorf, Saira Anwar, M Cynthia Hipwell, and Arun R Srinivasa.
Automatic assessment of text-based responses in post-secondary education: A systematic
review. Computers and Education: Artificial Intelligence, 6:100206, 2024.
Matthew Graham, Anthony Milanowski, and Jackson Miller. Measuring and promoting
inter-rater agreement of teacher and principal performance ratings. Online Submission,
2012.
Daya Guo, Dejian Yang, Haowei Zhang, Junxiao Song, Ruoyu Zhang, Runxin Xu, Qihao Zhu,
Shirong Ma, Peiyi Wang, Xiao Bi, et al. Deepseek-r1: Incentivizing reasoning capability in
llms via reinforcement learning. arXiv preprint arXiv:2501.12948, 2025.
Shibo Hao, Yi Gu, Haotian Luo, Tianyang Liu, Xiyan Shao, Xinyuan Wang, Shuhua Xie,
Haodi Ma, Adithya Samavedhi, Qiyue Gao, et al. Llm reasoners: New evaluation,
library, and analysis of step-by-step reasoning with large language models. arXiv preprint
arXiv:2404.05221, 2024.
Scott Hellman, Alejandro Andrade, and Kyle Habermehl. Scalable and explainable auto-
mated scoring for open-ended constructed response math word problems. In Proceedings
of the 18th Workshop on Innovative Use of NLP for Building Educational Applications (BEA
2023), pp. 137–147, 2023.
Dan Hendrycks, Collin Burns, Saurav Kadavath, Akul Arora, Steven Basart, Eric Tang,
Dawn Song, and Jacob Steinhardt. Measuring mathematical problem solving with the
math dataset. arXiv preprint arXiv:2103.03874, 2021.
Hyoungwook Jin, Yoonsu Kim, Yeon Su Park, Bekzat Tilekbay, Jinho Son, and Juho Kim. Us-
ing large language models to diagnose math problem-solving skills at scale. In Proceedings
of the Eleventh ACM Conference on Learning@ Scale, pp. 471–475, 2024.
Kaggle and Eedi. Eedi - mining misconceptions in mathematics dataset, 2020. URL https:
//www.kaggle.com/competitions/eedi-mining-misconceptions-in-mathematics.
Ac-
cessed: 2025-05-21.
Fong Ho Kheong. Information processing taxonomy (ipt): An alternative technique for
assessing mathematical problem-solving. 1994.
Sunnie SY Kim, Jennifer Wortman Vaughan, Q Vera Liao, Tania Lombrozo, and Olga
Russakovsky. Fostering appropriate reliance on large language models: The role of
explanations, sources, and inconsistencies. arXiv preprint arXiv:2502.08554, 2025.
Chen Li, Weiqi Wang, Jingcheng Hu, Yixuan Wei, Nanning Zheng, Han Hu, Zheng Zhang,
and Houwen Peng. Common 7b language models already possess strong math capabilities.
arXiv preprint arXiv:2403.04706, 2024.
Tianyi Liu, Julia Chatain, Laura Kobel-Keller, Gerd Kortemeyer, Thomas Willwacher, and
Mrinmaya Sachan. Ai-assisted automated short answer grading of handwritten university
level mathematics exams. arXiv preprint arXiv:2408.11728, 2024.
Samuel A Livingston. Constructed-response test questions: Why we use them; how we
score them. r&d connections. number 11. Educational Testing Service, 2009.
11


Preprint. Under review.
Li Lucy, Tal August, Rose E Wang, Luca Soldaini, Courtney Allison, and Kyle Lo. Mathfish:
Evaluating language model math reasoning via grounding in educational curricula. arXiv
preprint arXiv:2408.04226, 2024.
Ina V.S. Mullis. Timss 2019 assessment frameworks: Introduction, 2017. Monitoring Trends
in Mathematics and Science Achievement.
Ina V.S. Mullis, Michael O. Martin, and Matthias von Davier. Timss 2023 frameworks
introduction, 2023. First Fully Digital TIMSS Assessment.
OpenAI. Learning to reason with llms, January 2024. URL https://openai.com/index/
learning-to-reason-with-llms/.
George Polya. How to Solve It. Princeton University Press, Princeton, NJ, 2nd edition, 1957.
Freydoon Rahbarnia, Salehe Hamedian, and Farzad Radmehr. A study on the relationship
between multiple intelligences and mathematical problem solving based on revised bloom
taxonomy. Journal of Interdisciplinary Mathematics, 17(2):109–134, 2014.
David Saxton, Edward Grefenstette, Felix Hill, and Pushmeet Kohli. Analysing mathemati-
cal reasoning abilities of neural models. arXiv preprint arXiv:1904.01557, 2019.
Donghee Shin.
The effects of explainability and causability on perception, trust, and
acceptance: Implications for explainable ai. International journal of human-computer studies,
146:102551, 2021.
Charlie Snell, Jaehoon Lee, Kelvin Xu, and Aviral Kumar. Scaling llm test-time compute opti-
mally can be more effective than scaling model parameters. arXiv preprint arXiv:2408.03314,
2024.
Nina V Stankous. Constructive response vs. multiple-choice tests in math: American
experience and discussion. In 2nd Pan-American Interdisciplinary Conference, PIC 2016 24-26
February, Buenos Aires Argentina, pp. 321, 2016.
Gemini Team, Rohan Anil, Sebastian Borgeaud, Jean-Baptiste Alayrac, Jiahui Yu, Radu
Soricut, Johan Schalkwyk, Andrew M Dai, Anja Hauth, Katie Millican, et al. Gemini: a
family of highly capable multimodal models. arXiv preprint arXiv:2312.11805, 2023.
Hugo Touvron, Thibaut Lavril, Gautier Izacard, Xavier Martinet, Marie-Anne Lachaux,
Timoth´ee Lacroix, Baptiste Rozi`ere, Naman Goyal, Eric Hambro, Faisal Azhar, et al.
Llama: Open and efficient foundation language models. arXiv preprint arXiv:2302.13971,
2023.
Boshi Wang, Xiang Yue, and Huan Sun. Can chatgpt defend its belief in truth? evaluating
llm reasoning via debate. arXiv preprint arXiv:2305.13160, 2023.
Jason Wei, Xuezhi Wang, Dale Schuurmans, Maarten Bosma, Fei Xia, Ed Chi, Quoc V
Le, Denny Zhou, et al. Chain-of-thought prompting elicits reasoning in large language
models. Advances in neural information processing systems, 35:24824–24837, 2022.
Yibo Yan, Jiamin Su, Jianxiang He, Fangteng Fu, Xu Zheng, Yuanhuiyi Lyu, Kun Wang, Shen
Wang, Qingsong Wen, and Xuming Hu. A survey of mathematical reasoning in the era
of multimodal large language model: Benchmark, method & challenges. arXiv preprint
arXiv:2412.11936, 2024.
An Yang, Beichen Zhang, Binyuan Hui, Bofei Gao, Bowen Yu, Chengpeng Li, Dayiheng
Liu, Jianhong Tu, Jingren Zhou, Junyang Lin, Keming Lu, Mingfeng Xue, Runji Lin,
Tianyu Liu, Xingzhang Ren, and Zhenru Zhang. Qwen2.5-math technical report: Toward
mathematical expert model via self-improvement. arXiv preprint arXiv:2409.12122, 2024a.
Zhen Yang, Jinhao Chen, Zhengxiao Du, Wenmeng Yu, Weihan Wang, Wenyi Hong, Zhihuan
Jiang, Bin Xu, and Jie Tang. Mathglm-vision: Solving mathematical problems with multi-
modal large language model. arXiv preprint arXiv:2409.13729, 2024b.
12


Preprint. Under review.
Duzhen Zhang, Yahan Yu, Jiahua Dong, Chenxing Li, Dan Su, Chenhui Chu, and Dong
Yu. Mm-llms: Recent advances in multimodal large language models. arXiv preprint
arXiv:2401.13601, 2024a.
Renrui Zhang, Dongzhi Jiang, Yichi Zhang, Haokun Lin, Ziyu Guo, Pengshuo Qiu, Aojun
Zhou, Pan Lu, Kai-Wei Chang, Yu Qiao, et al. Mathverse: Does your multi-modal llm
truly see the diagrams in visual math problems? In European Conference on Computer
Vision, pp. 169–186. Springer, 2024b.
Tianyang Zhong, Zhengliang Liu, Yi Pan, Yutong Zhang, Yifan Zhou, Shizhe Liang, Zihao
Wu, Yanjun Lyu, Peng Shu, Xiaowei Yu, et al. Evaluation of openai o1: Opportunities and
challenges of agi. arXiv preprint arXiv:2409.18486, 2024.
A
Appendix
Domains
Cognitive Skills
Description
Knowing
Recall
Recall definitions, terminology, number properties, units of measurement,
geometric properties, and notation (e.g., a × b = ab, a + a + a = 3a).
Recognize
Recognize numbers, expressions, quantities, and shapes. Recognize entities
that are mathematically equivalent (e.g., equivalent familiar fractions,
decimals, and percents; different orientations of simple geometric figures).
Classify/Order
Classify numbers, expressions, quantities, and shapes by common properties.
Compute
Carry out algorithmic procedures for +, −, ×, ÷ or a combination of these
with whole numbers, fractions, decimals, and integers. Carry out
straightforward algebraic procedures.
Retrieve
Retrieve information from graphs, tables, texts, or other sources.
Measure
Use measuring instruments; and choose appropriate units of measurement.
Applying
Determine
Determine efficient/appropriate operations, strategies, and tools for solving
problems for which there are commonly used methods of solution.
Represent/Model
Display data in tables or graphs; create equations, inequalities, geometric
figures, or diagrams that model problem situations; and generate equivalent
representations for a given mathematical entity or relationship.
Implement
Implement strategies and operations to solve problems involving familiar
mathematical concepts and procedures.
Reasoning
Analyze
Determine, describe, or use relationships among numbers, expressions,
quantities, and shapes.
Integrate/Synthesize
Link different elements of knowledge, related representations, and
procedures to solve problems.
Evaluate
Evaluate alternative problem solving strategies and solutions.
Draw conclusions
Make valid inferences on the basis of information and evidence.
Generalize
Make statements that represent relationships in more general and more
widely applicable terms.
Justify
Provide mathematical arguments to support a strategy or solution.
Table 3: Fifteen cognitive skills and their descriptions defined in the TIMSS 2019 framework.
Problem Types
1
2
3
4
5
6
7
8
9
10
11
12
13
14
15
% Agreement
95
70
96
95
89
68
74
86
80
80
100
88
40
57
78
Table 4: The inter-rater percentage absolute agreement of each problem type. The percentage
indicates the ratio of unanimous verdicts in each teacher group.
A.1
Prompts
The blue text represents the programmatically filled arguments, and the orange text repre-
sents LLM-generated output.
A.2
System Prompt
# **Task Description**
13


Preprint. Under review.
You are a middle school math teacher tasked with evaluating students' mathematical
thinking skills based on their responses to math problems. Your goal is to analyze a
given student's response and determine whether they exhibit specific cognitive skills
in solving the problem. Your evaluation must be **strict** and **evidence-based**,
meaning that every verdict must be backed by direct evidence from the response. If no
clear evidence exists, do not assume correctness.
## **Evaluation Categories**
For each thinking skill in the checklist, you must classify the student's performance
into one of the following categories:
- **Evident Yes**: The student's response provides clear and explicit evidence that the
check item is met. A direct quote from the response can confirm this.
- **Vague Yes**: The response suggests that the check item might be satisfied, but no
specific part of the response directly proves it.
- **Evident No**: The response explicitly contradicts or fails to meet the check item,
with clear evidence demonstrating the error or omission.
- **Vague No**: The response does not appear to satisfy the check item, but there is no
direct evidence confirming whether the student considered it or not.
## **Input Format**
You will receive the following data:
- **Problem**: A math problem given to a student.
- **Answer**: The correct step-by-step solution.
- **Response**: The student's response to the problem.
- **Check Items**: A set of specific skills to evaluate.
## **Output Format**
Return a valid JSON object structured as follows:
```json
{
"skills": [
{
"checkItem": "<Check Item's [Label] and the Following Question>",
"evidence": "<Directly Quoted Part of Response>",
"explanation": "<Explanation About Why the Evidence Supports the Verdict>",
"verdict": "Evident Yes" | "Vague Yes" | "Evident No" | "Vague No"
}
]
}
```
A.3
User Prompt
# **Task**
student responses to math problems, extract direct evidence, and strictly classify
thinking skills according to the given categories.
Return a valid JSON object structured as follows:
```json
{
"skills": [
{
"checkItem": "<Check Item's [Label] and the Following Question>",
"evidence": "<Directly Quoted Part of Response>",
"explanation": "<Explanation About Why the Evidence Supports the Verdict>",
"verdict": "Evident Yes" | "Vague Yes" | "Evident No" | "Vague No"
}
]
}
```
**Problem:**
14


Preprint. Under review.
There is a two-digit natural number whose tens digit is 1. If the number that changes the
tens and ones digits of this natural number is 9 less than 5 times the first number, find
the first number.
**Answer:**
If the number in the ones place is x, this natural number is 10 + x. The number where the
tens digit and the ones digit are swapped is 10x + 1 because the tens digit is x and the
ones digit is 1. The changed number is 9 smaller than 5 times the first number, so
10x + 1 = 5(10 + x) −9 10x + 1 = 5x + 41 5x = 40 x = 8 Therefore, the first number is 18.
**Response:**
1 x x 1 10x + 1 = 5(10 + x) −9 10x + 1 = 50 + 5x −9 41 5x = 40 x = 8
**Check Items:**
- [recognize 0] Is the student aware that the relationship between two numbers switched
can be expressed as addition/subtraction/multiplication?
- [recognize 1] Has the student figured out all the elements necessary to solve the
problem (original numbers, swapped numbers, difference or multiple relationships, etc.)?
- [compute 0] Has the student performed algebraic calculations correctly, such as
expanding expressions and organizing similar terms?
- [determine 0] Has the student chosen the appropriate approach to solving the problem
(e.g., establishing a linear equation)?
- [represent 0] Are two-digit numbers expressed correctly in the form 10x + y (or
equivalent)?
- [implement 0] Does the student proceed consistently with the process of expanding the
equation and moving terms to find x (or y) according to the planned solution strategy?
**Output:**
```json
{
"skills": [
{
"checkItem": "[recognize 0] Is the student aware that the relationship between
two numbers switched can be expressed as
addition/subtraction/multiplication?",
"evidence": "10 x+1=5(10+x)-9",
"explanation": "The student sets up the equation 10x+1=5(10+x)-9, which shows
they understand the relationship between the original and swapped numbers
involves subtraction and multiplication.",
"verdict": "Evident Yes"
}, {
"checkItem": "[recognize 1] Has the student figured out all the elements
necessary to solve the problem (original numbers, swapped numbers, difference
or multiple relationships, etc.)?",
"evidence": "10 x+1=5(10+x)-9",
"explanation": "The student uses the correct equation to represent the
relationship between the original and swapped numbers, indicating they have
identified the necessary elements.",
"verdict": "Evident Yes"
},
...
]
}
Recall
Recognize
Classify/Order
Compute
Retrieve
Determine
Represent
Implement
Evident Yes
507
506
92
584
9
441
154
319
Evident No
78
69
8
160
9
54
55
146
Vague Yes
58
54
2
48
0
25
6
29
Vague No
98
62
0
58
34
16
46
41
Student responses
582
583
51
796
52
482
261
535
Table 5: Distribution of verdicts and number of diagnosed student responses in each
cognitive skill. Note that the number of student responses can be larger than the sum of the
four labels because some diagnostic checklists have two items for the same cognitive skill.
15


Preprint. Under review.
Models
Precision
Recall
F1
Accuracy
Overconfidence
Underconfidence
DeepSeek-R1
.447
.467
.442
.773
.901
.028
DeepSeek-V3
.406
.461
.417
.714
.710
.107
GPT-4o-img
.427
.494
.448
.743
.738
.070
GPT-4o
.398
.476
.412
.672
.703
.110
GPT-4o-Mini
.345
.397
.352
.622
.791
.102
o1-Preview
.338
.410
.354
.711
.757
.117
Llama-3.3-70B
.416
.468
.400
.640
.534
.189
Llama-3.1-8B
.283
.265
.257
.642
.695
.138
Llama-3.1-405B
.415
.438
.384
.624
.451
.186
Claude-3.5-Sonnet-img
.326
.365
.330
.690
.680
.140
Claude-3.5-Sonnet
.329
.387
.332
.654
.676
.173
Gemini-1.5-Flash-img
.431
.484
.429
.702
.593
.129
Gemini-1.5-Flash-8b
.287
.341
.279
.558
.579
.196
Gemini-1.5-Flash
.432
.490
.432
.679
.582
.155
Gemini-1.5-Pro
.430
.496
.441
.707
.721
.132
Gemini-2.0-Flash-Thinking
.455
.492
.421
.690
.589
.186
Mistral-7B
.384
.369
.347
.714
.805
.112
Qwen-2.5-7B
.278
.270
.271
.705
.842
.075
Qwen-2.5-72B
.415
.459
.416
.710
.631
.115
Table 6: Performance comparison of all 16 LLMs tested on skill diagnosis tasks.
Figure 5: Illustrative examples of diagnosis check items and student responses that LLMs
failed to diagnose correctly. Evidence for human judgment is marked with a red box.
16


