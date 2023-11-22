// import 'package:dart_stream_take_example/dart_stream_take_example.dart' as dart_stream_take_example;
import 'dart:async';

void main(List<String> arguments) {
  // print('Hello world: ${dart_stream_take_example.calculate()}!');
  // Create a stream of integers from 1 to 10
  Stream<int> originalStream = Stream<int>.fromIterable(List.generate(10, (index) => index + 1));

  // Use take to create a new stream with the first 5 items
  Stream<int> takenStream = originalStream.take(5);

  Stream<int> originalStream2 = originalStream.skip(5);

  // Listen to the original and taken streams
  originalStream2.listen((int data) {
      print('Original Stream2: $data');
  });

  takenStream.listen((int data) {
      print('Taken Stream: $data');
  });


  // Listen to the original and taken streams
  originalStream.listen((int data) {
      print('Original Stream: $data');
  });
}
