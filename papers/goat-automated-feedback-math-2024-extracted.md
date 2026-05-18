---
source_file: "goat-automated-feedback-math-2024.pdf"
type: paper
---

# goat-automated-feedback-math-2024

Automated Feedback in Math Education: A Comparative
Analysis of LLMs for Open-Ended Responses
Sami Baral
Worcester Polytechnic Institute
sbaral@wpi.edu
Eamon Worden
Worcester Polytechnic Institute
elworden@wpi.edu
Wen-Chiang Lim
Worcester Polytechnic Institute
wlim@wpi.edu
Zhuang Luo
Worcester Polytechnic Institute
zluo3@wpi.edu
Christopher Santorelli
Worcester Polytechnic Institute
cjsantorelli@wpi.edu
Ashish Gurung
Carnegie Mellon University
agurung@andrew.cmu.edu
Neil Heffernan
Worcester Polytechnic Instittue
nth@wpi.edu
ABSTRACT
The effectiveness of feedback in enhancing learning outcomes
is well documented within Educational Data Mining (EDM).
Various prior research has explored methodologies to en-
hance the effectiveness of feedback. Recent developments in
Large Language Models (LLMs) have extended their utility
in enhancing automated feedback systems. This study aims
to explore the potential of LLMs in facilitating automated
feedback in math education. We examine the effectiveness
of LLMs in evaluating student responses by comparing 3 dif-
ferent models: Llama, SBERT-Canberra, and GPT4 model.
The evaluation requires the model to provide both a quan-
titative score and qualitative feedback on the student’s re-
sponses to open-ended math problems. We employ Mistral,
a version of Llama catered to math, and fine-tune this model
for evaluating student responses by leveraging a dataset of
student responses and teacher-written feedback for middle-
school math problems.
A similar approach was taken for
training the SBERT model as well, while the GPT4 model
used a zero-shot learning approach. We evaluate the model’s
performance in scoring accuracy and the quality of feedback
by utilizing judgments from 2 teachers. The teachers utilized
a shared rubric in assessing the accuracy and relevance of
the generated feedback. We conduct both quantitative and
qualitative analyses of the model performance. By offering
a detailed comparison of these methods, this study aims to
further the ongoing development of automated feedback sys-
tems and outlines potential future directions for leveraging
generative LLMs to create more personalized learning expe-
riences.
Keywords
Auto-Scoring, Automated Feedback, Open-End Problems,
Large Language Models, Online Learning Platforms
1.
INTRODUCTION
The growing integration of online learning platforms into
traditional educational settings has influenced the devel-
opment and direction of educational research. The global
pandemic, COVID-19, resulted in the adoption of Online
Learning Platforms (OLP)[3]. Consequently, various OLPs,
especially in math education, have gained popularity over
the recent years [34].
With the popularity of these plat-
forms, there has been various research investigating effec-
tive teaching strategies, with many reporting on the benefit
of timely and immediate feedback [14, 32, 19].
Feedback
plays a crucial role in facilitating effective learning experi-
ences, offering more than just assessments on the correct-
ness of their answer by providing student-specific guidance.
Timely feedback, in particular, can be highly effective in en-
abling students to rectify misunderstandings, bridge gaps in
knowledge, or navigate to subsequent stages of their learning
requirements. Prior exploration of effective feedback has re-
ported on the effectiveness of feedback in enhancing learning
outcomes, including the use of hints [53], explanations [39],
worked-out examples [13], and common wrong answer feed-
back [22, 23], while others caution against the use of certain
feedback designs, suggesting that poorly designed feedback
can inadvertently impede student progress [23].
Automated scoring has been a focus for numerous online
learning platforms, with extensive research spanning vari-
ous fields, including mathematics [6], writing[43, 36], and
programming [41, 51].
The initial works emphasized au-
tomating the grading of close-ended questions.
However,
recent advancements have extended these methodologies to
include open-ended problems as well [18]. While early ap-
plications of automated scoring primarily focused on aug-
menting teacher resources in evaluating student responses,
more recent explorations have begun to implement these
techniques directly within classroom environments [38] to
support students dynamically in real-time.
The recent advancement and innovation in Large Language
Models (LLMs), such as ChatGPT, have introduced a trans-
formative approach to crafting automated feedback systems
arXiv:2411.08910v1  [cs.CY]  29 Oct 2024


within educational platforms [2].
These developments in
LLM technology have demonstrated significant potential in
creating diverse mathematical content, providing support
for math tutoring, offering detailed explanations, and facil-
itating the development of automated tutoring systems and
educational chatbots that are adept at adapting to a wide
range of contextual nuances.
In this study, we delve into the application of pre-trained
Large Language Models (LLMs) for both scoring and pro-
viding feedback on students’ open-ended responses. We par-
ticularly assess a fine-tuned LLM derived from Mistral—a
Llama variant optimized for mathematics—and compare its
efficacy with a leading non-generative model [11], currently
used for the automated assessment of open-ended responses
in mathematics. Additionally, we explore how these meth-
ods stack up against the capabilities of the GPT-4 model.
Given the current limitations on training and fine-tuning
GPT-4, we adopt a zero-shot strategy by providing the GPT-
4 model with specific rubrics related to the open-ended ques-
tions. Toward this, we explore the following research ques-
tions:
1. How does an LLM fine-tuned (GOAT) with a dataset
of students’ responses and teacher-provided scores com-
pare to the previous state-of-the-art, SBERT-Canberra
method in predicting teacher scores for student open-
responses?
2. How does the pre-trained GPT4 model compare to the
finetuned LLM (GOAT) in the auto-scoring task for
open-ended questions?
3. Which of the three models, SBERT-Canberra, GOAT,
or GPT4 is preferred for the feedback they generate,
according to a detailed assessment protocol and human
evaluators with prior teaching experience?
2.
BACKGROUND
2.1
Open-Ended Problems
The design of instructional materials for online learning plat-
forms typically falls into two broad categories: close-ended
and open-ended problems. Close-ended problems, such as
multiple-choice questions, “check all that apply” scenarios,
and arrange in the correct order, are inherently more amenable
to automatic grading. The finite range of possible responses
in these formats facilitates the development of targeted feed-
back. On the other hand, open-ended problems include fill-
in-the-blanks as well as short and long-answer questions.
These types of questions, due to their design, require addi-
tional time and resources from the teachers in terms of grad-
ing and providing feedback compared to their close-ended
counterparts.
While close-ended problems offer the advantage of straight-
forward automation, they are prone to issues like pattern
recognition and guessing [4, 50].
This susceptibility can
sometimes lead to shallow learning and pattern recognition,
resulting in the students not engaging deeply with the ma-
terial. In contrast, open-ended questions are generally con-
sidered more rigorous [35, 26] and are believed to provide a
better gauge of a student’s depth of understanding and com-
prehension of the subject matter [5, 40, 16]. This depth and
rigor, though highly valued in educational contexts, place
substantial demands on both the learners, who must artic-
ulate their understanding more fully, and the instructors,
who face increased burdens in terms of grading and provid-
ing meaningful feedback [8].
OLPs that incorporate mathematics curricula, such as Il-
lustrative Math, EngageNY, or OpenUpResources, avail-
able through Open Educational Resources (OER) [27], typ-
ically employ a mix of problem types to enrich the learn-
ing experience. This blend aims to leverage the automated
feedback and grading capabilities of close-ended problems
while the open-ended problems allow teachers to gauge stu-
dents’ understanding and mastery of the subject matter. As
presented in Figure 1, a multi-part problem in Illustrative
Maths begins with a close-ended question to confirm basic
topic knowledge, followed by an open-ended question de-
signed to evaluate the student’s comprehension of the topic.
Several researchers and math experts have highlighted the
importance of the use of open-ended problems in the ef-
fective facilitation of the acquisition and retention of topic
knowledge learning process [35, 26].
Figure 1: Example of Close and Open-response problem types
in mathematics, taken from Illustrative Math Curriculum.
Part A, is a close-ended problem and Part B is an open-ended
math problem.
2.2
Automated Scoring
There have been many prior works that have focused on au-
tomating the assessment (i.e. grading or scoring) of student
answers to open-ended questions in the past. Much of this
work has leveraged varying approaches that leverage NLP
and machine learning.
Methods such as C-rater [37] use
techniques to normalize student responses that vary across
syntactic, morphological structure, pronouns, and synonyms
to estimate the correctness of student responses to open-
ended questions. Other approaches have explored the use
of clustering approaches to grade student responses [9, 12].
Other approaches have used deep learning methods that use
high-dimensional representations of student work and com-


