---
description: Template literals provide multi-line strings, string interpolation with embedded expressions, and tagged templates for custom string processing.
tags: ["multi-line_strings", "string_interpolation", "syntax", "tagged_templates"]
---
**Template literals** are literals delimited with backtick (`` ` ``) characters, allowing for [multi-line strings](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Template_literals#multi-line_strings), [string interpolation](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Template_literals#string_interpolation) with embedded expressions, and special constructs called [tagged templates](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Template_literals#tagged_templates).

Template literals are sometimes informally called _template strings_, because they are used most commonly for [string interpolation](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Template_literals#string_interpolation) (to create strings by doing substitution of placeholders). However, a tagged template literal may not result in a string; it can be used with a custom [tag function](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Template_literals#tagged_templates) to perform whatever operations you want on the different parts of the template literal.

## [Syntax](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Template_literals#syntax)

jsCopy to Clipboard

```
`string text`

`string text line 1
 string text line 2`

`string text ${expression} string text`

tagFunction`string text ${expression} string text`
```