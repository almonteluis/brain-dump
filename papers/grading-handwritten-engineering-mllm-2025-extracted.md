---
source_file: "grading-handwritten-engineering-mllm-2025.pdf"
type: paper
---

# grading-handwritten-engineering-mllm-2025

Grading Handwritten Engineering Exams with Multimodal Large Language
Models
Janez Perˇs, Jon Muhoviˇc, Andrej Koˇsir and Boˇstjan Murovec
University of Ljubljana, Faculty of Electrical Engineering
{janez.pers},{jon.muhovic},{andrej.kosir},{bostjan.murovec}@fe.uni-lj.si
Abstract
Handwritten STEM exams capture open-ended reasoning
and diagrams, but manual grading is slow and difficult
to scale. We present an end-to-end workflow for grading
scanned handwritten engineering quizzes with multimodal
large language models (LLMs) that preserves the standard
exam process (A4 paper, unconstrained student handwrit-
ing). The lecturer provides only a handwritten reference
solution (100%) and a short set of grading rules; the ref-
erence is converted into a text-only summary that condi-
tions grading without exposing the reference scan. Re-
liability is achieved through a multi-stage design with a
format/presence check to prevent grading blank answers,
an ensemble of independent graders, supervisor aggrega-
tion, and rigid templates with deterministic validation to
produce auditable, machine-parseable reports. We evalu-
ate the frozen pipeline in a clean-room protocol on a held-
out real course quiz in Slovenian, including hand-drawn
circuit schematics. With state-of-the-art backends (GPT-
5.2 and Gemini-3 Pro), the full pipeline achieves ≈8-point
mean absolute difference to lecturer grades with low bias
and an estimated manual-review trigger rate of ≈17% at
Dmax = 40. Ablations show that trivial prompting and
removing the reference solution substantially degrade ac-
curacy and introduce systematic over-grading, confirming
that structured prompting and reference grounding are es-
sential.
1. Introduction
Handwritten, paper-based exams remain common in
STEM education because they naturally elicit open-ended
reasoning, intermediate work, and sketches (e.g., circuit
diagrams) that are difficult to capture with purely digi-
tal assessments. Figure 1 illustrates the challenges. Yet
manual grading of such exams is time-consuming and
hard to scale. Learnosity reports that, in an online sur-
vey of 258 U.S. teachers, respondents spent an average
of 9.9 hours per week grading and marking [14]. At the
university level, faculty emotions research similarly sug-
gests that grading can be experienced as comparatively
unpleasant: in a large U.S. faculty sample, grading was
Figure 1. Sample handwritten answer with diagrams (e.g. cir-
cuits) that our system is designed to handle. Sample provided
by authors (not student work). The link to the full exam and its
grading result are provided as supplementary material in the last
section of the paper.
associated with less positive and more negative emotions
than research and teaching [24]. Beyond the immediate
time cost, practitioner-facing syntheses argue that exten-
sive grading can consume time and energy that would oth-
erwise support course planning and instructional improve-
ment [28].
The problem is amplified in STEM courses, where
written exams and technical assignments require evaluat-
ing multi-step solutions and graphical artifacts under time
pressure. A STEM-focused review notes that, as enroll-
ments and workloads grow, instructors can struggle to pro-
vide timely feedback on labor-intensive assessments and
may assign fewer practice opportunities despite pedagog-
ical benefits [27]. More broadly, automated grading sys-
tems are often motivated by reducing educator workload
arXiv:2601.00730v1  [cs.CV]  2 Jan 2026


