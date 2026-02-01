---
description: Notes about Organisms.
tags: #atomic-design #react #components #patterns #organisms
---


description: Atomic Design: Organisms in React. 
---

Atomic Design: Organisms in React

**Key Points:**
* Organisms are larger, more complex components
* Combine multiple [[Molecules]] and [[Atoms]]
* Represent distinct sections of an interface
* More complex but still reusable
* Usually context-specific

# Common Organisms

## 1. Navigation Header
```javascript
function Header() {
  return (
    <header className="main-header">
      <div className="logo">
        <img src="/logo.svg" alt="Company Logo" />
      </div>
      
      <nav className="main-nav">
        <MenuItem href="/dashboard" icon="home" label="Dashboard" />
        <MenuItem href="/projects" icon="folder" label="Projects" />
        <MenuItem href="/team" icon="users" label="Team" />
      </nav>

      <div className="header-actions">
        <SearchBar onSearch={(query) => console.log(query)} />
        <Dropdown
          label={<Avatar src="/user.jpg" size="sm" />}
          options={[
            { label: 'Profile', value: 'profile' },
            { label: 'Settings', value: 'settings' },
            { label: 'Logout', value: 'logout' }
          ]}
        />
      </div>
    </header>
  );
}
```

## 2. Dashboard Widget Section
```javascript
function DashboardWidgets({ data }) {
  return (
    <section className="dashboard-widgets">
      <div className="widget-grid">
        <Card title="Revenue">
          <div className="widget-content">
            <Text size="lg">${data.revenue}</Text>
            <Chart data={data.revenueChart} />
            <div className="widget-footer">
              <Badge variant="success">+15%</Badge>
              <Text size="sm">vs last month</Text>
            </div>
          </div>
        </Card>

        <Card title="Active Users">
          <div className="widget-content">
            <Text size="lg">{data.activeUsers}</Text>
            <UsersList users={data.recentUsers} />
          </div>
        </Card>

        <Card title="Tasks">
          <TaskList
            tasks={data.tasks}
            onTaskComplete={(id) => console.log('Complete:', id)}
          />
        </Card>
      </div>
    </section>
  );
}
```

## 3. Complex Form
```javascript
function RegistrationForm() {
  const [formData, setFormData] = useState({});
  const [errors, setErrors] = useState({});

  const handleSubmit = async (e) => {
    e.preventDefault();
    // Validation and submission logic
  };

  return (
    <form className="registration-form" onSubmit={handleSubmit}>
      <div className="form-grid">
        <FormField
          label="Full Name"
          error={errors.name}
        >
          <Input
            value={formData.name}
            onChange={(e) => setFormData({
              ...formData,
              name: e.target.value
            })}
          />
        </FormField>

        <FormField
          label="Email"
          error={errors.email}
        >
          <Input
            type="email"
            value={formData.email}
            onChange={(e) => setFormData({
              ...formData,
              email: e.target.value
            })}
          />
        </FormField>

        <FormField
          label="Password"
          error={errors.password}
        >
          <PasswordInput
            value={formData.password}
            onChange={(e) => setFormData({
              ...formData,
              password: e.target.value
            })}
          />
        </FormField>

        <Alert type="info" message="Password must be at least 8 characters" />

        <div className="form-actions">
          <Button variant="secondary">Cancel</Button>
          <Button variant="primary" type="submit">Register</Button>
        </div>
      </div>
    </form>
  );
}
```

## 4. Data Table
```javascript
function DataTable({ data, columns, onSort, onFilter }) {
  return (
    <div className="data-table-container">
      <div className="table-header">
        <SearchBar onSearch={(query) => onFilter(query)} />
        <div className="table-actions">
          <Button>Export</Button>
          <Button variant="primary">Add New</Button>
        </div>
      </div>

      <table className="data-table">
        <thead>
          <tr>
            {columns.map(column => (
              <th 
                key={column.key}
                onClick={() => onSort(column.key)}
              >
                {column.label}
                <Icon name="sort" />
              </th>
            ))}
          </tr>
        </thead>
        <tbody>
          {data.map(row => (
            <tr key={row.id}>
              {columns.map(column => (
                <td key={column.key}>
                  {column.render ? 
                    column.render(row[column.key], row) : 
                    row[column.key]}
                </td>
              ))}
            </tr>
          ))}
        </tbody>
      </table>

      <div className="table-footer">
        <Pagination
          total={100}
          current={1}
          onChange={(page) => console.log(page)}
        />
      </div>
    </div>
  );
}
```

## 5. Sidebar Navigation
```javascript
function Sidebar({ user, notifications }) {
  return (
    <aside className="sidebar">
      <div className="sidebar-header">
        <ProfileCard user={user} />
      </div>

      <nav className="sidebar-nav">
        <MenuItem icon="dashboard" label="Dashboard" active />
        <MenuItem icon="calendar" label="Calendar">
          <Badge count={notifications.calendar} />
        </MenuItem>
        <MenuItem icon="message" label="Messages">
          <Badge count={notifications.messages} />
        </MenuItem>
        <Divider />
        <MenuItem icon="settings" label="Settings" />
      </nav>

      <div className="sidebar-footer">
        <ThemeToggle />
        <Button variant="ghost" onClick={() => logout()}>
          <Icon name="logout" />
          Logout
        </Button>
      </div>
    </aside>
  );
}
```

## Best Practices

### State Management
```javascript
// Use custom hooks for complex logic
function useTableData(initialData) {
  const [data, setData] = useState(initialData);
  const [sorting, setSorting] = useState({ key: null, direction: 'asc' });
  const [filters, setFilters] = useState({});

  // Sorting and filtering logic

  return {
    data: processedData,
    sorting,
    filters,
    setSorting,
    setFilters
  };
}
```

Remember:
* Break down into smaller components
* Handle loading and error states
* Implement proper prop validation
* Consider accessibility
* Add responsive behavior
* Implement proper event handlers
* Use consistent styling
* Document component APIs
* Include proper TypeScript types
* Write comprehensive tests​​​​​​​​​​​​​​​​