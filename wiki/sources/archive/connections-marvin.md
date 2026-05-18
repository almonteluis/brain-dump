---
description: "Connections - Marvin"
tags: ["marvin", "new-classrooms", "engineering"]
source: "https://newclassrooms.atlassian.net/wiki/spaces/MARVIN/pages/2261301/Connections"
raw_file: "Connections - Marvin.md"
created: 2026-05-17
---

## Connections

Some GraphQL queries can potentially return far more records than can comfortably handled in a single request. Connections are a standardized—though not universally adopted—mechanism for handling pagination of such results, while also providing a way to organize information about how different data types relate to each other.

## Introduction

A good way to get up to speed with connections is to go through [this short tutorial about pagination in GraphQL](https://graphql.org/learn/pagination/ "https://graphql.org/learn/pagination/").

Here's a simple hypothetical but at least realistic example. Say have two types of nodes in our graph, StudentNode and SkillNode. Think of these nodes as vertices in a [graph in the discrete math sense](https://en.wikipedia.org/wiki/Graph_\(discrete_mathematics\) "https://en.wikipedia.org/wiki/Graph_(discrete_mathematics)"). Students and skills are related, because we know a student has some state (completed, remaining, etc.) associated with each skill. So we could give our StudentNode a `skillStates` attribute that's a list of objects that contain both the skill and the state—call it a StudentSkillStateNode.

##### Traditional model

```
type StudentNode implements Node {
  username: String!
  skillStates: [SkillStateNode!]!
}

type StudentSkillStateNode implements Node {
  skill: SkillNode!
  state: SkillStateNode!

}
```

In the Relay model, that means we draw an edge between the StudentNode and each SkillNode, and we have a *connection* between StudentNode and SkillNode. Instead of grouping both skill and state information into a single object, the state is considered a property of the connection between the student and the skill. In other words, it's a property of the *edge* rather than of a *node*.

##### Relay connection model, abbreviated

```
type StudentNode implements Node {
  username: String!
  skillStates: SkillStateNodeConnection!

}

type SkillStateNodeConnection {
  edges: [SkillStateNodeEdge!]!
}

type SkillStateNodeEdge {
  node: SkillNode!
  state: SkillStateNode!
}
```

Why bother with this more complicated model? Because there is a critical piece of information that can be associated with the connection but which wouldn't make sense to associate with the related nodes: pagination information!

When a query has more results to return than can reasonably fit into a single response, it can attach this PageInfo data to the connection it returns:

```
type PageInfo {

  hasNextPage: Boolean!

  hasPreviousPage: Boolean!

  startCursor: String

  endCursor: String

}

type SkillStateNodeConnection {

  edges: [SkillStateNodeEdge!]!

  pageInfo: PageInfo!

}
```

See the specification below for the complete picture.

## Relay standard

The [connection specification](https://relay.dev/graphql/connections.htm "https://relay.dev/graphql/connections.htm") is curated by Relay. While we are not using Relay itself, there is some benefit to adhering to the standard, as it gives us a uniform and well-documented pattern to follow.

One minor deviation we are making from the standard is that the edges within a connection must not be null. This means that if the resolver fails to return data for any of the edges, the whole query will fail. We feel that this is a better failure mode, forcing us to triage that failure, rather than asking clients to handle incomplete data. We can revisit this decision if we aren't benefiting from it. The reason to *not* do this, conversely, is to allow a query to return partial results. The null entries in the edges list would presumably be refered to by an error message in the top-level error data structure.

## Pagination

The key thing to know about pagination of connections is that it's cursor-based, rather than being based on limits and offsets.

The common use case of getting all of the results basically looks like:

1. Continuing to query for more results while `pageInfo.hasNextPage` is true.
2. Passing the `pageInfo.endCursor` value as the `after` parameter for the next query.

Read more about the motivation for [cursor-based pagination here](https://www.apollographql.com/blog/graphql/pagination/understanding-pagination-rest-graphql-and-relay/ "https://www.apollographql.com/blog/graphql/pagination/understanding-pagination-rest-graphql-and-relay/").

## Nested connections in queries

Avoid nesting connections that must be paginated within a single query, since good patterns for both the client and server have not been established. (Altnernatively, do some research, come up with a good pattern, share it with the team, and delete this section!) For example, avoid this:

**Query with nested connection**

```
query studentLaddersAndSkils {

  studentById(id: "...") {

    enrolledGradeLevel {

      id

    }

    skillLadders {

      edges {

        node {

          # SkillLadderNode

          name

          skills {

            edges {

              node {

                # SkillNode

                id

                name

              }

            }

          }

        }

      }

    }

  }

}
```

Out of this query, you're going to get two sets of pagination data (one for skill ladders, and one for the skills within the ladders). But we don't currently have a way to pass both in (i.e. "give me the 3rd page of skills for the 2nd page of ladders").

## Further reading

- [https://www.apollographql.com/blog/graphql/explaining-graphql-connections/](https://www.apollographql.com/blog/graphql/explaining-graphql-connections/ "https://www.apollographql.com/blog/graphql/explaining-graphql-connections/")
