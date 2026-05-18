---
source_file: "ATLAS Concept Paper 23-Pager.pdf"
type: paper
---

# ATLAS Concept Paper 23-Pager

[DRAFT: Keep Confidential] 
Building an AI-Native Learning System 
for Math 
Project ATLAS (AI-Native Teaching, Learning & Academic Support) 
Abstract: 
AI might be the highest leverage technology for education ever created. However, its promise 
remains unrealized by platforms that treat off-the-shelf AI products as features to plug into their 
existing platforms. In contrast, we propose a fundamental reimagining of data-informed 
individualized student support where AI-tooling and continuous experimentation underpin the 
entire learning-science-informed framework. Concretely, we propose building on the existing 
impactful Teach to One Roadmaps product through Project ATLAS, an initiative to develop 
AI-Native Teaching, Learning & Academic Support capabilities that will form the intelligence 
foundation of Teach to One, transforming our platform to one that is more connected, adaptive, 
and responsive, and capable of supporting Roadmaps and future learning models.  
1. Introduction 
K-12 math education faces a persistent paradox. We know personalized, competency-based 
approaches dramatically improve learning outcomes. Yet across the country, most classrooms 
still operate in a fundamentally one-size-fits-all model, advancing same-aged students through 
content by calendar rather than by demonstrated mastery. The distance between what we know 
works and what we practice at scale remains vast. 
The consequences of this are well-documented. In 2025, TNTP and New Classrooms published 
Unlocking Algebra: What the Data Tells Us About Helping Students Catch Up, a study of 
approximately 2,000 students over three years (2021–2024). The findings were stark: students 
who lacked key "predecessor skills", specific foundational competencies from earlier grades that 
directly predict success in Algebra 1, had only a 13% success rate. Students with broad 
mathematical knowledge but missing these targeted predecessor skills achieved a 31% success 
rate.  But students who had both broad mathematical knowledge and the critical predecessor 
skills reached a 58% success rate (TNTP & New Classrooms, 2025). The implication is clear: 
success in mathematics depends not on covering everything, but on mastering the right 
foundational skills, and doing so in a targeted, personalized way. 
Artificial Intelligence (AI) can help make personalized, competency-based learning more 
possible at scale through student-facing supports, better teacher workflows, classroom 
orchestration, and richer evidence of student understanding. However, to date, AI in education 
has been largely defined by the chatbot. That framing has exposed real limitations: many 
students do not seek help effectively on their own, usage can be low, and even some of its 
1 


[DRAFT: Keep Confidential] 
earliest champions now see AI tutoring as only one part of a broader instructional solution. The 
greater promise of AI lies not in replacing teachers with conversational tools, but in 
strengthening the underlying systems that shape how students learn and how teachers respond. 
In that vision, teachers remain the relational and interpretational center of the student 
experience. 
New Classrooms proposes a vision for that future. Project ATLAS builds on the foundation of 
Teach to One Roadmaps, New Classrooms’ existing personalized math platform, to develop a 
new intelligence layer that will make Teach to One more connected, adaptive, and responsive, 
and capable of supporting additional models alongside Roadmaps. Many of the foundational 
pieces Project ATLAS will enhance, including the knowledge graph, sequencing engine, and 
assessment infrastructure, already exist within Teach to One; Project ATLAS is the next chapter 
of work already underway, not a new build from scratch. Project ATLAS is designed not only to 
enhance what New Classrooms has already built, but to create the intelligence layer and 
infrastructure required to ultimately support a broader set of instructional models, content 
providers, and school contexts. 
The intelligence layer Project ATLAS will build, ATLAS, operates across multiple interconnected 
components, each informed by learning science research and continuously refined through 
empirical validation in real classrooms. The intelligence that powers a single student's 
personalized path is the same intelligence that helps a teacher orchestrate an entire classroom. 
At the student level, ATLAS more deeply personalizes the progression of skills, calibrates the 
difficulty of challenges in real time, calibrates the difficulty of challenges in real time, detects 
misconceptions as they form, and dynamically responds to each learner's trajectory. At the 
classroom level, ATLAS transforms how teachers organize instruction, synthesizing learning 
data across students to recommend dynamic groupings, targeted modalities, and 
evidence-based instructional decisions that make differentiated teaching genuinely possible at 
scale.  
This paper articulates the vision, the research foundation, the implementation pathway for 
Project ATLAS, and why its underlying architecture has implications not just for New 
Classrooms' own classrooms, but for the field. It builds on more than a decade of New 
Classrooms' direct work in personalized math learning, currently serving nearly 40,000 students 
across diverse district and school settings. That experience, including the empirical research 
behind Unlocking Algebra, has taught us what works, what doesn't, and what becomes possible 
when you combine sound learning science with intelligent technology and a deep commitment 
to equitable outcomes. 
2. The Learning Science Foundation 
Effective learning systems must be grounded in how students actually learn. The research 
points toward a coherent set of design principles that ATLAS operationalizes. Namely, students 
learn most from interacting with the right content, at the right time, in the right ways, for the right 
reasons. 
2 


[DRAFT: Keep Confidential] 
The Right Content 
Mastery as the Gating Criterion 
While later studies have recalibrated Bloom’s (1984) mastery-learning impact estimate from 
about 1 standard deviation1 to .59 (Kulik et al., 1990), mastery-learning remains one of the most 
impactful, and simplest, effects in learning science. When students advance based on 
demonstrated competence rather than time elapsed, they build secure foundational knowledge 
that enables, rather than delays, later learning. The effect is particularly pronounced for students 
below grade level, for whom traditional remediation often compounds gaps rather than closing 
them. The opportunity for Project ATLAS to enable per-student mastery-tracking and 
advancement while at the same time enabling meaningful teacher-led whole-class and 
small-group activities, something no existing solution does well. 
The Zone of Proximal Development 
Vygotsky's (1978) zone of proximal development, the space between what a student can do 
independently and what they can do with appropriate support, remains foundational. A student 
who is under-challenged disengages; one who is over-challenged becomes frustrated. A 
personalized system can maintain each student in their zone continuously, adjusting task 
difficulty and scaffolding intensity in response to moment-to-moment performance. Systems that 
calibrate support to current competence produce measurably stronger learning gains than static 
scaffolding (Azevedo & Hadwin, 2005). 
Predecessor Skills: The Right Foundations Matter 
Which topics are in a student’s zone of proximal development depends partly on what 
prerequisite topics they’ve already mastered, and not all foundational skills are created equal. 
The Unlocking Algebra research demonstrates that a specific subset of predecessor skills, 
competencies from earlier grades that directly enable algebraic reasoning, predict success far 
more powerfully than broad mathematical knowledge. The difference between a 13% and a 58% 
success rate in Algebra 1 was not about how much math a student had learned, but about 
whether they had mastered the right math. Effective systems must identify and target the 
highest-leverage predecessor skills with respect to each learning objective, pairing foundational 
work with opportunities to engage with new, grade-level content. 
1 Bloom is often referenced for a “2-sigma effect,” but the effect (for individual tutoring with 
mastery-learning features) was informally estimated from a few other works (particularly two 
dissertations—from Anania and Burke) which themselves involved only a few hundred students in artificial 
settings. Even contemporary with Bloom, studies observed mastery-learning effect sizes ranging from .6 
to 1.5 standard deviations. 
3 


