---
description: Compound components — flexible React composition pattern where parent and children share implicit state
tags: ["react", "patterns", "composition", "components", "concept"]
created: 2026-04-23
---

# Compound Components

Compound components are a React pattern where a parent component and its children share implicit state through React Context, allowing flexible composition without prop drilling.

## The Problem It Solves

Without compound components, you get rigid APIs:
```tsx
<Tabs
  tabs={[
    { label: "Tab 1", content: <Content1 /> },
    { label: "Tab 2", content: <Content2 /> },
  ]}
  activeIndex={0}
  onChange={handleChange}
/>
```

With compound components, you get flexible composition:
```tsx
<Tabs onChange={handleChange}>
  <TabList>
    <Tab>Tab 1</Tab>
    <Tab>Tab 2</Tab>
  </TabList>
  <TabPanels>
    <TabPanel><Content1 /></TabPanel>
    <TabPanel><Content2 /></TabPanel>
  </TabPanels>
</Tabs>
```

## How It Works

1. **Parent** holds state and provides it via Context
2. **Children** consume Context to read state and call actions
3. **Consumer** composes children freely — order and nesting are flexible

```tsx
const TabsContext = createContext(null);

function Tabs({ children, defaultIndex = 0 }) {
  const [activeIndex, setActiveIndex] = useState(defaultIndex);
  return (
    <TabsContext.Provider value={{ activeIndex, setActiveIndex }}>
      {children}
    </TabsContext.Provider>
  );
}

function Tab({ children, index }) {
  const { activeIndex, setActiveIndex } = useContext(TabsContext);
  return (
    <button
      role="tab"
      aria-selected={activeIndex === index}
      onClick={() => setActiveIndex(index)}
    >
      {children}
    </button>
  );
}

// Attach as static properties
Tabs.TabList = TabList;
Tabs.Tab = Tab;
Tabs.TabPanels = TabPanels;
Tabs.TabPanel = TabPanel;
```

## When to Use

- **Tabs, Accordions, Selects** — UI components with shared selection state
- **Form groups** — Form + Field + Error composites
- **Data tables** — Table + Header + Row + Cell with shared sort/filter state
- **Navigation** — Menu + MenuItem with shared active state

## When NOT to Use

- Simple parent-child data passing (just use props)
- Components that don't share state
- One-off compositions (over-engineering)

## Related

- [[component-architecture]] — Overall component structuring patterns
- [[render-props-pattern]] — Alternative composition pattern
- [[state-context-reducer-pattern]] — Context + reducer for shared state
- [[designing-component-apis]] — Choosing the right component API
- [[container-presentational-pattern]] — Data/UI separation pattern
