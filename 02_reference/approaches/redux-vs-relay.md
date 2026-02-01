---
description: Guidelines for when to use Redux versus Relay for state management — server data vs UI state
tags: #relay #redux #state-management #architecture
date: 2026-01-31
---

# Redux vs Relay: When to Use Which

## The Golden Rule

> **Relay for server data, Redux for UI state.**

Mixing these concerns creates the problems we see in the DashboardStudent refactor.

## What Goes Where

### Use Relay For

| Concern                 | Example                                                |
| ----------------------- | ------------------------------------------------------ |
| **Server-fetched data** | User profiles, skill states, assignments               |
| **Normalized data**     | Entities with IDs that might appear in multiple places |
| **Data relationships**  | Nested objects, connections, pagination                |
| **Cache management**    | Data that should be cached and updated automatically   |
| **Mutations**           | CRUD operations that need optimistic updates           |

**Why:** Relay is designed specifically for fetching, caching, and managing server data. It handles:
- Colocated data requirements with components
- Automatic cache updates after mutations
- Request deduplication
- Background refetching
- Garbage collection of unused data

### Use Redux For

| Concern                      | Example                                          |
| ---------------------------- | ------------------------------------------------ |
| **UI-only state**            | Modal open/closed, active tab, current view mode |
| **Transient client state**   | Form inputs, selection state, hover states       |
| **Global UI config**         | Theme preferences, tour mode, filter settings    |
| **Cross-component UI flags** | "Show all units" vs "Show skills" toggle         |

**Why:** Redux excels at:
- Simple synchronous state updates
- State that doesn't need persistence
- UI transitions and animations
- Form state before submission
- Feature flags and A/B test variants

## Common Anti-Patterns

### ❌ Storing Server Data in Redux

```tsx
// DON'T DO THIS
const studentSkills = useAppSelector(selectedStudentSkillStates);
useEffect(() => {
  fetchStudentSkills().then(data => dispatch(setStudentSkills(data)));
}, []);
```

**Problems:**
- Duplicate caching (Relay cache + Redux store)
- Manual cache invalidation
- Stale data risks
- Prop drilling to pass data to components

**Instead:** Use Relay fragments

```tsx
// DO THIS
const fragment = graphql`
  fragment StudentSkills_skills on Query {
    studentSkills {
      ...DashboardCard_skill
    }
  }
`;
const data = useFragment(fragment, queryRef);
```

### ❌ Storing UI State in Relay

```graphql
# DON'T DO THIS
query UIStateQuery {
  modalOpen @client(always: true)
  currentTab @client(always: true)
}
```

**Problems:**
- Overcomplicates Relay's purpose
- Type safety confusion
- Mixing concerns

**Instead:** Use Redux or React state

```tsx
// DO THIS
const [isModalOpen, setIsModalOpen] = useState(false);
// or
const isModalOpen = useAppSelector(selectModalOpen);
```

## Decision Flowchart

```
Is this data from an API?
├── Yes → Use Relay
└── No
    Is it used across many components?
    ├── Yes → Use Redux
    └── No
        Is it complex form state?
        ├── Yes → Use Redux or form library
        └── No → Use React useState
```

## Migration Strategy

When refactoring from Redux to Relay:

1. **Identify server data slices** — Any Redux slice connected to API calls
2. **Create Relay fragments** — One per component boundary
3. **Compose at root** — Single query with composed fragments
4. **Remove Redux slices** — Delete server data slices, keep UI-only slices
5. **Update components** — Replace `useAppSelector` with `useFragment`

## Example: DashboardStudent Refactor

| Current Redux Slice  | Destination    | Rationale                    |
| -------------------- | -------------- | ---------------------------- |
| `targetGroupSlice`   | Relay fragment | Server data                  |
| `studentSkillsSlice` | Relay fragment | Server data                  |
| `unitSlice`          | Relay fragment | Server data                  |
| `filterSlice`        | Keep in Redux  | UI state (user selections)   |
| `studentTourSlice`   | Keep in Redux  | UI state (current tour mode) |

## Related

- [[Relay Fragment Refactor Plan]] — Applying these principles to DashboardStudent
- [[Relay Fragment Composition]] — How fragments compose across components
- [[Data Masking in Relay]] — Why components only see what they declare

---

# What FAANG/MAMAA Companies Actually Use

## Industry Reality: GraphQL is Dominant for Server Data

