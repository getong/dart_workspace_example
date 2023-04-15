// import 'package:stream_example/stream_example.dart' as stream_example;

// void main(List<String> arguments) {
//   print('Hello world: ${stream_example.calculate()}!');
// }

Stream<int> countStream(int count) async* {
  for (int i = 1; i <= count; i++) {
    yield i;
    await Future.delayed(Duration(seconds: 1));
  }
}

void main() async {
  await for (int value in countStream(5)) {
    print(value);
  }
}