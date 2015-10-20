@Js("ReactDOM")
library react_js.react_dom;

import 'dart:html';
import 'package:js/js.dart';
import 'package:react/react.dart';

@Js()
external dynamic render(ReactElement element, Element container);
