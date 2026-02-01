---
tags: ["code/C4TwDgpgBAChBOBnA9gOygXigbwFBSgHpCoA9ci-KVAQwFsIAuKRYeAS1QHMBuKmrk2oBXOgCMEfAL59cAM2GoAxsHZooXeBAjAAFJCRpmcQ6gCUOKluDD46AEQAJCABsXyKPagBqKAZSoAHS0DNJAA", "code/GYVwdgxgLglg9mABAcwE4FN1QBQAd2oDOCAXIgN6JgCGAtumYVKjGMgNyLXINUi0AjAogC", "code/JYOwLgpgTgZghgYwgAgArQM4HsTIN4BQyyA9CcRcgHo21HIhwC2EAXMhmFKAOYDc9ODzYMArkwBG0AQF8CBGKJAIwwHMh5QIEMAAoADphzt0UbCACU", "quick-reference", "typescript"]description: Notes on Object Types and key concepts for reference.
---
In JavaScript, the fundamental way that we group and pass around data is through objects. In TypeScript, we represent those through _object types_.

As we’ve seen, they can be anonymous:

`   function greet(person: { name: string; age: number }) {    return "Hello " + person.name;  }   `[Try](https://www.typescriptlang.org/play/#code/GYVwdgxgLglg9mABAcwE4FN1QBQAd2oDOCAXIgN6JgCGAtumYVKjGMgNyLXINUi0AjAogC+ASgoAoRIgD0smYqXLlAPXUbNW7TtXTEGKCFRIARAAl0AGytxEpxAGpE+IggB0Neu0kigA)

or they can be named by using either an interface:

`   interface Person {    name: string;    age: number;  }  function greet(person: Person) {    return "Hello " + person.name;  }   `[Try](https://www.typescriptlang.org/play/#code/JYOwLgpgTgZghgYwgAgArQM4HsTIN4BQyyA9CcRcgHo21HIhwC2EAXMhmFKAOYDc9ODzYMArkwBG0AQF8CBGKJAIwwHMh5QIEMAAoADphzt0UbCACU+elrCiouAEQAJCABs3WZI+QBqZIZmOAB0jCyyQA)

or a type alias:

`   type Person = {    name: string;    age: number;  };  function greet(person: Person) {    return "Hello " + person.name;  }   `[Try](https://www.typescriptlang.org/play/#code/C4TwDgpgBAChBOBnA9gOygXigbwFBSgHpCoA9ci-KVAQwFsIAuKRYeAS1QHMBuKmrk2oBXOgCMEfAL59cAM2GoAxsHZooXeBAjAAFJCRpmcQ6gCUOKluDD46AEQAJCABsXyKPagBqKAZSoAHS0DNJAA)

In all three examples above, we’ve written functions that take objects that contain the property `name` (which must be a `string`) and `age` (which must be a `number`).

## [](https://www.typescriptlang.org/docs/handbook/2/objects.html#quick-reference)
### Tags
#typescript

---
description: React notes and reference about Object Types.

Last Updated: 2025-01-12