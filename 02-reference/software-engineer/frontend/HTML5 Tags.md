---
description: HTML (HyperText Markup Language) is the standard markup language for creating web pages and defining their structure and content.
tags: #html #semantic-html #frontend #markup #web-standards
---

>Semantic HTML refers to the use of HTML markup to reinforce the meaning of web content, rather than merely defining its appearance. It involves using HTML elements that clearly describe their purpose and content. Semantic HTML improves [[Accessibility]], SEO, and code readability. Key elements include `<header>`, `<nav>`, `<main>`, `<article>`, `<section>`, `<aside>`, and `<footer>`. It also encompasses using appropriate heading levels (`<h1>` to `<h6>`), lists (`<ul>`, `<ol>`,`<li>`), and data tables (`<table>`, `<th>`, `<td>`). Semantic HTML helps screen readers interpret page content, enables better browser rendering, and provides clearer structure for developers. By using semantically correct elements, developers create more meaningful, accessible, and maintainable web documents that are easier for both humans and machines to understand and process.

## Header

The `<header>` tag is used to mark up the top section of a web page, which typically includes the main title or logo, navigation links, and other elements that are common to every page on the site. By using the `<header>` tag, you can create a clear separation between the header and the main content of your page, making it easier for users to understand and navigate your website.

```html
<!-- Non-semantic header -->
<div class="header">
  <h1>My Site</h1>
  <nav>
    <a href="#">Home</a>
    <a href="#">About</a>
    <a href="#">Contact</a>
  </nav>
</div>

<!-- Semantic header -->
<header>
  <h1>My Site</h1>
  <nav>
    <ul>
      <li><a href="#">Home</a></li>
      <li><a href="#">About</a></li>
      <li><a href="#">Contact</a></li>
    </ul>
  </nav>
</header>
```

## Navigation

The `<nav>` tag is used to mark up a section of a web page that contains navigation links. By using the `<nav>` tag, you can indicate to both users and search engines that this section of your website is specifically designed for navigation.

```html
<!-- Non-semantic navigation -->
<div class="navigation">
  <a href="#">Home</a>
  <a href="#">About</a>
  <a href="#">Contact</a>
</div>

<!-- Semantic navigation -->
<nav>
  <ul>
    <li><a href="#">Home</a></li>
    <li><a href="#">About</a></li>
    <li><a href="#">Contact</a></li>
  </ul>
</nav>
```

## Main

The `<main>` tag is used to mark up the main content area of a web page. By using the `<main>` tag, you can make it clear to both users and search engines which part of your page contains the main content.

```html
<!-- Non-semantic main content -->
<div class="main-content">
  <h2>About Us</h2>
  <p>Welcome to our website. We are a company that specializes in widgets.</p>
</div>

<!-- Semantic main content -->
<main>
  <h2>About Us</h2>
  <p>Welcome to our website. We are a company that specializes in widgets.</p>
</main>
```

## Article

The `<article>` tag is used to represent a standalone piece of content, such as a blog post, news article, or product review. The content within the `<article>` tag should be self-contained and meaningful, and can include headings, paragraphs, images, and other types of content.

```html
<!-- Non-semantic article -->
<div class="article">
  <h2>How to Make a Widget</h2>
  <p>Widgets are great. Here's how to make one.</p>
</div>

<!-- Semantic article -->
<article>
  <h2>How to Make a Widget</h2>
  <p>Widgets are great. Here's how to make one.</p>
</article>
```

## Aside

The `<aside>` tag is used to mark up content that is related to the main content on a web page but is not an integral part of it. This might include things like supplementary information, advertisements, or related articles.

```html
<div>
  <article>
    <h2>Article Title</h2>
    <p>Article content goes here</p>
  </article>
  <aside>
    <h3>Related Articles</h3>
    <ul>
      <li><a href="#">Article 1</a></li>
      <li><a href="#">Article 2</a></li>
      <li><a href="#">Article 3</a></li>
    </ul>
  </aside>
</div>
```

## Section

The `<section>` tag is used to mark up sections of a web page that are thematically grouped together. This might include things like chapters or sections of a long article, or different parts of a product page.

```html
<section>
  <h2>Section Title</h2>
  <p>Section content goes here</p>
</section>
```

## Footer

The `<footer>` tag is used to mark up the bottom section of a web page, which might include things like copyright information, contact details, or links to social media profiles.

```html
<!-- Non-semantic footer -->
<div class="footer">
  <p>&copy; 2021 My Site</p>
</div>

<!-- Semantic footer -->
<footer>
  <p>&copy; 2021 My Site</p>
</footer>
```

## Details and Summary

The `<details>` and `<summary>` tags are used to mark up a collapsible section of content. The `<summary>` tag is used to mark up the title of the section, and the `<details>` tag is used to mark up the content itself.

```html
<details>
  <summary>Click to expand</summary>
  <p>Content goes here</p>
</details>
```

## Figure and Figcaption

The `<figure>` and `<figcaption>` tags are used to mark up a self-contained piece of content that is referenced from the main content of a web page. The `<figure>` tag is used to mark up the content itself, and the `<figcaption>` tag is used to mark up a caption or description for the content.

```html
<figure>
  <img src="image.jpg" alt="Image description" />
  <figcaption>Image caption</figcaption>
</figure>
```

## Mark

The `<mark>` tag is used to mark up text that has been highlighted for some reason. This might include things like search results, or text that has been highlighted by a user.

```html
<p>Here is some <mark>highlighted</mark> text.</p>
```

## Time

The `<time>` tag is used to mark up a date or time. By using the `<time>` tag, you can make it easier for search engines and other technologies to understand the meaning of the content on your page.

```html
<p>The event will take place on <time datetime="2021-01-01">January 1st, 2021</time>.</p>
```

## Progress

The `<progress>` tag is used to mark up a progress bar. By using the `<progress>` tag, you can make it easier for users to understand the progress of a task.

```html
<progress value="50" max="100"></progress>
```

## What about `<div>` and `<span>`?

The `<div>` and `<span>` tags are not semantic tags. They are used to mark up generic content areas, and do not convey any specific meaning. You should only use these tags if you have no other option.

## Summary

In this lesson, you learned about semantic HTML tags, and how they can be used to make your web pages more accessible and easier to understand. You also learned about some of the most commonly used semantic tags, including `<header>`, `<nav>`, `<main>`, `<article>`, `<aside>`, `<section>`, `<footer>`, `<details>`, `<summary>`, `<figure>`, `<figcaption>`, `<mark>`, `<time>`, and `<progress>`. I hope you found this lesson helpful. Thanks for reading!