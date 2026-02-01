---
description: React class component lifecycle includes mounting with constructor and componentDidMount, updating with componentDidUpdate, and unmounting with componentWillUnmount.
tags: ["class-components", "interview", "lifecycle-methods", "react"]
---

# React Class Lifecycle Methods

## Overview

#react #lifecycle-methods #class-components #interview

> React class components follow a lifecycle with mounting, updating, and unmounting phases. Each phase has specific methods that are called in sequence, allowing you to run code at particular times during a component's life. These methods let you control the component's behavior throughout its existence in the DOM.

```javascript
class ExampleComponent extends React.Component {
  constructor(props) {
    super(props);
    this.state = { data: null };
  }

  componentDidMount() {
    // Called after component is mounted to DOM
    fetch('api/data').then(data => this.setState({ data }));
  }

  componentDidUpdate(prevProps, prevState) {
    // Called after component updates
    if (prevProps.id !== this.props.id) {
      this.fetchData(this.props.id);
    }
  }

  componentWillUnmount() {
    // Called before component is removed
    clearInterval(this.interval);
  }

  render() {
    return <div>{this.state.data}</div>;
  }
}
```

#### Key Points:
* Mounting: constructor → render → componentDidMount
* Updating: render → componentDidUpdate
* Unmounting: componentWillUnmount
* Modern React prefers functional components with hooks​​​​​​​​​​​​​​​​