---
description: Fragment composition is Relay's pattern for building component hierarchies where parents include child fragments, enabling local data ownership and single-query efficiency
tags: ["relay", "graphql", "fragment-composition", "react", "concept"]
created: 2026-04-08
updated: 2026-04-08
sources: ["relay-fragment-composition.md"]
---

# Fragment Composition

Fragment composition is Relay's pattern for building component hierarchies where data ownership stays local to components while still composing into a single efficient query.

## The Pattern

```
Query → Parent Fragment → Child Fragment → Grandchild Fragment
```

Each component:
1. Declares its own data needs
2. Includes fragments of direct children
3. Passes fragment refs to children

## Key Mechanism

**Parent must both:**
- Render child component in JSX
- Include child's fragment in its GraphQL

```tsx
// Parent includes child fragment
const fragment = graphql`
  fragment Parent_data on User {
    name
    ...Child_data  // Include child fragment
  }
`;

function Parent({ $ref }) {
  const data = useFragment(fragment, $ref);
  return <Child $ref={data} />;  // Pass fragment ref
}
```

## Benefits

| Benefit | Description |
|---------|-------------|
| Local Development | Change child data needs without touching parents |
| Clear Ownership | Each component owns its data requirements |
| Single Query | All fragments compose into one efficient query |
| Type Safety | Generated types enforce correct fragment usage |
| Reusability | Same component works in different graph contexts |

## Data Isolation

- Parent only sees what it declared
- Child only sees what it declared
- Unless both declare same field, data is isolated

## The Golden Rule

> Each React component is responsible for fetching the data dependencies of its direct children — just as it has to know about its children's props to render them correctly.

## Related

[[relay]]
[[data-colocation]]
[[fragment-references]]
