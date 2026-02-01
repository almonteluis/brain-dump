---
description: Notes about Templates.
tags: #atomic-design #react #components #patterns #templates
---


description: Template Examples with State Management.
---

Atomic Design: Templates with State Management

**Key Points:**
* Templates define layout structure
* Combine multiple [[Organisms]]
* Handle page-level state
* Define content placement
* Manage responsive layouts

# Template Examples with State Management

## 1. Dashboard Template with Context
```javascript
// DashboardContext.js
const DashboardContext = createContext();

function DashboardProvider({ children }) {
  const [dashboardState, dispatch] = useReducer(dashboardReducer, {
    sidebarOpen: true,
    currentView: 'grid',
    filters: {},
    loading: false,
    error: null
  });

  return (
    <DashboardContext.Provider value={{ dashboardState, dispatch }}>
      {children}
    </DashboardContext.Provider>
  );
}

// DashboardTemplate.jsx
function DashboardTemplate() {
  const { dashboardState, dispatch } = useContext(DashboardContext);

  return (
    <div className="dashboard-layout">
      <Sidebar 
        isOpen={dashboardState.sidebarOpen}
        onToggle={() => dispatch({ type: 'TOGGLE_SIDEBAR' })}
      />
      
      <main className="dashboard-main">
        <Header />
        
        <DashboardControls 
          view={dashboardState.currentView}
          onViewChange={(view) => dispatch({ 
            type: 'SET_VIEW', 
            payload: view 
          })}
        />
        
        <div className="dashboard-content">
          {dashboardState.loading ? (
            <LoadingSpinner />
          ) : dashboardState.error ? (
            <ErrorMessage error={dashboardState.error} />
          ) : (
            <DashboardContent view={dashboardState.currentView} />
          )}
        </div>
      </main>
    </div>
  );
}
```

## 2. Admin Panel Template with Redux
```javascript
// adminSlice.js
const adminSlice = createSlice({
  name: 'admin',
  initialState: {
    activeSection: 'users',
    permissions: [],
    notifications: [],
    settings: {}
  },
  reducers: {
    setActiveSection: (state, action) => {
      state.activeSection = action.payload;
    },
    // Other reducers...
  }
});

// AdminTemplate.jsx
function AdminTemplate() {
  const dispatch = useDispatch();
  const { activeSection, permissions } = useSelector(state => state.admin);

  return (
    <div className="admin-layout">
      <AdminHeader 
        notifications={notifications}
      />
      
      <div className="admin-container">
        <AdminSidebar 
          activeSection={activeSection}
          permissions={permissions}
          onSectionChange={(section) => 
            dispatch(setActiveSection(section))}
        />
        
        <main className="admin-content">
          <Breadcrumbs />
          <AdminContent section={activeSection} />
        </main>
      </div>
      
      <AdminFooter />
    </div>
  );
}
```

## 3. E-commerce Template with Zustand
```javascript
// store.js
const useStore = create((set) => ({
  cart: [],
  wishlist: [],
  filters: {},
  sortBy: 'featured',
  addToCart: (item) => set((state) => ({
    cart: [...state.cart, item]
  })),
  updateFilters: (filters) => set({ filters }),
  // Other actions...
}));

// EcommerceTemplate.jsx
function EcommerceTemplate() {
  const { cart, filters, sortBy, updateFilters } = useStore();

  return (
    <div className="shop-layout">
      <ShopHeader cartCount={cart.length} />
      
      <div className="shop-container">
        <FilterSidebar
          filters={filters}
          onChange={updateFilters}
        />
        
        <main className="shop-content">
          <ProductSort
            value={sortBy}
            onChange={(value) => updateSort(value)}
          />
          
          <ProductGrid
            filters={filters}
            sortBy={sortBy}
          />
        </main>
      </div>
      
      <ShopFooter />
    </div>
  );
}
```

## 4. Authentication Template with Custom Hook
```javascript
// useAuth.js
function useAuth() {
  const [authState, setAuthState] = useState({
    user: null,
    loading: true,
    error: null
  });

  // Auth logic...

  return {
    ...authState,
    login,
    logout,
    signup
  };
}

// AuthTemplate.jsx
function AuthTemplate() {
  const { user, loading, error, login } = useAuth();
  const [authMode, setAuthMode] = useState('login');

  return (
    <div className="auth-layout">
      <div className="auth-container">
        <div className="auth-content">
          <AuthHeader 
            mode={authMode}
            onModeChange={setAuthMode}
          />
          
          {loading ? (
            <LoadingSpinner />
          ) : (
            <>
              {authMode === 'login' ? (
                <LoginForm onSubmit={login} />
              ) : (
                <SignupForm onSubmit={signup} />
              )}
              
              {error && <Alert type="error" message={error} />}
            </>
          )}
        </div>
        
        <AuthFooter />
      </div>
    </div>
  );
}
```

## Best Practices

### Layout Management
```javascript
// useLayout.js
function useLayout() {
  const [layout, setLayout] = useState({
    sidebarWidth: 240,
    contentPadding: 24,
    isResponsive: window.innerWidth < 768
  });

  useEffect(() => {
    const handleResize = () => {
      setLayout(prev => ({
        ...prev,
        isResponsive: window.innerWidth < 768
      }));
    };

    window.addEventListener('resize', handleResize);
    return () => window.removeEventListener('resize', handleResize);
  }, []);

  return layout;
}
```

### State Organization
```javascript
// Template level state management
function useDashboardState() {
  const [filters, setFilters] = useState({});
  const [pagination, setPagination] = useState({
    page: 1,
    perPage: 10
  });
  const [sorting, setSorting] = useState({
    field: 'createdAt',
    direction: 'desc'
  });

  const computedState = useMemo(() => ({
    // Computed values based on state
  }), [filters, pagination, sorting]);

  return {
    filters,
    pagination,
    sorting,
    setFilters,
    setPagination,
    setSorting,
    ...computedState
  };
}
```

Remember:
* Keep templates focused on layout
* Handle responsive behavior
* Implement proper state management
* Consider performance optimizations
* Handle loading and error states
* Use proper TypeScript types
* Implement [[Accessibility]] features
* Document state management patterns
* Follow consistent naming conventions
* Write comprehensive tests
* Consider [[Code splitting]]
* Optimize for reusability​​​​​​​​​​​​​​​​