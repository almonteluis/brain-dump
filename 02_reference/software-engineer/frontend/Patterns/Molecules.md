---
description: Notes about Molecules.
tags: #atomic-design #react #components #patterns #molecules
---


description: Common Molecules.
---

Atomic Design: Molecules in React

**Key Points:**
* Molecules combine multiple [[Atoms]]
* Serve a single purpose/functionality
* Reusable across different contexts
* More complex than [[Atoms]] but still relatively simple

# Common Molecules

## 1. Form Controls
```javascript
function SearchBar({ onSearch }) {
  const [query, setQuery] = useState('');

  return (
    <div className="search-bar">
      <Input
        type="text"
        value={query}
        onChange={(e) => setQuery(e.target.value)}
        placeholder="Search..."
      />
      <Button 
        variant="primary"
        onClick={() => onSearch(query)}
      >
        <Icon name="search" />
      </Button>
    </div>
  );
}

function FormField({ label, error, children }) {
  return (
    <div className="form-field">
      <Label>{label}</Label>
      {children}
      {error && <Text className="error">{error}</Text>}
    </div>
  );
}
```

## 2. Navigation Elements
```tsx
function MenuItem({ icon, label, href, active }) {
  return (
    <a 
      href={href}
      className={`menu-item ${active ? 'active' : ''}`}
    >
      <Icon name={icon} />
      <Text>{label}</Text>
    </a>
  );
}

function Breadcrumb({ items }) {
  return (
    <nav className="breadcrumb">
      {items.map((item, index) => (
        <React.Fragment key={item.path}>
          <Link href={item.path}>{item.label}</Link>
          {index < items.length - 1 && <Icon name="chevron-right" />}
        </React.Fragment>
      ))}
    </nav>
  );
}
```

## 3. Card Components
```javascript
function Card({ title, subtitle, image, children }) {
  return (
    <div className="card">
      {image && (
        <div className="card-image">
          <img src={image} alt={title} />
        </div>
      )}
      <div className="card-content">
        <Heading level={3}>{title}</Heading>
        {subtitle && <Text>{subtitle}</Text>}
        {children}
      </div>
    </div>
  );
}

function ProfileCard({ user }) {
  return (
    <Card>
      <div className="profile-header">
        <Avatar src={user.avatar} alt={user.name} />
        <div>
          <Heading level={4}>{user.name}</Heading>
          <Text>{user.role}</Text>
        </div>
      </div>
      <Button variant="outline">View Profile</Button>
    </Card>
  );
}
```

## 4. Interactive Components
```javascript
function Dropdown({ label, options, value, onChange }) {
  const [isOpen, setIsOpen] = useState(false);

  return (
    <div className="dropdown">
      <Button onClick={() => setIsOpen(!isOpen)}>
        {label}
        <Icon name={isOpen ? 'chevron-up' : 'chevron-down'} />
      </Button>
      
      {isOpen && (
        <ul className="dropdown-menu">
          {options.map((option) => (
            <li
              key={option.value}
              onClick={() => {
                onChange(option.value);
                setIsOpen(false);
              }}
              className={value === option.value ? 'active' : ''}
            >
              {option.label}
            </li>
          ))}
        </ul>
      )}
    </div>
  );
}
```

## 5. Alert/Notification Components
```tsx
function Alert({ type = 'info', message, onClose }) {
  return (
    <div className={`alert alert-${type}`}>
      <Icon name={type} />
      <Text>{message}</Text>
      {onClose && (
        <Button variant="ghost" onClick={onClose}>
          <Icon name="close" />
        </Button>
      )}
    </div>
  );
}

function Toast({ message, type, duration = 3000 }) {
  const [visible, setVisible] = useState(true);

  useEffect(() => {
    const timer = setTimeout(() => setVisible(false), duration);
    return () => clearTimeout(timer);
  }, [duration]);

  if (!visible) return null;

  return (
    <div className={`toast toast-${type}`}>
      <Icon name={type} />
      <Text>{message}</Text>
    </div>
  );
}
```

## Best Practices

### Component Organization
```javascript
// molecules/FormField/index.jsx
export const FormField = {
  // Component logic
};

// molecules/FormField/styles.js
export const StyledFormField = styled.div`
  // Styles
`;

// molecules/FormField/FormField.test.js
describe('FormField', () => {
  // Tests
});
```

### Composition Pattern
```javascript
function ComposableMolecule({ leftComponent, rightComponent, children }) {
  return (
    <div className="molecule">
      {leftComponent}
      <div className="content">{children}</div>
      {rightComponent}
    </div>
  );
}
```

Remember:
* Keep molecules focused on single responsibility
* Maintain consistent prop patterns
* Use proper TypeScript/PropTypes
* Write unit tests
* Make components accessible
* Consider responsive design
* Document usage examples
* Use proper error handling
* Include loading states
* Follow consistent naming​​​​​​​​​​​​​​​​