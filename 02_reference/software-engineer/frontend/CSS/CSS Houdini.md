---
description: CSS (Cascading Style Sheets) is the styling language for the web, controlling layout, colors, fonts, and responsive design
tags: ["CSS", "advanced", "api", "syntax"]
---

# CSS Houdini

## Overview

## APIs


> CSS Houdini is a set of APIs that expose parts of the CSS engine. This makes it easier for developers to create extensions for CSS. 

## Basic example

A regular [[CSS custom property]] consists of a property name and a value. Therefore I might create a custom property called `--background-color` and expect it to be given a color value.

```css
:root {
--background-color: blue;
}

.box {
	background-color: var(--background-color);
}
```

In the above example however, there is nothing to stop someone using some other value for this property, perhaps setting it to a length. Having done so, anywhere that the property is used would have no background color as `background-color: 12px` is not valid. When browsers come across CSS they don't recognize as valid they throw that line away.

Using [`@property`](https://developer.mozilla.org/en-US/docs/Web/CSS/@property) however, we can declare the custom property with a [`syntax`](https://developer.mozilla.org/en-US/docs/Web/CSS/@property/syntax) of `<color>`. This shows that we need this property to have a value which is a valid color.

```css
@property --background-color {
  syntax: "<color>";
  inherits: false;
  initial-value: blue;
}
```


**tags:**
#CSS #advanced #syntax #api 