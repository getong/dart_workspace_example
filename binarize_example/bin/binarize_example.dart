// import 'package:binarize_example/binarize_example.dart' as binarize_example;

import 'package:binarize/binarize.dart';

void main(List<String> arguments) {
  // print('Hello world: ${binarize_example.calculate()}!');
  final writer = Payload.write()
    ..set(uint8, 16)
    ..set(string32, 'Hello World');
  print("writer: ${writer}");
  final bytes = binarize(writer);
  print("bytes: ${bytes}");

  final reader = Payload.read(bytes);

  final aUint8 = reader.get(uint8);
  final aString = reader.get(string32);

  print("aUint8: ${aUint8}");
  print("aString: ${aString}");
}