[DRAFT: Keep Confidential] 
At the Right Time 
Spaced Retrieval and Interleaved Practice 
Cognitive science has established that spacing retrieval practice over time leads to dramatically 
stronger long-term retention (Cepeda et al., 2008), and that interleaving different problem types 
produces better transfer. Rohrer et al. (2014) found students who engaged in interleaved 
practice retained 72% of procedural knowledge one month later, compared to 38% for blocked 
practice. An intelligent system can orchestrate spaced and interleaved practice across an entire 
cohort automatically. 
In the Right Ways 
Formative Assessment and Real-Time Feedback 
Regular, specific, actionable feedback during learning, not just summative grades at the end, 
produces substantively larger learning gains, with the largest effects for lower-performing 
students (Black & Wiliam, 1998). When students receive immediate information about what was 
accurate and what needs revision, they correct misconceptions before they calcify. At scale, 
providing this level of feedback to every student in real time requires technological support. 
Active Generation 
On a related note, engaging students in generating material, rather than merely reading or 
recognizing it, creates learning effect sizes of .4 standard deviations (Bertsch et al., 2007). This 
means explanations that students participate in, testing before explaining, and rich student 
expression formats (think free-response vs. multiple-choice) all lead to deeper and more durable 
learning. 
Collaborative Learning 
Students like talking to other people and they also learn more effectively when they’re in 
dialogue. Meta-analyses of collaborative learning (Kyndt et al., 2013) show large effect sizes 
(.54 standard deviations) from engaging students in collaborative learning activities. 
For the Right Reasons 
Motivation and Engagement 
Self-determination theory identifies three psychological needs that drive intrinsic motivation: 
competence, autonomy, and relatedness (Ryan & Deci, 2000). Research consistently shows 
these needs are satisfied by the core learning experience itself — where work is appropriately 
4 


[DRAFT: Keep Confidential] 
difficult, effort is recognized and progress is observable — far more than by gamification or 
extrinsic incentives. Engagement is a property of the system's design, not a feature bolted on. 
The Unified Picture 
These principles form a rich picture of how students learn mathematics. An effective system 
must operationalize all of them simultaneously: competency-based progression, calibration to 
the zone of proximal development, targeted predecessor skills, spaced and interleaved practice, 
responsive formative assessment, active social learning, and conditions for intrinsic motivation. 
Most existing systems address only a few of these. Project ATLAS is designed to embed all of 
them into every interaction, creating a compounding effect on learning outcomes. 
3. The Technology Foundation 
It seems like the whole world is talking about AI now, but it has a 75-year history and 
encompasses a broad assortment of individual technologies and capabilities. This section will 
clarify what’s ripe for use in education and why, foreshadowing the system we propose in the 
sections following. Plainly put, a surprisingly small number of technology adoptions can power a 
profound reimagining of classroom math education. 
The Bedrock: Continuous Experimentation 
Traditionally, full-cycle feedback from implementation back to policy-makers, curriculum 
providers, and even directly-involved educational administration has been slow, noisy, and 
coarse. Full-scale standardized testing is expensive and time-consuming, so schools often only 
know what’s working on an annual or sometimes quarterly basis, and that information rarely 
gets back to educational resource providers in any form to actually help them improve. In 
contrast, the massive growth of internet-native companies like Google, Amazon, Netflix, and 
others has been intrinsically driven by continuous data collection and experimentation at scale. 
Google transformed search by constantly testing: which links do people click on for which 
search terms; how long do they stay; do they come back to the same search to try a different 
link?  
Education platforms are finally beginning to reach the scale where they can adopt this strategy 
as well, constantly learning about what content is working, how students are feeling, what 
teacher interventions are effective— but only if that learning is built into the system deliberately. 
Importantly, an experimentation infrastructure designed this way is inherently content-agnostic: 
the same framework that evaluates the effectiveness of New Classrooms' own content can 
evaluate content from any source, making it the foundation of a system that could power 
personalized learning beyond any single provider's materials. 
5 


[DRAFT: Keep Confidential] 
Predicting and Discovering: Machine Learning 
Machine learning algorithms (optimized statistical models) have been silently improving our lives 
for decades, largely invisibly. Shopping recommendations, low-traffic GPS routes, flight 
scheduling, photo auto-tagging, speech recognition, mail sorting, credit card fraud detection, 
and spam filtering are just a few of the examples that we largely take for granted. Education is 
finally aggregating large enough centralized datasets to leverage some of the same techniques, 
but for even more impactful purposes: how related are these topics; which test question gives 
more insight; what content most inspires curiosity? 
Multi-modal Learning: Applied AI 
There have been massive capability advances in applications of AI (such as Natural Language 
Processing, Computer Vision, Robotic Control, and Audio Synthesis) driven behind the scenes 
by larger datasets, faster computers, and better machine learning algorithms. Education has the 
opportunity to thoughtfully integrate these consumer-grade technologies in ways that transform 
their impact. Large language models can grade student reasoning. Computer vision models can 
understand pen-and-paper scratchwork. Code synthesis can produce rich manipulatives 
on-demand. 
By themselves, these application-level technologies are unlikely to go beyond flashy demos in 
education. But when tested, evaluated, and quality-controlled through continuous 
experimentation, when informed by highly accurate models of student knowledge, curricular 
interrelationships, and learning trajectories, and when adopted for a purpose, rather than as an 
end in themselves, these emerging technologies have the opportunity to completely rewrite how 
classrooms interact with education technology. 
4. What Project ATLAS Makes Possible for Students  
Three Components and the Engagement EcoSystem 
A student learning math within an effective competency-based learning system experiences 
three things in a continuous loop: the system decides what they should learn next, how they 
should learn it in the moment, and whether they’ve actually learned it. These three 
functions—sequencing, instruction, and assessment—are not independent:  
●​ Preferences expressed over learning objectives suggest what they’ll be attentive to in a 
formative learning experience.  
●​ How a student engages during instruction reveals what assessment should probe; errors 
during learning can expose misconceptions that reflect the student’s “boundary of 
mastery” at that particular moment in time.  
●​ What a student demonstrates in assessment drives what the system sequences next. 
6 


