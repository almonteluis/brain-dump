---
description: Relay fragment naming conventions follow the {ComponentName}_{propName} pattern, with generated $key types for type-safe fragment references.
tags: ["relay", "graphql", "fragments", "typescript", "naming-convention"]
created: 2026-01-31
---

# Relay Fragment Naming and Typing

Quick reference for naming Relay fragments and typing fragment references properly — avoiding `any` and using generated types.

## Fragment Naming Convention

**Pattern:** `{ComponentName}_{propName} on {Type}`

The fragment name describes **where it's used** (component + prop), not what it contains.

| Fragment Name | Component | Prop Name | Type |
|---------------|-----------|-----------|------|
| `catalogSearch_query` | `CatalogSearch` | `query` / `data` | `Query` |
| `catalogSearch_BrandTypes` | `CatalogSearch` → `Brands` | `BrandTypes` data | `Query` |
| `catalogSearch_ProductTypes` | `CatalogSearch` → `ProductTypes` | `ProductTypes` data | `Query` |
| `catalog_query` | `Catalog` → `Products` | `catalog` data | `Query` |

### Why This Pattern?

```tsx
// ❌ Bad: Naming by contents
fragment BrandsAndProducts_brands on Query { ... }

// ✅ Good: Naming by component + prop
fragment catalogSearch_BrandTypes on Query { ... }
```

The contents (`brands`, `productTypes`) are encapsulated in child fragments. The parent fragment name only needs to describe its relationship to the component.

## Typing Fragment References

After running `npm run relay`, Relay generates types with `$key` suffix.

| Fragment Definition | Generated Type |
|---------------------|----------------|
| `fragment catalogSearch_query` | `catalogSearch_query$key` |
| `fragment catalogSearch_BrandTypes` | `catalogSearch_BrandTypes$key` |
| `fragment catalogSearch_ProductTypes` | `catalogSearch_ProductTypes$key` |

### ❌ Before: Using `any`

```tsx
interface BrandsProps {
  onChange: (id?: string) => void;
  selectedId?: string;
  $ref: any;  // ❌ Loses type safety
}
```

### ✅ After: Using Generated Type

```tsx
import type { catalogSearch_BrandTypes$key } from "./__generated__/catalogSearch_BrandTypes.graphql";

interface BrandsProps {
  onChange: (id?: string) => void;
  selectedId?: string;
  $ref: catalogSearch_BrandTypes$key;  // ✅ Type-safe
}

function Brands({ onChange, selectedId, $ref }: BrandsProps) {
  const data = useFragment(
    graphql`
      fragment catalogSearch_BrandTypes on Query {
        brands {
          nodes {
            id
            name
          }
        }
      }
    `,
    $ref,
  );
```

## Full Example: Catalog Search

This example shows proper fragment naming and typing through a component hierarchy.

```tsx
// Catalog.tsx - Root component with useLazyLoadQuery
import { graphql, useLazyLoadQuery } from "react-relay";
import type { catalogQuery } from "./__generated__/catalogQuery.graphql";

export function Catalog() {
  const data = useLazyLoadQuery<catalogQuery>(
    graphql`
      query catalogQuery {
        ...catalog_query
        ...catalogSearch_query
      }
    `,
    {},
  );

  return (
    <>
      <CatalogSearch $ref={data} />
      <Products $ref={data} />
    </>
  );
}
```

```tsx
// catalog-search.tsx - Parent component with composed fragments
import type { catalogSearch_query$key } from "./__generated__/catalogSearch_query.graphql";
import type { catalogSearch_BrandTypes$key } from "./__generated__/catalogSearch_BrandTypes.graphql";
import type { catalogSearch_ProductTypes$key } from "./__generated__/catalogSearch_ProductTypes.graphql";

interface CatalogSearchProps {
  onBrandChange: (id?: string) => void;
  onTypeChange: (id?: string) => void;
  selectedBrandId?: string;
  selectedTypeId?: string;
  $ref: catalogSearch_query$key;
}

export function CatalogSearch({ onBrandChange, onTypeChange, selectedTypeId, selectedBrandId, $ref }: CatalogSearchProps) {
  const data = useFragment(
    graphql`
      fragment catalogSearch_query on Query {
        ...catalogSearch_BrandTypes
        ...catalogSearch_ProductTypes
      }
    `,
    $ref,
  );

  return (
    <div className="catalog-search">
      <Brands onChange={onBrandChange} selectedId={selectedBrandId} $ref={data} />
      <ProductTypes onChange={onTypeChange} selectedId={selectedTypeId} $ref={data} />
    </div>
  );
}
```

```tsx
// brands.tsx - Child component with its own fragment
import type { catalogSearch_BrandTypes$key } from "./__generated__/catalogSearch_BrandTypes.graphql";

interface BrandsProps {
  onChange: (id?: string) => void;
  selectedId?: string;
  $ref: catalogSearch_BrandTypes$key;
}

function Brands({ onChange, selectedId, $ref }: BrandsProps) {
  const data = useFragment(
    graphql`
      fragment catalogSearch_BrandTypes on Query {
        brands {
          nodes {
            id
            name
          }
        }
      }
    `,
    $ref,
  );

  return (
    <div className="brands">
      {data.brands?.nodes?.map(({ id, name }) => (
        <div key={id} onClick={() => onChange(id)}>{name}</div>
      ))}
    </div>
  );
}
```

## Quick Reference

| Task | How |
|------|-----|
| Name fragment | `{ComponentName}_{propName} on {Type}` |
| Import type | `import type { FragmentName$key } from "./__generated__/FragmentName.graphql"` |
| Type prop | `$ref: FragmentName$key` |
| Run compiler | `npm run relay` generates types in `__generated__/` |

## Related

- [[Relay GraphQL Fragments]] - Core fragment concepts
- [[Relay Fragment Composition]] - Parent-child fragment patterns
- [[Data Masking in Relay]] - Why fragment refs are opaque
