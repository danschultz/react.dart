@JS("ReactDOM")
library react_js.react_dom;

import 'dart:html';
import 'package:js/js.dart';
import 'package:react/react.dart';

@JS()
external dynamic render(ReactElement element, Element container);
