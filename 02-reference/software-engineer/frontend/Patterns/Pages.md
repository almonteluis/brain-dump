---
description: Notes about Pages.
tags: #atomic-design #react #components #patterns #pages
---


description: Page Examples.
---

Atomic Design: Pages with State Management

**Key Points:**
* Pages are specific instances of templates
* Contain real content
* Handle data fetching
* Manage route-level state
* Implement business logic

# Page Examples

## 1. Dashboard Page
```tsx
// pages/Dashboard/index.jsx
function DashboardPage() {
  const { user } = useAuth();
  const queryClient = useQueryClient();
  
  // Data fetching with React Query
  const { data: dashboardData, isLoading } = useQuery(
    ['dashboard', user.id],
    () => fetchDashboardData(user.id),
    {
      staleTime: 5 * 60 * 1000, // 5 minutes
      refetchOnWindowFocus: true
    }
  );

  return (
    <DashboardTemplate>
      <SEO title="Dashboard | MyApp" />
      
      <PageHeader
        title={`Welcome back, ${user.name}`}
        actions={[
          <Button onClick={() => queryClient.invalidateQueries('dashboard')}>
            Refresh Data
          </Button>
        ]}
      />

      {isLoading ? (
        <LoadingState />
      ) : (
        <DashboardContent data={dashboardData} />
      )}
    </DashboardTemplate>
  );
}
```

## 2. Product List Page with Filters
```tsx
// pages/Products/index.jsx
function ProductsPage() {
  const [searchParams, setSearchParams] = useSearchParams();
  const { category } = useParams();

  // State management with Redux Toolkit
  const dispatch = useDispatch();
  const { products, filters, sorting } = useSelector(
    (state) => state.products
  );

  // Fetch products when filters/sorting change
  const { data, isLoading } = useQuery(
    ['products', filters, sorting],
    () => fetchProducts({ filters, sorting }),
    {
      keepPreviousData: true
    }
  );

  useEffect(() => {
    // Sync URL with filters
    setSearchParams({ 
      ...filters, 
      sort: sorting.field,
      order: sorting.direction 
    });
  }, [filters, sorting]);

  return (
    <ShopTemplate>
      <SEO 
        title={`${category} Products | Shop`}
        description={`Browse our ${category} collection`}
      />

      <div className="products-container">
        <FilterSidebar
          filters={filters}
          onFilterChange={(newFilters) => 
            dispatch(setFilters(newFilters))}
        />

        <main>
          <ProductsHeader
            total={data?.total}
            sorting={sorting}
            onSortChange={(newSort) => 
              dispatch(setSorting(newSort))}
          />

          <ProductGrid
            products={data?.items}
            isLoading={isLoading}
          />

          <Pagination
            total={data?.total}
            current={filters.page}
            onChange={(page) => 
              dispatch(setPage(page))}
          />
        </main>
      </div>
    </ShopTemplate>
  );
}
```

## 3. User Profile Page
```javascript
// pages/Profile/index.jsx
function ProfilePage() {
  const { userId } = useParams();
  const navigate = useNavigate();
  
  // Custom hook for profile management
  const { 
    profile,
    isLoading,
    error,
    updateProfile,
    uploadAvatar
  } = useProfile(userId);

  // Form state management with react-hook-form
  const { register, handleSubmit, formState: { errors } } = useForm({
    defaultValues: profile
  });

  const onSubmit = async (data) => {
    try {
      await updateProfile(data);
      toast.success('Profile updated successfully');
    } catch (error) {
      toast.error('Failed to update profile');
    }
  };

  if (error) return <ErrorTemplate error={error} />;

  return (
    <ProfileTemplate>
      <SEO title={`${profile?.name}'s Profile`} />

      <div className="profile-header">
        <Avatar
          src={profile?.avatar}
          size="xl"
          editable
          onUpload={uploadAvatar}
        />
        <h1>{profile?.name}</h1>
      </div>

      <form onSubmit={handleSubmit(onSubmit)}>
        <ProfileForm 
          register={register}
          errors={errors}
          isLoading={isLoading}
        />
      </form>

      <ProfileTabs userId={userId}>
        <Tab label="Activity">
          <ActivityFeed userId={userId} />
        </Tab>
        <Tab label="Settings">
          <Settings userId={userId} />
        </Tab>
      </ProfileTabs>
    </ProfileTemplate>
  );
}
```

## 4. Authentication Page
```tsx
// pages/Auth/index.jsx
function AuthPage() {
  const location = useLocation();
  const auth = useAuth();
  const [mode, setMode] = useState(
    location.pathname.includes('signup') ? 'signup' : 'login'
  );

  // Form validation with Yup
  const schema = yup.object({
    email: yup.string().email().required(),
    password: yup.string().min(8).required()
  });

  const { handleSubmit, control, errors } = useForm({
    resolver: yupResolver(schema)
  });

  const onSubmit = async (data) => {
    try {
      if (mode === 'login') {
        await auth.login(data);
      } else {
        await auth.signup(data);
      }
    } catch (error) {
      toast.error(error.message);
    }
  };

  return (
    <AuthTemplate>
      <SEO title={`${mode === 'login' ? 'Login' : 'Sign Up'} | MyApp`} />

      <AuthForm
        mode={mode}
        onModeChange={setMode}
        onSubmit={handleSubmit(onSubmit)}
        control={control}
        errors={errors}
      />

      <SocialAuth />
      
      <AuthFooter mode={mode} />
    </AuthTemplate>
  );
}
```

## Best Practices

### Data Fetching Pattern
```javascript
// Custom hook for data fetching
function usePageData(pageId) {
  const queryClient = useQueryClient();

  const { data, isLoading } = useQuery(
    ['page', pageId],
    () => fetchPageData(pageId),
    {
      staleTime: 60000,
      cacheTime: 300000,
      retry: 3,
      onError: (error) => {
        toast.error(`Failed to load page: ${error.message}`);
      }
    }
  );

  const prefetchRelatedData = useCallback(() => {
    queryClient.prefetchQuery(
      ['related', pageId],
      () => fetchRelatedData(pageId)
    );
  }, [pageId, queryClient]);

  return {
    data,
    isLoading,
    prefetchRelatedData
  };
}
```

### SEO Management
```javascript
// SEO component for pages
function SEO({ title, description, image }) {
  return (
    <Head>
      <title>{title}</title>
      <meta name="description" content={description} />
      <meta property="og:title" content={title} />
      <meta property="og:description" content={description} />
      {image && <meta property="og:image" content={image} />}
    </Head>
  );
}
```

Remember:
* Implement proper error boundaries
* Handle loading states
* Manage SEO
* Implement analytics
* Handle permissions/authentication
* Optimize performance
* Implement proper routing
* Handle form validation
* Manage side effects
* Cache data appropriately
* Handle offline functionality
* Implement proper error handling​​​​​​​​​​​​​​​​