[DRAFT: Keep Confidential] 
Project ATLAS will give us the capability to organize these three functions into an integrated 
cycle, embedded in an engagement ecosystem that sustains motivation throughout. AI operates 
across all of them, but largely invisibly. There is no conversational interface at the center of the 
student experience. Instead, intelligence is woven into every decision the system makes, and 
what the system learns in one component feeds directly into the others. 
 
Determining What Students Should Learn (The Personalized 
Roadmap) 
Every student receives a uniquely sequenced progression of skills: not a single lock-step 
curriculum, but a personalized pathway tailored to their current proficiency, learning cadence, 
and teacher-set instructional goals. 
Current state: Today, Teach to One Roadmaps operates on a robust set of heuristic rules 
leveraging more than a decade of New Classrooms’ knowledge about how students learn math. 
These rules analyze assessment data, identify readiness patterns, consider classroom priorities, 
and recommend the next skill. This approach has proven effective within its design constraints. 
AI opportunity: Machine learning (ML) models can take this ruleset much further with greater 
precision. ML can calibrate estimates of inter-topic relationships and student-topic readiness, 
and the models can be trained on a rich set of signals: formative assessment outcomes, 
engagement patterns (how long the student works, where they persist, where they disengage), 
time dynamics (learning velocity over weeks, forgetting curves from spaced retrieval data) and 
even semantic features of the content. Topic recommendations informed by these models can 
directly account for teacher-set priorities. Critically, the Unlocking Algebra research validates a 
key design principle: the system’s sequencing engine should identify which predecessor skills 
are highest-leverage for each student, rather than attempting to fill every gap comprehensively. 
Models trained on years of learning interaction data can predict which sequences produce the 
strongest outcomes and which predecessor skills unlock the most future learning for each 
individual student.  
7 


[DRAFT: Keep Confidential] 
Differentiating While They Learn (In-Skill Learning) 
Once a student is working on a particular skill, the quality of the learning experience within that 
skill directly determines how much the student learns and how motivated they remain. In-skill 
learning involves students working through carefully designed resources, contextual 
explanations, worked examples, guided practice, and independent practice, with built-in 
responsiveness at every step. 
Current state: Today, Teach to One Roadmaps guides students through a linear skill-specific 
formative experience, and provides static hints and fixed explanations calibrated to common 
errors. 
AI opportunity: Here, there are multitudinous opportunities for AI to make formative learning 
experiences more responsive, motivating, and ultimately more impactful. LLM-authored rich 
manipulatives and adaptive hints can be automatically screened for baseline quality and then 
tested empirically against existing content. Adaptive difficulty calibration can automatically adjust 
problem complexity within a skill based on performance, maintaining the zone of proximal 
development without requiring teacher intervention. Real-time misconception detection can 
identify when a student has understood a procedure but lacks conceptual grounding, or vice 
versa, and recommend targeted support. Benchmark research has developed structured 
datasets of common misconceptions in middle school algebra, enabling AI systems to classify 
errors, flag hierarchical misconception patterns, and recommend targeted micro-lessons. This 
layer directly operationalizes Zone of Proximal Development research and formative 
assessment principles. The responsiveness of the system to each student’s actual performance, 
moment by moment, is what creates conditions for learning and intrinsic motivation. 
Capturing What They Have Learned (Multi-Modal Assessment) 
Assessment is the function that closes the loop. Without it, the system is guessing at what a 
student knows, and differentiated learning has no signal for whether its approach is working. 
Assessment is what makes the entire cycle intelligent: it validates learning, surfaces 
misconceptions, and generates the evidence that drives every downstream decision the system 
makes. The quality of assessment directly determines the quality of personalization. 
Current state: Today, Teach to One Roadmaps uses 5-question assessments that are rigorous 
and validated, but limited to what the system can automatically process based on 
predetermined answers. They do not provide rich feedback, support misconception analysis, or 
allow flexibility for richer modes of assessing, like showing work, explaining thinking, or 
leveraging pencil and paper. 
AI opportunity: Two clear opportunities emerge. First, large multimodal models can score voice 
responses, image uploads of student work, and open-ended explanations with high reliability, 
capturing cognition in multiple forms. (This also enables more natural, adaptive, and 
open-ended assessment formats that get at student thinking more accurately, faster, and with 
less frustration.) Second, more sophisticated competency inference models can infer implicated 
8 


[DRAFT: Keep Confidential] 
knowledge states more accurately and separately track a student’s conceptual depth, 
procedural fluency, situational application, and inter-topic contextualization, allowing the system 
to recommend different interventions based on the true source of a student’s struggle. The 
continuous cycle of assessment, inference, and action is where formative assessment research 
is put into practice. 
The User Engagement Ecosystem: A Quality of Every Interaction 
The engagement ecosystem is not a separate layer; it is a dimension of the first three 
components. It is built into every interaction through automatically moderated difficulty, adaptive 
support, and context-aware encouragement. Students experience these properties as a 
responsive learning environment where challenges feel manageable and effort and progress is 
visible. This is intrinsic engagement, the kind that sustainable learning depends on. 
Current state: Currently, Teach to One Roadmaps engagement ecosystem manifests as brief, 
context-aware messages at strategic moments: when a student begins, when they’re frustrated, 
and when they’ve made progress.  
AI opportunity: The opportunity to evolve this is significant: from disconnected commentary to 
history-aware intervention in the learning experience itself. In addition to acting as a signal for 
optimizing every other part of the system, the engagement layer also includes active 
intervention: dynamically adjusting difficulty, contextualizing and reframing experiences, and 
facilitating student-teacher connection.The engagement ecosystem operationalizes 
self-determination theory, where autonomy (the student navigating through their own roadmap), 
competence (difficulty calibrated to capability), and relatedness (the system and teacher are 
responsive to student needs) are woven into every moment. 
The Connective Tissue: A System, Not a Collection of Features 
What makes Project ATLAS so impactful is that it develops a systems approach to leveraging 
the power of AI. Rather than developing a collection of isolated features, the three core 
components of the student experience feed each other in a continuous loop. What students 
demonstrate in assessment improves the roadmap recommendations for what they should learn 
next, identifying which skills have been truly mastered and which require revisiting. Engagement 
signals such as time spent, pace of progress, and response patterns inform pacing decisions in 
the roadmap and difficulty calibration during in-skill learning. Errors detected during 
differentiated learning reveal misconceptions that reshape how assessment interprets student 
understanding. This feedback loop is what creates compounding leverage: each component’s 
decisions improve in quality as the system learns more about the student. 
9 


