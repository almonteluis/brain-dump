---
description: Relay is a GraphQL client designed for scale — it provides declarative data fetching, automatic optimizations, data consistency, and ahead-of-time safety through fragments and compile-time validation.
tags: ["relay", "graphql", "data-fetching", "fragments", "mutations"]
created: 2026-02-01
---

# Relay - The GraphQL Client that Scales with You

Relay is designed for high performance at any scale. Relay keeps management of data-fetching easy, whether your app has tens, hundreds, or thousands of components. And thanks to Relay's incremental compiler, it keeps your iteration speed fast even as your app grows.

---

## Core Principles

### Built for Scale
Relay is designed for high performance at any scale. Relay keeps management of data-fetching easy, whether your app has tens, hundreds, or thousands of components. And thanks to Relay's incremental compiler, it keeps your iteration speed fast even as your app grows.

### Keeps Iteration Quick
Relay is data-fetching turned declarative. Components declare their data dependencies, without worrying about how to fetch them. Relay guarantees that data each component needs is fetched and available. This keeps components decoupled and promotes reuse.

With Relay, components and their data dependencies can be quickly modified without modifying other parts of the system. That means you won't accidentally break other components as you refactor or make changes to your app.

### Automatic Optimizations
Relay's compiler aggregates and optimizes data requirements for your entire app, so that they can be efficiently fetched in a single GraphQL request.

Relay handles heavy lifting to ensure data declared by your components is fetched in most efficient way. For example, by deduplicating identical fields, and precomputing information used at runtime, among other optimizations.

### Data Consistency
Relay automatically keeps all of your components up to date when data that affects them changes, and efficiently updates them only when strictly necessary. This means no unnecessary re-renders.

Relay also supports executing GraphQL Mutations, optionally with optimistic updates, and updates to local data, while ensuring that visible data on screen is always kept up to date.

---

## Query Data Fetching

The simplest way to fetch query data is to directly call `loadQuery`.

Later, you can read data from store in a functional React component by calling `usePreloadedQuery` hook.

