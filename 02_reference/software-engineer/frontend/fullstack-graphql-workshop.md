# Fullstack GraphQL Workshop

## Overview

This workshop introduces GraphQL and major concepts behind it. You'll learn how to build a GraphQL server with ASP.NET Core 8 and Hot Chocolate. You'll also learn how to query GraphQL and what tools are out there that can help you explore and manage large schemas. Further, you'll dive into React and explore how to efficiently build fast and fluent web interfaces using JavaScript client Relay.

**Technologies covered:**
- .NET 8
- ASP.NET Core 8
- TypeScript
- React
- GraphQL
- Hot Chocolate
- Relay

---

## Day 1 Agenda

### 09:00 Hello, Tech Check

### 09:15 Getting Started with GraphQL

- Introduction
- What Is GraphQL?
- Why Use GraphQL?
- The GraphQL type system explained.
- GraphQL operation syntax.
- Your first GraphQL server.

### 10:00 BREAK (5 min)

### 10:05 Building a Database Driven Application

- How to build APIs on top of EF Core.
- Paging, Filtering, Sorting and Projections
- Field Middleware

### 11:00 BREAK (5 min)

### 11:05 Building APIs with Simple Layering

- Schema building approaches.
- A better approach towards building APIs.
- Paging and Filtering in layered architectures.
- DataLoader

### 12:00 BREAK (60 min)

### 13:00 GraphQL Query Patterns and Best Practices

- Exploration of GraphQL enterprise patterns for building evolvable schemas.
- The GraphQL entity pattern.
- The GraphQL connection pattern

### 14:00 BREAK (5 min)

### 14:05 Getting Started with Relay.js

- Introduction to Relay.js
- Executing Queries
- Using Fragments & Arguments

### 15:00 BREAK (5 min)

### 15:05 Advanced Fetching Patterns

- Transitions
- Refetching
- Pagination

### 16:00 BREAK (5 min)

### 16:05 Understanding Relay

- Relay Store
- Prefetching Data
- Relay Internals

### 17:00 FINISH

---

## Day 2 Agenda

### 09:00 GraphQL Mutations Patterns and Best Practices

- Introduction to GraphQL mutations.
- The GraphQL Mutation pattern.
- Error Patterns in GraphQL mutations

### 10:00 BREAK (5 min)

### 10:05 Mutations In Relay

- Mutate data with Relay
- Errors in Mutations
- Optimistic Updates

### 11:00 BREAK (5 min)

### 11:05 GraphQL Schema Evolution

- Client Registry
- Schema Registry
- Open Telemetry

### 12:00 BREAK (60 min)

### 13:00 Introduction to Distributed GraphQL

### 14:00 BREAK (5 min)

### 15:00 BREAK (5 min)

### 15:05 CQRS, DDD and GraphQL, perfect fit?

### 16:00 BREAK (5 min)

### 16:05 GraphQL Subscriptions Patterns and Best Practices

### 17:00 Q&A

### 17:30

---

## Important Notice

> **Caution:** Code snippets and materials are intended for learning purposes and might contain deliberate omissions. In case of doubt do not hesitate to make questions and check the documentation for further information.

---

## Key Topics Covered

### GraphQL Fundamentals (Day 1 Morning)
- GraphQL type system and operation syntax
- Building GraphQL servers with Hot Chocolate
- Database integration with EF Core
- Paging, filtering, sorting, and projections
- Field middleware
- Schema building approaches
- DataLoader pattern for N+1 query optimization

### Enterprise Patterns (Day 1 Afternoon)
- GraphQL entity pattern
- GraphQL connection pattern
- Relay.js fundamentals
- Query execution and fragments
- Advanced fetching: transitions, refetching, pagination
- Relay store and internals
- Data prefetching

### Advanced Topics (Day 2)
- GraphQL mutations and error patterns
- Relay mutations with optimistic updates
- Schema evolution and registries
- Open Telemetry integration
- Distributed GraphQL
- CQRS and DDD with GraphQL
- GraphQL subscriptions for real-time data

---

## Technology Stack

### Backend
- **.NET 8 / ASP.NET Core 8** - Web framework
- **Hot Chocolate** - GraphQL server for .NET
- **Entity Framework Core** - ORM for database access
- **Open Telemetry** - Observability and monitoring

### Frontend
- **React** - UI library
- **TypeScript** - Type-safe JavaScript
- **Relay** - GraphQL client for React
  - Fragments for data fetching
  - Optimistic updates
  - Pagination and refetching
  - Store management

---

## Patterns Covered

### Server-Side Patterns
1. **GraphQL Entity Pattern** - Standard entity structure in GraphQL
2. **Connection Pattern** - Pagination pattern with edges and nodes
3. **DataLoader** - Batch loading to prevent N+1 queries
4. **Simple Layering** - Organized API architecture
5. **Mutation Pattern** - Consistent mutation structure
6. **Subscription Pattern** - Real-time data updates

### Frontend Patterns (Relay)
1. **Fragments** - Reusable data definitions
2. **Transitions** - Loading states during navigation
3. **Optimistic Updates** - Update UI before server confirms
4. **Pagination** - Efficiently loading large datasets
5. **Refetching** - Updating data after changes
6. **Prefetching** - Loading data before it's needed

### Architecture Patterns
1. **Schema Evolution** - Managing API changes over time
2. **Distributed GraphQL** - Microservices with GraphQL
3. **CQRS** - Command Query Responsibility Segregation
4. **DDD** - Domain-Driven Design integration