[DRAFT: Keep Confidential] 
 
5. How Project ATLAS Supports Classroom 
Intelligence  
From Individual Pathways to Orchestrated Learning 
At the individual level, ATLAS does three things: it personalizes what each student learns next, 
adapts how they learn it to keep them in their zone of proximal development, and validates 
whether they've actually learned it. That cycle—sequencing, adapting, validating—runs 
continuously for every student. But schools are not collections of isolated learners. They are 
classrooms, with teachers making dozens of instructional decisions every hour across students 
with different needs. 
This is where ATLAS unlocks something powerful: the same intelligence that drives each 
student's individual learning path can drive the orchestration of the entire classroom. 
The system aggregates its understanding of every student, synthesizes their collective learning 
patterns, and surfaces instructional configurations and resources for the whole group: 
groupings, content focus, modalities, pacing, and materials. The teacher becomes the learning 
architect, and the system becomes a precision instrument that makes genuinely differentiated 
instruction possible at scale. This changes the teacher's work across all four of their core roles: 
relational, interventional, interpretational, and directional, in ways we'll explore below. 
10 


[DRAFT: Keep Confidential] 
 
The Current and the Tide 
Imagine a teacher looking at her classroom through two complementary lenses. Through one 
lens, she sees individual students, each with their own learning trajectory, misconceptions, and 
needs. This is the current: ATLAS powering each student's personalized path, flowing in its own 
direction, finding its own way. Through the other lens, she sees the collective: a classroom that 
shares certain readiness patterns, coalesces around particular skill clusters, and benefits from 
deliberate grouping and targeted instruction. This is the tide: the classroom-level movement that 
emerges when individual currents come together. 
These are not separate systems. They are the same system, understood at different scales.  
The personalized roadmap, at the classroom level, becomes an engine for instructional 
scheduling and smart grouping. The system analyzes the classroom's collective learning 
state, including readiness clusters, skill overlaps, and prerequisite gaps, and proposes dynamic 
configurations: which students should be grouped together, what skill each group should focus 
on, and what instructional modality that skill experience should take. These are not static ability 
groups that persist all year; they are fluid, evidence-based configurations that change daily or 
even within a lesson. 
In-skill learning, at the classroom level, becomes learning in community. The skill experience 
is not only digital, it includes teacher-led mini-lessons, collaborative problem-solving with 
structured protocols, peer explanation pairs, mathematical discourse, hands-on manipulative 
work, and independent practice. Project ATLAS will provide the capability to recommend not just 
what students learn but how, proposing the modality and generating the instructional resources 
most likely to serve each group's needs based on the skill, the students' documented learning 
patterns, and what has worked for similar students in similar situations. Classroom experiences 
that wouldn’t otherwise be possible are facilitated, like autonomous team formation 
(pre-discussion) based on which strategies students used to solve a problem, live multilingual 
discussions, or live synthesis of student written work.  
Formative assessment, at the classroom level, becomes a source of classroom-level 
signals. Rather than individual data streams, the system synthesizes patterns across students: 
11 


