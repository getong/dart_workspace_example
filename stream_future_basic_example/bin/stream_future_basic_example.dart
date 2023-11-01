// import 'package:stream_future_basic_example/stream_future_basic_example.dart' as stream_future_basic_example;

Stream<int> countStream(int max) async* {
  for (int i = 0; i < max; i++) {
    yield i;
  }
}


Future<int> sumStream(Stream<int> stream) async {
  int sum = 0;
  await for (int value in stream) {
    sum += value;
  }
  return sum;
}


void main(List<String> arguments) async {
  // print('Hello world: ${stream_future_basic_example.calculate()}!');
  /// Initialize a stream of integers 0-9
  Stream<int> stream = countStream(10);
  /// Compute the sum of the stream of integers
  int sum = await sumStream(stream);
  /// Print the sum
  print(sum); // 45
}
