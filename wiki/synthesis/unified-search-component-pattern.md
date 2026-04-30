---
description: Pattern for combining PrimeReact AutoComplete and MultiSelect into a unified search component with facade + strategy approach
tags: ["synthesis", "react", "primereact", "component-design", "search", "pattern"]
created: 2026-04-16
sources: ["autocomplete-system-design", "nc-frontend-architecture-research-2026-04-09", "atomic-design", "state-context-reducer-pattern"]
---

# Unified Search Component Pattern

Pattern for combining PrimeReact `AutoComplete` (single select) and `MultiSelect` (multi-select) into a cohesive search component that handles different fetch strategies.

## The Problem

Search features often need to switch between single-select (AutoComplete) and multi-select (MultiSelect) modes. These PrimeReact components have:

1. **Different data shapes** — AutoComplete returns a single value, MultiSelect returns an array
2. **Different fetch patterns** — AutoComplete does search-as-you-type (debounced), MultiSelect loads options upfront or uses different pagination
3. **Different event handlers** — `onChange` payloads differ between them
4. **Different UX patterns** — AutoComplete is type-and-filter, MultiSelect is browse-and-check

## Anti-Pattern: God Component with Switch

```typescript
// AVOID — diverging API surface, hard to test
function UnifiedSearch({ isMulti, ...props }) {
  if (isMulti) {
    return <MultiSelect
      value={props.values}        // array
      options={props.allOptions}  // loaded upfront
      onChange={props.onArrayChange}
      // ... 10 more multi-only props
    />;
  }
  return <AutoComplete
    value={props.value}           // single
    suggestions={props.suggestions} // fetched on type
    completeMethod={props.onSearch}
    onChange={props.onSingleChange}
    // ... 10 more auto-only props
  />;
}
```

This creates a forest of `if (isMulti)` branches and requires callers to pass props for both variants.

## Recommended: Facade + Sub-Components + Shared Fetch Hook

```
SearchSelector (facade)
├── Props: { mode: 'single' | 'multi', fetchStrategy, ...sharedProps }
├── Delegates to:
│   ├── SearchAutoComplete (single mode)
│   └── SearchMultiSelect (multi mode)
└── Normalized API surface (onChange always returns consistent shape)
```

### The Facade — Thin, No Branching Logic

```typescript
interface SearchSelectorProps {
  mode: 'single' | 'multi';
  fetchStrategy: 'relay' | 'rest' | 'redux';
  onSelectionChange: (result: SearchResult) => void;
  label: string;
  placeholder?: string;
}

interface SearchResult {
  value: string[];
  mode: 'single' | 'multi';
}

function SearchSelector({ mode, onSelectionChange, fetchStrategy, ...rest }: SearchSelectorProps) {
  const normalizedOnChange = (selection: string | string[]) => {
    onSelectionChange({
      value: Array.isArray(selection) ? selection : [selection],
      mode,
    });
  };

  if (mode === 'multi') {
    return (
      <SearchMultiSelect
        onChange={normalizedOnChange}
        fetchStrategy={fetchStrategy}
        {...rest}
      />
    );
  }

  return (
    <SearchAutoComplete
      onChange={normalizedOnChange}
      fetchStrategy={fetchStrategy}
      {...rest}
    />
  );
}
```

### Shared Fetch Hook — Encapsulates Data Logic

```typescript
function useSearchFetch(strategy: 'relay' | 'rest' | 'redux') {
  // Each strategy knows how to get data
  // Returns: { options, isLoading, search, error }
}

// Both sub-components use the same hook
function SearchAutoComplete({ fetchStrategy, onChange, ...props }) {
  const { options, isLoading, search } = useSearchFetch(fetchStrategy);
  return (
    <AutoComplete
      suggestions={options}
      completeMethod={search}
      onChange={(e) => onChange(e.value)}
      loading={isLoading}
      {...props}
    />
  );
}

function SearchMultiSelect({ fetchStrategy, onChange, ...props }) {
  const { options, isLoading } = useSearchFetch(fetchStrategy);
  return (
    <MultiSelect
      options={options}
      onChange={(e) => onChange(e.value)}
      loading={isLoading}
      {...props}
    />
  );
}
```

### Usage

```typescript
// Single select with Relay
<SearchSelector
  mode="single"
  fetchStrategy="relay"
  label="Class"
  onSelectionChange={(result) => selectClass(result.value[0])}
/>

// Multi select with REST
<SearchSelector
  mode="multi"
  fetchStrategy="rest"
  label="Classes"
  onSelectionChange={(result) => selectClasses(result.value)}
/>
```

## Decision Matrix

| Approach | Pros | Cons | Verdict |
|----------|------|------|---------|
| God component with `if/else` | One file | Diverging APIs, hard to test, violates SRP | Avoid |
| **Facade + sub-components + shared fetch hook** | Clean separation, testable, shared data layer | Slightly more files | **Recommended** |
| Two completely separate components | Simple, no abstraction | Duplicated fetch logic, inconsistent APIs | OK if fetch hook still extracted |

## Key Principle

> **Share the data layer, not the UI layer.** The fetch strategy is the shared concern — the rendering should stay separate because PrimeReact's `AutoComplete` and `MultiSelect` have genuinely different APIs and behaviors.

This aligns with the [[atomic-design]] principle of keeping molecules focused on a single purpose, and the [[state-context-reducer-pattern]] approach of separating data concerns from UI concerns.

## Related

- [[autocomplete-system-design]] — Autocomplete component architecture and caching
- [[nc-frontend-architecture-research-2026-04-09]] — NC Marvin frontend uses PrimeReact 10.6.5 at scale (319+ components)
- [[atomic-design]] — Hierarchical component methodology
- [[state-context-reducer-pattern]] — Separating state and actions for performant components
- [[react-patterns]] — React best practices from Airbnb
