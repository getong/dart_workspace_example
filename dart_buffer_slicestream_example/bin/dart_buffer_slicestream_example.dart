import 'package:buffer/buffer.dart';
import 'dart:async';
import 'dart:typed_data';
import 'package:test/test.dart';

void main(List<String> arguments) async {
  // print('Hello world: ${dart_buffer_slicestream_example.calculate()}!');
  // Example usage of sliceStream
  Stream<List<int>> sourceStream = Stream.fromIterable([
    [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
  ]);

  final slicedStream = sliceStream(sourceStream, 3);

  slicedStream.listen((data) {
    print("data 1 is ${data}");
  });

  Stream<Uint8List> stream = sliceStream(
      Stream.fromIterable([
        [0, 1, 2],
      ]),
      10);

  stream.listen((data) {
    print("data 2 is ${data}");
  });

  var num = 0;
  final stream3 = sliceStream(
      Stream.fromIterable(List.generate(
        13,
        (i) => List.generate(i + 1, (i) => num++),
      )),
      5);

  // stream3.listen((data) {
  //     print("data 3 is ${data}");
  // });
  final list = await stream3.toList();
  print("the list is ${list}");
}
