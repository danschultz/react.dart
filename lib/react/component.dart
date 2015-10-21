part of react;

abstract class Component {
  Map _props;
  Map get props => _props;

  Map _state;
  Map get state => _state;

  bool get isMounted => _internalComponent.isMounted() ?? false;

  Map _nextState;
  Map _prevState;

  void componentWillMount() {

  }

  void componentDidMount() {

  }

  void componentWillReceiveProps(Map nextProps) {

  }

  void componentWillUpdate(Map nextProps, Map nextState) {

  }

  void componentDidUpdate(Map prevProps, Map prevState) {

  }

  void componentWillUnmount() {

  }

  bool shouldComponentUpdate(Map nextProps, Map nextState) => true;

  Map getInitialState() => {};

  Map getDefaultProps() => {};

  html.Element getDomNode() => _internalComponent.getDOMNode();

  ReactElement render();

  void setState(Map nextState) {
    _prevState = state;
    _nextState = new Map.from(state)..addAll(nextState);
    _internalComponent.setState({});
  }

  // Internal stuff..
  internal.Component _internalComponent;
  void _initialize(internal.Component internalComponent, Map props) {
    _internalComponent = internalComponent;
    _state = getInitialState();
    _props = new Map.from(getDefaultProps())..addAll(props);
  }
}
