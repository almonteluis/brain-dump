---
description: Frontend architecture patterns including component structure, state management layers, data flow, and compound components.
tags: ["architecture", "best-practices", "frontend", "system-design"]
---
#architecture #system-design #frontend #best-practices

## Frontend Architecture

#### Component Architecture
```typescript
// Atomic Design Structure
src/
  ├── atoms/
  │   ├── Button/
  │   ├── Input/
  │   └── Typography/
  ├── molecules/
  │   ├── SearchBar/
  │   └── FormField/
  ├── organisms/
  │   ├── Header/
  │   └── UserDashboard/
  ├── templates/
  └── pages/

// Feature-based Structure
src/
  ├── features/
  │   ├── auth/
  │   │   ├── components/
  │   │   ├── hooks/
  │   │   ├── services/
  │   │   └── types/
  │   └── dashboard/
  ├── shared/
  │   ├── components/
  │   └── utils/
  └── core/
```

#### State Management Patterns
```javascript
// Application State Layers
1. UI State (Component Level)
2. Form State (Form Management)
3. Server Cache State (API Data)
4. Global State (App-wide Data)

// Example using Different State Solutions
function App() {
  // Local UI State
  const [isOpen, setIsOpen] = useState(false);
  
  // Form State (React Hook Form)
  const { register, handleSubmit } = useForm();
  
  // Server State (React Query)
  const { data, isLoading } = useQuery('users', fetchUsers);
  
  // Global State (Redux)
  const user = useSelector(state => state.user);
}
```

#### Data Flow Architecture
```javascript
// Unidirectional Data Flow
View -> Action -> Dispatcher -> Store -> View

// Clean Architecture Layers
1. Presentation Layer (UI Components)
2. Domain Layer (Business Logic)
3. Data Layer (API Calls, Storage)

// Example Service Layer
export class UserService {
  async getUser(id: string): Promise<User> {
    const response = await this.api.get(`/users/${id}`);
    return this.userMapper.toDomain(response.data);
  }
}
```

## Design Patterns

#### 1. Compound Components
```javascript
const Select = ({ children, onChange }) => {
  const [selectedOption, setSelectedOption] = useState(null);
  
  return (
    <SelectContext.Provider value={{ selectedOption, setSelectedOption }}>
      {children}
    </SelectContext.Provider>
  );
};

Select.Option = ({ value, children }) => {
  const { selectedOption, setSelectedOption } = useSelectContext();
  return (
    <div onClick={() => setSelectedOption(value)}>
      {children}
    </div>
  );
};
```

#### 2. Provider Pattern
```javascript
const ThemeContext = React.createContext();

const ThemeProvider = ({ children }) => {
  const [theme, setTheme] = useState('light');
  
  const toggleTheme = () => {
    setTheme(prev => prev === 'light' ? 'dark' : 'light');
  };
  
  return (
    <ThemeContext.Provider value={{ theme, toggleTheme }}>
      {children}
    </ThemeContext.Provider>
  );
};
```

#### 3. Custom Hooks Pattern
```javascript
function useAsync(asyncFunction) {
  const [state, setState] = useState({
    data: null,
    loading: true,
    error: null
  });

  useEffect(() => {
    asyncFunction()
      .then(data => setState({ data, loading: false, error: null }))
      .catch(error => setState({ data: null, loading: false, error }));
  }, [asyncFunction]);

  return state;
}
```

## References & Further Reading

#### Books
* "Clean Architecture" by Robert C. Martin
* "Patterns of Enterprise Application Architecture" by Martin Fowler
* "Frontend Architecture for Design Systems" by Micah Godbolt

#### Online Resources
* [React Patterns](https://reactpatterns.com/)
* [Redux Style Guide](https://redux.js.org/style-guide/style-guide)
* [React Architecture Best Practices](https://www.tatvasoft.com/blog/reactjs-best-practices/)

#### Courses
* Frontend Masters: Advanced React Patterns
* Epic React by Kent C. Dodds
* Clean Code: Advanced React Design Patterns

#### Tools & Documentation
* [React DevTools](https://github.com/facebook/react/tree/main/packages/react-devtools)
* [Redux DevTools](https://github.com/reduxjs/redux-devtools)
* [Storybook](https://storybook.js.org/)

#### Architecture Examples
* [Real World React Apps](https://github.com/jeromedalbert/real-world-react-apps)
* [React Boilerplate](https://github.com/react-boilerplate/react-boilerplate)
* [React Enterprise Starter Kit](https://github.com/anandgupta193/react-enterprise-starter-kit)

Would you like me to expand on any particular pattern or provide more specific examples?​​​​​​​​​​​​​​​​