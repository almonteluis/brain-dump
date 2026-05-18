---
description: "GraphQL Service - Marvin"
tags: ['research', 'marvin', 'new-classrooms']
source: "https://newclassrooms.atlassian.net/wiki/spaces/MARVIN/pages/385417255/GraphQL+Service"
raw_file: "GraphQL Service - Marvin.md"
created: 2026-05-17
---

## GraphQL Service

## Purpose

Allows other components to retrieve and store any data they need in order to function. Provides the critical abstraction layer between NC and partner systems.

## Technology

C# code using [Hot Chocolate](https://chillicream.com/docs/hotchocolate/ "https://chillicream.com/docs/hotchocolate/") as a GraphQL framework. Runs via `dotnet` in the Docker Compose stack and as an ECS task behind an ALB in AWS.

## Connections

- [Database](https://newclassrooms.atlassian.net/wiki/spaces/MARVIN/pages/386007041) — serves and stores all data required by the service, though there is future potential for GraphQL resolvers to connect to other backends
- Inference Engine — reads skill states and other skill data and saves new skill states
- Learnosity Result Fetcher — retrieves data from Learnosity and essentially caches it
- Front End — reads and writes various program data

## Details

### Regenerating the schema files for clients

See [https://github.com/NewClassrooms/marvin/tree/main/graphql-service#generating-a-schema-file-for-client-use](https://github.com/NewClassrooms/marvin/tree/main/graphql-service#generating-a-schema-file-for-client-use)

## MiniProfiler

MiniProfiler ([https://miniprofiler.com/](https://miniprofiler.com/ "https://miniprofiler.com/")) can be used to understand how the GraphQL Service is interacting with the database. Profiling information is only available for development environments.

You can access the profiler information at `https://<graphql host name>/mini-profiler-resources/results-index`. You can also look at the response headers for a particular request for the `X-MiniProfiler-Ids` header. It will be a list. The last item in the list on that request is the id for the report for that request. You can visit `https://<graphql host name>/mini-profiler-resources/results?id=<that guid from the request>` directly to see the results as well.  
The reports show granular timing information, including what SQL queries were run and how long it took to return that data from PostgreSQL.

![image-20251124-172815.png](blob:https://newclassrooms.atlassian.net/d6e26f18-f853-4853-bec6-be6c65d70900#media-blob-url=true&id=03ba6cc8-f212-4b5d-86b9-8e3235c4641c&collection=contentId-385417255&contextId=385417255&mimeType=image%2Fpng&name=image-20251124-172815.png&size=189450&width=720&height=648&alt=image-20251124-172815.png&clientId=9fd199b9-f5f0-40a6-8c09-0dbb77bcfee5)

## See also

- [GraphQL Schema](https://newclassrooms.atlassian.net/wiki/spaces/MARVIN/pages/2261488)
