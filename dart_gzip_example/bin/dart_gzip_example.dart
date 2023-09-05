// import 'package:dart_gzip_example/dart_gzip_example.dart' as dart_gzip_example;

import 'dart:convert';
import 'dart:io';
// import 'dart:core';

void main(List<String> arguments) {
  // print('Hello world: ${dart_gzip_example.calculate()}!');
  String data = '';
  for (int i = 0; i < 100; i++) {
    data += 'Hello world\r\n';
  }

  List<int> original = utf8.encode(data);
  List<int> compressed = gzip.encode(original);
  List<int> decompress = gzip.decode(compressed);
  print('original ${original.length} bytes');
  print('compressed ${compressed.length} bytes');
  print('decompressed ${decompress.length} bytes');

  String decoded = utf8.decode(decompress);
  assert(data == decoded);

  print(decoded);
}
