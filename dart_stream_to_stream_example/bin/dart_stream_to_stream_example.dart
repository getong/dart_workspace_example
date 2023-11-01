// import 'package:dart_stream_to_stream_example/dart_stream_to_stream_example.dart' as dart_stream_to_stream_example;

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

void main(List<String> arguments) async {
  // print('Hello world: ${dart_stream_to_stream_example.calculate()}!');
  Stream<int> stream = countStream(5);
  Stream<String> strStream = stream.map((event) => "index($event)");
  StringBuffer streamSb = new StringBuffer();
  await strStream.forEach((value) => streamSb.write("$value,"));

  List<int> list = countList(5);
  StringBuffer listSb = new StringBuffer();
  var strList = list.map((e) => "index($e)").toList();
  strList.forEach((element) => listSb.write("$element,"));
  print("map stream:$streamSb  list:$listSb");
}

// copy from https://juejin.cn/post/6844904154171703309
