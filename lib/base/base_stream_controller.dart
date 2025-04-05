import 'dart:async';

class BaseStreamController<T> {
  late StreamController<T> controller;
  late T _value;

  final void Function()? onListen;
  final void Function()? onCancel;
  final bool sync;

  T get value => _value;
  Stream<T> get stream => controller.stream;

  BaseStreamController(T initialValue,
      {this.onListen,
      this.onCancel,
      this.sync = false,
      bool isSingle = false}) {
    if (isSingle) {
      controller = StreamController<T>(
          onListen: onListen, onCancel: onCancel, sync: sync);
    } else {
      controller = StreamController<T>.broadcast(
          onListen: onListen, onCancel: onCancel, sync: sync);
    }

    _value = initialValue;
  }

  set value(T newVal) {
    if (controller.isClosed) return;
    _value = newVal;
    controller.sink.add(newVal);
  }

  StreamSubscription<T> listen(Function(T) listener) {
    if (controller.isClosed) {
      throw Exception('StreamController is closed');
    }
    return controller.stream.listen(listener);
  }

  dispose() {
    controller.close();
  }
}
