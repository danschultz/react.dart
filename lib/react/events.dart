part of react;

typedef void EventHandler<E extends SyntheticEvent>(E event);

@JS()
class SyntheticEvent {
  external bool get bubbles;
  external bool get cancelable;
  external html.EventTarget get currentTarget;
  external bool get defaultPrevented;
  external num get eventPhase;
  external bool get isTrusted;
  external html.Event get nativeEvent;
  external html.EventTarget get target;
  external num get timeStamp;
  external String get type;

  external void preventDefault();
  external bool isDefaultPrevented();
  external void stopPropagation();
  external bool isPropagationStopped();
}

@JS()
class SyntheticMouseEvent extends SyntheticEvent {
  external bool get altKey;
  external num get button;
  external num get buttons;
  external num get clientX;
  external num get clientY;
  external bool get ctrlKey;
  external bool get metaKey;
  external num get pageX;
  external num get pageY;
  external html.EventTarget get relatedTarget;
  external num get screenX;
  external num get screenY;
  external bool get shiftKey;

  external bool getModifierState(key);
}

Function _wrapEventHandler(EventHandler handler) {
  return allowInterop((event, id, realEvent) => handler(event));
}
