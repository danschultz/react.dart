# react.dart

Experimental React JS bindings for Dart. These bindings use the new `@JS` metadata that are coming in Dart 1.13.

## Usage

Usage is similar to the [react-dart] package.

* Sub-class `Component` to create a React component.
* Register the component and create a class factory within React JS.
* Use the returned factory to create new instances of your component.

```dart
import 'dart:html';
import 'package:react/react.dart' as react;

// Create a sub-class of `Component`.
class Counter extends react.Component {
  num get _count => props["count"];

  react.ReactElement render() {
    return react.button({"className": "counter"}, "Count: ${_count}");
  }
}

// Register the component
react.ComponentFactory counter = react.registerComponent(() => new Counter());

// Use the factory to create new instances of a component.
void main() {
  var appElement = querySelector("#app");
  react.render(counter({"count": 1}), appElement);
}
```

## Vision

* Improved performance. The [react-dart] package suffers from slower performance than React JS, because it uses Dart's older JS interop APIs. See https://github.com/cleandart/react-dart/issues/49.
* Typed components and APIs. Many of [react-dart]'s public APIs don't include any type annotations, and use maps for representing component props and state. It would be better if component's supported being able to specify types for their property and state fields, i.e. `Counter extends react.Component<CounterProps, CounterState>`.

## Limitations

* This package doesn't yet support server-side Dart apps.
* Some of the Component API methods haven't been implemented yet: `replaceState`, `forceUpdate`, `replaceProps`.

[react-dart]: https://github.com/cleandart/react-dart/