and shortening feedback turnaround [27]. Workflow sys-
tems such as Gradescope show that digitizing and organiz-
ing scanned handwritten submissions can reduce grading
overhead and support more consistent rubric application
[25], but these platforms largely preserve a fundamental
bottleneck: humans still read and score each response.
Recent progress in large language models (LLMs)
opens a path toward more automated grading. On text-
only short-answer grading, experiments on K–12 short-
answer data report that GPT-4 can achieve agreement
close to human rater agreement under relatively simple
prompting [10].
Controlled ASAG evaluations further
show that grading performance is sensitive to prompt
context—including whether a reference answer is pro-
vided or withheld—and can change substantially across
datasets and setups [11]. For paper-based STEM exams,
multimodal LLMs can be evaluated directly on images
of handwritten solutions; recent results report improved
alignment when prompts include official solutions and a
grading rubric, while also noting that accuracy can re-
main insufficient for unsupervised, real-world deployment
[5]. Practical limitations also remain in hybrid workflows:
when handwriting is transcribed to text/LATEX before grad-
ing, transcription errors can affect downstream scoring,
and recent work treats LLM-produced grades as subject
to subsequent human verification and explores confidence
estimation via repeated sampling [15].
Separately, ap-
plied deployments on longer, multi-part responses high-
light handwriting-to-text conversion as a recurring bot-
tleneck and report challenges in applying fine-grained
rubrics to long solutions and diagram/graph-heavy work
[12]. Together, these findings suggest that reliable exam
grading requires not only strong multimodal models, but
also systems-level design: structured prompting, verifica-
tion/aggregation, and deterministic post-processing to en-
force consistent outputs.
In this work, we target the setting of end-to-end grad-
ing for scanned handwritten STEM exams that combine
free-form text with hand-drawn diagrams. We present a
multi-stage, multi-prompt grading workflow with deter-
ministic post-processing to ensure reliable, auditable out-
puts, and evaluate it on undergraduate open-question engi-
neering exams requiring handwritten textual answers and
electrical schematics.
2. Related Work
Research into automated exam grading has a long history
that predates modern LLMs. Before LLMs, many practi-
cal systems either (i) constrained answers into computer-
readable formats (enabling direct scoring) or (ii) relied on
handwriting recognition/OCR to extract text from scanned
work before applying text-based scoring methods. A re-
curring challenge in this area is data availability: authentic
exam scripts are frequently private and difficult to share,
and publicly distributable datasets often only partially re-
flect real exam conditions.
2.1. Exam grading before the advent of LLMs
Prior to multimodal LLMs, automatic assessment largely
decomposed into (i) text-based automated short-answer
grading (ASAG) and (ii) document pipelines that first
transcribed handwriting.
Surveys of ASAG describe
early systems built around engineered lexical/syntactic
features and semantic similarity to reference answers, of-
ten using supervised models trained on scored responses
and evaluated with standard agreement/correlation met-
rics [4].
Representative feature-integration approaches
combine multiple linguistic feature families in discrimina-
tive scoring models [23], while vector-based approaches
use distributed representations and similarity scoring for
grading [16]. More recent surveys emphasize the shift to-
ward deep learning and pretrained language models (in-
cluding transformer-based approaches) for text ASAG [9].
For handwritten work, a common strategy was hand-
writing recognition/OCR followed by text-based scoring.
Early examples integrated handwriting recognition with
automated essay scoring and underscored the dependence
of end-to-end scoring quality on transcription quality [26].
For short handwritten answers, Rowtula et al. propose a
word-spotting-based approach that avoids full transcrip-
tion and instead relies on retrieval-style signals for down-
stream evaluation [22]. In parallel, system-level tools such
as Gradescope scaled the workflow of grading scanned
submissions through dynamic rubrics and answer group-
ing, while still relying on humans to assign points [25].
For structured STEM problems, clustering-based methods
have been proposed to group similar solution structures
so that an instructor can label clusters and propagate (par-
tial) credit [13]. Overall, pre-LLM grading systems either
assumed clean text or relied on transcription as an error-
prone front-end, and most did not robustly support uncon-
strained handwriting, diagrams, and multi-page exam con-
text end-to-end.
2.2. Exam grading in the LLM era
Since 2023, large language models have been evaluated as
general-purpose graders, first on text-only responses and
increasingly on images of handwritten work. On K–12
short-answer data, Henkel et al. report that GPT-4 with
relatively simple prompting can achieve agreement close
to human rater agreement [10]. Complementary ASAG
studies show that results depend on prompt context and
experimental setup, including whether reference answers
are provided or withheld [11]. In advanced mathemat-
ics settings, Gandolfi reports that GPT-4 can produce use-
ful solutions and grading rationales, while also document-
ing reliability issues such as occasional loss of coherence
and hallucinations that motivate explicit verification and
guardrails [6].
A major shift is direct multimodal grading of scanned
handwritten solutions. For university-level math exams,
Caraeni et al. evaluate GPT-4o grading directly from
handwriting images and report improved alignment when
prompts include official solutions and a grading rubric,