pare them to exemplar samples, such as in [54] and [58].
Many prior works in NLP have leveraged or expanded upon
the idea of creating high-dimensional representations, re-
ferred to as embeddings, of student answers (e.g. Word2Vec
[44] and GloVe [52]). The SBERT-Canberra model[6] uti-
lizes a similarity-matching approach using pre-trained SBERT
embeddings.
Outperforming previous benchmarks in pre-
dicting teacher-provided scores for student answers to math-
ematics open-response problems, this method works by iden-
tifying “similar” student answers using a measure of Can-
berra distance [31] between embeddings; predicted scores
are then produced by taking the given score for the most-
similar student answer from a pool of historic responses.
2.3
Automated Feedback
Automated feedback has been utilized on a variety of do-
mains such as essays, math and coding[10, 38, 20]. Hahn
et al.[25] found prior methods have typically attempted au-
tomatic at the undergraduate level, but typically reduced
bias and assisted teachers by decreasing the time they were
required to spend grading. Prior studies in similar domains
found that consistent feedback increased student performance
in essay writing[33], and similar studies at the undergrad-
uate level have found feedback decreases math anxiety[47],
and increases reasoning abilities[21].
A literature review by Deeva et al. [17] reviewed automated
feedback models used from 2008-2018. They found the ma-
jority of automated feedback systems utilized an expert-
driven model when providing feedback to students, meaning
experts modeled student actions and provided feedback ac-
cordingly. We will utilize a data-driven are we utilize exist-
ing data to fine-tune our model, whereas many expert-driven
models lack substantial data to create models for providing
feedback. We will discuss plans to incorporate expert-data
in order to make a mixed model in the future, but we in-
tend to first demonstrate that purely data-driven fine-tuned
LLMs can outperform SBERT models.
2.4
LLMs
Recently, LLMs such as ChatGPT [48], Llama2-Chat [56],
and Vicuna [15] have emerged as breakthrough technolo-
gies in natural language processing, demonstrating impres-
sive performance in language generation and understanding
through pre-training on massive text corpora and fine-tuning
with specific instructions. Leveraging the capabilities of cus-
tom language models for feedback generation, we employ
Mistral 7B [30], an open-source LLM with outstanding per-
formance on a wide range of benchmarks.
To enhance the applicability of LLMs in downstream tasks,
various parameter-efficient fine-tuning (PEFT) techniques
have been developed. Notably, [29] introduces a low-rank
adaptation method named LoRA, which employs rank de-
composition matrices in each LLM layer while keeping all
pre-trained parameters fixed during fine-tuning. This method,
which we also adopt in this paper, aims to optimize the per-
formance of LLMs for specific tasks without altering their
original pre-trained parameters.
Additionally, there are also lots of works regarding combin-
ing LLMs and education together. [45] evaluates ChatGPT’s
ability to grade and provide feedback on students’ open-
ended self-explanations in a digital learning game, finding
that while ChatGPT performs well on conceptual questions
and generates high-quality feedback, it struggles with deci-
mal place values and number line problems. [28] explores the
ability of GPT-4 in providing feedback to human tutors on
their praise to students in synthetic dialogues, comparing its
performance with human graders and identifying areas for
improvement. [57] investigates the use of ChatGPT in gener-
ating formative feedback on Java programming assignments,
examining students’ perceptions, preferences, and sugges-
tions for improvement.
[49] explores the use of GPT-3.5
model to generate personalized feedback for programming
assignments, demonstrating its positive impact on student
performance and learning outcomes, although it may ini-
tially lead to over-reliance on the generated hints.
How-
ever, these works all focus on leveraging OpenAI’s models to
generate feedback. Our paper attempts to draw inspiration
from the concept of CLASS [55], a design methodology for
developing sophisticated Intelligent Tutoring Systems that
harness high-performance Large Language Models to offer
tutor-like guidance and cultivate interactive conversations.
We aim to adapt this approach to fine-tune an open-source
Large Language Model for enhanced feedback generation.
3.
METHODOLOGY
In this paper, we present a fine-tuned Large Language Model
based on Llama, catered to the dataset of students’ open-
ended responses in mathematics. We call this model“GOAT,”
which can generate a numeric score and textual feedback for
student open-ended responses in mathematics. We present
an in-depth analysis of this model, comparing its perfor-
mance with the established method, called SBERT-Canberra,
from the prior works and the conventional pre-trained GPT4
model. We talk about these methods in detail in the follow-
ing subsections.
3.1
Dataset
For this study, we utilize a dataset from an OLP of students’
responses to open-ended math questions with the correct-
ness scores and feedback messages given by teachers to these
open-ended responses. We selected a dataset from a specific
group of about 50 teachers who used open-ended questions
more frequently in their classrooms.
In preparation for this dataset, we excluded those that fea-
tured images within the question, including graphs or ta-
bles presented in image format, as our main focus here is on
language-based models. Additionally, we eliminated student
responses which included images or had images attached to
their answers. All HTML tags were stripped from the prob-
lems, answers, and teacher feedback messages. Lastly, we
converted math symbols, like “&ge”, into a more readable
format like “>=” that a language model could interpret.
To train and evaluate our models, we selected 50 random
open-response problems, which each had 100 student an-
swers, feedback messages, and teacher scores. We performed
an 80-20 train-test split on each question. This meant our
training set included 80 student answers, feedback messages,
and scores per problem for all 50 problems for a total of 4,000


