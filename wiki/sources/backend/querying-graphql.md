---
description: GraphQL query fundamentals — basic queries, arguments, variables, fragments, and directives
tags: ["graphql", "query", "fragments", "directives", "pluralsight"]
created: 2026-04-30
updated: 2026-04-30
sources: ["Querying Data with GraphQL.md"]
---

## Querying Data with GraphQL

Fundamental guide to constructing GraphQL queries, using the Star Wars API as a teaching example.

### Basic Query Structure

```graphql
query GetAllFilms {
  allFilms {
    films {
      title
      episodeID
      openingCrawl
      director
      producers
      releaseDate
    }
  }
}
```

Components:
- **Operation name** (`GetAllFilms`) — useful for debugging
- **Field** (`allFilms`) — exposed endpoint on the root node
- **Scalar fields** (`title`, `episodeID`, etc.) — units of data requested

### Sending Arguments

**Inline:**
```graphql
query GetAllFilms {
  allFilms(first: 3) {
    films { title }
  }
}
```

**Variables:**
```graphql
query GetAllFilms($firstFilms: Int) {
  allFilms(first: $firstFilms) {
    films { title }
  }
}
```

Variables JSON: `{"firstFilms": 3}`

### Fragments

Reusable selection sets on a specific type:

```graphql
query GetAllFilms {
  allFilms { films { ...FilmFragment } }
  film(id: "ZmlsbXM6MQ==") { ...FilmFragment }
}

fragment FilmFragment on Film {
  title
  episodeID
  openingCrawl
  director
  producers
  releaseDate
  id
}
```

### Directives

Built-in directives: `@include` and `@skip`

```graphql
query GetAllFilms($includeFilm: Boolean!) {
  allFilms { films { title } }
  film(id: "ZmlsbXM6MQ==") @include(if: $includeFilm) {
    ...FilmFragment
  }
}
```

Conditionally includes the `film` field based on the `$includeFilm` variable.

### See Also

- [[graphql]] — GraphQL overview
- [[relay]] — Relay GraphQL client framework
- [[relay-fragments]] — Relay fragment patterns
- [[graphql-service]] — Marvin GraphQL service
- [[query-filters]] — Server-side filtering
