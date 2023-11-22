// import 'package:dart_string_convert_bytedata_example/dart_string_convert_bytedata_example.dart' as dart_string_convert_bytedata_example;

import 'dart:convert';

import 'dart:typed_data';

List<int> stringLengthToBytes(String input) {
  // Encode the string to UTF-8
  List<int> encodedString = utf8.encode(input);

  // Get the length of the encoded string
  int length = encodedString.length;

  // Convert the length to a list of bytes
  ByteData byteData = ByteData(4);
  byteData.setInt32(0, length);

  // Return the list of bytes
  final list = byteData.buffer.asUint8List().toList();
  list.addAll(input.codeUnits);
  return list;
}

void main(List<String> arguments) {
  // print('Hello world: ${dart_string_convert_bytedata_example.calculate()}!');
  // Create a string
  String myString = "Hello, World!";

  // Convert the string length to a list of bytes
  List<int> lengthBytes = stringLengthToBytes(myString);

  // Print the result
  print('String: $myString');
  print('String Length in Bytes: $lengthBytes');
}
