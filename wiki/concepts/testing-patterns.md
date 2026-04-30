---
description: Patterns and practices for testing frontend applications including unit, integration, and E2E testing
tags: [testing, patterns, frontend, quality, concept]
created: 2026-04-09
updated: 2026-04-09
---

# Testing Patterns

Patterns and practices for ensuring code quality through automated testing.

## Test Types

### Unit Testing
- Tests individual functions/components in isolation
- Fast execution
- High coverage of edge cases

### Integration Testing
- Tests component interactions
- Validates data flow between modules
- API integration tests

### E2E Testing
- Tests complete user workflows
- Validates real browser behavior
- Critical path coverage

## Tools

| Type | Tools |
|------|-------|
| Unit | Jest, Vitest, Mocha |
| Component | React Testing Library, Storybook |
| E2E | Playwright, Cypress, Selenium |

## Best Practices

1. Test behavior, not implementation
2. Use realistic test data
3. Keep tests independent
4. Follow AAA pattern (Arrange, Act, Assert)
5. Maintain test pyramid balance

## Test Types in Detail

| Type | Description | Page |
|------|-------------|------|
| Unit testing | Individual functions/components in isolation | [[e2e-testing]] |
| Integration testing | Component interactions and data flow | [[component-testing]] |
| E2E testing | Complete user workflows in real browser | [[playwright-testing]] |
| Component testing | React Testing Library, user-centric testing | [[component-testing]] |
| Visual testing | Screenshot comparison for UI regressions | [[component-testing]] |
| Snapshot testing | Serialized output comparison | [[component-testing]] |
| Smoke testing | Basic health checks post-deploy | [[e2e-testing]] |
| Property testing | Generative testing with random inputs | [[testing-conversations]] |

## AI-Assisted Testing

- [[prompts-for-ai-unit-test-generation]] — Prompt templates for AI-generated unit tests covering error states and edge cases
- [[workflows]] — Bug-catching prompts ("Write 20 unit tests designed to break this function")

## Related

- [[playwright]]
- [[react-patterns]]
- [[tdd-python-guide]]
- [[clean-code-javascript]]
- [[frontend-system-design-index]]
