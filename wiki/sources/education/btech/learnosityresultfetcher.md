---
description: "Lambda service that retrieves assessment results from Learnosity API"
tags: ["marvin", "new-classrooms", "engineering"]
raw_file: "LearnosityResultFetcher.md"
created: 2026-05-17
---

---

# Learnosity Result Fetcher

## Purpose

Retrieves assessment results from the Learnosity API and persists them through GraphQL. Read more here.

## Technology

C# codebase running as a Lambda in AWS. Not currently part of the Docker Compose stack, so running it locally involves doing something out of band with the AWS .NET Mock Lambda Test Tool.

## Connections

- **GraphQL Service** - persists student assessment information retrieved from Learnosity
- **Learnosity** - retrieves information about student sessions from Learnosity

## See also

- https://newclassrooms.atlassian.net/wiki/x/KADBAg
