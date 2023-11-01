// import 'package:dart_stream_to_future_example/dart_stream_to_future_example.dart' as dart_stream_to_future_example;
import 'dart:async';

//构建Stream
Stream<int> countStream(int to) async* {
  for (int i = 0; i < to; i++) yield i;
}

//构建List
List<int> countList(int to) {
  List<int> list = [];
  for (int i = 0; i < to; i++) list.add(i);
  return list;
}

//我们发现 区别就在于 Stream/Future加了await去执行。
//用同步的方式去写异步。剩下部分，Stream和List是一样的。
void reduce() async {
  Stream<int> stream = countStream(5);
  Future<int> future = stream.reduce((previous, element) => previous + element);
  var futureSum = await future;

  List<int> list = countList(5);
  var listSum = list.reduce((value, element) => value + element);
  print("reduce futureSum:$futureSum  listSum:$listSum");
}

void forEach() async {
  Stream<int> stream = countStream(5);
  StringBuffer streamSb = new StringBuffer();
  await stream.forEach((value) => streamSb.write("$value,"));

  List<int> list = countList(5);
  StringBuffer listSb = new StringBuffer();
  list.forEach((value) => listSb.write("$value,"));
  print("stream forEach:$streamSb  list forEach:$listSb");
}

void main(List<String> arguments) {
  // print('Hello world: ${dart_stream_to_future_example.calculate()}!');
  reduce();
  forEach();
}

// copy from https://juejin.cn/post/6844904154171703309