Table 1: Examples of student open-responses with, teacher-provided feedback and scores to these answers taken from our dataset.
Problem
Student Answer
Teacher Feedback
Teacher Score
Explain why 6:4 and 18:8 are
not equivalent ratios.
You cannot multiply 4 into
6 and you cannot multiply 8
into 18.
I somewhat see what you are
doing but instead you need
to see how do you get from
6 to 18 and is that the same
scale factor to get 4 to 8.
1
Explain why 6:4 and 18:8 are
not equivalent ratios.
They are not equivalent ra-
tios because 6 went into 18,
3 times and 4 went into 8, 2
times
Great job!
4
Write
an
equation
that
represents each description.
The
opposite
of
negative
seven
–7=7
Great job!
4
Write
an
equation
that
represents each description.
The
opposite
of
negative
seven
7
Can you write an equation?
2
entries. We then evaluate our models on the remaining 20
students’ answers, feedback messages, and scores for a to-
tal of 1,000 entries. We compare each model’s score to the
teacher’s assigned score. We also utilize 2 math teachers to
manually review 100 random test entries to determine which
model performs the best. We had teachers review 2 unique
entries for each of the 50 questions in our test set.
We illustrate a few examples of open-ended problems with
student responses, teacher-provided feedback, and scores to
these responses in Table 1. Also, Table 2 presents the dis-
tribution of teacher-provided scores within our dataset.
Table 2: Score Distribution
Score
Total Responses
0
771
1
768
2
1086
3
816
4
1559
3.1.1
Illustrative Math
Illustrative Mathematics(IM) is an innovative and widely re-
spected mathematics curriculum designed to deeply engage
students in mathematics through problem-solving and inter-
active learning. IM emphasizes conceptual understanding,
problem-solving skills, and critical thinking[1] and covers a
range of grades, typically from Kindergarten through 12th
grade. Developed by the combined efforts of both grade K-
12 educators and mathematicians, this curriculum utilizes
state common core skills to ensure students learn highly val-
ued skills[42] and is considered one of the standard mathe-
matics curricula.
Illustrative Mathematics curriculum widely incorporates open-
ended type problems. The online learning platform on which
our study is based also adopts this curriculum and follows
the same scoring procedure as suggested by this curricu-
lum. As such in our study we utilize the standardized rubric
for the assessment provided by Illustrative Mathematics[1].
This rubric of assessment suggests a 0-4 points rating for
student open-responses[1]. They divide their rubric into 5
tiers which correspond to :
• Tier 1 response: Work is complete and correct, with
complete explanation or justification.
• Tier 2 response: Work shows good conceptual under-
standing and mastery, with either minor errors or cor-
rect work with insufficient explanation or justification.
• Tier 3 response:
Work shows a developing but in-
complete conceptual understanding, with significant
errors.
• Tier 4 response: Work includes major errors or omis-
sions that demonstrate a lack of conceptual under-
standing and mastery.
We translate this rubric into a 0-4 point scoring system,
where a tier 1 would correspond with a 4/4, tier 4 would
correspond with a 1/4, and no attempt would correspond
with a 0/4 as can be seen in figure 3.
3.2
SBERT-Canberra
The SBERT-Canbera method from Baral et. al [6] presents
a similarity-based ranking algorithm for automating assess-
ment for open-ended responses. This method has two parts
to it: i) predicting teacher score and ii) predicting teacher
feedback for a given student answer. Based on the sentence-
level semantic representation of students’ open-ended an-
swers, this method presents an unsupervised learning ap-
proach as shown in Figure 2. The method utilizes a historical
dataset collected from an online learning platform, consist-
ing of students’ responses with scores and textual feedback
from teachers.
The model compares any new student re-
sponse for a math problem, with the list of responses for
the same problem in the historic dataset using sentence-
level embeddings from the Sentence-BERT model [46]. Us-
ing Canberra distance[31], the model finds the most similar


answer from the historical dataset to any new student an-
swer and then suggests a score and feedback based on this
similar answer. This method is currently in practice in the
ASSISTments[27] Online learning platform, to recommend
scores and feedback suggestions to teachers to give to stu-
dents’ open-responses.
Figure 2:
SBERT-Canberra Model for Automated-scoring
and feedback for student open-responses in mathematics,
taken from the prior works of Botelho et al. [11, 6]
For our study, we leverage a different dataset than the prior
paper, on student open-responses as described in the earlier
section. We split the dataset into train and test sets, and
use the training data of 50 problems to develop the SBERT-
Canberra model and evaluate the results of this model on
the test dataset.
3.3
GOAT
The GOAT model is our fine-tuned LLM catered to the
dataset of student open responses and teacher-provided scores
to these responses. To develop the GOAT model we fine-
tune Mistral 7B[30]. We fine-tune based on Mistral since it
has shown to beat Llama 13B on math, reading comprehen-
sion and reasoning.
We fine-tuned using LoRA [29] since
it uses less GPU memory and time and avoids catastrophic
forgetting.
To acquire input-output pairs for fine-tuning, we utilize the
illustrative grading rubric to design an instructional prompt
for each pair, as shown in Figure 3, amalgamating a math
problem and a student’s answer into the input, while treat-
ing a real teacher’s score as the desired output. We utilized
4000 entries data in the training split for fine-tuning and
1000 entries for testing.
Fine-tuning spans 4 epochs with 10 warm-up steps.
We
initialize the learning rate to 0.0002 and apply a cosine an-
nealing schedule. To address memory constraints, we adopt
the gradient accumulation technique, setting gradient ac-
cumulation steps to 2, partitioned into micro-batches of 2.
The training process, conducted on a single A100 GPU, lasts
approximately 2 hours and yields a near-zero loss function
when complete.
We determined the optimal inferencing hyperparameters us-
ing a validation set of 100 entries which was a subset of
the train set.
We found argmaxc by finding the parame-
ters which minimized the MSE of our score compared to the
teacher score. We found argmaxc to be temperature set to
0.5, top p to 0.5, and top k to 30.
3.4
GPT4
GPT4 is the state-of-the-art language model developed by
OpenAI, designed to understand and generate human-like
text based on the prompts provided as input to the model.
This model has been retained on a diverse and extensive
dataset of texts available from the internet, books, and other
sources. GPT4 has proven to have significantly improved ca-
pabilities in terms of understanding the context, generating
relevant text, and handling various complex language tasks.
As such in this work, we explore the applicability of this pre-
trained language model in predicting a score and generating
appropriate feedback for students’ open-response answers in
mathematics.
For our method, we employ the“GPT4 Turbo”model, which
is the optimized version of the GPT4 model designed to en-
hance the efficiency and response time and maintain the high
quality of the original GPT4 model. With the real-world
applicability of this model, being cost and time-efficient, we
focus on the use of this version of GPT4 for our study. To
explore the performance of the pre-trained model in math
assessment tasks, we employ a zero-shot learning approach
with GPT-4, where we do not provide any context exam-
ples to the model. For this, we follow a carefully designed
prompting strategy, where we provide the model with the
problem, the student’s answer, and a scoring rubric based on
the standard illustrative math rubric. For the prompt engi-
neering process, we followed an iterative approach involving
two researchers in math education. We also got high-level
feedback from experts with teaching experiences when de-
signing the prompts. They suggested keeping the feedback
concise, using middle school-appropriate language, and not
giving the answer away through the feedback. We incorpo-
rated this feedback in our prompts, and the final prompt for
the study is shown in Figure 3.
3.5
Evaluation
There are two main parts of the models in this study: i)
Predicting a Score and ii) Generating Feedback. Thus, we
employ different methods of evaluation for investigating and
comparing the performances of these models for the tasks of
scoring and generating feedback.
3.5.1
Scoring Evaluation
For the Scoring task, we employ three different evaluation
metrics: i) the area under the curve (AUC), ii) the Root
mean squared error (RMSE), and iii) multi-class Cohen’s
Kappa. Given that the scores for these responses range on a
5-point integer scale ranging from 0 to 4, similar to the prior
works[6] we employ AUC calculated using the simplified
multi-class calculation of ROC AUC, calculating an average


