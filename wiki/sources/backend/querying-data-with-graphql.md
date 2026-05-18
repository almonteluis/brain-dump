---
description: "In this guide, you will learn how to construct GraphQL queries and explore unique features of GraphQL using the GraphQL implementation of the Star War"
tags: ['research']
source: "https://www.pluralsight.com/resources/blog/guides/querying-data-with-graphql"
raw_file: "Querying Data with GraphQL.md"
created: 2026-05-17
---

In this guide, you will learn how to construct GraphQL queries and explore unique features of GraphQL using the GraphQL implementation of the Star Wars API.

![Benney Au](https://www.pluralsight.com/content/dam/ps/images/resource-center/blog-contributor/7aa57bc1-6266-4719-a497-c3ab18a28f5d.png)

By Benney Au

## Introduction

GraphQL is a query language for accessing object graphs. It is designed to be type safe and give clients the ability to request only the data they need.

In this guide, you will learn how to construct GraphQL queries. Then we will explore some unique features of GraphQL, including fragments, sending variables and GraphQL directives. Throughout this guide, you will use the [GraphQL implementation of the Star Wars API](https://github.com/graphql/swapi-graphql) to test the querying capabilities of GraphQL.

## Performing a Basic Query in GraphiQL

[GraphiQL](https://github.com/graphql/graphiql) is a simple UI tool that allows you to query GraphQL endpoints with the convenience of auto-complete and syntax highlighting.

To get started writing your first GraphQL query, navigate to the [Star Wars GraphiQL page](https://graphql.org/swapi-graphql). From this page, you can look at the documentation for the GraphQL endpoint, submit queries and see the output.

Submit the following query in the top left pane of GraphiQL.

```
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

This query consists of three components:

- **GetallFilms** is the operation name that clients can set. This can be useful for debugging issues.
- **allFilms** is field exposed endpoint on the root node. It is a complex types of **Film** that combines several scalar values into a single unit.
- **title**, **episodeID**, **director**, etc. are fields. These are units of data that you are requesting to appear in the response data. **allFilms** is also a field that combines the fields nested inside it.

These are the fundamental building blocks of a GraphQL query. In the following sections, you will use these building blocks to perform more advanced queries.

## Sending Arguments to GraphQL Fields

You have just queried all films. However, sometimes you only need a subset of this data. With the Star Wars GraphQL endpoint, you can send arguments to the **allFilms** field to filter the data.

There are two ways to send arguments. The first is inline:

```
query GetAllFilms {
  allFilms(first: 3) {
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

You modified the **allFilms** field in the query to **allFilms(first: 3)**. This approach is appropriate when you don't need to change the value of your argument(s). If your argument values change frequently, it is better to define an input variable.

To do this, update your query to the following:

```
query GetAllFilms($firstFilms: Int) {
  allFilms(first: $firstFilms) {
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

You will also need to set the variables. In GraphiQL, this is configured at the bottom left of the screen. Insert the following JSON to set the variables in the query operation defined above.

```json
{"firstFilms": 3}
```

## Using GraphQL Fragment

As you use GraphQL to query a number of resources, your query can become quite large. One way to manage this is to split your query into small, reusable pieces called fragments. Fragments are a selection set on a specific GraphQL type and can be reused in different query operations.

The snippet below demonstrates reusing a snippet fragment on the **Film** type within the same query operation.

```
query GetAllFilms {
  allFilms {
    films {
      title
      episodeID
      openingCrawl
      director
      producers
      releaseDate
      id
    }
  }

  film(id:"ZmlsbXM6MQ==") {
    ...FilmFragment
  }
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

## Using GraphQL Directives

A powerful feature that makes GraphQL extensible is the inclusion of directives. These are declarations that are prefixed with **@**, which allows extra logic to be executed on either the server or the client.

There are two directives that are built into the Star Wars Schema: **@include** and **@skip**. Usage of **@include** of is demonstrated in the code snippet below:

```
query GetAllFilms($includeFilm: Boolean!) {
  allFilms {
    films {
      title
      episodeID
      openingCrawl
      director
      producers
      releaseDate
      id
    }
  }

  film(id:"ZmlsbXM6MQ==") @include(if: $includeFilm) {
    ...FilmFragment
  }
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

The **film** field is appended with **@include(if: $includeFilm)**. Adding this allows clients to conditionally request the film field when the **$includeFilm** variable is set to **true**, and not return this field when it is set to **false**. This approach makes it possible to retrieve different resources without modifying your query.

## Conclusion

GraphQL is becoming an increasingly important technology. It was developed by Facebook, and other large organizations like GitHub, Pinterest, and Coursera have adopted it. Web and integration developers will need to learn this query language to access the next generation of APIs. As a next step, you may want to explore [How to Set Up GraphQL in a React App](https://www.pluralsight.com/resources/blog/guides/how-to-set-up-graphql-in-a-react-app).