Pseudo-anonymized
scanned student exam
Format / presence
checker
Grading engine
(ensemble graders)
Supervisor
aggregation
Postprocessor
Final PDFs,
reports, exports
Format / presence
prompt pair
Grading
prompt pair
Supervisor
prompt pair
Postprocessor
prompt pair
Markdown templates
& grading/report layout
Pseudoanonymous
student ID list
Scanned
reference exam
Reference solution
extraction
Reference solution
summary (text)
Reference solution
prompt pair
Figure 2. System overview. Green boxes denote data artifacts, red ellipses denote prompt pairs and templates, and blue boxes denote
processing stages. All blue processing stages invoke a multimodal LLM backend (e.g., GPT-4o, GPT-5.x, Gemini, or Mistral), while
reference solution scans are converted into a text-only summary that is injected into grading prompts.
while noting that overall accuracy remains a limiting fac-
tor for real-world use [5]. Hybrid pipelines remain rele-
vant: Liu et al. study AI-assisted grading of handwritten
university mathematics exams using an OCR/LATEX tran-
scription stage and emphasize both transcription sensitiv-
ity and the role of human verification, while also exploring
confidence estimation by sampling multiple grading runs
[15]. At larger scale (e.g., hundreds of scripts in physics),
workflow studies continue to highlight handwriting-to-
text conversion as a practical bottleneck, challenges in
applying fine-grained rubrics to long solutions, and per-
sistent difficulty with diagrams/graphs [12].
For non-
textual outputs such as hand-drawn graphs, recent com-
parative work evaluates meta-learning approaches along-
side vision-language models on graph grading tasks [21].
Alternative multimodal scoring paradigms use CLIP-style
embeddings (optionally combined with OCR) to incorpo-
rate visual information into scoring [2], and new bench-
marks (e.g., DrawEduMath) systematically probe VLM
interpretation of students’ hand-drawn math images and
document remaining weaknesses [3].
2.3. Datasets
Public datasets that enable end-to-end evaluation of hand-
written exam grading (images in, numeric scores out) are
rare, largely because authentic exam scripts are privacy-
sensitive and typically collected under institutional con-
sent/IRB, limiting public release. Consequently, recent
multimodal grading studies evaluate on private course-
exam collections with scanned pages, rubrics, and human
scores [5, 12], while graph-focused handwritten corpora
are likewise institutional [21]. The few open resources
with handwriting either target short answers [7] or serve as
VLM understanding benchmarks rather than points-based
grading datasets [3]; large educational corpora with im-
age responses are often not redistributable [1]. Therefore,
to evaluate an end-to-end pipeline under realistic STEM
exam conditions (multi-part solutions and diagrams), we
collected and graded our own exam data.
3. Methods
The pipeline was designed to minimize interference with
the exam process. Beyond using the standard A4 paper, no
constraints are imposed on students or on how the lecturer
administers the exam. The only additional requirement is
that the lecturer provides a handwritten reference solution
representing a perfect (100%) answer. These requirements
directly shape the architecture shown in Fig. 2.
3.1. System architecture
The pipeline in Fig. 2 couples deterministic document
handling with a small number of LLM-invoking stages.
While the system is implemented as a substantial amount
of orchestration code, the primary methodological contri-
bution lies in the structure of the pipeline and, crucially, in
the prompt pairs and rigid templates that make the over-
all behavior stable and machine-parseable. Due to space
constraints, we do not reproduce the full prompts and tem-
plates.
Reference conditioning without exposing the reference
scan.
The lecturer provides a handwritten reference so-
lution representing a perfect (100%) answer.
A dedi-
cated reference-extraction stage converts the scanned ref-
erence into a text-only summary that is injected into grad-
ing prompts; the reference image itself is not used during
grading. This stage is run with a highly capable multi-
modal backend (GPT-5.2-pro in our experiments) to ro-
bustly interpret unconstrained handwriting and sketches.
Answer presence guardrail.
Before any scoring, a for-
mat/presence checker predicts which tasks contain an ac-
tual student answer. This safeguard was introduced af-


ter observing rare cases where a model would hallucinate
content when an entire answer region was left blank. Al-
though such events are not reflected in aggregate metrics,
they are operationally unacceptable, and the presence list
prevents the grader from assigning points to missing an-
swers.
Ensemble grading and supervisor aggregation.
For
each task, grading is performed by an ensemble of K = 3
independent, stateless model calls that produce structured
drafts according to a fixed template. A supervisor model
then merges the drafts into a single exam-level output,
enforces template compliance, applies the presence de-
cisions (unanswered tasks receive 0%), and flags incon-
sistencies for optional human resolution. This ensemble-
plus-supervisor design reduces variance and improves ro-
bustness to occasional model glitches.
Postprocessing and exports.
Finally, a postprocessor
produces presentation-ready artifacts (e.g., report assem-
bly and optional translation) while preserving all numeric
fields and the template structure, enabling deterministic
parsing, auditing, and export.
Privacy.
Students are instructed not to write their name
and surname anywhere on the exam. Instead, they are
required to write their registration number, so the data
is pseudo-anonymized before invoking LLM. The LLM
gets sanitized student roster with all registration numbers
for students participating in the exam and only needs to
find which one of the finite set of registration number is
written at the top of the first page of the exam. All de-
anonymization is done locally after grading. Mandatory
markdown templates ensure that the model outputs stu-
dent’s pseudo-identity in a specific place in the output,
where it can be parsed. If parsing fails, human is required
to read the number from the scan.
3.2. Prompts and templates
Each LLM-invoking stage is implemented as a prompt
pair (system + user) backed by rigid Markdown templates.
The system prompt fixes role, constraints, and prohibited
behavior, while the user prompt injects instance-specific
context (task labels, student scan, reference summary, and
optional instructor rules). The templates strictly define
section hierarchy and numeric fields, converting otherwise
probabilistic outputs into artifacts that can be validated
and parsed by deterministic post-processing; in contrast,
directly asking an LLM to “grade the exam” is unreliable
due to format drift and inconsistent application of rubrics.
Instructor-facing
configuration.
The
only
course-
specific inputs are (i) the scanned handwritten reference
solution and (ii) a short list of grading rules. All other
pipeline stages, prompts, and templates are intended to
remain unchanged across courses. Rules are numbered
([R1], [R2], ...), appended verbatim to grading-related
prompts, and graders are instructed to cite applicable rule
IDs in their explanations, improving auditability and fa-
cilitating human review. In our experiments, most rules
transferred across STEM quizzes, with only minor course-
specific adjustments (e.g., evaluating circuit sketches by
topology rather than drawing orientation).
Template constraints.
Two templates are used: a per-
grader template and a supervisor template. Both prohibit
adding or removing sections and enforce a fixed scoring
line with a deterministic numeric pattern (achievement,
weight, contribution). Per task, the template separates the
question text, a plain-text summary of the student answer,
a correctness explanation with required short meta-tags
(including rule citations), and a single scoring line. The
final exam total must equal the sum of per-task contribu-
tions (no normalization), which enables automatic consis-
tency checks.
Language.
Unless stated otherwise, the prompts, rules,
and templates used in our experiments are written in
Slovenian.
The pipeline itself is language-agnostic:
adapting to other languages requires only translating these
text artifacts, without changing the processing stages.
4. Experiments
Automated grading quality has important qualitative as-
pects that are not fully captured by aggregate metrics
alone (e.g., the coherence and pedagogical usefulness of
the generated feedback).
Therefore, in addition to the
quantitative evaluation reported below, we provide sup-
plementary material, comprised of the scanned reference
solution of the ”Class B” exam, and a corresponding mock
solution, which was actually graded by the pipeline using
GPT-5.2 with thinking set to ”high”. We provide these
materials to illustrate the structure and depth of the pro-
duced feedback. The link to the supplementary material is
provided at the end of the manuscript.
4.1. Experimental protocol
Our grading pipeline is not trainable and therefore oper-
ates in a fully zero-shot setting. To limit potential bias
from iterative prompt and rubric engineering, we use a
clean-room protocol with two parallel courses: Class A
(development) and Class B (held-out evaluation).
During the semester, the system was deployed weekly
on Class A quizzes and its outputs were reviewed by
the lecturer and students, providing formative feedback
on system behavior. After week 9, the pipeline and all
prompts were frozen. The frozen system was then ap-
plied to one scanned quiz from Class B without any mod-
ifications to the pipeline, prompts, or templates.
The
only change relative to Class A was an instructor-facing
grading-rule adjustment reflecting standard practice for


