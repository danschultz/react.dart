library react.internal;

import 'package:js/js.dart';

@Js("React.Component")
class Component {
  external Props get props;

  external bool isMounted();
  external void setState(nextState);
}

@Js()
class Props {
  external int get propKey__;

  external factory Props({int propKey__});
}