Relay encourages you to call `loadQuery` in response to an event, such as when a user presses on a link to navigate to a particular page or presses a button. See guided tour section on [Queries](https://relay.dev/docs/guided-tour/rendering/queries/) for more.

```javascript
import React from "react";
import { graphql, usePreloadedQuery } from "react-relay";

const artistsQuery = graphql`
  query ArtistQuery($artistID: String!) {
    artist(id: $artistID) {
      name
      ...ArtistDescription_artist
    }
  }
`;

const artistsQueryReference = loadQuery(
  environment,
  artistsQuery,
  {artistID: "1"}
);

export default function ArtistPage() {
  return (
    <EnvironmentProvider environment={environment}>
      <React.Suspense fallback={<LoadingIndicator />}>
        <ArtistView />
      </React.Suspense>
    </EnvironmentProvider>
  )
}

function ArtistView() {
  const data = usePreloadedQuery(artistsQuery, artistsQueryReference);
  return (
    <>
      <Name>{data?.artist?.name}</Name>
      {data?.artist && <ArtistCard artist={data?.artist} />}
    </>
  );
}
```

---

## Fragments

Step two is to render a tree of React components powered by Relay. Components use fragments to declare their data dependencies, and read data from Relay store by calling `useFragment`.

A fragment is a snippet of GraphQL that is tied to a GraphQL type (like Artist) and which specifies what data to read from an item of that type.

`useFragment` takes two parameters:

- A fragment literal
- A fragment reference

A fragment reference specifies which entity to read that data from.

Fragments cannot be fetched by themselves; instead, they must ultimately be included in a parent query. The Relay compiler will then ensure that data dependencies declared in such fragments are fetched as part of that parent query.

```javascript
import React from "react";
import { graphql, useFragment} from "react-relay";

export default function ArtistCard(props) {
  const {href, image, bio} = useFragment(
    graphql`
      fragment ArtistHeader_artist on Artist {
        href
        bio
        image {
          url
        }
      }
    `,
    props.artist
  );

  const imageUrl = image && image.url;

  return (
    <Card>
      <Link href={href}>
        <Image imageUrl={imageUrl} />
        <Bio>{bio}</Bio>
      </Link>
    </Card>
  );
}
```

---

## GraphQL Best Practices Baked In

Relay applies and relies on GraphQL best practices. To get most from Relay's features, you'll want your GraphQL server to conform to these standard practices.

### Fragments
A GraphQL [Fragment](https://graphql.org/learn/queries/#fragments) is a reusable selection of fields for a given GraphQL type. It can be composed by including it in other Fragments, or including it as part of GraphQL Queries.

Relay uses Fragments to declare data requirements for components, and compose data requirements together.

### Connections
GraphQL [Connections](https://graphql.org/learn/pagination/#complete-connection-model) are a model for representing lists of data in GraphQL, so that they can easily be paginated in any direction, as well as to be able to encode rich relationship data.

GraphQL Connections are considered a best practice for [Pagination in GraphQL](https://graphql.org/learn/pagination/), and Relay provides first class support for these, as long as your GraphQL server supports them.

### Global Object Identification
Relay relies on [Global Object Identification](https://graphql.org/learn/global-object-identification/) to provide reliable caching and refetching, and to make it possible to automatically merge updates for objects.

Global Object Identification consists on providing globally unique ids across your entire schema for every type, built using the Node GraphQL interface.

---

## Mutations

### Flexible Mutations

Using GraphQL mutations, you can declaratively define and request data that will be affected by executing a mutation in a single round trip, and Relay will automatically merge and propagate those changes.

### Automatic Updates
Using Global Object Identification, Relay is capable of automatically merging mutation updates for any affected objects, and updating only the affected components.

For more complex cases where updates cannot automatically be merged, Relay provides APIs to manually update local Relay data in response to a mutation.

### Designed for Great UX
Relay's mutation API supports making optimistic updates to show immediate feedback to users, as well as error handling and automatically reverting changes when mutations fail.

---

## Subscriptions

### Real-Time Data

Relay provides full support for GraphQL subscriptions, enabling real-time data updates when server-side events occur. Subscriptions maintain a persistent WebSocket connection and automatically update the Relay store and components when new data arrives.

### Automatic Store Updates

When subscription events are received, Relay automatically:
- Finds matching records by ID in the store
- Updates fields with new values
- Triggers re-renders for affected components
- Supports declarative directives like `@appendNode`, `@prependNode`, and `@deleteRecord`

### WebSocket Integration

Relay subscriptions require WebSocket-capable network layer configuration. Popular libraries include:
- `graphql-ws` (recommended)
- `subscriptions-transport-ws` (legacy)

For a complete guide on implementing subscriptions, see [[02_reference/approaches/relay-subscriptions-guide.md]].

---

## Ahead-of-Time Safety

### Peace of Mind
While you work on a Relay project, Relay compiler will guide you to ensure project-wide consistency and correctness against your GraphQL schema.

### Optimized Runtime
Relay pre-computes a lot of work (like processing and optimizing queries) ahead of time, during build time, in order to make runtime on the browser or device as efficient as possible.

### Type Safety
Relay generates Flow or TypeScript types for each of your React components that use Relay, which represent the data that each component receives, so you can make changes more quickly and safely while knowing that correctness is guaranteed.

---

## Can Relay Work For Me?

### Adopt Incrementally
If you already can render React components, you're most of the way there. Relay requires a Babel plugin, and to also run Relay Compiler.

You can use Relay out of the box with Create React App and Next.js.

### Make Complexity Explicit
Relay requires a bit more up-front setup and tools, in favour of supporting an architecture of isolated components which can scale with your team and app complexity.

Learn these principles once, then spend more time working on business logic instead of pipelining data.

### Used at Facebook Scale
Relay is critical infrastructure in Facebook, there are tens of thousands of components using it. Relay was built in tandem with GraphQL and has full-time staff working to improve it.

### Not Just for Big Apps
If you're the sort of team that believes in using Flow or TypeScript to move error detection to dev-time, then Relay is likely a good fit for you.

It's probable you'd otherwise re-create a lot of Relay's caching, and UI best practices independently.

### Proudly Used Elsewhere
Relay was originally created for the React Native sections of the Facebook app, and it has been used adapted and improved by other teams internally and externally.

---

## Related Resources

- Tutorial: https://relay.dev/docs/tutorial/
- API Reference: https://relay.dev/docs/api-reference/
- Guides: https://relay.dev/docs/guides/
- GitHub: https://github.com/facebook/relay
