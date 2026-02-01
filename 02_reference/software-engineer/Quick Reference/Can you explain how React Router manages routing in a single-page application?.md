---
description: React Router enables client-side routing using the History API for URL manipulation, nested routes, dynamic parameters, and navigation hooks.
tags: ["interview", "react", "react-router", "routing", "spa"]
---

# React Router in SPAs

## Overview

#react #routing #react-router #spa #interview

> React Router enables client-side routing in React applications, allowing navigation between different components without page refreshes. It uses the browser's History API to manipulate the URL and render different components based on the current path.

#### Code Example:
```javascript
import { 
  BrowserRouter, 
  Routes, 
  Route, 
  Link, 
  useParams, 
  useNavigate 
} from 'react-router-dom';

// Basic Router Setup
function App() {
  return (
    <BrowserRouter>
      <nav>
        <Link to="/">Home</Link>
        <Link to="/about">About</Link>
        <Link to="/users">Users</Link>
      </nav>

      <Routes>
        <Route path="/" element={<Home />} />
        <Route path="/about" element={<About />} />
        <Route path="/users" element={<Users />}>
          <Route path=":id" element={<UserProfile />} />
        </Route>
        <Route path="*" element={<NotFound />} />
      </Routes>
    </BrowserRouter>
  );
}

// Component with Navigation and Parameters
function UserProfile() {
  const { id } = useParams();
  const navigate = useNavigate();

  return (
    <div>
      <h2>User Profile: {id}</h2>
      <button onClick={() => navigate('/users')}>
        Back to Users
      </button>
    </div>
  );
}

// Protected Route Example
function PrivateRoute({ children }) {
  const auth = useAuth(); // Custom hook for auth state
  
  return auth ? children : <Navigate to="/login" />;
}
```

#### Key Points:
* Uses HTML5 History API for client-side routing
* Supports nested routes and dynamic parameters
* Provides hooks for navigation and route info
* Can handle protected routes and redirects

#### References:
* [React Router Official Documentation](https://reactrouter.com/)
* [React Router GitHub Repository](https://github.com/remix-run/react-router)
* [React Router Tutorial by React Training](https://reactrouter.com/docs/en/v6/getting-started/tutorial)
* Modern React with Redux [2023 Update] by Stephen Grider
* [React Router Hooks Documentation](https://reactrouter.com/docs/en/v6/hooks/use-navigate)​​​​​​​​​​​​​​​​