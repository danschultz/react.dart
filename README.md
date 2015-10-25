# react.dart

Experimental React JS bindings for Dart. These bindings use the new `@JS` metadata that's coming in Dart 1.13.

## Usage

This package requires at least Dart 1.13.0-dev.7.3. If you use Brew, you can easily install developer releases by running:

```
brew install dart --devel --with-dartium --with-content-shell
brew linkapps dart
```

Later, you can use `brew switch` to revert back to using a stable version of Dart:

```
brew switch dart 1.12.1
brew linkapps dart
```

Once you have a developer release of Dart installed, add a Git dependency to your `pubspec.yaml`.

```yaml
name: my_app
dependencies:
  browser: any
  react:
    git: https://github.com/danschultz/react.dart.git
```

Include `packages/react/react.js` in your HTML.

```html
<html>
  <head>
    <script async src="packages/react/react.js"></script>
    <script async type="application/dart" src="main.dart"></script>
    <script async src="packages/browser/dart.js"></script>
  </head>
  <body>
    <div id="app">Your React app's content</div>
  </body>
</html>
```

Mount a React component in your Dart app. Usage is similar to the [react-dart] package.

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

## Examples

Check out the [example] folder to see working examples.

To run the examples:

* Run `pub serve example` from the project's directory.
* Open `http://localhost:8080` from your web browser.

## Vision

* Improved performance. The [react-dart] package suffers from slower performance than React JS, because it uses Dart's older JS interop APIs. See https://github.com/cleandart/react-dart/issues/49.
* Typed components and APIs. Many of [react-dart]'s public APIs don't include any type annotations, and use maps for representing component props and state. It would be better if you could specify a property type and state type for your components, i.e. `Counter extends react.Component<CounterProps, CounterState>`.

## Limitations

* This package doesn't yet support server-side Dart apps.
* Some of the Component API methods haven't been implemented yet: `replaceState`, `forceUpdate`, `replaceProps`.

[example]: https://github.com/danschultz/react.dart/tree/master/example
[react-dart]: https://github.com/cleandart/react-dart/
