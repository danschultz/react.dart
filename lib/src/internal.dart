@JS("React")
library react.src.internal;

import 'dart:html' as html;
import 'package:js/js.dart';
import 'package:react/react.dart';

@JS()
external ReactElement createElement(type, [props, children]);

@JS()
external ReactClass createClass(ClassSpecification specification);

@JS()
external Function createFactory(ReactClass clazz);

@JS()
class Component {
  external Props get props;

  external html.Element getDOMNode();
  external bool isMounted();
  external void setState(nextState);
}

@JS()
class Props {
  external int get propKey__;

  external factory Props({int propKey__});
}

@JS()
class ReactClass {}

@JS()
class ClassSpecification {
  external Function get componentWillMount;
  external Function get componentDidMount;
  external Function get componentWillReceiveProps;
  external Function get shouldComponentUpdate;
  external Function get componentWillUpdate;
  external Function get componentDidUpdate;
  external Function get componentWillUnmount;
  external Function get getInitialState;
  external Function get render;

  external factory ClassSpecification(
      {Function componentWillMount,
      Function componentDidMount,
      Function componentWillReceiveProps,
      Function shouldComponentUpdate,
      Function componentWillUpdate,
      Function componentDidUpdate,
      Function componentWillUnmount,
      Function getInitialState,
      Function render});
}