| Company | Server Data | UI State | Notes |
|---------|-------------|----------|-------|
| **Meta (Facebook)** | Relay + GraphQL | React state / internal tools | Invented both GraphQL and Relay; uses them across FB, IG, WhatsApp |
| **Google** | Angular + gRPC internally; Apollo for some React | NgRx / RxJS / Redux | Heavy internal use of gRPC, not GraphQL |
| **Amazon** | Apollo Client + GraphQL | Redux / Context | Moving toward GraphQL for newer services |
| **Netflix** | Apollo Client + GraphQL (migrated from Falcor) | Redux / RxJS | Migrated from Falcor to GraphQL in 2019+ |
| **Apple** | Minimal public info; likely internal tooling | SwiftUI state | Not public about their web stack |

## Key Findings

### Meta: The Relay Standard-Bearer

**What they use:**
- **Relay + GraphQL** for all server data
- **React state** for UI-only state
- **No Redux** in production codebases (per engineering blogs)

> *"Meta invented the GraphQL protocol, as well as the Relay GraphQL client layer, and frequently uses those with their React code."* — State of React 2025

**Why Relay works for them:**
- Colocated data requirements = faster development
- Compiler-time optimizations = better mobile performance
- Normalized cache = consistent data across app
- Built at scale to solve their specific problems

**Recent developments (2025):**
- Mobile GraphQL framework updated for better performance
- Relay continues to be the default for new React projects at Meta
- F8 app (their conference app) built entirely with Relay + GraphQL

### Netflix: From Falcor to GraphQL/Apollo

**Evolution:**
1. **Falcor** (Netflix's own) — Original data-fetching solution
2. **GraphQL + Apollo** — Migrated starting 2019
3. **Current** — Apollo Client for GraphQL, Redux/RxJS for UI state

**Why they migrated:**
- Falcor was Netflix-specific; GraphQL has broader ecosystem
- Better tooling and developer experience with Apollo
- Wanted industry-standard patterns

**Current stack:**
- Apollo Client for server data
- Redux/RxJS for complex UI state
- React state for simple component state

### Airbnb: Apollo at Scale

**What they use:**
- **Apollo Client + GraphQL** for server data
- **Apollo Server** ("Niobe") for schema stitching
- Reported **10x development speed** after GraphQL adoption

> *"How Airbnb is Moving 10x Faster at Scale with GraphQL and Apollo"* — Airbnb Engineering

**Key insight:** They chose Apollo over Relay because:
- Easier onboarding for developers
- Better ecosystem support at the time (2018-2019)
- Flexible architecture with Java backend services

### Google: A Different Path

**What they use:**
- **gRPC** for internal service communication (not GraphQL)
- **Angular** with **NgRx** (RxJS-based) for many internal apps
- **Apollo** used in some React-based acquisitions/products

**Why not GraphQL everywhere:**
- Heavy investment in gRPC/Protocol Buffers
- Internal tools built around this ecosystem
- Different constraints (scale, latency requirements)

### Amazon: Gradual GraphQL Adoption

**What they use:**
- **Apollo Client + GraphQL** for newer consumer-facing features
- **Redux / Context** for UI state
- Gradual migration from REST APIs

## The Trend: GraphQL for Server Data

**2015-2018:** Redux was the default for everything
**2019-2022:** GraphQL + Apollo/Relay gained adoption for server data
**2023-2025:** Clear separation emerged:
- **Server data** → GraphQL clients (Relay or Apollo)
- **UI state** → Redux, Zustand, or React state

## Why Relay vs Apollo?

| Factor | Relay | Apollo |
|--------|-------|--------|
| **Created by** | Meta | Community (Apollo Graph) |
| **Compilation** | Build-time query optimization | Runtime query execution |
| **Type safety** | Stronger (generated types) | Good (with codegen) |
| **Learning curve** | Steeper | Easier |
| **Adoption** | Meta, some large-scale apps | Airbnb, Netflix, most others |
| **Best for** | Very large apps, mobile-first | Most apps, faster onboarding |

## The Modern Pattern (2025)

```tsx
// Server data — Relay or Apollo
const { data } = useQuery(USER_QUERY);
const userData = useFragment(UserFragment, userRef);

// UI state — Redux, Zustand, or React state
const [modalOpen, setModalOpen] = useState(false);
const filters = useSelector(selectFilters);
```

**Key insight from industry:**
> *"Separate server state from UI state. Use a GraphQL client for server data, use simpler tools for UI state."*

## Sources

- Meta Engineering Blog — "Mobile GraphQL at Meta in 2025" (March 2025)
- Netflix Tech Blog — "Migrating Netflix to GraphQL Safely" (2023)
- Airbnb Engineering — "How Airbnb is Moving 10x Faster at Scale with GraphQL and Apollo" (2019)
- "The State of React and the Community in 2025" — Mark Erikson (Redux maintainer)
- Relay.dev official blog — Active development in 2025