[DRAFT: Keep Confidential] 
shared misconceptions that warrant whole-class reteaching, evidence that yesterday's lesson 
landed (or didn't), and specific pedagogical recommendations for how to respond. The teacher 
receives interpreted patterns with actionable implications, not raw data. 
The user engagement ecosystem at the classroom level becomes classroom culture and 
collective progress. When differentiated instruction is well-orchestrated, something shifts in the 
social dynamic. Students are all working on appropriately challenging problems, some at their 
edge of comfort, some in mastery consolidation, and they see that differentiation is normal, not a 
sign of deficit. Progress is visible. Growth is shared. This is intrinsic engagement at the group 
level, emerging from the quality of the learning experience itself. 
 
The Teacher's Role 
The system proposes classroom adjustments and interventions. The teacher decides. We will  
be able to  surface groupings and modality recommendations based on real-time data, but the 
teacher exercises professional judgment over all of it. She understands which student 
combination won't work because of social dynamics, so she regroups and the system adapts. 
She notices an insight emerging in student discourse and pauses to amplify it. The teacher 
remains the learning architect. Project ATLAS enables that architecture to be executable at 
scale. 
In doing so, Project ATLAS will help to transform each of the teacher’s four core roles. The 
relational role is enriched: with logistical burden lifted, the teacher has attention to notice what 
drives each student, build connections, and reflect back growth. The interventional role 
becomes targeted: the system surfaces which students need support, so the teacher focuses 
her expertise on designing the right intervention rather than searching for who needs it or 
responding only to those who self-identify as needing help. The interpretational role becomes 
more powerful: instead of drowning in raw data, the teacher receives synthesized signals with 
clear patterns, which she interprets through her knowledge of the student and the classroom. 
The directional role becomes connected: the teacher sets goals for individuals and the 
classroom that are informed by system-surfaced patterns; the system recalibrates its 
recommendations in service of those goals. 
12 


[DRAFT: Keep Confidential] 
How Project ATLAS Enhances Professional Learning 
After more than a decade of working in schools, we’ve learned change rarely happens 
overnight. Through our current work in schools, we have seen the power of in-district champions 
(often math coaches or academic officers) using rich classroom data to inform and direct 
coaching conversations, not just about implementation fidelity, but about deeper teacher 
practices and even content expertise. Integrating with and complementing existing workflows 
and expectations is important, as is providing scaffolding, professional learning, and even 
on-demand support as teachers grow into newly-possible practices.  
Just as Project ATLAS will personalize the student experience, it will also reshape how teachers 
are onboarded, coached, supported in real time, and developed over the course of their careers. 
The same data and intelligence that personalize learning for students can make teacher 
onboarding adaptive to each teacher’s readiness, surface in-the-moment coaching signals, give 
administrators real-time visibility into adoption and impact, and replace static professional 
learning resources with timely, context-aware support. The chart below illustrates how each 
dimension of teacher development shifts when current Teach to One capabilities are powered 
with ATLAS. 
 
6. Beyond the Chat: Why System Intelligence is Key 
The landscape of AI in education has been dominated, in recent years, by a particular vision: 
the chat-based AI tutor. Systems like Khanmigo promise personalized, conversational support at 
scale through an AI powered chat interface available to every student, responsive to their 
questions, adapting to their needs. 
It is also, when examined closely against the research, not well-supported by evidence. A 2025 
meta-analysis by Laun and Wolff reviewed studies of AI-powered chatbots in education. After 
correcting for publication bias (which substantially inflates reported effect sizes in educational 
13 


[DRAFT: Keep Confidential] 
technology research), the estimated effect on learning was small to moderate, not the large 
effects that early evangelists had promised. Additionally, the majority of studies documented 
contextual barriers to implementation: technical failures, student confusion about how to interact 
with the chatbots, lack of integration with curriculum, and inconsistent use. A substantial 
proportion of studies also note concerns about overreliance, with students asking the chatbot 
rather than engaging with the harder work of thinking through problems themselves (Wu et al., 
2024). 
By contrast, the research on adaptive learning infrastructure, such as systems that personalize 
sequencing, difficulty calibration, and feedback across multiple components, shows substantially 
stronger evidence. Wang et al. (2024) found that adaptive learning systems produce an average 
effect size of g = 0.70 on learning outcomes compared to non-adaptive learning interventions, 
translating to approximately a 26 percentile-point improvement in learner performance. 
In the chatbot model, the AI-student conversation is the learning model. A student asks the AI a 
question; the AI responds, and an unstructured dialogue carries the pedagogical weight. With 
Project ATLAS, the learning model is the validated, competency-based system Teach to One 
already centers around: skills maps, sequenced progressions, in-skill learning, multimodal 
assessment, and teacher-orchestrated classrooms. AI operates throughout the learning model: 
powering the sequence engine, calibrating in-skill difficulty, scoring open-ended responses, 
surfacing classroom patterns. The AI is largely invisible to the student because it is doing the 
work that enables a smarter pedagogical experience, not trying to be the central mechanism of 
the learning. This is not to say that targeted AI-powered chat interfaces have no place. There 
are specific, bounded use cases where conversational AI can provide real value: supporting 
open-ended question-asking, encouraging students to elaborate on their thinking, providing 
after-hours support. These are targeted interventions that can be embedded within the broader 
system, rather than being the primary instructional tool. 
7. The Ultimate Vision 
Today, schools typically divide math instruction into distinct categories: core instruction, 
supplemental time, intervention blocks, enrichment periods, special education, and tutoring. 
Each operates under different rules, using different curricula, staffed by different people, and 
with different tools. A student might use one adaptive program in her core class and a different 
one during intervention. Her data does not flow between these spaces. Her learning experience 
is fragmented. Teachers in different roles see different pictures of the same student. Progress is 
siloed. 
"All Math Minutes" is a vision for what becomes possible when ATLAS realizes its full 
capabilities to serve as the intelligent backbone of ALL of a student's math learning time, not just 
one block or one context. Instead of thinking about core instruction, intervention, enrichment, or 
tutoring as separate blocks with separate infrastructure, schools can begin to organize math 
around more coherent questions: What mathematics does this student need to learn right now? 
What is the optimal way for them to learn it? And how will we capture what they learned? In this 
14 


[DRAFT: Keep Confidential] 
future, the boundaries between instructional settings matter less than the continuity of the 
student’s learning experience across them. 
In the All Math Minutes model, rather than centering learning experiences on adherence to the 
broader systems of grade-level accountability, every minute of math instruction is centered 
around a unified understanding of the students themselves: their competencies, their gaps, their 
learning patterns, their goals. The system adapts its behavior based on context and setting. 
During a teacher-led instruction block, it informs the teacher's grouping and content decisions in 
real time. During independent digital time, it drives the personalized learning experience. During 
a practice block, it orchestrates spaced retrieval and interleaved scheduling. Every context is 
different, but they are all connected to the same underlying intelligence. 
Teachers have a single, coherent dashboard: a unified view of each student's mathematical 
journey. Instead of pulling data from multiple systems and trying to synthesize a picture, a 
teacher sees one comprehensive roadmap: where the student is, how they got there, what 
comes next, and why. A special educator working with a student in a resource room sees the 
same roadmap the core classroom teacher sees, plus additional diagnostics on specific 
misconceptions. An instructional coach can see real-time data on whether the current grouping 
is working. Students experience genuine continuity. Their roadmap is one roadmap. Their 
progress is one story. Whether they are in first-period math, afternoon intervention, Saturday 
tutoring, or summer school, the system knows where they left off and what comes next. 
School leaders gain another dimension of insight, triangulating data with other school systems 
to surface patterns no single source could reveal. A student who used to love math is 
disengaging from all of her classes and has repeated absences. A different student sees math 
class as a refuge, where her math teacher is best positioned to ask about her goals and 
dreams. A third student is excelling across the board and might need new challenges that 
bridge multiple disciplines. 
This does not require that every minute of instruction look the same. It requires that every 
minute be connected: informed by the same intelligence, contributing to the same picture of the 
student, and part of a coherent whole. 
Two Paths Forward: Digital-First and Offline-Enabled 
Two parallel futures are possible as Project ATLAS matures, and they may ultimately blend. 
The digital-first path is the natural evolution of the current conception of Teach to One 
Roadmaps. The platform becomes increasingly rich: more adaptive content across a wider 
range of math domains; deeper multimodal assessment and rich interactions (voice, image, 
open-ended response, handwriting); a persistent digital companion that creates continuity 
across sessions; and increasingly personalized recommendation engines. 
The offline-enabled path challenges a fundamental assumption about where the intelligence 
needs to live. Many schools and families are concerned about screen time. Many students learn 
better with physical manipulatives and written work. Imagine a classroom where students work 
15 


[DRAFT: Keep Confidential] 
primarily on physical surfaces: solving problems, showing their thinking with pencil and 
whiteboard, collaborating with peers. A student completes a problem set, places it under a 
document camera, and within seconds the system has assessed it: not just whether the answer 
is correct, but whether her reasoning is sound, what misconceptions she might harbor, and what 
she's ready to learn next. The system generates her next problems, tailored to what she just 
demonstrated, and surfaces a synthesis for the teacher, including which peers share similar 
misconceptions for targeted grouping. 
The component technologies exist: handwriting recognition, document scanning, AI-powered 
assessment, and automated content generation. ATLAS is the learning intelligence layer that 
connects all of them, enabling discussion, collaboration, and hands-on problem solving without 
sacrificing the intelligence of the system. 
Whether the All Math Minutes future is primarily digital, primarily offline, or (most likely) a 
thoughtful blend, the system will  provide the connective intelligence. The learning science 
doesn't change. The adaptive, competency-based, assessment-driven cycle doesn't change. 
What changes is the interface. 
This is the long-term vision. Realizing it requires a path that respects the realities of how schools 
operate today, and a platform flexible enough to enter through the contexts where the need is 
most visible and the fit is most immediate. 
8. The Path to Adoption 
The All Math Minutes vision is powerful, but the K–12 market is not yet ready to adopt a fully 
integrated solution all at once. The constraints are structural, and they do not resolve on their 
own. 
Policy frameworks continue to organize accountability around grade-level standards and annual, 
calendar-based assessments, creating persistent pressure to advance students by time rather 
than by mastery. Instructional mindsets across teachers, administrators, and families have been 
shaped by decades of grade-level pacing and still treat competency-based progression as an 
exception rather than a norm. Publisher ecosystems dominate core curriculum adoption on 
multi-year cycles, making it difficult for a new intelligence layer to displace existing materials 
even when the learning model underneath is stronger. And the practical realities of change 
management, including limited teacher capacity, finite professional learning budgets, staff 
turnover, and competing priorities, mean that any adoption strategy requiring wholesale 
transformation on day one will stall regardless of its merit. 
That does not make the vision less compelling. It means the path to adoption must be 
sequenced, and Project ATLAS enables Teach to One to support that sequencing by entering 
schools and the broader market through contexts where the need is already visible and the fit is 
easier to establish.  
16 


[DRAFT: Keep Confidential] 
Supplemental learning, including intervention blocks, extended-day and summer programs, 
enrichment periods, is the most immediate, because these contexts are already structured 
around individual student need rather than grade-level pacing, and Teach to One’s adaptive, 
competency-based sequencing engine answers a need those programs already feel acutely.  
Tutoring, particularly high-dosage and virtual models, is a similar wedge: tutors need real-time 
insight into what each student knows and doesn't, and the goal is acceleration rather than 
coverage, which is exactly what a personalized, mastery-oriented system is built to deliver.  
Assessment experiences such as exit tickets and formative check-ins offer a third entry point, 
where Teach to One, powered with multimodal capabilities (voice responses, handwriting 
analysis, open-ended reasoning) and misconception detection, can replace a generation of 
multiple-choice items with something that gives teachers far more useful information.  
Personalized homework is a fourth: sequencing out-of-class practice to each student's current 
skill level with adaptive difficulty and immediate feedback is a persistent pain point for teachers, 
a natural application of the system's sequencing engine, and a low-friction way to bring students 
and families into regular contact with it.  
Core classroom adoption is also a critical opportunity. Rather than displacing a district's 
existing curriculum or publisher relationships, Teach to One can layer on top of them, using the 
district's scope and sequence as the frame while adding the personalization, misconception 
detection, and smart grouping that core materials rarely provide on their own. This path requires 
deeper institutional commitment than the others, but for districts already seeking better ways to 
differentiate within grade-level standards, it is a direct entry rather than an expansion from 
adjacent contexts.  
And the skill maps themselves, the underlying knowledge graph and predecessor-skill structure 
that Unlocking Algebra validated, are directly usable artifacts that districts, publishers, and 
researchers can adopt as planning and analysis tools even before taking on any other part of 
the system. 
In each case, Teach to One solves a concrete, visible problem while demonstrating the value of 
the more connected, AI-native learning system underneath. And the same flexibility that makes 
these entry points possible has a broader implication for how Teach to One enters classrooms: 
the platform is architected to power multiple models of instruction, not a single "mode," and to 
do so across more than just New Classrooms' own product. 
How Project ATLAS unlocks multiple learning models 
Schools organize math instruction in multiple ways, often with different pedagogical goals, 
staffing, and structure. Teach to One will be designed to integrate effectively into these multiple 
instructional contexts while maintaining a competency-based, personalized approach 
throughout. Rather than offering schools a binary choice between one product configuration and 
another, Teach to One, powered by ATLAS ,will provide a single intelligence layer that adapts to 
17 


[DRAFT: Keep Confidential] 
how instruction is actually structured on the ground. Three dimensions of flexibility make this 
possible. 
Teach to One will be architected to power a range of instructional models, including core 
instruction, tutoring, enrichment, intervention, extended learning, and blended combinations of 
these. Each model looks different on the surface, but all of them connect to a shared adaptive 
intelligence and a common data foundation. A student moving across these contexts during the 
day will not leave Teach to One behind; the same sequencing engine, the same misconception 
models, and the same record of prior learning follow them from one context to the next. 
Second, Teach to One is built on a modular, API-driven architecture that makes integration 
possible, streamlining connections with the systems a school or district already runs, including 
student information systems, rostering tools, and learning management platforms. This reduces 
the one-off engineering work that typically accompanies new deployments and means Teach to 
One can enter an existing technology ecosystem without wholesale replacement of the tools 
already in place. 
Finally, traditional instructional software is organized around grade-level pacing, with the 
calendar as the primary structural anchor. Teach to One inverts this: student progression is 
the organizing principle, and personalized pathways are aligned with shared classroom goals 
and instructional coherence. That shift is what allows the same system to support both a 
grade-level core classroom where teachers are accountable to standards and an intervention 
block where a student may be working several grades behind, without disrupting either setting's 
logic. 
 
Smart document processing and data import further reduce the setup burden. Bell schedules, 
academic calendars, pacing guides, and rosters can be ingested directly rather than manually 
configured, which minimizes the amount of district-specific setup work required to make each 
instructional context impactful. The operational ease of standing up Teach to One inside a new 
school or district is part of what makes the multi-model approach feasible at scale, not just in 
principle. 
18 


[DRAFT: Keep Confidential] 
What this Looks Like in Practice 
To make these dimensions concrete, the three vignettes below show Teach to One, powered by 
ATLAS, operating inside three different instructional contexts with three different students. The 
examples below illustrate how the same intelligence layer adapts to different models without 
changing its core value. 
A Grade-Level Core Classroom 
Marcus is a 6th grader in his regular math class, where his teacher, Mrs. Gonzalez, is 
accountable to grade-level standards and a district scope and sequence. Teach to One respects 
these constraints and personalizes within them. When Marcus begins work on expressing 
decimals as fractions, he starts to struggle, and the system surfaces a gap in his place-value 
understanding. Rather than pulling him out of the grade-level sequence,  Teach to One 
orchestrates a just-in-time mini-sequence of place-value problems with hints calibrated to his 
exact misconception. When he treats 0.304 as 304/100, the system does not give a generic 
hint, it targets the error: "Is 0.304 greater than or less than 1? What about 304/100? Try thinking 
about the ones place and the tenths place separately." He revises, the system assesses his 
reasoning, and after a streak of quick answers it signals his readiness to return to grade-level 
fractions work. Marcus does not experience the detour as remediation. His roadmap is simply 
personalized. 
Mrs. Gonzalez is working at a different altitude. Five minutes before class, she opens her  Teach 
to One dashboard and finds five recommended groupings for the block, each with a suggested 
modality and curated materials, synthesized from yesterday's assessment data and this 
morning's entrance checks. One student is flagged for the personalized prerequisites group. 
She reviews the recommendation and overrides it: she knows that student has had a rough 
morning and will benefit from peer proximity and her direct presence, so she moves him into the 
teacher-led group. The dashboard updates.  Teach to One’s role is to make her decisions 
informed and efficient; the professional judgment remains hers. 
An Intervention Block 
Jayla is a 7th grader in a 30-minute intervention block that meets three times a week. She has 
gaps in multi-digit multiplication and fraction operations that are blocking her grade-level work in 
ratios and proportions. Here Teach to One operates with significantly wider latitude. The 
roadmap ranges freely across the full skill graph, working Jayla through carefully sequenced 
predecessor skills the system has identified as the highest-leverage for her 7th-grade readiness. 
The experience is rich rather than remedial, with adaptive hints, digital manipulatives, and 
multiple problem modalities. An interventionist monitors the session in real time and steps in 
when the system signals that Jayla needs human help. Nothing in the framing suggests she is 
"behind." Her roadmap is personalized; it simply includes deeper work on foundational skills 
because that is what will unlock her ability to progress. 
A Summer Bridge Program 
19 


[DRAFT: Keep Confidential] 
Diego is a rising 9th grader in a four-week summer bridge program aimed at Algebra 1 
readiness. The program opens with a diagnostic that maps his current competencies and gaps 
against the Algebra 1 prerequisite graph, and  Teach to One uses this assessment to build a 
four-week sequence targeting the highest-leverage predecessor skills. The summer teacher 
opens the dashboard and reads a synthesis in less than a minute: what Diego has mastered, 
what still blocks him, and what the coming weeks will work on. Across those four weeks, Diego 
works through carefully calibrated problems, with adaptive hints, multimodal assessment, and 
ongoing recalibration based on what he demonstrates. The goal is not coverage but readiness, 
with the Unlocking Algebra research grounding what readiness actually requires. 
Three students, three contexts, three distinct ways 8.4 
Teach to One adapts. What changes across them is the scope of personalization, the 
relationship to external curriculum constraints, and the degree of freedom the system has to 
range across the skill graph. What stays constant is the learning science underneath: 
competency-based progression, predecessor-skill targeting, adaptive calibration, and 
continuous formative assessment. 
Project ATLAS enables Infrastructure for the Field 
The same flexibility that lets Teach to One adapt across instructional contexts within a single 
school also makes it usable outside New Classrooms' own classrooms. As Teach to One 
matures through Project ATLAS, the platform will be configurable for use by other organizations: 
curriculum providers, districts, and innovative model designers looking to embed personalized, 
competency-based learning into their own approaches without having to build the underlying 
infrastructure themselves. 
In 2022, New Classrooms and Transcend 
published Out of the Box: How Innovative 
Learning Models Can Transform K-12 Education, 
arguing that the transition from the industrial 
paradigm of schooling to a student-centered 
paradigm requires a new type of organization: 
the innovative model provider. These are 
organizations that weave together instructional 
design, pedagogy, operations, and technology 
into comprehensive learning models that schools 
can adopt and adapt. The paper identified a 
critical structural barrier to this work: too few 
such providers exist, in large part because the 
technical infrastructure required, including skill 
maps, sequencing engines, assessment 
systems, experimentation pipelines, and 
real-time data synthesis, is extraordinarily 
difficult and expensive to build from scratch. 
20 


[DRAFT: Keep Confidential] 
Project ATLAS has the potential to remove that barrier. The same infrastructure that powers 
Teach to One Roadmaps, including the skill  map, the competency inference models, the 
adaptive sequencing engine, the experimentation framework, and the classroom orchestration 
layer, can be offered as a managed platform that other organizations build on top of. Three 
audience patterns illustrate how this plays out. 
Curriculum providers will plug their content into Teach to One and immediately gain access to 
personalized sequencing, adaptive difficulty calibration, and multimodal assessment, without 
building any of that infrastructure themselves. A publisher integrating their math curriculum can 
continue to focus on pedagogy and content quality while Teach to One handles personalization 
underneath. 
Districts will configure Teach to One with their own content and scope and sequence, infusing 
their pedagogical point of view by adjusting the calibration of modalities and the balance of 
inquiry-based experiences and direct instruction. A district deploying Teach to One across fifty 
schools can calibrate the system to reflect the district's instructional philosophy and local 
curriculum, while the intelligence layer handles personalization and orchestration underneath. 
Innovative model providers, the type of organization Out of the Box called for, focus on what 
makes their model distinctive: learning design, teacher support, community relationships, and 
the specific experience they are building. Teach to One handles the computational complexity of 
personalization at scale. A microschool network using Teach to One for adaptive math while 
designing its own blended learning model is one example; a tutoring organization building its 
practice around real-time mastery signals is another. 
New Classrooms has always believed that personalized, competency-based learning should be 
the norm, not the exception. Project ATLAS is how that belief becomes infrastructure for 
the field, evolving Teach to One from a platform that powers New Classrooms' own product into 
one that others can build on. It also reflects New Classrooms' position as a nonprofit: the 
organization's mission is to shift how K-12 math is taught and learned at scale, not to capture a 
single slice of the market. A platform approach lets New Classrooms partner with organizations 
that might otherwise be in competition with each other, and with organizations that could not 
reasonably fund this infrastructure on their own. 
The Shared Foundation 
Across every instructional context Teach to One supports and every platform configuration it 
enables, the underlying learning science stays constant. Competency-based progression, 
targeted predecessor skill development, adaptive difficulty calibrated to each learner's zone of 
proximal development, continuous formative assessment, and the compounding intelligence of 
the ATLAS-powered learning cycle are not features that apply in some settings and not others. 
They are how the system works, full stop. 
What changes from one model to the next is the scope of personalization, the relationship to 
external curriculum constraints, and the degree of freedom the system has to range across the 
21 


[DRAFT: Keep Confidential] 
skill graph. A grade-level classroom constrains the roadmap to on-grade standards while still 
differentiating within them. An intervention block opens the roadmap to the full skill graph so the 
system can target predecessor skills wherever they sit. A summer program prioritizes readiness 
for the next grade. A district configuration reflects that district's pedagogical point of view. A 
publisher integration routes through the publisher's content. In each case the configuration is 
different, but the learning principles and the accumulated record of the student are the same. 
This is what makes Teach to One a platform with intelligence at its core, rather than a static 
piece of software. The system's behavior adapts to context, but what it does for a given student, 
meaning measuring what they know, identifying what they need next, calibrating the experience 
to their current zone, and closing the loop with evidence of learning, does not. That is the claim 
New Classrooms is in a position to make. 
9. New Classrooms Is Uniquely Positioned 
Project ATLAS builds on more than a decade of New Classrooms' direct work in personalized 
math learning, including the development and scaling of Teach to One Roadmaps, its existing 
product serving nearly 40,000 students across diverse district and school settings. This is not a 
vision starting from zero. It is the next chapter of work already underway: extending the learning 
science, product infrastructure, and classroom experience developed through Teach to One 
Roadmaps into a more deeply AI-native foundation for teaching, learning, and academic 
support. 
New Classrooms has invested more than $100 million over the fifteen years building the 
technical infrastructure and organizational know-how required to support personalized, 
competency-based learning. That investment has produced assets that are difficult to replicate: 
years of historical implementation data, a proprietary mathematics skill map, a structured 
dataset of more than 5 million student-skill interactions generated within a personalized, 
competency-based learning framework, and a platform architecture already operating in real 
classrooms. The Unlocking Algebra research, conducted on New Classrooms’ own student 
population data in partnership with TNTP, further demonstrates that this foundation is not merely 
structural but empirically validated: the predecessor skill relationships in the system predict 
real-world student success. 
Much of what Project ATLAS requires already exists in foundational form. The skill maps, 
competency inference models, adaptive sequencing engine, experimentation infrastructure, 
data pipelines, content systems, and classroom orchestration layer are not hypothetical. They 
are already in use through Teach to One Roadmaps and can now be enhanced through AI and 
tested in authentic school settings. This gives New Classrooms a rare ability to apply emerging 
AI capabilities to longstanding instructional and operational challenges in ways that are 
grounded in practice, not built in abstraction. 
The team is built for this work. It includes academicians, product leaders, technologists, 
computer science PhDs, and former teachers who understand both the possibilities of adaptive 
systems and the realities of classroom implementation. New Classrooms’ approach is grounded 
22 


[DRAFT: Keep Confidential] 
in learning science, not hype. Personalized, competency-based learning is not a marketing 
frame for the organization; it has been the core of its work for fifteen years. 
Moreover, as a nonprofit, New Classrooms is positioned to pursue Project ATLAS not only as 
product innovation, but as infrastructure for the broader field. It is focused on a mission of 
transforming K–12 education, not on generating financial returns for investors. That creates 
unusual freedom to partner across the sector, including with organizations that may otherwise 
compete with one another or lack the resources to build the necessary infrastructure and data 
on their own. 
To realize the full ATLAS vision, both as an enhancement to Teach to One and as infrastructure 
for the broader field, additional capabilities will need to be layered in: diverse content ingestion 
so partner curricula can be integrated alongside New Classrooms’ own content; configurable 
scope and sequence constraints so Teach to One can operate across different pedagogical 
frameworks; partner-facing APIs and interfaces; and a multi-tenant architecture that enables 
multiple organizations to build on the same intelligence layer while maintaining their own identity 
and instructional approach. 
Project ATLAS is the next chapter of this work: the application of powerful new AI capabilities to 
problems New Classrooms has been solving methodically for years, and a path toward making 
the underlying capabilities of personalized, competency-based learning more powerful and more 
broadly available. New Classrooms has always believed personalized, competency-based 
learning should be the norm, not the exception. Project ATLAS creates an opportunity not only 
to deepen that work within Teach to One, but to extend its impact across a far broader set of 
students, classrooms, and organizations. 
 
23 


[DRAFT: Keep Confidential] 
References 
Azevedo, R., & Hadwin, A. F. (2005). Scaffolding cognition and metacognition in 
computer-based learning environments. New Directions for Teaching and Learning, 104, 47–57. 
Bertsch, S., Pesta, B. J., Wiscott, R., & McDaniel, M. A. (2007). The generation effect: A 
meta-analytic review. Memory & Cognition, 35(2), 201–210. 
Black, P., & Wiliam, D. (1998). Assessment and classroom learning. Assessment in Education: 
Principles, Policy & Practice, 5(1), 7–74. 
Bloom, B. S. (1984). The 2 sigma problem: The search for methods of group instruction as 
effective as one-to-one tutoring. Educational Researcher, 13(6), 4–16. 
Cepeda, N. J., Vul, E., Rohrer, D., Wixted, J. T., & Pashler, H. (2008). Spacing effects in 
learning: A temporal ridgeline of optimal retention. Psychological Science, 19(11), 1095-1102. 
Kulik, C.-L. C., Kulik, J. A., & Bangert-Drowns, R. L. (1990). Effectiveness of mastery learning 
programs: A meta-analysis. Review of Educational Research, 60(2), 265–299. 
Kyndt, E., Raes, E., Lismont, B., Timmers, F., Cascallar, E., & Dochy, F. (2013). A meta-analysis 
of the effects of face-to-face cooperative learning. Do recent studies falsify or verify earlier 
findings? Educational Research Review, 10, 133–149. 
https://doi.org/10.1016/j.edurev.2013.02.002 
Laun, M. & Wolff, F. (2025). Chatbots in Education: Hype or Help? A meta-analysis. Learning 
and Individual Differences, 119.  
Rohrer, D., Dedrick, R.F. & Burgess, K. (2014). The benefit of interleaved mathematics practice 
is not limited to superficially similar kinds of problems. Psychonomic Bulletin & Review, 21, 
1323–1330. 
Ryan, R. M., & Deci, E. L. (2000). Self-determination theory and the facilitation of intrinsic 
motivation, social development, and well-being. American Psychologist, 55(1), 68–78. 
TNTP & New Classrooms. (2025). Unlocking Algebra: What the data tells us about helping 
students catch up. TNTP.org. 
Vygotsky, L. S. (1978). Mind in society: The development of higher psychological processes. 
Harvard University Press. 
Wang, X., Huang, R. T., Sommer, M., Pei, B., Shidfar, P., Rehman, M. S., Ritzhaupt, A. D., & 
Martin, F. (2024). The efficacy of artificial intelligence-enabled adaptive learning systems from 
2010 to 2022 on learner outcomes: A meta-analysis. Journal of Educational Computing 
Research. 
Wu, H., Chen, X., Zhang, X., & Liu, Y. (2024). Efficacy of AI-powered chatbots in education: A 
meta-analysis. British Journal of Educational Technology, 55(3), 1247–1268. 
24 


