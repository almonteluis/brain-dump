---
description: Lifting state up moves shared state to the closest common parent component, passing state and updater functions as props to create a single source of truth.
tags: ["flashcards/react/state-management"]
---
Lifting State Up in React - Condensed Answer:

**Key Points:**
```javascript
// 1. Parent Component Holds Shared State
function Parent() {
  const [sharedState, setSharedState] = useState(0);
  
  return (
    <>
      <ChildA value={sharedState} onUpdate={setSharedState} />
      <ChildB value={sharedState} onUpdate={setSharedState} />
    </>
  );
}

// 2. Children Components Use Props
function ChildA({ value, onUpdate }) {
  return <button onClick={() => onUpdate(value + 1)}>
    Increment from A: {value}
  </button>;
}
```

**Must Remember:**
* Move shared state to closest common parent
* Pass state and updater functions as props
* Makes state changes predictable
* Creates single source of truth
* Children become controlled components
* Enables component communication
* Helps maintain data consistency

```markdown
#flashcards/react/state-management

? What is Lifting State Up in React and how is it implemented?
?? Lifting State Up is a pattern where shared state is moved to the closest common parent component.

Basic Implementation:
```javascript
// Parent holds shared state
function Parent() {
  const [sharedState, setSharedState] = useState(0);
  
  return (
    <>
      <ChildA value={sharedState} onUpdate={setSharedState} />
      <ChildB value={sharedState} onUpdate={setSharedState} />
    </>
  );
}
```

? What are the key principles of Lifting State Up?
?? Core Principles:
1. ==Move shared state to closest common parent==
2. ==Pass state down as props==
3. ==Pass updater functions as props==
4. ==Create single source of truth==
5. ==Makes children controlled components==

? Show an example of a Shopping Cart implementation using Lifted State
?? ```javascript
function ShoppingCart() {
  const [items, setItems] = useState([]);
  const [total, setTotal] = useState(0);

  const addItem = (item) => {
    setItems([...items, item]);
    setTotal(prev => prev + item.price);
  };

  const removeItem = (itemId) => {
    const item = items.find(i => i.id === itemId);
    setItems(items.filter(i => i.id !== itemId));
    setTotal(prev => prev - item.price);
  };

  return (
    <div>
      <ProductList onAddItem={addItem} />
      <CartItems items={items} onRemoveItem={removeItem} />
      <CartTotal total={total} />
    </div>
  );
}
```

? Show an example of a Form Wizard using Lifted State
?? ```javascript
function FormWizard() {
  const [formData, setFormData] = useState({
    step1: {},
    step2: {},
    step3: {}
  });
  const [currentStep, setCurrentStep] = useState(1);

  const updateFormData = (step, data) => {
    setFormData(prev => ({
      ...prev,
      [step]: { ...prev[step], ...data }
    }));
  };

  return (
    <div>
      {currentStep === 1 && (
        <PersonalInfo 
          data={formData.step1}
          onUpdate={data => updateFormData('step1', data)}
          onNext={() => setCurrentStep(2)}
        />
      )}
      {currentStep === 2 && (
        <AddressInfo 
          data={formData.step2}
          onUpdate={data => updateFormData('step2', data)}
          onNext={() => setCurrentStep(3)}
          onBack={() => setCurrentStep(1)}
        />
      )}
      {currentStep === 3 && (
        <PaymentInfo 
          data={formData.step3}
          onUpdate={data => updateFormData('step3', data)}
          onSubmit={() => submitForm(formData)}
          onBack={() => setCurrentStep(2)}
        />
      )}
    </div>
  );
}
```

? Show a Tabs Component implementation using Lifted State
?? 
```javascript
function TabsContainer() {
  const [activeTab, setActiveTab] = useState(0);

  return (
    <div>
      <TabList 
        tabs={['Tab 1', 'Tab 2', 'Tab 3']}
        activeTab={activeTab}
        onTabChange={setActiveTab}
      />
      <TabContent 
        activeTab={activeTab}
        contents={[
          <div>Content 1</div>,
          <div>Content 2</div>,
          <div>Content 3</div>
        ]}
      />
    </div>
  );
}

function TabList({ tabs, activeTab, onTabChange }) {
  return (
    <div className="tabs">
      {tabs.map((tab, index) => (
        <button
          key={index}
          className={activeTab === index ? 'active' : ''}
          onClick={() => onTabChange(index)}
        >
          {tab}
        </button>
      ))}
    </div>
  );
}

function TabContent({ activeTab, contents }) {
  return <div className="content">{contents[activeTab]}</div>;
}
```

? What are the best practices for managing lifted state?
?? Best Practices:

1. State Location:
==Place state in common ancestor==

2. Avoid Redundant State:
```javascript
// ✅ Good
const [selectedId, setSelectedId] = useState(null);
const selectedItem = items.find(item => item.id === selectedId);

// ❌ Bad
const [selectedId, setSelectedId] = useState(null);
const [selectedItem, setSelectedItem] = useState(null);
```

3. Performance Optimization:
```javascript
// Memoize callbacks
const handleUpdate = useCallback((newValue) => {
  setData(newValue);
}, []);

// Memoize components
const MemoizedChild = memo(ChildComponent);
```

? What problems does Lifting State Up solve?
?? Key Benefits:
1. ==Creates single source of truth==
2. ==Makes state changes predictable==
3. ==Enables component communication==
4. ==Maintains data consistency==
5. ==Makes debugging easier==

## Best Practices

### State Management
```javascript
// Avoid redundant state
const [selectedId, setSelectedId] = useState(null);
const selectedItem = items.find(item => item.id === selectedId);

// Instead of
const [selectedId, setSelectedId] = useState(null);
const [selectedItem, setSelectedItem] = useState(null);
```

### Props Drilling
```javascript
// Consider [[Context]] for deep hierarchies
const DataContext = React.createContext();

function App() {
  const [data, setData] = useState();
  
  return (
    <DataContext.Provider value={{ data, setData }}>
      <DeepComponent />
    </DataContext.Provider>
  );
}
```

### Performance
```javascript
// Memoize callbacks
const handleUpdate = useCallback((newValue) => {
  setData(newValue);
}, []);

// Memoize child components if needed
const MemoizedChild = memo(ChildComponent);
```


This pattern helps maintain:
* Single source of truth
* Predictable data flow
* Component reusability
* State synchronization
* Easier debugging​​​​​​​​​​​​​​​​