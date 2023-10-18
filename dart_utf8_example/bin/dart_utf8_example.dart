// import 'package:dart_utf8_example/dart_utf8_example.dart' as dart_utf8_example;
import 'dart:typed_data';
import 'dart:convert';

void main(List<String> arguments) {
  // print('Hello world: ${dart_utf8_example.calculate()}!');
  // Convert a string to a `Uint8List`.
  String string = 'Hello, world!';
  List<int> encodedString = utf8.encode(string);
  print('int list : ${encodedString}');

  // Convert a `Uint8List` to a string.
  String decodedString = utf8.decode(encodedString);

  // Print the decoded string.
  print('decodedString: ${decodedString}'); // Prints 'Hello, world!'
  base64_decode_string_example();
}

void base64_decode_string_example() {
  String string = 'Hello, world!';
  print('string.codeUnits: ${string.codeUnits}');
  String encodedString = base64.encode(string.codeUnits);
  print('int list : ${encodedString}');

  List<int> decodedString = base64.decode(encodedString);
  print('decodedString: ${decodedString}');
}
