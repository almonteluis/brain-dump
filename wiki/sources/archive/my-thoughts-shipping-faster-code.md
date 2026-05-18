---
description: "Most of the things discussed here I already know, like shipping smaller diffs. The thing that really just stood out to me was the mention of using fea"
tags: ['research']
raw_file: "My thoughts shipping faster code.md"
created: 2026-05-17
---

Most of the things discussed here I already know, like shipping smaller diffs. The thing that really just stood out to me was the mention of using feature flag. Pretty much hey, we could release features behind the flags and, in the process, we don't need to go through all these edge cases to kind of QA. To think of it let's do it like that even for release features we could do that. 

And another thing that stood out was test through automated tests. It never really specified if they were talking about unit tests or end-to-end testing. I do find that more useful towards the end of development, when I was ready for QA and running all of the frontend automation tests and fixing bugs as I came across them. I should add running the frontend automation a lot sooner and earlier in my development. Once I think I have a feature and it's on dev, I should definitely be running that. 

Another thing that the author mentioned I really do like is if you're new to a codebase, learn how to trace code. I've been using Nvim, so it kind of forced me to be one with the editor and jump around and go between files and find functions to do code traces. That resonated with me recently because I could traverse the codebase a lot easier and I understand the changes that I'm making. I do want to add that to the list of things that's like "Hey, I'm already doing it," and recently I am seeing it prove that's working, so I'm in agreement with the author here. 

Okay, another thing that had me thinking was the phases of development.

The biggest blocker for me is usually code review. My PRs usually don't get approved. It takes two to three days, typically longer. The shorter it is, the quicker I can get those through, but the bigger it is, the longer it takes. The bigger the PR is, the more I procrastinate and clean up proactively so it could go through smoothly.

The second biggest blocker is usually after code review, which is QA. There's a lot of knowledge dumping from me to them so they could do their job to find edge cases. There's usually some misunderstanding as I'm describing a feature, and then design is usually pretty straightforward. There's really no back-and-forth with them, and development is usually just me. Deployment, if it goes through QA, is usually smooth. 

---
**Harvested into:**
- [[shift-left-fe-automation]]
- [[code-tracing-onboarding]]
- [[unleash]] (release gates appended)
- [[context-engineering]] (code review bottleneck appended)
