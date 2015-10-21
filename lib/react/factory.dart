part of react;

typedef ReactElement ComponentFactory([Map props, children]);

ComponentFactory registerComponent(Component factory()) {
  // When a component is registered, an internal ClassSpecification is created which
  // contain the component lifecycle callbacks. These callbacks are invoked in JS,
  // then forwarded to their Dart components. A ReactClass and component factory is then
  // created for each registered component using JS interop.
  //
  // The mapping between the JS React component and the Dart React component are stored
  // in `components`. When a lifecycle callback is invoked by JS, a lookup is performed
  // and the equivalent lifecycle callback is invoked on the Dart component.
  //
  // On each render, the new props for the Dart component are temporarily stored in
  // `componentProps`. A copy of the props is created, and a unique key is generated
  // based on the props' hash code. The key is assigned as a prop on the internal React
  // component, which then can be used as a lookup to retrieve the props in the lifecycle
  // callbacks.
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
      componentWillUpdate: allowInteropCaptureThis((jsComponent, jsNextProps, jsNextState, jsPrevContext) {
        var component = components[jsComponent];
        var nextProps = componentProps[jsNextProps["propKey__"]];

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
