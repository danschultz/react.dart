library react_js.internal;

import 'package:js/js.dart';

@Js("React.Component")
class Component {
  external Map get props;

  external void setState(nextState);
}
