// import 'package:dart_streamsplitter_example/dart_streamsplitter_example.dart' as dart_streamsplitter_example;
import 'dart:async';
import 'package:async/async.dart';

void main(List<String> arguments) {
  // Create a single source stream
  StreamController<int> sourceStreamController = StreamController<int>();
  Stream<int> sourceStream = sourceStreamController.stream;

  // Create a StreamSplitter
  StreamSplitter<int> splitter = StreamSplitter<int>(sourceStream);

  // Create multiple independent streams from the splitter
  Stream<int> stream1 = splitter.split();
  Stream<int> stream2 = splitter.split();

  // Add listeners to the independent streams
  stream1.listen((int data) {
      print('Stream 1: $data');
  });

  stream2.listen((int data) {
      print('Stream 2: $data');
  });

  // Add data to the source stream
  for (int i = 1; i <= 5; i++) {
    sourceStreamController.add(i);
  }

  // Close the source stream controller to signal the end of the stream
  sourceStreamController.close();

}
