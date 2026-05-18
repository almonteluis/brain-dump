---
description: "Today I looked at the first PR on our new project repo. It added a new run script, but the README didn’t mention it. The proposed change was incomplet"
tags: ['research']
source: "https://jessitron.com/2026/04/06/adding-correctness-conditions-to-code-changes/"
raw_file: "Adding Correctness Conditions to Code Changes.md"
created: 2026-05-17
---

Today I looked at the first PR on our new project repo. It added a new `run` script, but the README didn’t mention it. The proposed change was incomplete, because the documentation was out of sync.

Did I comment on the PR? heck no. I want to fix this problem for all PRs, not just this one. We can automate this stuff now.

**Correctness condition:** All PRs include updates to all relevant documentation files.

How can we make this true?

Instructions – We can change AGENTS.md to instruct our coding agent to look for documentation files and update them.  
Verification – We can add a reviewer agent to check each PR for missed documentation updates.

This is two changes, so I can break this work into two parts. Which of these should we do first?

## Changing the instructions is easy.

If we do instructions first, it’s easy. It will work most of the time. When I try it on this little PR, it will certainly work, and then I can claim victory and move on to the next feature.

Then later, on some future PR, the agent will miss updating some documentation. Will I notice? No. In fact: I hope not. If I’m looking through PRs to a level of detail that includes all documents in the PR and also documentation files not in the PR, then we have failed to automate enough of this project. (This project does not deserve that level of scrutiny.)

Changing instructions without verification gives me no guarantee of my correctness condition.

## Adding validation is sufficient.

If we do validation first, then every PR will be checked for missed documentation updates. Incorrect PRs will be rejected, so the coding agent will have to update the documentation.

My correctness condition will be guaranteed. Well, as guaranteed as I can get it with this nondeterministic automation. The reviewing agent will have only one task, so it won’t forget to check for needed documentation updates. If we ever catch it being wrong, then we must update its instructions.

If we never implement the instructions change, then PRs will take longer, because some agent has to respond to the PR comments, and then the feedback loop runs again.

With verification in place, the instructions change is an optimization!

## Validation before implementation.

It’s a little like test-first development, but at a higher level. We’re adding a check to every feature implementation, not just one.

It’s more like property testing than unit testing. We aren’t hard-coding “every feature should update the README.” We’re stating a property: the documentation should be up-to-date after every feature change.

Now my PR reviews are also system reviews: what about this PR should have been different? How can we change the agent’s context and feedback to make that different? Now test that system change on this PR before we fix it.

This is the new Boy Scout Rule. It went from “leave the codebase cleaner than I found it” to “make the whole develoment system stronger than it was.”

It’s all part of programming the agents to program our software.