Figure 3: The fine-tuning process for the GOAT model for the downstream task of predicting teacher score and feedback for
student open-responses in mathematics.
Table 3: Final Prompt used as input for GPT-4 model to
generate score and feedback for student open-ended responses
in mathematics.
You are a middle school math teacher, giving helpful
feedback to students on their mathematical reason-
ing on open-response questions. Keep your feedback
direct, under 50 words, and do not give away the an-
swer in your feedback.
Problem:
{body}
Student’s Answer:
{value}
Scoring Rubric:
1
Students should get 4 points if their work is com-
plete and correct, with complete explanation or
justification.
2
Students should get 3 points if their work shows
good conceptual understanding and mastery,
with either minor errors or correct work with in-
sufficient explanation or justification.
3
Students should get 2 points if their work shows
a developing but incomplete conceptual under-
standing, with significant errors.
4
Students should get 1 point if their work includes
major errors or omissions that demonstrate a
lack of conceptual understanding and mastery.
5
Students should get 0 points if they do not at-
tempt the problem at all.
AUC over each score category. We use this as the primary
metric for evaluating the performance of the models in pre-
dicting teacher-provided scores for a given student answer.
We employ RMSE which is calculated using the model’s es-
timates as a continuous-valued integer scale, and calculate
the multi-class Cohen’s Kappa to measure the inter-rater
agreement for the scoring task.
3.5.2
Feedback Evaluation
For the evaluation of the generated feedback messages, we
employ two human evaluators and use a detailed assessment
rubric.
The evaluators for the feedback messages are the
trailing authors of this paper and are Ph.D. students in ed-
ucational technology with prior teaching experience at the
school and college levels. These human evaluators had very
little to no information about the models being used in this
study. For the study, we randomly sampled a dataset of 100
student answers across 50 different math problems from the
test dataset, and the evaluators rated three different feed-
back messages across the 100 sampled student answers.
The evaluation rubric is based on: accuracy, relevancy, and
the motivational aspects of the feedback messages.
Accuracy:
We define accuracy as the factual correctness of
the generated feedback. This is a crucial factor for evalua-
tion to ensure that the generated feedback is free of any fac-
tual errors. Accuracy is rated on a binary 0-1 scale where a
score of 1 indicates the feedback was accurate and a score of
0 indicates the feedback was inaccurate. Further, if feedback
was too vague to reflect any factual correctness, the accu-
racy would be determined by the correctness of the feedback
in response to the student’s answer. For example, Feedback
such as “Correct Answer!” was deemed accurate only if it
accurately reflected the student’s performance.
Relevancy:
Relevancy refers to whether or not feedback
is relevant to a student’s answer or the context of the cur-
rent problem. For instance, providing a complete problem
explanation to every student, regardless of their answer’s
correctness, would often be deemed irrelevant. Relevancy


was also rated on a binary 0-1 scale.
Motivation:
Motivation is rated on a 3-point scale as either
-1, 0, or 1. A feedback with motivational aspect would be
rated as 1, neutral feedback would be rated as 0 and de-
motivational feedback would be rated as -1. For example,
responses that said “Good job”, or began with “Great start,
...” were considered motivating. Responses that were explic-
itly demotivating, such as “I am disappointed” were scored
as -1, and everything else was scored as 0.
Preferred Model:
In addition to the above-mentioned cri-
teria, the human raters were asked about their preferences
on which of the three feedback messages they would pick to
give out to their students.
Finally, at the end of this evaluation, we also asked both
teachers to provide their overall recommendations and their
perspectives on the quality of feedback generated by the
three models involved in this research.
4.
RESULTS
4.1
Scoring Evaluation
Our comparison of the performance of three advanced mod-
els: SBERT-Canberra, GOAT, and GPT-4, in terms of their
accuracy in predicting scores provided by teachers, is pre-
sented in Table 4. These models were evaluated using three
different metrics–AUC, RMSE, and Kappa– to ensure a com-
prehensive assessment of their predictive capabilities.
Among the three models, the GOAT model outperformed
the SBERT-Canberra and GPT-4 models across all three
evaluation metrics used. Specifically, the GOAT model achieved
an AUC score of 0.7, indicating its strong ability to dif-
ferentiate between score predictions as ordinal labels. Fur-
thermore, it showed a Root Mean Square Error (RMSE) of
1.119, reflecting its precision in predicting numerical scores,
and a Kappa score of 0.422, showcasing 42% agreement with
teacher-provided scores beyond chance.
The SBERT-Canberra model, while not outperforming the
GOAT model, had the second-highest AUC score of 0.66 and
Kappa of 0.362. However, it is noteworthy that the SBERT-
Canberra model had a higher RMSE of 1.364 compared to
the GPT-4 model, which achieved an RMSE of 1.16. Indi-
cating that while the SBERT-Canberra model is relatively
strong in predicting the actual scores considering the scores
as ordinal labels, it is likely to make more errors on average
when considering these scores as continuous values.
The GPT-4 model, with an AUC score of 0.639 and a Kappa
score of 0.266, ranked lower in classification performance
and agreement with teacher scores compared to the other
models. However, its RMSE indicates a relatively moderate
level of accuracy in predicting the actual scores, with better
performance than that of the SBERT-Canberra model but
slightly poorer performance than the GOAT model.
4.2
Feedback Evaluation
We conducted a qualitative study using two human evalua-
tors to examine the LLM-generated feedback. Both evalu-
ators were experienced teachers with more than 3 years of
Table 4: Model Performances on Scoring
Model
AUC
RMSE
Kappa
SBERT
0.662
1.364
0.362
GOAT
0.697
1.119
0.422
GPT-4
0.639
1.16
0.266
teaching experience. The evaluation of the feedback gener-
ation was conducted on 4 key criteria: accuracy, relevancy,
motivation, and overall preference. Accuracy is quantified
as the factual correctness of the feedback message, reflect-
ing how often models provided accurate math information.
Relevancy represents the applicability of the feedback mes-
sages, presenting how often feedback was directly related to
the student’s answer. Motivation aims to identify whether
feedback is motivating, neutral, or demotivating, and pref-
erence represents the teacher’s preference for the feedback
message as judged by our human evaluators.
We defined a message as accurate or relevant if it was unani-
mously recognized as such by both evaluators. In the aspect
of feedback accuracy, the GPT-4 model excelled beyond the
SBERT and GOAT models, achieving a consensus accuracy
rate of 86% from both evaluators. In contrast, GOAT and
SBERT were deemed accurate 68% and 52% times, respec-
tively, by the evaluators. The result for this is presented in
Table 5.
Table 5: Teacher Evaluations for the Accuracy of Generated
Feedback
Evaluator
SBERT
GOAT
GPT-4
Teacher 1
57
69
89
Teacher 2
85
91
96
Consensus
52
68
86
For the relevance of feedback as presented in Table 6, GPT-
4 once again outperformed the other two models, securing
a unanimous relevance score of 91% from the evaluators.
GOAT was closely behind with 88% relevance, nearly match-
ing GPT-4, whereas SBERT received a lower relevance score
of 76%.
Table 6: Teacher Evaluations for the Relevancy of Generated
Feedback
Evaluator
SBERT
GOAT
GPT-4
Teacher 1
84
91
93
Teacher 2
90
96
97
Consensus
76
88
91
In the evaluation of motivational aspects, feedback was cate-
gorized as motivating if at least one evaluator found it to be
so and similarly categorized as demotivating under the same
criterion. The results of the models on the motivational as-
pect are presented in Tables 7 and 8. In terms of motiva-
tional impact, the models showed similar performance, with
GPT-4 slightly ahead at a 52% motivation score, followed
by GOAT at 48%, and SBERT at 46%.


