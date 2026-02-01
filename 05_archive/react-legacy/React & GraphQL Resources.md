# React & GraphQL Resources

> Your central hub for React, GraphQL, and Relay patterns and documentation.

> *Last Updated:* 2026-01-31 at 14:04*

---

## Quick Access

Jump straight to the guide you need:

### React Patterns
- [[airbnb-react-style-guide]] - Full Airbnb React style guide (24KB)
- [[airbnb-react-patterns-summary]] - Quick reference summary (5KB)

### Refactoring
- [[react-refactoring-catalog]] - 69 refactoring operations from empirical study of 320 React commits
  - **React-specific** (25 ops): Extract logic to custom hook, migrate class to function component, etc.
  - **React-adapted** (17 ops): Extract component, rename component, remove unused props, etc.
  - **Traditional** (22 ops): Dead code elimination, extract function, rename, etc.
  - **JavaScript** (6 ops): Convert to TypeScript, arrow functions, etc.

### Patterns Covered
- One component per file (multiple stateless OK)
- Prefer ES6 classes for stateful, functions for stateless
- Double quotes for JSX props, single for JS
- Always use stable IDs for keys (no array indexes)
- Bind event handlers in constructor, not render
- Define defaultProps for all non-required props
- Always include alt prop on images
- No mixins, no string refs, no isMounted()

### Component Structure
- [[react-bits-index]] - React Bits index
- [[react-bits-summary]] - React Bits patterns (8KB)

### Key Patterns

#### Presentational vs Container
- **Containers:** Data, logic, business rules, lifecycle
- **Presentational:** How things look, stateless, receive via props
- Enables swapping renderers and reusability

#### setState Best Practices
- setState is async — don't rely on immediate state
- Use functional setState: `setState(prev => ({count: prev.count + 1}))`
- Pass callback for post-update logic: `setState({...}, () => ({...}))`

#### React Fragments
- Return multiple elements without wrapper divs
- Critical for tables, lists, semantic HTML
- Syntax: `<React.Fragment>` or shorthand `<>...</>`

