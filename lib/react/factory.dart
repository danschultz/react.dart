part of react;

typedef ReactElement ComponentFactory([Map props, children]);

ComponentFactory registerComponent(Component factory()) {
  var components = <internal.Component, Component>{};
  var componentProps = <int, Map>{};

  var spec = new internal.ClassSpecification(
      getInitialState: allowInteropCaptureThis((internal.Component jsComponent) {
        var component = factory();
        var props = componentProps[jsComponent.props.propKey__];
        components[jsComponent] = component;
        component._initialize(jsComponent, props);
        return {};
      }),
      componentWillMount: allowInteropCaptureThis((jsComponent) => components[jsComponent].componentWillMount()),
      componentDidMount: allowInteropCaptureThis((jsComponent) => components[jsComponent].componentDidMount()),
      shouldComponentUpdate: allowInteropCaptureThis((jsComponent, jsNextArgs, jsNextState, jsNextContext) {
        var component = components[jsComponent];
        var nextProps = componentProps[jsNextArgs["propKey__"]];

        if (component.shouldComponentUpdate(nextProps, component._nextState)) {
          return true;
        } else {
          component._props = nextProps;
          component._state = component._nextState;
          return false;
        }
      }),
      componentWillUpdate: allowInteropCaptureThis((jsComponent, jsNextArgs, jsNextState, jsPrevContext) {
        var component = components[jsComponent];
        var nextProps = componentProps[jsNextArgs["propKey__"]];

        component.componentWillUpdate(nextProps, component._nextState);
        component._props = nextProps;
        component._state = component._nextState;
      }),
      componentDidUpdate: allowInteropCaptureThis((jsComponent, jsPrevProps, jsPrevState, jsPrevContext) {
        // Clean up the prop keys
        var prevProps = componentProps.remove(jsPrevProps["propKey__"]);
        var component = components[jsComponent];
        component.componentDidUpdate(prevProps, component._prevState);
      }),
      componentWillUnmount: allowInteropCaptureThis((jsComponent, jsPrevContext) {
        var component = components[jsComponent];
        component.componentWillUnmount();
      }),
      render: allowInteropCaptureThis((jsComponent) {
        // The returned element gets converted to a DartObject when running in JS, and
        // causes React gives up on rendering the component.
        // See: https://github.com/danschultz/react.dart/issues/1
        return components[jsComponent].render();
      }));

  var clazz = internal.createClass(spec);
  var reactFactory = internal.createFactory(clazz);

  return ([Map props, children]) {
    // Copy the props into a new map, so that we can get a unique hash code to be used for
    // mapping the props between Dart and JS interop.
    var copiedProps = new Map.from(props ?? {});
    var propKey = copiedProps.hashCode;
    componentProps[propKey] = copiedProps;

    var jsProps = new internal.Props(propKey__: propKey);
    return reactFactory(jsProps, children);
  };
}