When examining the presence of demotivating elements within
the feedback messages, GPT-4 exhibited the least, with only
1% of its feedback being categorized as demotivating.
In
comparison, GOAT had a slightly higher incidence of de-
motivating content at 5%, and SBERT showed the most,
with 11%, indicating that GPT-4’s feedback contained the
least demotivational language, whereas GOAT and SBERT
utilized more.
Table 7: Teacher Evaluations for Motivation of Generated
Feedback
Evaluator
SBERT
GOAT
GPT-4
Teacher 1
45
47
52
Teacher 2
40
36
27
Consensus
46
48
52
Table 8: Teacher Evaluations for Demotivation of Generated
Feedback
Evaluator
SBERT
GOAT
GPT-4
Teacher 1
11
5
0
Teacher 2
0
4
1
Consensus
11
5
1
In the final analysis of model preference, GPT-4 outper-
formed the other two models in terms of favorability. On
average, the GPT-4 generated feedback was chosen 77.5%
of the time, while both GOAT and SBERT were selected
only 12% of the time each.
Table 9: Preferred Model
Evaluator
SBERT
GOAT
GPT-4
Teacher1
15
19
69
Teacher2
9
5
86
Avg. Percent
12%
12%
77.5%1
Unsurprisingly, GPT-4 excelled across the entire feedback
generation rubric. Its standout performance can be attributed
to the advanced capabilities of LLMs like GPT-4 in mim-
icking human-like fluency and readability, factors that un-
doubtedly swayed the evaluators’ assessments. Consequently,
GPT-4’s superior proficiency in these areas led it to outshine
the others in our qualitative evaluation.
5.
DISCUSSION
5.1
Scoring
In this paper, we introduce the GOAT model, a fine-tuned
bespoke solution designed for predicting scores and generat-
ing feedback for student responses to open-ended math ques-
tions. Our results demonstrate that GOAT outperforms the
previous benchmark set by the SBERT-Canberra model in
the auto-scoring domain across all three evaluation metrics:
AUC, RMSE, and Kappa. However, the model’s accuracy,
while fair, signals the need for further refinements before
full-scale deployment is feasible.
Notably, both GOAT and SBERT outperformed the GPT-4
model in the scoring task. However, it’s crucial to recog-
nize that GPT-4 serves as a generic pre-trained model and
hasn’t undergone any task-specific fine-tuning or training
that both SBERT and GOAT have undergone by utilizing
teacher grades on student responses. This distinction is un-
derscored by the alignment between the scoring patterns of
SBERT and GOAT with those of the teachers, particularly
in their propensity to award scores of 4. In contrast, GPT-
4’s achieved a distinct score distribution, as illustrated in
Figure 4. This variance highlights the nuanced differences
in model training and the potential impact on their scoring
capabilities. Given that the GPT-4 model utilized a grad-
ing rubric from Illustrative Math to assess the quality of
student responses, future research should delve into the spe-
cific factors contributing to the differences in grading out-
comes between GPT-4 and the other models.
Identifying
the root cause of this grading discrepancy is essential. It
could indicate whether the variance is due to teachers’ le-
niency stemming from personalization, a misalignment be-
tween the rubric’s literal interpretation and teacher expecta-
tions in practice, or perhaps a combination of both factors.
Figure 4: Score Distribution of Teachers compared to the
three models of SBERT, GOAT and GPT-4 across the test
dataset used for the study.
5.2
Feedback
For the feedback generation task, the GPT-4 model proved
to outperform the GOAT and the SBERT-Canberra mod-
els across all the evaluation measures as judged by human
raters. This highlights the applicability of GPT-4 models
in educational platforms for developing automated-feedback
systems.
Further, the proposed GOAT model proved to
outperform the prior state-of-the-art SBERT model though
both have comparable scores.
GPT4 proved to be both raters’ favorite model, however,
GOAT proved to be as good as if not better than BERT.
Both teacher 1 and GPT4 ranked GOAT as significantly
more accurate and relevant than SBERT. While neither GOAT
or SBERT was picked a significant portion of the time, GOAT
was rated as accurate 68% of the time by both raters, whereas
SBERT was only rated as accurate by both raters 52% of the
time. GPT was rated as the most accurate being rated as
accurate by both raters 86% of the time. Similarly, GOAT
was rated as relevant 88% of the time compared to 76% for
SBERT, while GPT-4 was still the highest at 91%.
Teacher 1 considered the following demotivating: “ask for


