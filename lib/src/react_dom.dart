@JS("ReactDOM")
library react.src.react_dom;

import 'dart:html';
import 'package:js/js.dart';
import 'package:react/src/react.dart';

@JS()
external dynamic render(ReactElement element, Element container);
