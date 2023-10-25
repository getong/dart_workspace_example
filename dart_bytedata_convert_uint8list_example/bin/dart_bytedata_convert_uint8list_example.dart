// import 'package:dart_bytedata_convert_uint8list_example/dart_bytedata_convert_uint8list_example.dart' as dart_bytedata_convert_uint8list_example;

import 'dart:typed_data';

void bytedata_to_uint8list_example() {
  // Create ByteData
  ByteData byteData = ByteData(4);
  byteData.setInt32(0, 12345); // Setting a 32-bit integer at position 0

  // Convert ByteData to Uint8List
  Uint8List uint8List = Uint8List.view(byteData.buffer);

  print('ByteData: $byteData'); // ByteData: Instance of 'ByteData'
  print('Uint8List: $uint8List'); // Uint8List: [57, 48, 0, 0]
}

void uint8list_to_bytedata_example() {
  // Create Uint8List
  Uint8List uint8List = Uint8List.fromList(
      [57, 48, 0, 0]); // Represents the integer 12345 in little-endian format

  // Convert Uint8List to ByteData
  ByteData byteData = ByteData.sublistView(uint8List);

  int integerValue =
      byteData.getInt32(0); // Reading the 32-bit integer at position 0
  print('Integer Value: $integerValue'); // Integer Value: 12345
}

void main(List<String> arguments) {
  // print('Hello world: ${dart_bytedata_convert_uint8list_example.calculate()}!');
  bytedata_to_uint8list_example();
  uint8list_to_bytedata_example();
}