help!” which occurred 6 times by GOAT, whereas Teacher
2 viewed it as neither motivating nor demotivating. Baral
et al.
[7] found such phrases can be interpreted as both
motivating or demotivating.
While Teacher 1 viewed the
exclamation mark at the end as demotivating, Teacher 2
felt it was simply encouragement for the student to ask for
help from the teacher. One reason for this difference may be
the different cultural and teaching backgrounds of the teach-
ers. Teacher 1 was from Singapore, whereas Teacher 2 was
from the United States and they showed to have different
interpretations of what was motivating and demotivating.
Additionally, Teacher 1 taught at the middle school level
of mathematics, whereas Teacher 2 taught at the graduate
level which may be a cause of their disagreements over which
messages would be viewed as motivating, neutral and demo-
tivating.
5.3
Teacher Opinions
When asked about their experience, teacher 1 said they
viewed the feedback provided by large language models as
a helpful starting point, although it sometimes required ad-
ditional refinement. This teacher likened the experience to
receiving an initial draft of feedback from a teaching assis-
tant, which alleviated the cognitive load required to compose
feedback from scratch. However, the teacher observed that
among the three models, the feedback from GPT was often
more thorough, providing deeper insights into the student’s
work’s strengths and areas for improvement. Consequently,
this teacher believed that the detailed feedback from GPT
was more accessible and easier to tailor for individual needs,
in contrast to the feedback provided by the other models.
Teacher 2 said they found the responses provided by each
of the three models to be generally accurate, relevant, and
motivational. Their assessment indicated a discernible pref-
erence for the feedback of GPT. Teacher 2 denoted their
preference was influenced by a greater value in the concep-
tual details and instructions provided by generalized feed-
back rather than motivational terms which they felt had
roots in their individual teaching style. Teacher 2 described
GOAT and SBERT as rather stoic in their resultant feed-
back, which they believed would negatively affect student
acquisition of new mathematical concepts and motivation
to continue through exercises in practical use.
Although
the feedback may have been factually correct and concisely
conveyed, they felt it would at times be unrelated to the
student due to the robotic tone of its responses. They felt
GOAT provided a commendable balance between subject
matter expertise and motivational nuances which would be
necessary given the intended audience. They felt GOAT’s
responses were often too short, but that a longer more de-
tailed explanation provided in GOAT’s feedback would allow
this model to excel.
6.
LIMITATIONS AND FUTURE WORK
To contextualize the limitations of our study, it is essential
to address the primary challenge encountered during the de-
velopment of the GOAT model, which directly relates to the
dataset selection process. The main constraint in training
the GOAT model stems from our choice of dataset.
We
opted to fine-tune the model using the student data that
was available to us. However, this led to two main concerns:
First, a significant challenge was the often subpar quality
of teacher feedback. Both SBERT and GOAT models could
greatly benefit from detailed and insightful feedback from
teachers. However, due to constraints on time and resources,
teachers did not always provide feedback that was suffi-
ciently detailed or specific, leading to a collection of training
data that lacked depth and variety. This, in turn, diminished
the models’ effectiveness on test datasets. Specifically, the
feedback issues included vagueness, with minimal construc-
tive guidance; irrelevance, where generic comments were ap-
plied indiscriminately; and lack of utility, as seen in feedback
that merely labeled responses as ’incorrect’ without further
explanation. Unlike SBERT and GOAT, GPT models, such
as GPT-4, are less affected by the quality of these inputs due
to their reliance on pre-trained knowledge and the absence
of direct training from these specific examples.
Second, the performance of the models varies based on the
volume and quality of the data. SBERT, in particular, ben-
efits from a high number of student submissions featuring a
wide array of responses and detailed teacher feedback. This
environment enables SBERT to closely replicate the discern-
ment of expert teachers, allowing it to detect subtle grading
distinctions and expectations for comprehensive answers.
On the other hand, GOAT benefits from high-quality feed-
back across a variety of problems. As seen in the scoring
performance, GOAT has identified patterns in teacher scor-
ing that are not picked up on by SBERT and not captured in
the rubric utilized by GPT. Where GOAT performs poorly
is its quality of feedback, which mimics the teacher-provided
feedback, both good and bad. By training on inaccurate, ir-
relevant, demotivating, and low-quality feedback messages,
the GOAT model captures aspects of teacher feedback that
are not as meaningful.
While more high-quality training
examples on each question would be beneficial, GOAT can
benefit from high-quality training examples across multiple
questions and use the knowledge it learns for all problems
regardless of how many times it has seen each question.
To understand the discrepancies among our raters, we drew
parallels with the study by Gurung et al., [24], which inves-
tigated the variance in teacher grading of identical student
responses, both anonymized and nonanonymized. This com-
parison revealed significant inconsistencies in teacher evalu-
ations even when grading their own students’ work. Specif-
ically, the lower-performing teachers demonstrated only a
22% consistency rate above chance, while the highest per-
forming teachers reached a 73% consistency rate above chance.
These findings underscore the inherent subjectivity and vari-
ability in teacher assessments, where teachers frequently di-
verge from their own previous judgments. Furthermore, Gu-
rung et al. highlighted a tendency for teachers to grade more
leniently when aware of the students’ identities, pointing to
the influence of contextual factors, particularly those consid-
ered meaningful by the teachers, on their grading decisions.
We also recognize that many teachers do not utilize the il-
lustrative rubric when grading. They hold a mental model
of their rubric for each score on the problems. Additionally,
teachers may provide different feedback to their different
students depending on their relationship with the student,
among other factors. Additionally, some teachers may be
harde graders than others, leading to different teachers pro-


