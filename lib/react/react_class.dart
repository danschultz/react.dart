part of react;

@Js()
class ReactClass {}

@Js()
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

@Js("createClass")
external ReactClass _createClass(ClassSpecification specification);

@Js("createFactory")
external JsFunction _createFactory(ReactClass clazz);
