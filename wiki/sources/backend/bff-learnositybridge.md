---
description: "Backend for Frontend that provides secure access to Learnosity APIs"
tags: ["marvin", "new-classrooms", "engineering"]
raw_file: "BFF_LearnosityBridge.md"
created: 2026-05-17
---

---

# BFF / Learnosity Bridge

## Purpose

Provides access to Learnosity for the Front End, storing the private API keys and providing authorization for requests from the front end.

## Technology

C# codebase running via dotnet in the Docker Compose stack and as a Lambda in AWS.

## Connections

- **Front End** - makes connections to Learnosity Bridge to do things like initializing assessment sessions
- **Learnosity** - makes requests to various [Learnosity APIs](https://reference.learnosity.com/) to retrieve data

## See also

- [Learnosity Access](https://newclassrooms.atlassian.net/wiki/spaces/PRODUCT/pages/43057209/Learnosity+Access)
