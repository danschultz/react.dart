part of react;

@Js()
class ReactElement {}

@Js()
class Props {
  external bool get disabled;
  external String get className;
  external Function get onClick;

  external factory Props({String className, bool disabled, Function onClick});
}

Props _props({String className, bool disabled, void onClick(EventHandler<SyntheticMouseEvent> event)}) {
  return new Props(className: className, disabled: disabled, onClick: _wrapEventHandler(onClick));
}

ReactElement createElement(type, [Map props, children]) {
  var interopProps = new Props();
  if (props != null) {
    interopProps = _props(className: props["className"], onClick: props["onClick"]);
  }
  return _internalCreateElement(type, interopProps, children);
}

@Js("createElement")
external ReactElement _internalCreateElement(type, [props, children]);
