// import 'package:dart_uint8list_example/dart_uint8list_example.dart' as dart_uint8list_example;

// void main(List<String> arguments) {
//   print('Hello world: ${dart_uint8list_example.calculate()}!');
// }
import 'dart:typed_data';

List<Uint8List> splitUint8List(Uint8List data, int chunkSize) {
  List<Uint8List> chunks = [];
  for (int i = 0; i < data.length; i += chunkSize) {
    int end = (i + chunkSize < data.length) ? i + chunkSize : data.length;
    Uint8List chunk = Uint8List.fromList(data.sublist(i, end));
    chunks.add(chunk);
  }
  // Optionally, if you want to merge the chunks back into a single Uint8List:
  // Uint8List mergedData = Uint8List.fromList(chunks.expand((chunk) => chunk).toList());
  return chunks;
}

void main() {
  Uint8List originalData = Uint8List.fromList([1, 2, 3, 4, 5, 6, 7, 8, 9, 10]);
  int chunkSize = 3;
  List<Uint8List> chunks = splitUint8List(originalData, chunkSize);
  for (var chunk in chunks) {
    print(chunk);
  }
}
