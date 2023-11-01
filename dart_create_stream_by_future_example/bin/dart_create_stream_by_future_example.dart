// import 'package:dart_create_stream_by_future_example/dart_create_stream_by_future_example.dart' as dart_create_stream_by_future_example;

import 'dart:async';

//创建一个Future,延迟毫秒数，返回整数i
Future<int> createFuture(int delayMilliseconds, int i) {
  return Future.delayed(Duration(milliseconds: delayMilliseconds))
      .then((value) => i);
}

Stream<T> streamFromFutures<T>(Iterable<Future<T>> futures) async* {
  for (var future in futures) {
    //请求future 并返回future的结果给Stream
    var result = await future;
    yield result;
  }
}

void _onData(int event) => print("$event");

void _onDone() => print("onDone");

void main(List<String> arguments) {
  // print('Hello world: ${dart_create_stream_by_future_example.calculate()}!');

  List<int> values = [0, 1, 2, 3, 4];
  List<Future<int>> futures =
      values.map((i) => createFuture(i * 200, i)).toList();
  Stream<int> stream = streamFromFutures(futures);
  stream.listen(_onData, onDone: _onDone);
}

// copy from https://juejin.cn/post/6844904154171703309