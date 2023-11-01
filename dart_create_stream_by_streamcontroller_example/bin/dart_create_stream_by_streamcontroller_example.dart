// import 'package:dart_create_stream_by_streamcontroller_example/dart_create_stream_by_streamcontroller_example.dart' as dart_create_stream_by_streamcontroller_example;

import 'dart:async';

void _onData(int event) => print("$event");

void _onDone() => print("onDone");

void main(List<String> arguments) {
  // print('Hello world: ${dart_create_stream_by_streamcontroller_example.calculate()}!');
  var controller = StreamController<int>();
  controller.stream.listen(_onData, onDone: _onDone);
  controller.add(1);
  controller.add(2);
  controller.add(3);
  controller.close();
}

// copy from https://juejin.cn/post/6844904154171703309
