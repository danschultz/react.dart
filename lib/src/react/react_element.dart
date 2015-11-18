part of react.src.react;

@JS()
class ReactElement {}

@anonymous
@JS()
class Props {
  external bool get disabled;
  external String get className;
  external Function get onClick;
  external Function get onChange;

  external factory Props({String className, bool disabled, Function onClick,
    Function onChange});
}

Props _props({String className, bool disabled, void onClick(EventHandler<SyntheticMouseEvent> event),
    void onChange(EventHandler<SyntheticEvent> event)}) {
  return new Props(className: className, disabled: disabled, onClick: _wrapEventHandler(onClick),
      onChange: allowInterop(onChange));
}

ReactElement createElement(typeOrClass, [Map props, children]) {
  var interopProps = new Props();
  if (props != null) {
    interopProps = _props(className: props["className"], onClick: props["onClick"],
        onChange: props["onChange"]);
  }
  return internal.createElement(typeOrClass, interopProps, children);
}
