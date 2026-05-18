---
description: "https://youtube.com/watch?v=GWYhtksrmhE&si=1Z4CKwSOGme07B6V"
tags: ['research']
raw_file: "How NASA write code.md"
created: 2026-05-17
---

https://youtube.com/watch?v=GWYhtksrmhE&si=1Z4CKwSOGme07B6V

1. Simple control flow
	1. they don't use recursion because it's hard to trace if there's an error
2. Give all loops a set limit for the upper bound
	1. If a tool/loop can't can't prove the boundaries statistically then the rule is violated
3. Do not use HEAP
	1. This is because he has memory leaks and memory over usage so instead use something else to help control the memory used. 
4.  limit function size 
	1. The size of the function file should be no more than 60 lines 
5. Practice data hiding. 
	1. declaring variables as they're used at the lowest scope possible again all these rules are centered at writing safe code and code that is statically testable by declaring variables at the lowest scope required you not only reduce the amount of code that can access those variables but you also reduce the amount of places that can go wrong when debugging why
6. Check return value. 
	1. Check all non-void returned values, all of them. 
---
My thoughts around how NASA writes code: it's heavy on the backend, C#-kinda code. How would I implement this into my frontend work?
1. Simple control flow. I think it's valuable to set upper limits for loops. It also makes sense. I usually only really loop through an array so that's the upper loop that I'm usually dealing with.
2. Limit function size and stress the point that a function should only do one thing. I should implement that more. Check the return value for all functions. I got to be doing that more often and practice that more often.


That were the key takeaways I had from watching the video. I had to cut it off short because it was mostly about backend code but I found some value in it. 
