---
description: 3|source: "https://newclassrooms.atlassian.net/wiki/spaces/MARVIN/pages/2261426/Architecture"
tags: ["marvin", "new-classrooms", "engineering"]
source: "Architecture - Marvin.md"
created: 2026-05-17
---

# Architecture - Marvin

1|---
     2|title: "Architecture - Marvin"
     3|source: "https://newclassrooms.atlassian.net/wiki/spaces/MARVIN/pages/2261426/Architecture"
     4|author:
     5|published:
     6|created: 2026-04-30
     7|description:
     8|tags:
     9|  - "clippings"
    10|---
    11|## Architecture
    12|
    13|This is a high-level description of the architecture, intended to outline the components that are independent of the specific environment, with environment-level details included when necessary.
    14|
    15|## Overview
    16|
    17|Marvin comprises a small set of narrowly-focused services triggered through an event system and operating on data through GraphQL. The primary architectural goals are:
    18|
    19|1. Simplicity — something that a small group of experienced developers can build in a short timeframe
    20|2. Clarity — coherent interfaces both between internal components and between NC and Classify areas of responsibility
    21|3. Flexibility — components can be added, removed, or changed when needed with reasonable effort
    22|4. Testability — the system should be amenable to testing at any level of granularity
    23|5. Scalability — at least an order of magnitude of scalability should be easily achievable, with further scaling not requiring major redesigns
    24|6. Portability — can be moved into other hosting or execution environments with reasonable effort
    25|7. Security — follows established security best practices
    26|
    27|## Diagram
    28|
    29|[Draft Kermit Architecture](https://www.figma.com/file/FjO1PhdLA3AN2hYMUfyjNr/Draft-Kermit-Architecture)
    30|
    31|This is not a great diagram. Consider it very schematic and not rigorous.
    32|
    33|![Draft Kermit Architecture.png](https://media-cdn.atlassian.com/file/3ab0c297-3340-4d8f-9a7f-31f8229c1189/image/cdn?allowAnimated=true&client=9fd199b9-f5f0-40a6-8c09-0dbb77bcfee5&collection=contentId-2261426&height=125&max-age=2592000&mode=full-fit&source=mediaCard&token=***&width=631#media-blob-url=true&id=3ab0c297-3340-4d8f-9a7f-31f8229c1189&clientId=9fd199b9-f5f0-40a6-8c09-0dbb77bcfee5&contextId=contentId-2261426&collection=contentId-2261426)
    34|
    35|## Major Components
    36|
    37|## Internal
    38|
    39|### Database
    40|
    41|1. basically functional
    42|2. connection to graphql well established
    43|	1. QA uses python psycopg2 library; can run against deployed environments; injects its own data
    44|3. yes, this runs locally and in the docker stack; would be nice to switch port **TODO**
    45|4. flyway can trip us up when using multiple branch
    46|5. documentation could be improved (filling out descriptions, as-built versus future plans)
    47|
    48|Stores data to be displayed and modified as necessary by the end users and to be used as input to processes like scheduling or Roadmap building.
    49|
    50|Technology: AWS RDS Aurora PostgreSQL serverless database, scaling automatically to meet demand
    51|
    52|Connections:
    53|
    54|- GraphQL Service — talks directly to the database to read and write data
    55|
    56|See also:
    57|
    58|- [Database schema](https://newclassrooms.atlassian.net/wiki/spaces/MARVIN/pages/2261059 "https://newclassrooms.atlassian.net/wiki/spaces/MARVIN/pages/2261059")
    59|
    60|### GraphQL Service
    61|
    62|1. will have a better idea of how well it’s working now that it’s connected to the front end; some differences with mock data
    63|2. connections to auth0, docker ports, etc. not so well understood
    64|3. in deployed environment, not so functional (e.g. CORS, trying to connect to localhost); work in progress e.g. to get variables passed along
    65|
    66|Allows other components to retrieve and store any data they need in order to function. Provides the critical abstraction layer between NC and partner systems.
    67|
    68|Technology: C# code using [Hot Chocolate](https://chillicream.com/docs/hotchocolate/ "https://chillicream.com/docs/hotchocolate/") as a GraphQL framework, hosted in AWS ECS
    69|
    70|Connections:
    71|
    72|- Database — serves and stores all data required by the service
    73|- Roadmap Builder — reads things like skill states and creates/updates/deletes Roadmaps
    74|- Inference Engine — reads skill states and other skill data and saves new skill states
    75|
    76|See also:
    77|
    78|- [GraphQL Schema](https://newclassrooms.atlassian.net/wiki/spaces/MARVIN/pages/2261488 "https://newclassrooms.atlassian.net/wiki/spaces/MARVIN/pages/2261488")
    79|
    80|### Frontend
    81|
    82|1. generally working well!
    83|2. connection to learnosity; inline assessment works fine with temp-learnosity-SDK but not clear how that works when deployed
    84|	1. [Learnosity inline assessment rendering](https://newclassrooms.atlassian.net/wiki/spaces/PRODUCT/pages/197296192)
    85|		2. concerned about how well that will work with BFF/learnosity bridge (TEAMA2-260); Maya and Fede to close that loop
    86|3. some lack of clarity about retrieving session for user; Fede to look into that further
    87|
    88|### Backend for Frontend / Learnosity Bridge
    89|
    90|1. generally doing what it needs to in terms of being a Learnosity gateway
    91|2. need ticket the work for documenting the recently Learnosity endpoint updates
    92|3. some changes to deployment pipelines needed to get it working in test/demo; keys need to be provisioned; not ticketed
    93|
    94|Serves as the point of contact between the user’s browser and our back end services, performing authentication and authorization checks. See details in the [implementation guide](https://newclassrooms.atlassian.net/wiki/spaces/PRODUCT/pages/81592401 "https://newclassrooms.atlassian.net/wiki/spaces/PRODUCT/pages/81592401").
    95|
    96|Technology: C# code (notably.NET 8) running containerized in AWS Lambda behind an API Gateway
    97|
    98|Connections:
    99|
   100|- [Auth0](https://newclassrooms.atlassian.net/wiki/spaces/KERMIT/pages/39780368/Auth0+Patterns+Practices "https://newclassrooms.atlassian.net/wiki/spaces/KERMIT/pages/39780368/Auth0+Patterns+Practices") — handling OIDC flow, retrieving claims and such
   101|- GraphQL Service — sends data back through the BFF to the end user
   102|- End User — talks to the BFF to get data to and from our systems
   103|- Event Stream — fires an event when new assessment results are expected from Learnosity
   104|
   105|Documentation:
   106|
   107|- [Learnosity Endpoint](https://newclassrooms.atlassian.net/wiki/spaces/PRODUCT/pages/104890481)
   108|
   109|### Event Stream
   110|
   111|1. overall connections like ED -> LRF -> GraphQL working; upcoming work about assessmention completion events; triggering “data available” events for things like Inference Engine
   112|2. mocking a stream locally might be an option with a library, but it’s not clear that would be very useful
   113|
   114|Provides a centralized place to record events and for other components to listen for events relevant to their functioning.
   115|
   116|Technology: AWS Kinesis
   117|
   118|Connections:
   119|
   120|- Event Dispatcher — listens for actionable events and triggers services accordingly
   121|- Roadmap Builder — fires an event when a Roadmap has been built
   122|- Inference Engine — fires an event when skill states are changed
   123|
   124|Documention:
   125|
   126|- [How to Work With the Event System](https://newclassrooms.atlassian.net/wiki/spaces/MARVIN/pages/2261566)
   127|
   128|### Event Dispatcher
   129|
   130|1. can be tested locally in the sense of crafting inputs and making sure that log messages correspond to the actions that would be taken
   131|2. TODO: ticket work for documenting how to use it locally and as deployed per (1)
   132|
   133|Listens to the event stream and triggers various services when relevant events occur. For example, when new assessment data is available (event!), tell the Inference Engine to update skill states.
   134|
   135|Technology: C# code containerized and hosted in AWS Lambda
   136|
   137|Connections:
   138|
   139|- Event Stream — constantly sifting through it for actionable events
   140|- Roadmap Builder — triggered when skill states change
   141|- Inference Engine — triggered when new assessment data is available
   142|
   143|### Roadmap Builder
   144|
   145|Builds roadmaps. Simple! Actually, this whole thing is currently being redesigned.
   146|
   147|Technology: C# code containerized and hosted in AWS Lambda
   148|
   149|Connections:
   150|
   151|- Event Dispatcher — triggers this as needed
   152|- Event Stream — fires an event when Roadmaps are changed
   153|- GraphQL Service — used to retrieve and persist data
   154|
   155|### Inference Engine
   156|
   157|1. TODO Steve to connect with Jordan on this
   158|2. requirements are more or less ready; work on business logic is starting
   159|
   160|Follows the inferencing requirements to update skill states for a student.
   161|
   162|Technology: C# code containerized and hosted in AWS Lambda
   163|
   164|Connections:
   165|
   166|- Event Dispatcher — triggers this as needed
   167|- Event Stream — fires an event when skill states are updated
   168|- GraphQL Service — used to retrieve and persist data
   169|
   170|See also:
   171|
   172|- [Technical requirements](https://newclassrooms.atlassian.net/wiki/spaces/MARVIN/pages/2261365 "https://newclassrooms.atlassian.net/wiki/spaces/MARVIN/pages/2261365")
   173|
   174|### Learnosity Result Fetcher
   175|
   176|1. ED -> LRF -> GraphQL works but front end connection not finalized yet
   177|2. TODO could possibly use docs regarding endpoint to use (TEAMA2-475)
   178|3. can use AWS Lambda Mock Test Tool
   179|
   180|Retrieves assessment results from the Learnosity API and persists them through GraphQL. [Read more here](https://newclassrooms.atlassian.net/wiki/spaces/KERMIT/pages/46202920/Data+Storage+Workflow#Learnosity-Results-Service "https://newclassrooms.atlassian.net/wiki/spaces/KERMIT/pages/46202920/Data+Storage+Workflow#Learnosity-Results-Service").
   181|
   182|Technology: C# code containerized and hosted in AWS Lambda
   183|
   184|Connections:
   185|
   186|- BFF / Learnosity Bridge — fires an event when assessment is submitted
   187|- Learnosity — polled until results are ready
   188|- Event Dispatcher — triggers this as needed
   189|- Event Stream — gets an event with there is an assessment to handle; gets an event when skill states are updated
   190|- GraphQL Service — stores results of assessment
   191|
   192|### Strapi CMS
   193|
   194|- next sprint starting to implement some basic content types
   195|- v5 public beta opens March 20---both for public and for their support team to train; no enterprise support
   196|- hoping to have this deployed in demo/test roughly beginning of May
   197|
   198|Allows users to manage content, which is stored in the Postgres database and S3 buckets.
   199|
   200|Technology: Node.js service hosted in ECS behind an ALB
   201|
   202|Connections:
   203|
   204|- Database — reads and writes data
   205|- GraphQL Service — will eventually go through this instead of directly to database
   206|- S3 bucket — storing media files
   207|- Event Stream — may need to be able to do things like say “this skill was deactivated”
   208|- Auth0 — possibly will be used for auth; unclear when or how we will do this, but there is an enterprise plugin for it (early spring)
   209|
   210|### External Sync Service
   211|
   212|This section needs expanding to fully cover what this service does. Please help document it!
   213|
   214|A lambda which is run hourly that pulls data from Clever.
   215|
   216|## External
   217|
   218|### Auth0
   219|
   220|Identity provider (IdP) where all users of the system are registered, providing our single sign-on (SSO) service. See [more here](https://newclassrooms.atlassian.net/wiki/spaces/KERMIT/pages/39780368/Auth0+Patterns+Practices "https://newclassrooms.atlassian.net/wiki/spaces/KERMIT/pages/39780368/Auth0+Patterns+Practices").
   221|
   222|### Learnosity
   223|
   224|Provides assessments to students and all kinds of back-office stuff for our academic team to manage them. [Lots of docs](https://newclassrooms.atlassian.net/wiki/spaces/PRODUCT/pages/18677831 "https://newclassrooms.atlassian.net/wiki/spaces/PRODUCT/pages/18677831").
   225|
   226|### GitLab
   227|
   228|Hosts our code and drives our SDLC through release to production. See [here](https://newclassrooms.atlassian.net/wiki/spaces/DEV/pages/111738895 "https://newclassrooms.atlassian.net/wiki/spaces/DEV/pages/111738895").
   229|
   230|### AWS
   231|
   232|### GitHub
   233|
   234|See notes here for how this is coming along: [Cloud Posse](https://newclassrooms.atlassian.net/wiki/spaces/DEV/pages/197296204)
   235|
   236|### Clever
   237|
   238|SSO provider and external data source
