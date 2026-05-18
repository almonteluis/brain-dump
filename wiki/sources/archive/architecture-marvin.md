---
description: "Architecture - Marvin"
tags: ["marvin", "new-classrooms", "engineering"]
source: "https://newclassrooms.atlassian.net/wiki/spaces/MARVIN/pages/2261426/Architecture"
raw_file: "Architecture - Marvin.md"
created: 2026-05-17
---

## Architecture

This is a high-level description of the architecture, intended to outline the components that are independent of the specific environment, with environment-level details included when necessary.

## Overview

Marvin comprises a small set of narrowly-focused services triggered through an event system and operating on data through GraphQL. The primary architectural goals are:

1. Simplicity — something that a small group of experienced developers can build in a short timeframe
2. Clarity — coherent interfaces both between internal components and between NC and Classify areas of responsibility
3. Flexibility — components can be added, removed, or changed when needed with reasonable effort
4. Testability — the system should be amenable to testing at any level of granularity
5. Scalability — at least an order of magnitude of scalability should be easily achievable, with further scaling not requiring major redesigns
6. Portability — can be moved into other hosting or execution environments with reasonable effort
7. Security — follows established security best practices

## Diagram

[Draft Kermit Architecture](https://www.figma.com/file/FjO1PhdLA3AN2hYMUfyjNr/Draft-Kermit-Architecture)

This is not a great diagram. Consider it very schematic and not rigorous.

![Draft Kermit Architecture.png](https://media-cdn.atlassian.com/file/3ab0c297-3340-4d8f-9a7f-31f8229c1189/image/cdn?allowAnimated=true&client=9fd199b9-f5f0-40a6-8c09-0dbb77bcfee5&collection=contentId-2261426&height=125&max-age=2592000&mode=full-fit&source=mediaCard&token=eyJhbGciOiJIUzI1NiJ9.eyJpc3MiOiI5ZmQxOTliOS1mNWYwLTQwYTYtOGMwOS0wZGJiNzdiY2ZlZTUiLCJhY2Nlc3MiOnsidXJuOmZpbGVzdG9yZTpjb2xsZWN0aW9uOmNvbnRlbnRJZC0yMjYxNDI2IjpbInJlYWQiXX0sImV4cCI6MTc3NzU1NzA0NiwibmJmIjoxNzc3NTU0MTY2LCJhYUlkIjoiNzEyMDIwOmU1MTM3NWI2LTQ4NGQtNDBjYS04MDRiLTljMmNlNWMwYjI1MiIsImh0dHBzOi8vaWQuYXRsYXNzaWFuLmNvbS9hcHBBY2NyZWRpdGVkIjpmYWxzZSwiYXV0aFR5cGUiOiJzZXNzaW9uIn0.PpQsrpYzM3zBQhvNLtLCUlFQZDwDhG0njkSKZNgNMh4&width=631#media-blob-url=true&id=3ab0c297-3340-4d8f-9a7f-31f8229c1189&clientId=9fd199b9-f5f0-40a6-8c09-0dbb77bcfee5&contextId=contentId-2261426&collection=contentId-2261426)

## Major Components

## Internal

### Database

1. basically functional
2. connection to graphql well established
	1. QA uses python psycopg2 library; can run against deployed environments; injects its own data
3. yes, this runs locally and in the docker stack; would be nice to switch port **TODO**
4. flyway can trip us up when using multiple branch
5. documentation could be improved (filling out descriptions, as-built versus future plans)

Stores data to be displayed and modified as necessary by the end users and to be used as input to processes like scheduling or Roadmap building.

Technology: AWS RDS Aurora PostgreSQL serverless database, scaling automatically to meet demand

Connections:

- GraphQL Service — talks directly to the database to read and write data

See also:

- [Database schema](https://newclassrooms.atlassian.net/wiki/spaces/MARVIN/pages/2261059 "https://newclassrooms.atlassian.net/wiki/spaces/MARVIN/pages/2261059")

### GraphQL Service

1. will have a better idea of how well it’s working now that it’s connected to the front end; some differences with mock data
2. connections to auth0, docker ports, etc. not so well understood
3. in deployed environment, not so functional (e.g. CORS, trying to connect to localhost); work in progress e.g. to get variables passed along

Allows other components to retrieve and store any data they need in order to function. Provides the critical abstraction layer between NC and partner systems.

Technology: C# code using [Hot Chocolate](https://chillicream.com/docs/hotchocolate/ "https://chillicream.com/docs/hotchocolate/") as a GraphQL framework, hosted in AWS ECS

Connections:

- Database — serves and stores all data required by the service
- Roadmap Builder — reads things like skill states and creates/updates/deletes Roadmaps
- Inference Engine — reads skill states and other skill data and saves new skill states

See also:

- [GraphQL Schema](https://newclassrooms.atlassian.net/wiki/spaces/MARVIN/pages/2261488 "https://newclassrooms.atlassian.net/wiki/spaces/MARVIN/pages/2261488")

### Frontend

1. generally working well!
2. connection to learnosity; inline assessment works fine with temp-learnosity-SDK but not clear how that works when deployed
	1. [Learnosity inline assessment rendering](https://newclassrooms.atlassian.net/wiki/spaces/PRODUCT/pages/197296192)
		2. concerned about how well that will work with BFF/learnosity bridge (TEAMA2-260); Maya and Fede to close that loop
3. some lack of clarity about retrieving session for user; Fede to look into that further

### Backend for Frontend / Learnosity Bridge

1. generally doing what it needs to in terms of being a Learnosity gateway
2. need ticket the work for documenting the recently Learnosity endpoint updates
3. some changes to deployment pipelines needed to get it working in test/demo; keys need to be provisioned; not ticketed

Serves as the point of contact between the user’s browser and our back end services, performing authentication and authorization checks. See details in the [implementation guide](https://newclassrooms.atlassian.net/wiki/spaces/PRODUCT/pages/81592401 "https://newclassrooms.atlassian.net/wiki/spaces/PRODUCT/pages/81592401").

Technology: C# code (notably.NET 8) running containerized in AWS Lambda behind an API Gateway

Connections:

- [Auth0](https://newclassrooms.atlassian.net/wiki/spaces/KERMIT/pages/39780368/Auth0+Patterns+Practices "https://newclassrooms.atlassian.net/wiki/spaces/KERMIT/pages/39780368/Auth0+Patterns+Practices") — handling OIDC flow, retrieving claims and such
- GraphQL Service — sends data back through the BFF to the end user
- End User — talks to the BFF to get data to and from our systems
- Event Stream — fires an event when new assessment results are expected from Learnosity

Documentation:

- [Learnosity Endpoint](https://newclassrooms.atlassian.net/wiki/spaces/PRODUCT/pages/104890481)

### Event Stream

1. overall connections like ED -> LRF -> GraphQL working; upcoming work about assessmention completion events; triggering “data available” events for things like Inference Engine
2. mocking a stream locally might be an option with a library, but it’s not clear that would be very useful

Provides a centralized place to record events and for other components to listen for events relevant to their functioning.

Technology: AWS Kinesis

Connections:

- Event Dispatcher — listens for actionable events and triggers services accordingly
- Roadmap Builder — fires an event when a Roadmap has been built
- Inference Engine — fires an event when skill states are changed

Documention:

- [How to Work With the Event System](https://newclassrooms.atlassian.net/wiki/spaces/MARVIN/pages/2261566)

### Event Dispatcher

1. can be tested locally in the sense of crafting inputs and making sure that log messages correspond to the actions that would be taken
2. TODO: ticket work for documenting how to use it locally and as deployed per (1)

Listens to the event stream and triggers various services when relevant events occur. For example, when new assessment data is available (event!), tell the Inference Engine to update skill states.

Technology: C# code containerized and hosted in AWS Lambda

Connections:

- Event Stream — constantly sifting through it for actionable events
- Roadmap Builder — triggered when skill states change
- Inference Engine — triggered when new assessment data is available

### Roadmap Builder

Builds roadmaps. Simple! Actually, this whole thing is currently being redesigned.

Technology: C# code containerized and hosted in AWS Lambda

Connections:

- Event Dispatcher — triggers this as needed
- Event Stream — fires an event when Roadmaps are changed
- GraphQL Service — used to retrieve and persist data

### Inference Engine

1. TODO Steve to connect with Jordan on this
2. requirements are more or less ready; work on business logic is starting

Follows the inferencing requirements to update skill states for a student.

Technology: C# code containerized and hosted in AWS Lambda

Connections:

- Event Dispatcher — triggers this as needed
- Event Stream — fires an event when skill states are updated
- GraphQL Service — used to retrieve and persist data

See also:

- [Technical requirements](https://newclassrooms.atlassian.net/wiki/spaces/MARVIN/pages/2261365 "https://newclassrooms.atlassian.net/wiki/spaces/MARVIN/pages/2261365")

### Learnosity Result Fetcher

1. ED -> LRF -> GraphQL works but front end connection not finalized yet
2. TODO could possibly use docs regarding endpoint to use (TEAMA2-475)
3. can use AWS Lambda Mock Test Tool

Retrieves assessment results from the Learnosity API and persists them through GraphQL. [Read more here](https://newclassrooms.atlassian.net/wiki/spaces/KERMIT/pages/46202920/Data+Storage+Workflow#Learnosity-Results-Service "https://newclassrooms.atlassian.net/wiki/spaces/KERMIT/pages/46202920/Data+Storage+Workflow#Learnosity-Results-Service").

Technology: C# code containerized and hosted in AWS Lambda

Connections:

- BFF / Learnosity Bridge — fires an event when assessment is submitted
- Learnosity — polled until results are ready
- Event Dispatcher — triggers this as needed
- Event Stream — gets an event with there is an assessment to handle; gets an event when skill states are updated
- GraphQL Service — stores results of assessment

### Strapi CMS

- next sprint starting to implement some basic content types
- v5 public beta opens March 20---both for public and for their support team to train; no enterprise support
- hoping to have this deployed in demo/test roughly beginning of May

Allows users to manage content, which is stored in the Postgres database and S3 buckets.

Technology: Node.js service hosted in ECS behind an ALB

Connections:

- Database — reads and writes data
- GraphQL Service — will eventually go through this instead of directly to database
- S3 bucket — storing media files
- Event Stream — may need to be able to do things like say “this skill was deactivated”
- Auth0 — possibly will be used for auth; unclear when or how we will do this, but there is an enterprise plugin for it (early spring)

### External Sync Service

This section needs expanding to fully cover what this service does. Please help document it!

A lambda which is run hourly that pulls data from Clever.

## External

### Auth0

Identity provider (IdP) where all users of the system are registered, providing our single sign-on (SSO) service. See [more here](https://newclassrooms.atlassian.net/wiki/spaces/KERMIT/pages/39780368/Auth0+Patterns+Practices "https://newclassrooms.atlassian.net/wiki/spaces/KERMIT/pages/39780368/Auth0+Patterns+Practices").

### Learnosity

Provides assessments to students and all kinds of back-office stuff for our academic team to manage them. [Lots of docs](https://newclassrooms.atlassian.net/wiki/spaces/PRODUCT/pages/18677831 "https://newclassrooms.atlassian.net/wiki/spaces/PRODUCT/pages/18677831").

### GitLab

Hosts our code and drives our SDLC through release to production. See [here](https://newclassrooms.atlassian.net/wiki/spaces/DEV/pages/111738895 "https://newclassrooms.atlassian.net/wiki/spaces/DEV/pages/111738895").

### AWS

### GitHub

See notes here for how this is coming along: [Cloud Posse](https://newclassrooms.atlassian.net/wiki/spaces/DEV/pages/197296204)

### Clever

SSO provider and external data source
