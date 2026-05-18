---
description: "After home week, with new classrooms and hearing Russ's thoughts, our current architecture is not currently built to do the knowledge graphs and retri"
tags: ["marvin", "new-classrooms", "engineering"]
raw_file: "Thoughts about current architecture with Marvin.md"
created: 2026-05-17
---

After home week, with new classrooms and hearing Russ's thoughts, our current architecture is not currently built to do the knowledge graphs and retrieval-augmented generation. The main reason is that we are a Postgres database with tables and columns but we need to start transitioning to converting that database from tables and columns into a graph with nodes and connections. That makes more sense why Russ thinks that our current architecture isn't good enough as it is because we fundamentally have to change the data structure of how we are currently doing stuff. To support this new phase, which makes sense, I think I stated that before but I'm just recording it again
