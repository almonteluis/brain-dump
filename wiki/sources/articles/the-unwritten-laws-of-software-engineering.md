---
description: "Last April, I wrote a well-received article about the 13 software engineering laws - Hyrum’s, Conway’s, Zawinski’s, and 10 famous others."
tags: ['research']
source: "https://newsletter.manager.dev/p/the-unwritten-laws-of-software-engineering?utm_source=tldrdev"
raw_file: "The unwritten laws of software engineering.md"
created: 2026-05-17
---

Last April, I wrote a well-received article about the 13 software engineering laws - Hyrum’s, Conway’s, Zawinski’s, and 10 famous others.

Last April, I wrote a well-received article about [the 13 software engineering laws](https://newsletter.manager.dev/p/the-13-software-engineering-laws) - Hyrum’s, Conway’s, Zawinski’s, and 10 famous others. The common patterns people noticed in software projects and decided to name.

But beyond the named laws, there are many unwritten rules every engineer who’s been around for a while just *knows*. You learn them by breaking things and swearing you’ll never do it again.

As everybody and their mother thinks they can build great software right now, I decided to help them avoid a bit of pain.

Here are 7 laws every engineer has broken at least once, learned the hard way:

1. Backups aren’t real until you’ve restored from them
2. You’ll always hate yourself for how you write logs
3. Always have a rollback plan. ALWAYS.
4. Every external dependency will fail
5. If there is ANY risk - “4 eyes” rule
6. There is nothing more lasting than a temporary fix

I lost count of how many times production broke right after I deployed something, and my first instinct was: “That’s totally not related to what I touched.”

Someone pings me: “Hey, this incident might be related to your PR.” My answer: “No way. Completely different area.”

![](https://media.beehiiv.com/cdn-cgi/image/fit=scale-down,quality=80,format=auto,width=720,onerror=redirect/uploads/asset/file/e5dfcd80-1ba8-4638-a74f-71e1013ce0a8/ff3edcfc-96d4-4eb1-b839-d37bc5383309_736x354.jpg)

It took me embarrassingly long to learn that when production breaks and you recently deployed *anything*, you shouldn’t spend an hour proving your change is innocent... You should just roll back immediately, stabilize, and *then* figure out what happened.

Instead of proving it’s not the problem, it took me a while to learn we should just rollback any change, stabilize, and then debug.

## 2\. Backups aren’t real until you’ve restored from them

This is the one engineers fail at the most.

How many of you have actually tried the restore option on your managed database? Not “I know it exists” - actually clicked through, watched it run, and confirmed your data came back as you expected?

Because aside from the fact that someone might have quietly turned backups off:

![](https://media.beehiiv.com/cdn-cgi/image/fit=scale-down,quality=80,format=auto,width=720,onerror=redirect/uploads/asset/file/585120dc-6f72-4ef1-937a-00f84affaeb6/6a81ba1b-d02e-484e-9700-2b9d37826d48_650x607.jpg)

Just *knowing* the restore process is critical:

- Do you have incremental backups or only full snapshots at specific times? What’s the gap between them - how much data can you lose?
- Who has the permissions to trigger a restore? Is it just one person?
- Where exactly do you click? Do you know the steps or are you ChatGPTing it for the first time during an outage?
- How long does it take? Hours? Will your app be down the entire time?

And this isn’t a one-time exercise. Processes change, infrastructure changes, and your data keeps growing (meaning restores that used to take 10 minutes now take 2 hours).

Even if you have a DevOps team that handles infrastructure, if you have write access to a database, it’s your responsibility to know how to restore it.

*Thanks Unblocked for supporting today’s article!*

A new unwritten law for 2026: AI-generated code is only as good as your context.

We all know garbage in, garbage out. But that’s not the problem anymore - agents today can get context through rules, skills, and MCPs. Yet teams still waste tokens on code they must rework. One culprit is *satisfaction of search*: agents stop at the first answer, with no way to know if it’s the right one.

Instead of duct-taping it yourself, try [Unblocked](https://getunblocked.com/?utm_source=managerdev&utm_medium=email&utm_campaign=contextengine). They build your org’s context from across code, PRs, docs, conversations and runtime signals so AI tools understand how your team works. It connects identities across systems, resolves conflicts, respects permissions, and surfaces what matters for the task.

[Give your AI the full picture](https://getunblocked.com/?utm_source=managerdev&amp;utm_medium=email&amp;utm_campaign=contextengine)

## 3\. You’ll always hate yourself for how you write logs

No matter how many times I started a repo with the intention of writing perfect logs, when an incident happened, something was always missing (or my json dumps were parsed incorrectly, causing messy info that is barely searchable).

Cursor & Claude cause the opposite problem - too many super verbose and confusing logs.

![](https://media.beehiiv.com/cdn-cgi/image/fit=scale-down,quality=80,format=auto,width=720,onerror=redirect/uploads/asset/file/8706eeb9-3fca-423e-9820-f9f795d78471/b69a7ac3-998a-4618-9d7c-a706f80631ca_355x465.jpg)

It’s quite tricky to hit the balance of:

- Have all the needed info
- In a searchable way, with a shared request/task ID across services
- Without too much info to confuse you

## 4\. Always have a rollback plan. ALWAYS.

No matter how small the migration or how minor the DB change seems - if you touch data, you need a quick, tested rollback plan.

Adding a column? Have a migration ready to remove it, and a PR to revert the related code changes. Inserting data? Be prepared to delete the exact rows you inserted. Deleting data? Copy it somewhere safe first. Changing a column type or constraint? Know exactly how to reverse it without data loss.

The keyword here is *tested*. A rollback plan you haven’t actually run has a 50/50 chance to break.

![](https://media.beehiiv.com/cdn-cgi/image/fit=scale-down,quality=80,format=auto,width=720,onerror=redirect/uploads/asset/file/8047fba6-2ea1-42aa-b06f-35020f9ae750/ee1d7cae-a43c-4b6b-b9d9-1b60d74c1ec6_600x628.jpg)

## 5\. Every external dependency will fail

A couple of years ago, [a 3rd party api ruined my weekend](https://newsletter.manager.dev/p/how-a-3rd-party-api-can-ruin-you). We started consistently hitting their rate limits, getting 429 errors, which escalated into a 2-week-long mess.

![](https://media.beehiiv.com/cdn-cgi/image/fit=scale-down,quality=80,format=auto,width=720,onerror=redirect/uploads/asset/file/e5a2fb57-50d2-4424-a94e-57a8c2cd8c4a/03d02a93-2b3e-4f74-818b-dfde41fe57f9_1024x1536.jpg)

As an engineer in a small company, adding an external API is so easy. You log in, get an API key, boom - works, problem solved. In a bigger company, you might go through some security process and maybe even some basic architecture review. But rarely does anyone ask: "What happens when this thing goes down?"

And even is they do, the default answer of “5 retries with exponential backoff” is usually enough. But if your system has a 99.9% SLA and you add a critical dependency on another system with 99.9% SLA, you will DOUBLE your downtime, from 8 to 17 yearly hours (unless you are both down anyway because AWS/Cloudflare is down…).

Took me a while (and that incident) to learn which questions to ask:

- What are the rate limits? What happens when you breach them? How are you notified?
- What will happen to our system if the API is completely down? Is a feature degraded, or is the whole app broken?
- Have we **actually tested in production** how our app behaves when this API is unavailable? (I had cases where we thought it’d impact a single feature, and it crashed the whole app as the call to the API was not where you would expect)
- Can we cache responses, queue requests, or serve stale data as a fallback?
- Do we know in advance what to communicate to users when it happens?
- Who’s the contact on their side when things go wrong, and what does their support SLA actually look like?

## 6\. If there is ANY risk - “4 eyes” rule

A few years ago, I [destroyed the company’s DB](https://newsletter.manager.dev/p/how-i-destroyed-the-companys-db), after a very stupid mistake.

As managers, we often have stronger permissions than we should - root access, production consoles, DB access. And after multiple incidents I've caused (both as an engineer and as a manager), this rule is burned into my brain:

If I have ANY doubt whether what I'm about to do is 1000% safe, I ask someone to look at it with me. Four eyes are always better than two. And honestly, half the time you catch the mistake yourself just by explaining what you're about to do out loud.

![](https://media.beehiiv.com/cdn-cgi/image/fit=scale-down,quality=80,format=auto,width=720,onerror=redirect/uploads/asset/file/e79653b9-570e-4b95-b049-6d35ee6dafd1/2bf82b80-3e91-4380-96ab-2ecf3c690e4d_1280x1920.jpg)

What if it’s late at night or a weekend, and you don’t want to bother anyone? That's the strongest signal you shouldn't be doing anything dangerous by yourself…

As any developer knows, when your PM says "we'll address this later," what they mean is "we'll never do it."

Priorities change. New projects are always shinier than maintaining existing infrastructure. The tech debt ticket keeps getting pushed to the next sprint, then the next quarter, and then gets buried in the backlog graveyard.

So many times I implemented V1/MVP of a project, just the bare bones of it, with tons of hacks, planning to improve things in V2. 90% of the cases, the time never arrived.

![](https://media.beehiiv.com/cdn-cgi/image/fit=scale-down,quality=80,format=auto,width=720,onerror=redirect/uploads/asset/file/7e7a6888-3d0d-4ace-be7a-7e05ca67af99/7d7fc045-1926-41bb-a3b5-94c057b3a053_493x539.jpg)

My approach slowly shifted into acknowledging it instead of fighting, as in some cases, it actually shows a good product culture. So now, I try to push for a minimal solution that I’m actually happy with. It doesn’t need to support future scale, or be super robust - just not be hacky.

There's a big difference between “this is simple and limited” and “this is held together with duct tape.”

1. [The hidden danger of shipping fast](https://newsletter.posthog.com/p/the-hidden-danger-of-shipping-fast?utm_campaign=the-unwritten-laws-of-software-engineering&utm_medium=referral&utm_source=newsletter.manager.dev) in. Super relevant article, many parts resonated.
2. [How to debug a team that isn’t working: the Waterline Model](https://www.lennysnewsletter.com/p/how-to-debug-a-team-that-isnt-working?utm_campaign=the-unwritten-laws-of-software-engineering&utm_medium=referral&utm_source=newsletter.manager.dev) by. Loved this model, I wish more managers would use it!
3. 2 more gems by (who slowly becomes a favorite newsletter writer of mine): [The Myth of Never Giving Up](https://marcrandolph.substack.com/p/the-myth-of-never-giving-up?utm_campaign=the-unwritten-laws-of-software-engineering&utm_medium=referral&utm_source=newsletter.manager.dev) and The [Most Underrated Startup Skill Isn’t Hustle. It’s Curiosity.](https://marcrandolph.substack.com/p/the-most-underrated-startup-skill?utm_campaign=the-unwritten-laws-of-software-engineering&utm_medium=referral&utm_source=newsletter.manager.dev)
