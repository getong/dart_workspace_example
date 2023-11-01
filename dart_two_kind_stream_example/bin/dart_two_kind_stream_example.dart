// import 'package:dart_two_kind_stream_example/dart_two_kind_stream_example.dart' as dart_two_kind_stream_example;

import 'dart:async';

void main(List<String> arguments) {
  print("broadcast stream\n");
  broadcastStreamsTest();
  print("single stream\n");
  singleSubscriptionStreamsTest();
}

void broadcastStreamsTest() {
  //此时返回的是 _AsyncBroadcastStreamController，广播流
  var _streamController = StreamController<int>.broadcast();
  _streamController.stream.listen((event) => print("broadcast stream $event"));
  _streamController.stream.listen((event) => print("broadcast stream $event"));
  _streamController.sink.add(100);
  _streamController.close();
}

void singleSubscriptionStreamsTest() {
  //此时返回的是 _AsyncStreamController，单订阅者流
  var _streamController = StreamController<int>();
  _streamController.stream.listen((event) => print("single stream $event"));
  // _streamController.stream.listen((event) => print("$event"));
  _streamController.sink.add(100);
  _streamController.close();
}

// copy from https://juejin.cn/post/6844904154171703309