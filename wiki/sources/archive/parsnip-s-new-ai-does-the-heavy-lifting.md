---
description: "Our human-in-the-loop system creates content faster than ever, and at scale"
tags: ['research', 'ai']
source: "https://parsnip.substack.com/p/ai-content-creation"
raw_file: "Parsnip's new AI does the heavy lifting 💪.md"
created: 2026-05-17
---

Dear friends,

I’m excited to announce that over 30 new recipes have landed in Parsnip in the last several weeks — and more importantly, accompanied by extensive associated skill content, bringing us to over 400 levels of cooking skills. We’re now able to create learning materials for a dozen recipes at once, thanks to our transition from a labor-intensive manual writing process to a human-in-the-loop AI system where the AI does 90% of the work. For comparison, manually writing the 150 levels for our first 40 recipes took almost a year.

![](https://substackcdn.com/image/fetch/$s_!OU3C!,w_1456,c_limit,f_webp,q_auto:good,fl_progressive:steep/https%3A%2F%2Fsubstack-post-media.s3.amazonaws.com%2Fpublic%2Fimages%2Fcb32aad5-188a-4595-8ad0-32274bead2f8_1284x2778.png)

Until recently, one of the huge blockers for Parsnip was our limitation in teaching new recipes (and their required skills) at scale. Our new AI content pipeline unlocks a much larger library of recipes, moving us closer to our goal of being able to import any recipe from the internet and teach it automatically.

To give a sense of the scale of this improvement: it used to take *over 2 weeks* to research and write all the teaching content (levels) for a single recipe. Now, we can handle a dozen recipes at a time with a few hours of quality control/validation effort, all the while improving the underlying AI system with each iteration.

---

For some more context on what’s happening under the hood, it’s helpful to review how Parsnip works, conceptually:

![](https://substackcdn.com/image/fetch/$s_!Yg5b!,w_1456,c_limit,f_webp,q_auto:good,fl_progressive:steep/https%3A%2F%2Fsubstack-post-media.s3.amazonaws.com%2Fpublic%2Fimages%2F8c9a59f5-40da-4ca6-a1cd-bd71460fc8da_2127x1201.png)

1. We create a knowledge graph of cooking skills & concepts, turning unstructured cooking knowledge into a structured organization of discrete modules or nodes.
2. For any recipe, we can automatically identify the relevant skills and concepts in this knowledge graph using machine learning.
3. Then, for each concept, we create content to teach the relevant knowledge.

This content used to be laboriously written by hand, but we now use generative AI for much of the heavy lifting. Note that although Parsnip is still mostly in a quiz-style format, this knowledge graph can be used to generate many other forms of effective learning content in the future.

Other education approaches using generative AI are often a thin wrapper around LLMs, and there are two main ways the knowledge graph approach is different:

1. By breaking the universe of knowledge down into discrete nodes, we can teach you specific skills while also **tracking what you’ve learned**.[^1]
2. By focusing on teaching one concept at a time, we greatly reduce hallucination from generative models and can also improve quality using techniques like RAG.[^2]

---

In our first pass of this AI system, we’re accepting a quality drop on this content (maybe ~80% of hand-written) — but with the ability to create it ten times faster, our thesis is that we can overcome our content limitation [^3] to build a consistently growing subscription business. Then, we can improve quality over time, both using crowdsourced and expert validation.

One thing we’ve noticed while building this system is that LLMs by themselves are not great at surfacing expert knowledge — that is, if you ask ChatGPT about tacos, it won’t tell you what Mark Miller does in [his renowned book](https://www.amazon.com/Tacos-75-Authentic-Inspired-Recipes/dp/1580089771).[^4] We want to bring Mark’s experience and insight to anyone who’s learning about tacos, and building a RAG system into our knowledge graph will bring AI-powered learning much closer to an expert human tutor. We’ll have more exciting news to share on this later.

We’d love your feedback on these new recipes and the skills that are created with the help of AI. Please let us know what you think!

---

A common question we get when people hear about our approach to learning is: “ *would this work for something other than cooking*?” The answer, as we wrote [in a previous post](https://parsnip.substack.com/p/vision-part-two), is **absolutely**! The knowledge of any domain, whether conceptual or non-conceptual [^5], can be broken down into a structured format and then taught/learned in an individualized, personalized way.

In fact, not only is this possible, but we believe it’s crucial for a far more effective way of teaching anything, one that brings learning outside of the classroom into a personalized, digital experience that’s available at any time.

We're beginning to explore how this AI system can go beyond cooking and be used as a personal coach for other things we’d want to learn in life. If you have any thoughts about **(a)** creating Parsnip for something that isn’t cooking, or **(b)** how knowledge graph-powered learning might apply to other topics, we’d love to hear from you!

[^1]: Whether you’re learning in a classroom, from watching YouTube videos, or taking AI-generated quizzes, your teacher has no map of what you’ve actually learned and understood. But, a knowledge graph allows for a personalized view of exactly that.

[^2]: RAG, or retrieval-augmented generation, allows LLMs to use information in a database that is beyond the scope of their training data (e.g. information that’s more recent, or proprietary). A common turnkey approach is to use a vector database, but knowledge-graph based RAG is where things get really interesting.

[^3]: In our PMF surveys, feedback has overwhelmingly been “more recipes and more levels!”

[^4]: We’re fortunate and grateful for Mark’s continued support as one of our earliest backers.

[^5]: An example of conceptual knowledge is “avocadoes should be ripened outside of the refrigerator”. Non-conceptual knowledge includes things like dicing an onion or riding a bike, which are learned through practice. Capturing this in a knowledge graph means that instead of generating reading or quizzes, we would suggest drills or exercises.