circuit sketches: circuit answers were evaluated by elec-
trical topology rather than drawing orientation. All quan-
titative and qualitative results reported in this paper are
based exclusively on this held-out Class B evaluation and
are compared to grades assigned by the Class B lecturer.
To maintain separation, Class B quizzes were graded
only by the lecturer during the semester and scanned for
archival purposes. Apart from limited pilot runs in week 2
(not used for analysis), the Class B materials were not ac-
cessed or inspected by the system developers prior to the
held-out evaluation.
4.2. Dataset
Class A is an undergraduate course on communication
technologies (approximately 30 enrolled students), while
Class B is an industrial electronics course (approximately
15 enrolled students). Both courses used short weekly
written quizzes administered for 20 minutes at the begin-
ning of each lecture, covering material from the previ-
ous week. The quizzes consist of open-ended questions
requiring handwritten text and, where appropriate, hand-
drawn diagrams or schematics.
Weekly quizzes were not strictly mandatory, but pass-
ing a subset was required to qualify for the final exam;
strong weekly performance could optionally substitute the
final exam grade.
This provided meaningful incentive
while keeping overall pressure moderate. For privacy rea-
sons, we do not release student submissions, scans, or
grades; we report only aggregate performance metrics and
the exact text of the held-out evaluation questions.
Language.
The quizzes and student answers were in
a non-English language (Slovenian).
Accordingly, all
prompt pairs, grading rules, and report templates used
in the main evaluation were written in Slovenian. The
pipeline itself is language-agnostic:
language-specific
content is confined to prompts, rules, and templates,
which can be translated to other languages (including
with the assistance of modern LLM-based tools) without
changing the pipeline stages.
Held-out exam content.
Table 1 lists the three ques-
tions (with weights) from the held-out Class B quiz used
for evaluation.
4.3. Evaluation Metrics
We evaluate the grading system using exam-level metrics
that quantify agreement with human grading. As ground
truth, we use the exam grade assigned by the lecturer of
Class B, which is the only available reference.
Unless stated otherwise, all metrics are computed at the
level of the full exam (three tasks), thereby evaluating the
system in a true end-to-end setting. Importantly, we dis-
tinguish two sources of variability: (i) an internal ensem-
ble used by the grading pipeline as part of its fixed design,
and (ii) independent repetitions of the full evaluation used
only to estimate experimental variability.
Weight
Question text
25%
When using voltage dividers, we encounter a trade-
off: for certain reasons we want to construct the di-
vider using resistors with as small resistance values
as possible, while on the other hand we want the
resistances to be as large as possible. Explain this
contradiction and the reasons behind it.
25%
What condition must be satisfied when connecting
a load to a voltage divider consisting of resistors R1
and R2 in order for the load to be current-driven?
50%
Two batteries with Thevenin voltages Ut1 and Ut2
and Thevenin internal resistances Rt1 and Rt2 are
connected in parallel and then connected to a load
Rb.
• Sketch the corresponding circuit.
• Write the expression for the Thevenin resistance
of the combined source.
• Write the expression for the Thevenin voltage of
the combined source.
• Write the expression for the voltage across the
load.
Table 1. Exam questions used in the held-out evaluation. Only
question text and weights are disclosed; no student data are
shared. Questions are translated from Slovenian; translation is
provided for readability.
Pipeline parameter: ensemble size.
Within a single
pipeline execution, each task is graded by an ensemble
of K = 3 independent, stateless model calls, and the
resulting drafts are merged by a supervisor model into a
single exam-level grade. We denote this final, supervisor-
aggregated output for student i as gLLM
i
. The ensemble
size K is a fixed pipeline parameter (not varied in the ex-
periments), chosen early as a compromise between infer-
ence cost and robustness to occasional model failures.
Let N denote the number of students, gLLM
i
the exam
grade assigned by the system for student i, and gH
i the
corresponding grade assigned by the human lecturer. We
define the signed grading difference as ∆i = gLLM
i
−gH
i .
Mean Absolute Difference (MAD).
Overall grading
accuracy is measured using the mean absolute difference
between automated and human-assigned grades:
MAD = 1
N
N
X
i=1
|∆i| .
(1)
Standard Deviation of Absolute Differences.
To cap-
ture the variability of grading errors across students, we
compute the standard deviation of absolute differences:
σ|∆| =
v
u
u
t 1
N
N
X
i=1
(|∆i| −MAD)2.
(2)


