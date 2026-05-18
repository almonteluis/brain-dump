---
description: "Building a knowledge graph to power retrieval-augmented AI content generation"
tags: ['research', 'ai']
source: "https://parsnip.substack.com/p/ai-content-bet"
raw_file: "Parsnip's bet on expert-trained LLMs 👩‍💻.md"
created: 2026-05-17
---

Friends who are following our journey,

As we enter the next phase of Parsnip, I’d like to share a summary of our progress so far and the AI content hypothesis we’re proving out next.

---

As a refresher, our vision for Parsnip is to build a **personalized** **AI tutor** that’s **integrated into your life**.

![](https://substackcdn.com/image/fetch/$s_!di-4!,w_1456,c_limit,f_webp,q_auto:good,fl_progressive:steep/https%3A%2F%2Fsubstack-post-media.s3.amazonaws.com%2Fpublic%2Fimages%2Ffe783088-1058-4ea4-8f15-55275f005c84_1606x635.png)

Underlying our core insight is Bloom’s 2 sigma problem: we know that almost any student can reach the 98th percentile of what’s possible in classroom education, but it’s too costly to give everyone a human tutor. Despite decades of effort in education tech, no one’s really cracked this problem.

![](https://substackcdn.com/image/fetch/$s_!I_xe!,w_1456,c_limit,f_webp,q_auto:good,fl_progressive:steep/https%3A%2F%2Fsubstack-post-media.s3.amazonaws.com%2Fpublic%2Fimages%2F755d433a-fec2-4a3c-b293-1158ee757c11_1710x946.png)

Moreover, there are core skills in our lives where proficiency would be incredibly beneficial—such as parenting, relationships, health/fitness, personal finance, and cooking. But we can’t even go to schools for these, let alone find everyone an individual coach or tutor.

An AI & software-powered tutor that (1) you can use at any time, (2) is personalized to your experience, and (3) lets you learn new knowledge at your own pace, would make incredible learning accessible to anyone. And in the age of generative AI, it’s now possible to build that.

Parsnip’s core idea is to:

1. create a structure of knowledge (or skills) from unstructured information,
2. generate content to learn each of those skills, and
3. connect those skills to real world tasks:

![](https://substackcdn.com/image/fetch/$s_!MX2d!,w_1456,c_limit,f_webp,q_auto:good,fl_progressive:steep/https%3A%2F%2Fsubstack-post-media.s3.amazonaws.com%2Fpublic%2Fimages%2Fcea12b9d-1d43-41f2-8185-c865f6961afc_1695x856.png)

This AI-driven learning using [[retrieval-augmented content generation (RAG)]] from an underlying [[knowledge-graph]] (or “skill tree”) has two significant differentiators from a pure-LLM learning approach [^1]. The knowledge graph both (1) **controls hallucination** and (2) **keeps track of what users have learned**. As a result, this learning system can do three interesting things simultaneously:

1. **track and map** a user's existing knowledge
2. **teach and impart** new knowledge
3. **visualize and explore** what a user has learned—and what can be learned next—in an interpretable way

==This feeling of “seeing your skills” akin to playing a character in a video game is a feature that Parsnip users love, and also the foundation of a data moat for the business we’re building.==

---

Cooking is a perhaps surprising, but particularly powerful market [^2] for personal consumer learning. Consider that:

- **72%** of Americans (**84%** ages 18-34) want to improve their cooking skills.
- **70%** of beginner cooks we interviewed “ **don’t know where to start** ”.

There are [numerous examples of this pain](https://parsnips.notion.site/Learning-to-cook-is-a-painkiller-not-a-vitamin-49f10a31defc4ef9bdba6cb8726627bb?pvs=4) all over the internet, which users go to the trouble of writing long screeds about, in the hopes of finding relief.

![](https://substackcdn.com/image/fetch/$s_!jmkY!,w_1456,c_limit,f_webp,q_auto:good,fl_progressive:steep/https%3A%2F%2Fsubstack-post-media.s3.amazonaws.com%2Fpublic%2Fimages%2Fe555ceb2-4a3f-4057-b46f-fd265199e7e7_1669x535.png)

There’s a simple reason behind this lamentable situation: we used to learn to cook from our parents and our schools, but [not any more](https://parsnip.substack.com/p/why-now). And YouTube and TikTok, the main replacement for this “job to be done” of “I need to get better at feeding myself”, just aren’t cutting it—and folks are hungry to try something else.

---

What we’ve been building with Parsnip is a learning platform that not only lets you learn the cooking skills behind any recipe, but also see how your knowledge grows over time.

![](https://substackcdn.com/image/fetch/$s_!RijY!,w_1456,c_limit,f_webp,q_auto:good,fl_progressive:steep/https%3A%2F%2Fsubstack-post-media.s3.amazonaws.com%2Fpublic%2Fimages%2Ffdba402f-36d4-4aad-a274-4a4fd3093b82_2100x876.png)

Our approach has shown some promising traction so far. First, because of that widespread hair-on-fire pain, we’ve seen steadily increasing **free user acquisition** via earned media and word-of-mouth. Parsnip currently sees about **600 new organic installs/week** with no marketing efforts. We’ve been featured on both iOS and Android, which included us in “big ideas from up-and-coming companies”:

![](https://substackcdn.com/image/fetch/$s_!kgQ0!,w_1456,c_limit,f_webp,q_auto:good,fl_progressive:steep/https%3A%2F%2Fsubstack-post-media.s3.amazonaws.com%2Fpublic%2Fimages%2F174af753-575e-4cdd-93e6-a0c72c46c473_797x581.png)

Many users arrive at our active [Discord community](https://discord.gg/P4qpxsJ6A8) via word-of-mouth. But they also make this plain in their reviews, as they are “sending to everyone I know” and “making my mom and sister download it too”.

![](https://substackcdn.com/image/fetch/$s_!F-_f!,w_1456,c_limit,f_webp,q_auto:good,fl_progressive:steep/https%3A%2F%2Fsubstack-post-media.s3.amazonaws.com%2Fpublic%2Fimages%2F49c0d55d-5f24-4a43-bcb5-bbdf9fcaeefb_1328x534.png)

And that’s because the knowledge graph approach to learning isn’t just a cool idea, it also makes a fantastic product. The Parsnip app currently has

- 4.9⭐ on both iOS & Android, with over 1,000 reviews
- ~40% of users would be “very disappointed” if they could no longer use it [^3]
- extremely excited users, including one of our favorite testimonials:

![](https://substackcdn.com/image/fetch/$s_!LqPu!,w_1456,c_limit,f_webp,q_auto:good,fl_progressive:steep/https%3A%2F%2Fsubstack-post-media.s3.amazonaws.com%2Fpublic%2Fimages%2F1e200a74-e3e9-438c-abd6-7afb3ddca514_1395x629.png)

---

Yet, the ==main limitation with Parsnip until now is that much of our content was either laboriously hand-written or LLM-generated with heavy editing==. With only a subset of all available cooking skills, users ran out of things to learn, and became dormant. When we surveyed several hundred users about how to improve Parsnip, 70-80% of them simply wanted more levels and more dishes.

And so despite great user excitement, our user retention is nowhere near its potential. Even with only 150 skills and 30 recipes available, our retention of 25% week 4 and 15-20% week 8 is promisingly high, with some users having completed every single level in Parsnip. With every cooking skill for any dish in the world (and features that go beyond just learning), we hypothesize that it’s possible to attain retention as high as 50% even 3-6 months in.

Hence, we’re excited to be building fully automated AI skill tree generation that expands Parsnip's learning modality so that anyone in the world can learn how to cook anything. You’ll be able to drop *any recipe on the Internet* into Parsnip and learn all the skills you need to make it.

The cherry on top is that this design means we get to use the latest advances in LLMs and image generation models in a way that's core to our product experience [^4] — more on the cool tech behind this system in a future post.

With essentially unlimited content, users will be able to enjoy Parsnip for far longer — and our free user acquisition and intense product love will become the foundation of a thoughtful freemium business model. We’d love to make this user’s dream come true…

![](https://substackcdn.com/image/fetch/$s_!KiPA!,w_1456,c_limit,f_webp,q_auto:good,fl_progressive:steep/https%3A%2F%2Fsubstack-post-media.s3.amazonaws.com%2Fpublic%2Fimages%2Fb882506e-425b-40f6-affc-08b4ace212e0_862x383.png)

[^1]: Many recent AI education products can also generate a variety of multimodal content from any prompt. But only an underlying representation or map of knowledge will make it possible for the AI, and you, to keep track of what you’ve learned.

[^2]: A huge market with high demand, little competition, winner-take-all dynamics, and many potential positive externalities. See Section 4 of our previous post:[Friends of Parsnip](https://parsnip.substack.com/p/vision-part-two?utm_source=substack&utm_campaign=post_embed&utm_medium=web)


“Education is not preparation for life; education is life itself.” — John Dewey Friends, it’s been a while. But I’m excited to share a renewed vision for Parsnip. We started Parsnip to solve the cooking problem. But as we dug in, we realized that the biggest part of being able to cook is learning how to cook. And the more we worked on making that learning…

[^3]: This categorization comes from Sean Ellis’ [product-market fit survey](https://pmfsurvey.com/).

[^4]: Many AI products can run into the situation of being a hammer looking for a nail. Fortunately, we already have plenty of nails here!

For a startup they are positioning themselves well. With AI generating content and keeping their users learning and using the app. It’s working and it a most for them. I want to know if they planning on expanding this further to different subjects or an even a better play here for them would be selling the skill map in the LLM knowledge graph workflow to sell to other companies who got the domain expert but just want this tool to integrate. Hey we could generate our own content but we can have our people who are experts to validate that content and keep it pushing. They could be a Learnocity kind of third party that we will be relying on. For a new classrooms kind of deal they should really be focused on building out the tech team and have them take on these things.
