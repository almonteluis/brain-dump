---
description: "Global Object IDs - Marvin"
tags: ['research', 'marvin', 'new-classrooms']
source: "https://newclassrooms.atlassian.net/wiki/spaces/MARVIN/pages/2261147/Global+Object+IDs"
raw_file: "Global Object IDs - Marvin.md"
created: 2026-05-17
---

## Global Object IDs

We are opting to follow the [Relay Global Object ID specification](https://relay.dev/graphql/objectidentification.htm "https://relay.dev/graphql/objectidentification.htm"). The implications are discussed below.

## Node interface

All types other than payloads and inputs must implement the [Node interface](https://newclassrooms.atlassian.net/wiki/display/MARVIN/GraphQL+Schema#GraphQLSchema-NodeGQLNode "https://newclassrooms.atlassian.net/wiki/display/MARVIN/GraphQL+Schema#GraphQLSchema-NodeGQLNode") ([Relay spec](https://relay.dev/graphql/objectidentification.htm#sec-Node-root-field "https://relay.dev/graphql/objectidentification.htm#sec-Node-root-field")). The interface is very simple:

```
interface Node {

  id: ID!

}
```

This ensures that every piece of data has *an* ID that it can be found by, but it's up to us ensure that that ID is unique.

## node query

Relay-compliant GraphQL services must provide a query `node` that takes a single ID and returns the object corresponding to that ID.

**node query**

```
type Query {

  node(id: ID!): Node

}
```

It can be used like so:

**node query example**

```
query getSection {

  node(id: "SectionNode:1") {

    id

    __typename

    ... on SectionNode {

      isActive

    }

  }

}
```

**node query result**

```javascript
{

  "data": {

    "node": {

      "id": "SectionNode:1",

      "__typename": "SectionNode",

      "isActive": true

    }

  }

}
```

## Nested pagination

The graphql `{node(id: "...") { ... } }` pattern is useful in nested pagination scenarios. Say you got

```
{

    brands (first: 2) {

        pagingInfo { endCursor}

        nodes {

            products (first: 2) {

                pagingInfo { endCursor }

                nodes { name }

            }

        }

    }

}
```

and you want to get the second page of products for each brand you got. It's not possible to do this with the brands field/resolver so you'd take the brand id and products paging cursor and use the node field to get subsequent pages of products. The `node` field will one day be replaced with the `@lookup` directive but since it was created before directives were available we need to have it for efficient pagination on the client.

## Global uniqueness

A critical aspect of the specification is that the IDs be *globally unique* (within our GraphQL service). This allows for easier caching and a concept referred to as *refetching* in the [Relay documentation](https://relay.dev/docs/guides/graphql-server-specification/#object-identification "https://relay.dev/docs/guides/graphql-server-specification/#object-identification"), which basically just means that if you have a node with a given ID and then query for that node with the `node(id: ...)` query, you are guaranteed to get back the same object.

Database primary keys are generally not unique outside of the context of a single table, and since we're using integer primary keys, we have to factor this in—see below.

## ID format

To ensure uniqueness of our IDs, we concatenate the type name and database primary key, separated by a colon for legibility. For example, the SectionNode corresponding to the row in the `sections` table with primary key 42 would be `SectionNode:42`.

It's called out [explicitly in the Relay server spec](https://relay.dev/docs/guides/graphql-server-specification/#object-identification "https://relay.dev/docs/guides/graphql-server-specification/#object-identification") (but not the Global Object ID spec itself) that these IDs are intended to be *opaque* in the sense that they should not be parsable into something with additional meaning. They suggest base64-encoding the IDs, so that for the example above, you'd just see `U2VjdGlvbk5vZGU6NDIK`. You could accomplish both the uniqueness and opacity by using a UUID, but you'd very quickly run into the problem of having an ID and needing to figure out what table to look it up in—you'd have no way to get the table name or the primary key value.

So the compromise we make, and which seemingly many others make, is to simply not pretend that there is no content in the ID, and rather *require* that you be able to get both the type name and primary key value from it. We are also opting to not base64-encode the IDs, since this seems to provide no actual value once we've decided the IDs are meaningful, and having them in plain text will make debugging and communication with non-techies much easier.  
  
We are using.Net's `System.Text.Json.JsonSerializer` class to cast the object returned from GraphQL server (with Id in the format *"<Type>Node:<Id>"* to our POCOs where Id is an integer. This code is shared by both the server and client sides.
