part of react;

@JS()
class ReactElement {}

@JS()
class Props {
  external bool get disabled;
  external String get className;
  external Function get onClick;

  external factory Props({String className, bool disabled, Function onClick});
}

Props _props({String className, bool disabled, void onClick(EventHandler<SyntheticMouseEvent> event)}) {
  return new Props(className: className, disabled: disabled, onClick: _wrapEventHandler(onClick));
}

ReactElement createElement(typeOrClass, [Map props, children]) {
  var interopProps = new Props();
  if (props != null) {
    interopProps = _props(className: props["className"], onClick: props["onClick"]);
  }
  return internal.createElement(typeOrClass, interopProps, children);
}
