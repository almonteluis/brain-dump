---
description: "Query Filters - Marvin"
tags: ['research', 'marvin', 'new-classrooms']
source: "https://newclassrooms.atlassian.net/wiki/spaces/MARVIN/pages/2261023/Query+Filters"
raw_file: "Query Filters - Marvin.md"
created: 2026-05-17
---

## Query Filters

Some of our GraphQL queries may return a large amount of data, and in some cases, it may be more effective to filter that data on the server side rather than dumping it to the client to pick through. This document describes the pattern we're using to implement such filters for queries, and explains why we designed it this way. There is no published or agreed upon standard for this, so we're making this up as we go.

## Design

The major goals are:

1. to provide a simple set of conjunctive ("and") filters that can be specified in any combination
2. to allow for some possibility of filter conditions other than simple equality
3. to clearly separate optional filter parameters from other possible required parameters
4. to ensure that the query signature doesn't change when new filter options are added

Notably, there is no attempt to provide disjunctions ("or") or other kinds of combinations. We'll presume you can run multiple queries if you need multiple sets of data like that. (It may be possible to provide a list to a filter, but we haven't considered this in detail yet.)

Here is the pattern:

- Given a query `foo`
- Add an optional (nullable) parameter `filter` to the query
- The type of the `filter` parameter is `FooFilterInput`
- The `FooFilterInput` type has multiple attributes, all optional (nullable)
- For comparisons other than equality, append `_<comparison>` to the filter attribute

Note that some queries do still have **mandatory parameters**, like `skillAssessmentsByStudentId` requiring a `studentId`. In that case, the `studentId` parameter must be a top-level parameter of the query, rather than being placed in the filter object. These should be readily identifiable, as the mandatory parameter is in the name of the query ("by such and such").

## Example

Here's a little query that would ordinarily just return about 10,000 kinds of birds. We want to be able to filter this down to whatever might be relevant to us, so we'll add some filter options:

```
query allBirds(filter: {family: "Trochilidae", wingspan_lt: 5}) {

  edges {

    node {

      commonName

      binomen

      canFly

      wingspan

    }

  }

}
```

There we're asking for all birds in the family Trochilidae (hummingbirds) with a wingspan less than 5cm. We may have other filters available that we aren't using here.

So to make that work, we could define our query like this:

```
type Query {

  allBirds(filter: AllBirdsFilterInput, before: String, after: String, first: Int, last: Int): BirdNodeConnection

}
```

Note that we have set this up as a [connection](https://newclassrooms.atlassian.net/wiki/spaces/MARVIN/pages/2261301 "https://newclassrooms.atlassian.net/wiki/spaces/MARVIN/pages/2261301"), so we want to have those before/after/first/last parameters available to allow us to page through results.

Our filter input could look like this:

```
type AllBirdsFilterInput {

  family: String

  wingspan_lt: Int

  canFly: Boolean

}
```