Grading Bias.
Systematic over- or under-grading is
quantified by the mean signed difference:
Bias = 1
N
N
X
i=1
∆i.
(3)
Manual Review Trigger Rate.
In addition to agree-
ment with human grades, we quantify the expected
amount of manual consolidation required when multiple
automated graders disagree. This metric does not rely on
human reference grades and is computed solely from the
ensemble outputs.
Let si,k denote the exam-level score assigned to student
i by grader k within the ensemble, with k = 1, . . . , K. For
a given disagreement threshold Dmax, a manual review is
triggered for student i if the maximum pairwise disagree-
ment between graders exceeds the threshold, i.e.,
max
k
si,k −min
k si,k ≥Dmax.
(4)
We define the corresponding trigger indicator as
Ti(Dmax) =
(
1,
if a review is triggered for student i,
0,
otherwise.
(5)
The manual review trigger rate at threshold Dmax is
then given by
TR(Dmax) = 1
N
N
X
i=1
Ti(Dmax).
(6)
In this work, TR(Dmax) is estimated at the exam level,
using final exam scores produced by each grader. In prac-
tical deployments, the same criterion could be applied at a
finer granularity, such as the level of individual questions
or answers, to further localize and reduce the required
amount of human intervention.
Experimental
parameter:
evaluation
repetitions.
Separately from the pipeline ensemble, we repeat the en-
tire evaluation R = 3 times to measure run-to-run vari-
ability due to stochastic model outputs. Each repetition
corresponds to a full rerun of the grading pipeline (includ-
ing all model calls and supervisor aggregation) with the
system configuration unchanged. For each metric, we re-
port the three per-run values, together with their mean and
standard deviation across the R repetitions. The choice
R = 3 reflects a practical compromise between robust-
ness and the computational cost of repeated multimodal
inference.
5. Results
All results are reported on the held-out Class B exam
(Sec. 4). We use the exam-level metrics defined in Sec. 4.3
(MAD, σ|∆|, Bias) and, where relevant, the manual re-
view trigger rate based on grader disagreement. Unless
Figure 3.
Baseline exam-level performance across backends
(mean over R = 3 repetitions where available; GPT-5.2-pro:
single run).
noted otherwise, each backend was evaluated with the full
pipeline configuration and repeated R = 3 times to es-
timate experimental variability; GPT-5.2-pro is reported
from a single run due to cost. OpenAI models were ac-
cessed via the official OpenAI API [17], while other mod-
els were accessed via OpenRouter [20].
Model viability screening.
Figure 3 compares back-
ends under the full pipeline.
The strongest back-
ends (GPT-5.2, GPT-5.2-pro, and Gemini-3 Pro) achieve
single-digit MAD with low bias, indicating close agree-
ment with the lecturer’s exam grades. In contrast, GPT-4o
and Mistral 3 exhibit substantially larger deviations; Mis-
tral 3 also shows a pronounced positive bias, consistent
with systematic over-grading on this exam.
Ablation on pipeline guidance.
To isolate the effect of
prompt engineering and reference conditioning, we evalu-
ate two strong backends under a trivial prompting regime
(Fig. 4).
In this setting, the prompts only enforce the
Markdown output format, but omit grading rules, omit the
reference-solution summary, and disable supervisor ag-
gregation. Because aggregation is disabled, we treat the
three per-grader outputs as independent grading attempts
and report their mean. For both GPT-5.2 and Gemini-3
Pro, trivial prompting increases MAD and introduces a
strong positive bias, confirming that structured prompting
and reference grounding are necessary to obtain reliable
grading.
Estimated manual review workload.
Figure 5 reports
the fraction of submissions that would require manual
consolidation as a function of the disagreement thresh-


Figure 4. Full pipeline vs. trivial prompting for two strong back-
ends (trivial: no rules, no reference, no supervisor).
Figure 5. Estimated manual review trigger rate vs. disagreement
threshold Dmax (mean over repetitions where available).
old Dmax, computed at the exam level from the ensemble
grader outputs. At strict thresholds (e.g., Dmax = 20–
30 points), weaker backends yield substantially higher
review rates, reflecting less stable grading.
For larger
thresholds the trigger rate drops for all models, indicat-
ing that only a small subset of submissions exhibit se-
vere grader disagreement. This analysis complements ac-
curacy metrics by quantifying the expected human effort
required to safely deploy the system.
Ablation on reference conditioning.
Table 2 ablates
reference usage for the two best backends (GPT-5.2,
Gemini-3 Pro) under three regimes: Full pipeline (ref-
erence extracted to text and injected into prompts), No
reference, and Image reference (reference image only,
no text extraction).
Each cell reports run1/run2/run3
and mean±std; best results per model and metric are
boldfaced. We report MAD, σ|∆|, Bias, and the exam-
level manual review trigger rate TR(Dmax = 40) from
per-grader scores. For GPT-5.2, removing the reference
increases MAD and introduces a strong positive bias;
image-only reference partly recovers MAD but remains
biased, highlighting the role of text extraction for cali-
brated scoring. For Gemini-3 Pro, both ablations primar-
ily increase positive bias with limited gains in MAD/σ|∆|,
consistent with pipeline development being carried out
mainly on GPT-5 models, yielding a larger benefit for
GPT-5.2 than for Gemini.
Student feedback (Class A).
We collected preliminary
student feedback in Class A after real use of the system
on 8 weekly AI-graded quizzes. A total of 14 students
completed an anonymous questionnaire; at the time of
the survey, students had already received detailed PDF
feedback and had access to a complaint process. Atti-
tudes toward AI-first grading were mostly positive: 64%
reported a positive stance or preference, 21% negative,
and 14% indifferent. When asked whether they benefit
from the system, 71% answered yes (29% no). Reported
benefits (multiple-choice) were primarily detailed expla-
nations (41%), perceived fairness/impartiality (34%), and
fast turnaround (21%). The main concerns were missed
answers (35%), more mistakes than professors (26%), and
changed exam difficulty (22% less demanding, 17% more
demanding). Overall, 43% judged that advantages out-
weigh disadvantages, 29% the opposite, and 21% reported
no difference.
6. Discussion
To the best of our knowledge, the literature does not yet
describe a comparable end-to-end framework that grades
scanned, multi-page, handwritten STEM exams with di-
agrams using multimodal LLMs while producing deter-
ministically parseable outputs with explicit guardrails, ag-
gregation, and auditable reports. Our results show that,
with such workflow design, modern multimodal back-
ends can grade short engineering quizzes with agreement
close enough to enable practical use with limited man-
ual intervention. In informal discussions with instructors,
we repeatedly encountered skepticism that this would be
achievable for unconstrained handwriting and sketches at
the level of accuracy reported here; these experiments pro-
vide evidence that the capability is now real when the
system is engineered around model failure modes rather
than idealized prompts. A key contextual point is tim-
ing: in our experience, this type of end-to-end approach
only became practically viable with the late-2025 gener-
ation of multimodal reasoning-capable models released


Model
Regime
MAD
σ|∆|
Bias
TR(Dmax = 40) [%]
GPT-5.2
Full pipeline
7.7/8.4/7.4
(7.8±0.4)
4.2/6.5/6.9
(5.9±1.2)
0.6/-0.4/0.3
(0.2±0.4)
16.7/16.7/16.7%
(16.7±0.0)%
No reference
9.8/11.2/9.5
(10.2±0.8)
8.4/6.4/6.0
(6.9±1.1)
6.5/6.4/6.1
(6.4±0.2)
22.2/16.7/16.7%
(18.5±2.6)%
Image reference
7.7/8.2/8.2
(8.1±0.2)
5.9/4.9/7.1
(6.0±0.9)
3.9/3.4/4.8
(4.0±0.5)
16.7/16.7/16.7%
(16.7±0.0)%
Gemini-3 Pro
Full pipeline
7.1/9.8/6.7
(7.9±1.4)
5.0/15.1/5.7
(8.6±4.6)
3.0/-2.7/0.7
(0.3±2.3)
16.7/16.7/16.7%
(16.7±0.0)%
No reference
7.4/8.9/9.6
(8.6±0.9)
6.8/8.2/8.6
(7.9±0.8)
6.6/8.4/9.0
(8.0±1.0)
16.7/16.7/16.7%
(16.7±0.0)%
Image reference
7.9/8.5/8.4
(8.3±0.3)
6.9/6.2/7.4
(6.9±0.5)
7.1/7.8/7.7
(7.5±0.3)
16.7/16.7/16.7%
(16.7±0.0)%
Table 2.
Ablation study on the two best-performing backends under three reference regimes: Full pipeline (reference extracted
into text and injected into prompts), No reference, and Image reference (reference image only, no text extraction). Each cell re-
ports run1/run2/run3 and mean±std across runs.
Metrics are exam-level MAD, σ|∆|, Bias, and the manual review trigger rate
TR(Dmax = 40) computed from per-grader exam scores. Best results per model and metric are highlighted in bold (lowest mean; for
Bias, smallest absolute mean).
by major providers (e.g., GPT-5/GPT-5.2 and Gemini 3)
[8, 18, 19]. Earlier backends in our screening exhibit sub-
stantially larger deviations and stronger bias (Fig. 3), re-
inforcing the need for both capable models and systems-
level safeguards. The presented pipeline was built first for
real instructional use, not as a benchmark-optimized re-
search prototype. Accordingly, our evaluation is prelimi-
nary: results are reported on one held-out quiz with a sin-
gle human grader as reference, and the underlying exam
data cannot be released in its raw form due to privacy con-
straints. We therefore plan to expand validation to a larger
and more diverse collection and, following privacy review
and institutional approval, release the code, prompts, and
an accompanying dataset suitable for standardized evalu-
ation. The absence of widely usable end-to-end datasets
for authentic handwritten exam grading remains a practi-
cal barrier for the field; we view this work as an initial step
toward making such evaluation feasible and repeatable.
7. Conclusion
We presented an end-to-end workflow for grading scanned
handwritten engineering exams with multimodal LLMs.
The core contribution is a robust system design that cou-
ples prompt pairs and rigid templates with deterministic
validation, ensemble grading, and supervisor aggregation
to turn probabilistic model behavior into auditable grad-
ing artifacts. On a held-out real course quiz, state-of-the-
art multimodal backends achieve close agreement with
lecturer grades and manageable estimated manual-review
rates, indicating that deployment is plausible for short
formative assessments.
We release this as preliminary
evidence that automated grading of realistic handwritten
STEM work is now achievable under careful workflow
constraints, and we plan broader evaluation and open-
sourcing (with an accompanying dataset) after further val-
idation and privacy review.
Ethical considerations
The ethical consideration of this research research aims
to protect both study participants and future users of the
proposed technology. Key ethical concerns include the
handling of sensitive data (e.g., grades), the risk that par-
ticipation in the experiment could affect student perfor-
mance, and the power imbalance between students and in-
structors.
Our approach is guided by the three principles of the
Belmont Report [29]:
1. Respect for persons: safeguarding autonomy through
dignity, agency, and informed consent;
2. Beneficence:
maximizing potential benefits while
minimizing risks and harms; and
3. Justice: ensuring equitable treatment and a fair distri-
bution of benefits and burdens.
In this context, a central consideration is whether the
anticipated benefits justify the burdens placed on the af-
fected population. Potential benefits to students include
(i) more objective grading and (ii) higher-quality feed-
back from their instructors.
Individualized feedback is
especially valuable because it is often infeasible for in-
structors to provide at scale. The resulting feedback may
also support improvements to course design and teaching
practices. Importantly, the automated grading system did
not affect students’ official course or exam grades; all as-
sessments were graded manually as they would have been
without the study.
A full-scale deployment would require formal ethical
review, including evaluation of the experimental design
and data-protection measures. Nonetheless, we conclude
that the anticipated benefits to students outweigh the asso-
ciated burdens.


Disclosure of AI use
The whole orchestration pipeline and the experimental
code (approximately 13.000 lines of python code) has
been written with the help of GPT5-codex tool and GPT5-
pro models by OpenAI. Search for related work was done
using OpenAI’s AI agent (DeepResearch), and manuscript
text was written by dictating the contents to the GPT5-pro.
The manuscript has been throroughly checked by the au-
thors and revised where necessary.
Supplementary material
We provide the scanned reference solution of the ”Class
B” exam, and a corresponding mock solution, which was
actually graded by the pipeline using GPT-5.2 with think-
ing set to ”high”. It can be accessed via the following
link: https://lmi.fe.uni-lj.si/en/janez-
pers-2/supplementary-material/
Acknowledgements
We acknowledge the support of the EC/EuroHPC JU and
the Slovenian Ministry of HESI via the project SLAIF
(grant number 101254461).
References
[1] Sami Baral, Anthony F. Botelho, John A. Erickson,
Priyanka Benachamardi, and Neil T. Heffernan. Improving
automated scoring of student open responses in mathemat-
ics. In Proceedings of the 14th International Conference
on Educational Data Mining (EDM 2021), pages 130–138,
Paris, France, 2021. International Educational Data Mining
Society. Conference dates: June 29–July 2, 2021. 3
[2] Sami Baral, Anthony Botelho, Abhishek Santhanam,
Ashish Gurung, Li Cheng, and Neil Heffernan.
Auto-
scoring student responses with images in mathematics. In
Proceedings of the 16th International Conference on Ed-
ucational Data Mining, pages 362–369, Bengaluru, India,
2023. International Educational Data Mining Society. 3
[3] Sami Baral, Lucy Li, Robert Knight, Alice Ng, Luca Sol-
daini, Neil Heffernan, and Kyle Lo. DrawEduMath: Eval-
uating vision language models with expert-annotated stu-
dents’ hand-drawn math images.
In Proceedings of the
2025 Conference of the North American Chapter of the
Association for Computational Linguistics: Human Lan-
guage Technologies, pages 7110–7132. Association for
Computational Linguistics, 2025. arXiv version: https:
//arxiv.org/abs/2501.14877. 3
[4] Steven Burrows, Iryna Gurevych, and Benno Stein. The
eras and trends of automatic short answer grading. Inter-
national Journal of Artificial Intelligence in Education, 25
(1):60–117, 2015. 2
[5] Adriana Caraeni, Alexander Scarlatos, and Andrew S. Lan.
Evaluating GPT-4 at grading handwritten solutions in math
exams, 2024. 2, 3
[6] Alberto Gandolfi. GPT-4 in education: Evaluating aptness,
reliability, and loss of coherence in solving calculus prob-
lems and grading submissions. International Journal of
Artificial Intelligence in Education, 35(1):367–397, 2024.
2
[7] Christian Gold and Torsten Zesch.
Handwritten ASAP
short answer scoring. Zenodo dataset, 2020. Version 1.0;
accessed 2025-12-14. 3
[8] Google. A new era of intelligence with Gemini 3. https:
//blog.google/products/gemini/gemini-
3/, 2025. Accessed: 2025-12-23. 8
[9] Stefan Haller, Adina Aldea, Christin Seifert, and Nicola
Strisciuglio. Survey on automated short answer grading
with deep learning: from word embeddings to transform-
ers, 2022. 2
[10] Owen Henkel, Adam Boxer, Libby Hills, Bill Roberts,
and Zachary Levonian. Can large language models make
the grade? an empirical study evaluating LLMs’ ability
to mark short answer questions in K-12 education.
In
Proceedings of the 11th ACM Conference on Learning
@ Scale (L@S), pages 300–304, 2024.
arXiv version:
https://arxiv.org/abs/2405.02985. 2
[11] Gerd Kortemeyer. Performance of the pre-trained large lan-
guage model GPT-4 on automated short answer grading.
Discover Artificial Intelligence, 4(1):47, 2024. Open PDF
also available via ETH Research Collection (see Springer
page for links). 2
[12] Gerd Kortemeyer, Julian N¨ohl, and Daria Onishchuk.
Grading assistance for a handwritten thermodynamics
exam using artificial intelligence: An exploratory study.
Physical Review Physics Education Research, 20(2):
020144, 2024. 2, 3
[13] Andrew S. Lan, Divyanshu Vats, Andrew E. Waters, and
Richard G. Baraniuk. Mathematical language processing:
Automatic grading and feedback for open response math-
ematical questions.
In Proceedings of the Second ACM
Conference on Learning @ Scale (L@S), pages 167–176,
2015. 2
[14] Learnosity. A third of US teachers considered leaving edu-
cation in last 12 months due to grading workload. Learnos-
ity EdTech Blog (Press Release), 2025. Published 26 Mar
2025. 1
[15] Tianyi Liu, Julia Chatain, Laura Kobel-Keller, Gerd Ko-
rtemeyer, Thomas Willwacher, and Mrinmaya Sachan.
AI-assisted automated short answer grading of handwrit-
ten university level mathematics exams, 2024.
HTML:
https://arxiv.org/html/2408.11728v1. 2,
3
[16] Ahmed E. Magooda, Mohamed A. Zahran, Mohsen A.
Rashwan, Hazem M. Raafat, and Magda B. Fayek. Vec-
tor based techniques for short answer grading. In Proceed-
ings of the 29th International Florida Artificial Intelligence
Research Society Conference (FLAIRS), pages 238–243,
2016. 2
[17] OpenAI. OpenAI API Reference. Online documentation,
2025. Accessed 2025-12-23. 6
[18] OpenAI. Introducing GPT-5. https://openai.com/
index/introducing- gpt- 5/, 2025.
Accessed:
2025-12-23. 8
[19] OpenAI.
Introducing GPT-5.2.
https://openai.
com/index/introducing-gpt-5-2/, 2025. Ac-
cessed: 2025-12-23. 8
[20] OpenRouter.
OpenRouter API Documentation.
Online
documentation, 2025. Accessed 2025-12-23. 6
[21] Behnam Parsaeifard, Martin Hlosta, and Per Bergamin.
Automated grading of students’ handwritten graphs: A


comparison of Meta-Learning and Vision-Large language
models, 2025. 3
[22] Vijay Rowtula, Subba Reddy Oota, and C. V. Jawahar. To-
wards automated evaluation of handwritten assessments. In
2019 International Conference on Document Analysis and
Recognition Workshops (ICDARW), pages 19–24, 2019. 2
[23] Keisuke Sakaguchi, Michael Heilman, and Nitin Mad-
nani. Effective feature integration for automated short an-
swer scoring. In Proceedings of the 2015 Conference of
the North American Chapter of the Association for Com-
putational Linguistics: Human Language Technologies,
pages 1049–1054, Denver, Colorado, 2015. Association
for Computational Linguistics. 2
[24] Carolin Schwab, Anne C. Frenzel, Jordan Jaeger, Allison
BrckaLorenz, and Robert H. Stupnisky. How do university
faculty feel about grading? insights from a control-value
theory perspective. Studies in Higher Education, 49(8):
1486–1503, 2024. Published online 15 Oct 2023. 1
[25] Arjun Singh, Sergey Karayev, Kevin Gutowski, and Pieter
Abbeel. Gradescope: a fast, flexible, and fair system for
scalable assessment of handwritten work.
In Proceed-
ings of the Fourth ACM Conference on Learning @ Scale
(L@S), pages 81–88, 2017. 2
[26] Sargur N. Srihari, Rohini Srihari, Pavithra Babu, and Har-
ish Srinivasan. On the automatic scoring of handwritten
essays. In Proceedings of the 20th International Joint Con-
ference on Artificial Intelligence (IJCAI-07), pages 2880–
2884, 2007. 2
[27] Le Ying Tan, Shiyu Hu, Darren J. Yeo, and Kang Hao
Cheong. A comprehensive review on automated grading
systems in STEM using AI techniques. Mathematics, 13
(17):2828, 2025. 1, 2
[28] Youki Terada and Stephen Merrill. Why teachers should
grade less frequently. Edutopia, 2024. Published 08 Nov
2024. 1
[29] The National Commission for the Protection of Human
Subjects of Biomedical and Behavioral Research. The bel-
mont report: Ethical principles and guidelines for the pro-
tection of human subjects of research, 1979.
Published
April 18, 1979. U.S. Department of Health, Education, and
Welfare. Hosted by the U.S. HHS Office for Human Re-
search Protections (OHRP). 8


