// import 'package:dart_stream_receving_stream_by_await_for_example/dart_stream_receving_stream_by_await_for_example.dart' as dart_stream_receving_stream_by_await_for_example;

import 'dart:async';

//生成一个Stream<int>
Stream<int> countStream(int to) async* {
  for (int i = 1; i < to; i++) yield i;
}

//求和(迭代处理Stream事件),因为Stream是异步的，所以返回一个Future<int>
Future<int> sumStream(Stream<int> stream) async {
  var sum = 0;
  await for (var value in stream) {
    print("$value");
    sum += value;
  }
  return sum;
}

void main(List<String> arguments) async {
  // print('Hello world: ${dart_stream_receving_stream_by_await_for_example.calculate()}!');
  //使用await，sumStream执行完，才会执行接下来的print
  var sum = await sumStream(countStream(5));
  print("sum:$sum");
}

// copy from https://juejin.cn/post/6844904154171703309