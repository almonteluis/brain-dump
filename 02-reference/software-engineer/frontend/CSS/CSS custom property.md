---
description: CSS (Cascading Style Sheets) is the styling as language for the web, controlling layout, colors, fonts, and responsive designsba[[]]
tags: ["0000ff", "16f", "290", "container", "css", "declaration-value", "example", "ff7", "firstParagraph", "html", "result", "secondParagraph", "syntax", "thirdParagraph"]

---

Property names that are prefixed with `--`, like `--example-name`, represent _custom properties_ that contain a value that can be used in other declarations using the [`var()`](https://developer.mozilla.org/en-US/docs/Web/CSS/var) function.

Custom properties are scoped to the element(s) they are declared on, and participate in the cascade: the value of such a custom property is that from the declaration decided by the cascading algorithm.

## [Syntax](https://developer.mozilla.org/en-US/docs/Web/CSS/--*#syntax)


``` css
--some-keyword: left;
--some-color: #0000ff;
--some-complex-value: 3px 6px rgb(20 32 54);
```

[`<declaration-value>`](https://developer.mozilla.org/en-US/docs/Web/CSS/--*#declaration-value)

This value matches any sequence of one or more tokens, so long as the sequence does not contain any disallowed token. It represents the entirety of what a valid declaration can have as its value.

**Note:** Custom property names are case sensitive — `--my-color` will be treated as a separate custom property to `--My-color`.

## [Example](https://developer.mozilla.org/en-US/docs/Web/CSS/--*#example)

### [HTML](https://developer.mozilla.org/en-US/docs/Web/CSS/--*#html)

``` html
<p id="firstParagraph">
  This paragraph should have a blue background and yellow text.
</p>
<p id="secondParagraph">
  This paragraph should have a yellow background and blue text.
</p>
<div id="container">
  <p id="thirdParagraph">
    This paragraph should have a green background and yellow text.
  </p>
</div>
```

### [CSS](https://developer.mozilla.org/en-US/docs/Web/CSS/--*#css)


``` css
:root {
  --first-color: #16f;
  --second-color: #ff7;
}

#firstParagraph {
  background-color: var(--first-color);
  color: var(--second-color);
}

#secondParagraph {
  background-color: var(--second-color);
  color: var(--first-color);
}

#container {
  --first-color: #290;
}

#thirdParagraph {
  background-color: var(--first-color);
  color: var(--second-color);
}
```

### [Result](https://developer.mozilla.org/en-US/docs/Web/CSS/--*#result)