viding different scores for the same student’s answer.
We trained GOAT on a large dataset, however, we believe
that GOAT would perform significantly better if trained on
a more refined dataset. We attribute the presence of incon-
sistencies in the teacher scores and the presence of vague,
relatively shorter, and sometimes irrelevant feedback mes-
sages within the training dataset to have affected the per-
formance of the GOAT model.
Further, we believe that
many GPT responses were significantly longer and detailed
and, thus, were more helpful to students, as is reflected in
the teacher’s preferred model. As such, we intend to refine
our dataset further for the next iteration of our fine-tuned
GOAT model. We believe that training only teachers who
spend more time writing personalized feedback and supple-
menting our dataset with feedback from GPT will allow us
to provide high-quality while also capturing a human aspect
of feedback provided by teachers. We also believe that fine-
tuning on problems regardless of the number of examples for
each problem will allow us to capture more variety in math
problems and answers.
Fine-tuning on over 50 problems,
even if we don’t fine-tune on a large number of instances
per problem, will make GOAT generally better at math and
generally better at providing feedback.
Lastly, the divergence in human evaluators’ perceptions of
what constitutes demotivating feedback points to the subjec-
tive nature of educational feedback and the need for careful
consideration in future model training to ensure that the
feedback is universally constructive and encouraging.
7.
CONCLUSIONS
In this work, we present a fine-tuned GOAT model to gen-
erate a score and feedback message for a student’s open-
ended answers. Comparing this method with the traditional
method of automated assessment – the SBERT-Canberra
method and the conventional pre-trained GPT-4 model, we
find that this method outperforms both the models in the
autoscoring task. However, for the feedback generation, the
conventional GPT-4 model beats the other two when evalu-
ated by human raters with prior teaching experience.
8.
ACKNOWLEDGMENTS
We would like to thank past and current including NSF
(2118725, 2118904, 1950683, 1917808, 1931523, 1940236,
1917713, 1903304, 1822830, 1759229, 1724889, 1636782, 1535428),
IES (R305N210049, R305D210031, R305A170137, R305A170243,
R305A180401, R305A120125, R305R220012, R305T240029),
GAANN (P200A120238, P200A180088, P200A150306), EIR
(U411B190024 S411B210024, S411B220024), ONR (N00014-
18-1-2768), NIH (via a SBIR R44GM146483), Schmidt Fu-
tures, BMGF, CZI, Arnold, Hewlett and a $180,000 anony-
mous donation.
None of the opinions expressed here are
those of the funders.
9.
ADDITIONAL AUTHORS
10.
REFERENCES
[1] Illustrative mathematics.
https://illustrativemathematics.org/. Accessed:
2/1/2024.
[2] Personalized learning for math & science.
[3] O. B. Adedoyin and E. Soykan. Covid-19 pandemic
and online learning: the challenges and opportunities.
Interactive learning environments, 31(2):863–875,
2023.
[4] R. Agustianingsih and A. Mahmudi. How to design
open-ended questions?: Literature review. In Journal
of Physics: Conference Series, volume 1320, page
012003. IOP Publishing, 2019.
[5] H. Akay, D. Soyba¸s, and Z. Arg¨un. Problem kurma
deneyimleri ve matematik ¨o˘gretiminde a¸cık-u¸clu
soruların kullanımı. Gazi ¨Universitesi Kastamonu
E˘gitim Dergisi, 14(1):129–146, 2006.
[6] S. Baral, A. F. Botelho, J. A. Erickson,
P. Benachamardi, and N. T. Heffernan. Improving
automated scoring of student open responses in
mathematics. International Educational Data Mining
Society, pages –, 2021.
[7] S. Baral, A. F. Botelho, A. Santhanam, A. Gurung,
J. Erickson, and N. T. Heffernan. Investigating
patterns of tone and sentiment in teacher written
feedback messages. In International Conference on
Artificial Intelligence in Education, pages 341–346.
Springer, 2023.
[8] C. Bastin and M. Van der Linden. The contribution of
recollection and familiarity to recognition memory: A
study of the effects of test format and aging.
Neuropsychology, 17(1):14–24, 2003.
[9] S. Basu, C. Jacobs, and L. Vanderwende.
Powergrading: a clustering approach to amplify
human effort for short answer grading. Transactions of
the Association for Computational Linguistics,
1:391–402, 2013.
[10] J. G. Borade and L. D. Netak. Automated grading of
essays: a review. In Intelligent Human Computer
Interaction: 12th International Conference, IHCI
2020, Daegu, South Korea, November 24–26, 2020,
Proceedings, Part I 12, pages 238–249. Springer, 2021.
[11] A. Botelho, S. Baral, J. A. Erickson, P. Benachamardi,
and N. T. Heffernan. Leveraging natural language
processing to support automated assessment and
feedback for student open responses in mathematics.
Journal of Computer Assisted Learning, pages –, 2023.
[12] M. Brooks, S. Basu, C. Jacobs, and L. Vanderwende.
Divide and correct: Using clusters to grade short
answers at scale. In Proceedings of the first ACM
conference on Learning@ scale conference, pages
89–98, 2014.
[13] W. M. Carroll. Using worked examples as an
instructional support in the algebra classroom.
Journal of educational psychology, 86(3):360, 1994.
[14] A. P. Cavalcanti, A. Barbosa, R. Carvalho, F. Freitas,
Y.-S. Tsai, D. Gaˇsevi´c, and R. F. Mello. Automatic
feedback in online learning environments: A
systematic literature review. Computers and
Education: Artificial Intelligence, 2:100027, 2021.
[15] W.-L. Chiang, Z. Li, Z. Lin, Y. Sheng, Z. Wu,
H. Zhang, L. Zheng, S. Zhuang, Y. Zhuang, J. E.
Gonzalez, I. Stoica, and E. P. Xing. Vicuna: An
open-source chatbot impressing gpt-4 with 90%*
chatgpt quality, March 2023.
[16] T. Cooney, W. Sanchez, K. Leatham, and
D. Mewborn. Open-ended assessment in math: A


searchable collection of 450+ questions, 2004.
[17] G. Deeva, D. Bogdanova, E. Serral, M. Snoeck, and
J. De Weerdt. A review of automated feedback
systems for learners: Classification framework,
challenges and opportunities. Computers & Education,
162:104094, 2021.
[18] S. Dikli. An overview of automated scoring of essays.
The Journal of Technology, Learning and Assessment,
5(1):–, 2006.
[19] M. Dzikovska, N. Steinhauser, E. Farrow, J. Moore,
and G. Campbell. Beetle ii: Deep natural language
understanding and automatic feedback generation for
intelligent tutoring in basic electricity and electronics.
International Journal of Artificial Intelligence in
Education, 24:284–332, 2014.
[20] J. A. Erickson, A. F. Botelho, S. McAteer,
A. Varatharaj, and N. T. Heffernan. The automated
grading of student open responses in mathematics. In
Proceedings of the Tenth International Conference on
Learning Analytics & Knowledge, pages 615–624, 2020.
[21] E. R. Fyfe and S. A. Brown. Feedback influences
children’s reasoning about math equivalence: A
meta-analytic review. Thinking & Reasoning,
24(2):157–178, 2018.
[22] A. Gurung. How common are common wrong
answers? exploring remediation at scale. In
Proceedings of the Tenth ACM Conference on
Learning@ Scale (L@ S’23), July 20-22, 2023,
Copenhagen, Denmark., pages –, 2023.
[23] A. Gurung, S. Baral, K. P. Vanacore, A. A.
Mcreynolds, H. Kreisberg, A. F. Botelho, S. T. Shaw,
and N. T. Hefferna. Identification, exploration, and
remediation: Can teachers predict common wrong
answers? In LAK23: 13th International Learning
Analytics and Knowledge Conference, pages 399–410,
2023.
[24] A. Gurung, A. Botelho, R. Thompson, A. Sales,
S. Baral, and N. Heffernan. Considerate, unfair, or
just fatigued? examining factors that impact teacher.
Proceedings of the 30th International Conference on
Computers in Education. Asia-Pacific Society for
Computers in Education.
[25] M. G. Hahn, S. M. B. Navarro, L. D. L. F. Valent´ın,
and D. Burgos. A systematic review of the effects of
automatic scoring and automatic feedback in
educational settings. IEEE Access, 9:108190–108198,
2021.
[26] C. L. Hancock. Implementing the assessment
standards for school mathematics: Enhancing
mathematics learning with open-ended questions. The
Mathematics Teacher, 88(6):496–499, 1995.
[27] N. T. Heffernan and C. L. Heffernan. The assistments
ecosystem: Building a platform that brings scientists
and teachers together for minimally invasive research
on human learning and teaching. International
Journal of Artificial Intelligence in Education,
24:470–497, 2014.
[28] D. Hirunyasiri, D. R. Thomas, J. Lin, K. R.
Koedinger, and V. Aleven. Comparative analysis of
gpt-4 and human graders in evaluating praise given to
students in synthetic dialogues, 2023.
[29] E. J. Hu, Y. Shen, P. Wallis, Z. Allen-Zhu, Y. Li,
S. Wang, L. Wang, and W. Chen. Lora: Low-rank
adaptation of large language models, 2021.
[30] A. Q. Jiang, A. Sablayrolles, A. Mensch, C. Bamford,
D. S. Chaplot, D. de las Casas, F. Bressand,
G. Lengyel, G. Lample, L. Saulnier, L. R. Lavaud,
M.-A. Lachaux, P. Stock, T. L. Scao, T. Lavril,
T. Wang, T. Lacroix, and W. E. Sayed. Mistral 7b,
2023.
[31] G. Jurman, S. Riccadonna, R. Visintainer, and
C. Furlanello. Canberra distance on ranked lists. In
Proceedings of advances in ranking NIPS 09 workshop,
pages 22–27. Citeseer, 2009.
[32] K. Kebodeaux, M. Field, and T. Hammond. Defining
precise measurements with sketched annotations. In
Proceedings of the Eighth Eurographics Symposium on
Sketch-Based Interfaces and Modeling, pages 79–86,
2011.
[33] R. T. Kellogg, A. P. Whiteford, and T. Quinlan. Does
automated feedback help students learn to write?
Journal of Educational Computing Research,
42(2):173–196, 2010.
[34] D. Kim, Y. Lee, W. L. Leite, and A. C.
Huggins-Manley. Exploring student and teacher usage
patterns associated with student attrition in an open
educational resource-supported online learning
platform. Computers & Education, 156:103961, 2020.
[35] R. Klavir and S. Hershkovitz. Teaching and evaluating
‘open-ended’problems. International Journal for
Mathematics Teaching and Learning, 20(5):23, 2008.
[36] N. LaVoie, J. Parker, P. J. Legree, S. Ardison, and
R. N. Kilcullen. Using latent semantic analysis to
score short answer constructed responses: Automated
scoring of the consequences test. Educational and
Psychological Measurement, 80(2):399–414, 2020.
[37] C. Leacock and M. Chodorow. C-rater: Automated
scoring of short-answer questions. Computers and the
Humanities, 37(4):389–405, 2003.
[38] O. L. Liu, J. A. Rios, M. Heilman, L. Gerard, and
M. C. Linn. Validation of automated scoring of science
assessments. Journal of Research in Science Teaching,
53(2):215–233, 2016.
[39] B. Liz, T. Dreyfus, J. Mason, P. Tsamir, A. Watson,
and O. Zaslavsky. Exemplification in mathematics
education. In Proceedings of the 30th Conference of
the International Group for the Psychology of
Mathematics Education, volume 1, pages 126–154.
Citeseer, 2006.
[40] J. P. Magliano, K. Millis, Y. Ozuru, and D. S.
McNamara. A multidimensional framework to
evaluate reading assessment tools. In D. S.
McNamara, editor, Reading Comprehension Strategies:
Theories, Interventions, and Technologies, volume 1,
chapter A Multidimensional Framework to Evaluate
Reading Assessment Tools, pages 107–136. Psychology
Press, New York, USA, 1 edition, May 2007.
[41] S. Marwan, G. Gao, S. Fisk, T. W. Price, and
T. Barnes. Adaptive immediate feedback can improve
novice programming engagement and intention to
persist in computer science. In Proceedings of the 2020
ACM Conference on International Computing
Education Research, ICER ’20, page 194–203, New
York, NY, USA, 2020. Association for Computing


