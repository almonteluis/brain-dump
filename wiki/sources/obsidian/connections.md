---
description: 3|source: "https://newclassrooms.atlassian.net/wiki/spaces/MARVIN/pages/2261301/Connections"
tags: ["marvin", "new-classrooms", "engineering"]
source: "Connections - Marvin.md"
created: 2026-05-17
---

# Connections - Marvin

1|---
     2|title: "Connections - Marvin"
     3|source: "https://newclassrooms.atlassian.net/wiki/spaces/MARVIN/pages/2261301/Connections"
     4|author:
     5|published:
     6|created: 2026-04-30
     7|description:
     8|tags:
     9|  - "clippings"
    10|---
    11|## Connections
    12|
    13|Some GraphQL queries can potentially return far more records than can comfortably handled in a single request. Connections are a standardized—though not universally adopted—mechanism for handling pagination of such results, while also providing a way to organize information about how different data types relate to each other.
    14|
    15|## Introduction
    16|
    17|A good way to get up to speed with connections is to go through [this short tutorial about pagination in GraphQL](https://graphql.org/learn/pagination/ "https://graphql.org/learn/pagination/").
    18|
    19|Here's a simple hypothetical but at least realistic example. Say have two types of nodes in our graph, StudentNode and SkillNode. Think of these nodes as vertices in a [graph in the discrete math sense](https://en.wikipedia.org/wiki/Graph_\(discrete_mathematics\) "https://en.wikipedia.org/wiki/Graph_(discrete_mathematics)"). Students and skills are related, because we know a student has some state (completed, remaining, etc.) associated with each skill. So we could give our StudentNode a `skillStates` attribute that's a list of objects that contain both the skill and the state—call it a StudentSkillStateNode.
    20|
    21|##### Traditional model
    22|
    23|```
    24|type StudentNode implements Node {
    25|  username: String!
    26|  skillStates: [SkillStateNode!]!
    27|}
    28|
    29|type StudentSkillStateNode implements Node {
    30|  skill: SkillNode!
    31|  state: SkillStateNode!
    32|
    33|}
    34|```
    35|
    36|In the Relay model, that means we draw an edge between the StudentNode and each SkillNode, and we have a *connection* between StudentNode and SkillNode. Instead of grouping both skill and state information into a single object, the state is considered a property of the connection between the student and the skill. In other words, it's a property of the *edge* rather than of a *node*.
    37|
    38|##### Relay connection model, abbreviated
    39|
    40|```
    41|type StudentNode implements Node {
    42|  username: String!
    43|  skillStates: SkillStateNodeConnection!
    44|
    45|}
    46|
    47|type SkillStateNodeConnection {
    48|  edges: [SkillStateNodeEdge!]!
    49|}
    50|
    51|type SkillStateNodeEdge {
    52|  node: SkillNode!
    53|  state: SkillStateNode!
    54|}
    55|```
    56|
    57|Why bother with this more complicated model? Because there is a critical piece of information that can be associated with the connection but which wouldn't make sense to associate with the related nodes: pagination information!
    58|
    59|When a query has more results to return than can reasonably fit into a single response, it can attach this PageInfo data to the connection it returns:
    60|
    61|```
    62|type PageInfo {
    63|
    64|  hasNextPage: Boolean!
    65|
    66|  hasPreviousPage: Boolean!
    67|
    68|  startCursor: String
    69|
    70|  endCursor: String
    71|
    72|}
    73|
    74|type SkillStateNodeConnection {
    75|
    76|  edges: [SkillStateNodeEdge!]!
    77|
    78|  pageInfo: PageInfo!
    79|
    80|}
    81|```
    82|
    83|See the specification below for the complete picture.
    84|
    85|## Relay standard
    86|
    87|The [connection specification](https://relay.dev/graphql/connections.htm "https://relay.dev/graphql/connections.htm") is curated by Relay. While we are not using Relay itself, there is some benefit to adhering to the standard, as it gives us a uniform and well-documented pattern to follow.
    88|
    89|One minor deviation we are making from the standard is that the edges within a connection must not be null. This means that if the resolver fails to return data for any of the edges, the whole query will fail. We feel that this is a better failure mode, forcing us to triage that failure, rather than asking clients to handle incomplete data. We can revisit this decision if we aren't benefiting from it. The reason to *not* do this, conversely, is to allow a query to return partial results. The null entries in the edges list would presumably be refered to by an error message in the top-level error data structure.
    90|
    91|## Pagination
    92|
    93|The key thing to know about pagination of connections is that it's cursor-based, rather than being based on limits and offsets.
    94|
    95|The common use case of getting all of the results basically looks like:
    96|
    97|1. Continuing to query for more results while `pageInfo.hasNextPage` is true.
    98|2. Passing the `pageInfo.endCursor` value as the `after` parameter for the next query.
    99|
   100|Read more about the motivation for [cursor-based pagination here](https://www.apollographql.com/blog/graphql/pagination/understanding-pagination-rest-graphql-and-relay/ "https://www.apollographql.com/blog/graphql/pagination/understanding-pagination-rest-graphql-and-relay/").
   101|
   102|## Nested connections in queries
   103|
   104|Avoid nesting connections that must be paginated within a single query, since good patterns for both the client and server have not been established. (Altnernatively, do some research, come up with a good pattern, share it with the team, and delete this section!) For example, avoid this:
   105|
   106|**Query with nested connection**
   107|
   108|```
   109|query studentLaddersAndSkils {
   110|
   111|  studentById(id: "...") {
   112|
   113|    enrolledGradeLevel {
   114|
   115|      id
   116|
   117|    }
   118|
   119|    skillLadders {
   120|
   121|      edges {
   122|
   123|        node {
   124|
   125|          # SkillLadderNode
   126|
   127|          name
   128|
   129|          skills {
   130|
   131|            edges {
   132|
   133|              node {
   134|
   135|                # SkillNode
   136|
   137|                id
   138|
   139|                name
   140|
   141|              }
   142|
   143|            }
   144|
   145|          }
   146|
   147|        }
   148|
   149|      }
   150|
   151|    }
   152|
   153|  }
   154|
   155|}
   156|```
   157|
   158|Out of this query, you're going to get two sets of pagination data (one for skill ladders, and one for the skills within the ladders). But we don't currently have a way to pass both in (i.e. "give me the 3rd page of skills for the 2nd page of ladders").
   159|
   160|## Further reading
   161|
   162|- [https://www.apollographql.com/blog/graphql/explaining-graphql-connections/](https://www.apollographql.com/blog/graphql/explaining-graphql-connections/ "https://www.apollographql.com/blog/graphql/explaining-graphql-connections/")