#### Anti-Patterns
- Never mutate state directly — use setState with immutable patterns
- No props in initial state (won't update when props change)
- No findDOMNode, mixins, setState in componentWillMount
- No array indexes as keys — use stable IDs
- No spreading props on DOM elements

#### Performance
- Use PureComponent for shallow comparison optimization
- Prevents re-renders when props/state unchanged
- Gotcha: shallow comparison only, functions break it

---

## GraphQL Workshop (ASP.NET Core + Relay)

### Workshop Materials
- [[fullstack-graphql-workshop]] - ASP.NET Core + Hot Chocolate workshop (5KB)
- [[graphql-workshop-summary]] - GraphQL patterns (11KB)

### Server-Side Patterns (ASP.NET Core + Hot Chocolate)
- DataLoader pattern for N+1 query prevention
- Connection pattern for pagination (edges/nodes/cursors)
- Entity and Mutation patterns for consistency
- Field middleware for cross-cutting concerns
- Schema evolution with client/schema registries

### Relay.js Patterns
- Fragments for co-located data requirements
- Optimistic updates for instant UX
- Pagination for large datasets
- Prefetching data before navigation
- Transitions for loading states
- Query Renderer for data fetching

### Architecture
- Simple layering (API → Business Logic → Data Access)
- Distributed GraphQL for microservices
- CQRS + DDD with GraphQL
- Open Telemetry for monitoring

---

## Relay Query Refactoring

### Quick Reference
- [[relay-query-refactoring-guide]] - Convert multiple useLazyLoadQuery to single query + fragments (15KB)

### Hook Comparison
| Hook | Purpose | When to Use |
|-------|-----------|--------------|
| `useLazyLoadQuery` | Fetch on render, can waterfall | Simple pages, no prefetch |
| `usePreloadedQuery` | Read preloaded data, better for navigation | Route transitions |
| `useQueryLoader` | Manage preloaded refs with auto-disposal | Navigation with disposal |

### Fragment Pattern
- Define fragment with `graphql` tag and `on Type`
- Use `useFragment(fragment, fragmentKey)` to read data
- Fragment keys (`$ref`) tell Relay where to read from
- Data masking prevents accidental coupling
- Generated types: `FragmentName$key`

### Refactoring Strategy (SingleSkill Example)
1. Create fragment in TeacherSingleSkill component
2. Spread fragment into parent SingleSkill query
3. Update child props to accept fragment key (not raw data)
4. Remove separate `useLazyLoadQuery` calls
5. Handle conditional fragments with `@skip` directive for student vs teacher views
6. Run `npm run relay` to regenerate types

### Performance Impact
- **Before:** 2+ network requests with waterfall (~450ms total)
- **After:** 1 optimized query (~250ms total)
- **Savings:** ~45% faster, fewer round trips

### Common Pitfalls
- Forgetting to spread fragment into parent query
- Passing wrong type (raw data vs fragment key)
- Not running Relay compiler after adding fragments
- Missing fragment in parent query definition

---

## Relay ESLint Rules

### Quick Reference
- [[relay-eslint-rules-guide]] - Fragment usage rules deep dive (14KB)

### Rule 1: relay/unused-fields
- Ensures every GraphQL field referenced is used within a module
- Prevents waste: unused fields = wasted bandwidth + server processing
- When triggered: Means you should use fragments to co-locate data requirements
- Fix: Extract unused fields into fragments, let components declare their needs

### Rule 2: relay/must-colocate-fragment-spreads
- Ensures fragment is imported in file where it's spread
- Prevents anti-pattern: fetches fragment but doesn't use it (no data masking)
- When triggered: Fragment is spread but not imported or child doesn't use `useFragment`
- Fix: Import fragment where spread, use `useFragment` in child, pass fragment reference

### How Rules Work Together
- `must-colocate-fragment-spreads` → Forces proper fragment usage
- `unused-fields` → Catches fields not used by any fragment
- **Result:** Co-located fragments = optimal data fetching (only what's needed)

### Real-World Example: SingleSkill
- **Before:** Both rules fail (fragment not imported + unused fields + 2 queries)
- **After:** Both rules pass (imported fragment + used only in child + 1 query)
- **Impact:** Single optimized request, type-safe components, ~45% faster

---

## Core Documentation

### Main Relay Docs
- [[relay-main]] - Relay core documentation (9KB)

Use this for:
- Declarative data fetching
- Automatic optimizations (deduplication, precomputation)
- Data consistency across components
- Mutations with optimistic updates
- Fragment-based data composition
- Pagination patterns
- Performance management

### Concepts Covered
- Data-fetching turned declarative
- Components declare data dependencies independently
- Relay guarantees data is fetched and available
- Keeps components decoupled and promotes reuse
- Modifications don't break other components
- Automatic merge of mutation updates

---

## Architecture & Best Practices

### GraphQL Server Spec
- Node interface for global object identification
- Cursor-based connections for pagination
- Relay-compliant server requirements

### Design Patterns
- Entity pattern for structured data
- Connection pattern for lists with pagination
- Mutation pattern for data updates
- DataLoader pattern for N+1 optimization

### State Management
- One-way data flow
- Predictable state updates
- No direct state mutation

---

## Quick Tips

### When Working with GraphQL
- Use fragments to co-locate data needs
- Define input types for queries
- Use `@skip` and `@include` directives for conditional fields
- Implement proper error handling
- Leverage DataLoader for batched data fetching

### When Working with Relay
- Start with fragments even for simple components
- Use `useFragment` to access masked data
- Keep components focused and reusable
- Let Relay handle data optimization automatically
- Use `usePreloadedQuery` for route transitions

---

## All Resources Summary

Total: 9 comprehensive guides covering React, GraphQL, and Relay best practices.

**Size:** ~92KB of documentation
**Topics Covered:**
- Component patterns and architecture
- State management and lifecycle
- GraphQL schema and queries
- Relay data fetching and optimization
- Fragment usage and colocation
- ESLint rules and best practices
- Performance optimization techniques
- Query refactoring strategies

---

*Ready for your interview prep and daily development!*