Machinery.
[42] W. McCallum. The common core state standards in
mathematics. In Selected regular lectures from the 12th
international congress on mathematical education,
pages 547–560. Springer, 2015.
[43] D. S. McNamara, S. A. Crossley, R. D. Roscoe, L. K.
Allen, and J. Dai. A hierarchical classification
approach to automated essay scoring. Assessing
Writing, 23:35–59, 2015.
[44] T. Mikolov, K. Chen, G. Corrado, and J. Dean.
Efficient estimation of word representations in vector
space. arXiv preprint arXiv:1301.3781, pages –, 2013.
[45] H. A. Nguyen, H. Stec, X. Hou, S. Di, and B. M.
McLaren. Evaluating chatgpt’s decimal skills and
feedback generation in a digital learning game, 2023.
[46] R. Nils and I. S.-B. Gurevych. Sentence embeddings
using siamese bert-networks. In Proceedings of the
2019 Conference on Empirical Methods in Natural
Language Processing and the 9th International Joint
Conference on Natural Language Processing, Hong
Kong, China, pages 3–7, 2019.
[47] M. I. N´u˜nez-Pe˜na, R. Bono, and M. Su´arez-Pellicioni.
Feedback on students’ performance: A possible way of
reducing the negative effect of math anxiety in higher
education. International Journal of Educational
Research, 70:80–87, 2015.
[48] OpenAI. Chatgpt: Optimizing language models for
dialogue. https://openai.com/blog/chatgpt, 2023.
[49] M. Pankiewicz and R. S. Baker. Large language
models (gpt) for automating feedback on
programming assignments, 2023.
[50] Z. Papamitsiou and A. A. Economides. Process mining
of interactions during computer-based testing for
detecting and modelling guessing behavior. In
Learning and Collaboration Technologies: Third
International Conference, LCT 2016, Held as Part of
HCI International 2016, Toronto, ON, Canada, July
17-22, 2016, Proceedings 3, pages 437–449. Springer,
2016.
[51] S. Parihar, Z. Dadachanji, P. K. Singh, R. Das,
A. Karkare, and A. Bhattacharya. Automatic grading
and feedback using program repair for introductory
programming courses. In Proceedings of the 2017 ACM
Conference on Innovation and Technology in
Computer Science Education, pages 92–97, 2017.
[52] J. Pennington, R. Socher, and C. D. Manning. Glove:
Global vectors for word representation. In Proceedings
of the 2014 conference on empirical methods in natural
language processing (EMNLP), pages 1532–1543, 2014.
[53] T. Phung, V.-A. P˘adurean, A. Singh, C. Brooks,
J. Cambronero, S. Gulwani, A. Singla, and G. Soares.
Automating human tutor-style programming feedback:
Leveraging gpt-4 tutor model for hint generation and
gpt-3.5 student model for hint validation. arXiv
preprint arXiv:2310.03780, pages –, 2023.
[54] B. Riordan, A. Horbach, A. Cahill, T. Zesch, and
C. Lee. Investigating neural architectures for short
answer scoring. In Proceedings of the 12th Workshop
on Innovative Use of NLP for Building Educational
Applications, pages 159–168, 2017.
[55] S. Sonkar, N. Liu, D. B. Mallick, and R. G. Baraniuk.
Class: A design framework for building intelligent
tutoring systems based on learning science principles,
2023.
[56] H. Touvron, L. Martin, K. Stone, P. Albert,
A. Almahairi, Y. Babaei, N. Bashlykov, S. Batra,
P. Bhargava, S. Bhosale, et al. Llama 2: Open
foundation and fine-tuned chat models. arXiv preprint
arXiv:2307.09288, pages –, 2023.
[57] Z. Zhang, Z. Dong, Y. Shi, N. Matsuda, T. Price, and
D. Xu. Students’ perceptions and preferences of
generative artificial intelligence feedback for
programming, 2023.
[58] S. Zhao, Y. Zhang, X. Xiong, A. Botelho, and
N. Heffernan. A memory-augmented neural model for
automated grading. In Proceedings of the fourth
(2017) ACM conference on learning@ scale, pages
189–192, 2017.


