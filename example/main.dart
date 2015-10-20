// Copyright (c) 2015, <your name>. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

library react_js.example;

import 'dart:html';
import 'package:react/react.dart' as react;
import 'package:react/react_dom.dart' as react_dom;

main() {
  var output = querySelector("#output");

  var element = app();
  react_dom.render(element, output);
}

var app = react.registerComponent(() => new App());

class App extends react.Component {
  num get _count1 => state["count1"];
  num get _count2 => state["count2"];

  Map getInitialState() => {"count1": 0, "count2": 0};

  react.ReactElement render() {
    return react.div(null, "Hi");
    // return react.div(null, [
    //   counter({
    //     "count": _count1,
    //     "change": (value) {
    //       print("counter1: $value");
    //       setState({"count1": value});
    //     }
    //   }),
    //   counter({
    //     "count": _count2,
    //     "change": (value) => setState({"count2": value})
    //   })
    // ]);
  }
}

var counter = react.registerComponent(() => new Counter());

class Counter extends react.Component {
  num get _count => props["count"];
  Function get _change => props["change"];

  void componentWillMount() {
    print("componentWillMount()");
  }

  void componentDidMount() {
    print("componentDidMount()");
  }

  react.ReactElement render() {
    return react.button({
      "className": "counter",
      "onClick": (event) {
        print("click");
        _change(_count + 1);
      }
    }, "Count: ${_count}");
  }
}
