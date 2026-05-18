---
description: "General Conventions - Marvin"
tags: ['research', 'marvin', 'new-classrooms']
source: "https://newclassrooms.atlassian.net/wiki/spaces/MARVIN/pages/2261560/General+Conventions"
raw_file: "General Conventions - Marvin.md"
created: 2026-05-17
---

## General Conventions

This page covers our general conventions, guidelines, styles, and various practices for working with GraphQL both from a server and client perspective. It's by no means comprehensive, and we should keep it up to date as we learn and establish new patterns.

## Naming and identifiers

## Type names

Type names should be in UpperCamelCase. This also applies to inputs and enums.

## Attribute names

Attribute names should be in lowerCamelCase.

For Node types, do not include Node in the attribute. Thus `SkillLadderNode.skillBucket` not SkillLadderNode.skillBucketNode.

## Query names

Query names should be in lowerCamelCase and should *not* start with or include a verb—they should just indicate the nature of the fetched data. Thus allActiveSkills not getAllActiveSkills.

If a query has a single, required parameter, call it out in the name, like `skillStatesByStudentId`.

## Mutation names

Mutation names should be in lowerCamelCase and should start with a verb. Verbs may be things like `create`, `delete`, or `upsert`; they may also be less CRUDdy like `deactivate`.

## Enums

Enum types should be in UpperCamelCase. The values in the enum should be in ALL\_CAPS\_SNAKE\_CASE. Apologies for yelling.

## Acronyms and initialisms in CamelCase

We are somewhat strictly following a "first letter capitalized only" rule. Thus Id not ID, Http not HTTP, Us, not US.

## Queries

- All query operations should be named.
- Values should be passed into queries as variables.

## Mutations

Mutations should take a single input and return a single payload. For a mutation `makeFoo`, these should be called `MakeFooInput` and `MakeFooPayload`, respectively.

The mutation payload should return the affected objects.

Mutation operations should be named, and values should be passed in as variables.

## Formatting

Schema documents and queries should be formatted with a two-space indent. We do not currently have any linting tool set up. Feel free to research one and bring it to the team!

Do not use `"""` for single-line comments; use `#`.

## Nullability and lists

All collections are defined in the GraphQL schema as \[<collection\_name>!\]! implying that neither the collection itself will be null nor will it contain null values. For details about this notation, please see [here](https://www.apollographql.com/blog/graphql/basics/using-nullability-in-graphql/#nullability-and-lists "https://www.apollographql.com/blog/graphql/basics/using-nullability-in-graphql/#nullability-and-lists").

This is a rather restrictive but safe choice, for now. However, it implies that the GraphQL service will not raise an error if a collection does not exist; it simply returns an empty list. This is because in GraphQL there’s no way yet to specify that the list can’t be empty therefore an empty list is always considered valid. Read more about our [error handling and nullability here](https://newclassrooms.atlassian.net/wiki/display/MARVIN/Errors#Errors-Nullability "https://newclassrooms.atlassian.net/wiki/display/MARVIN/Errors#Errors-Nullability").
