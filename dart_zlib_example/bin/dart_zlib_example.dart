// import 'package:dart_zlib_example/dart_zlib_example.dart' as dart_zlib_example;
import 'dart:io';
import 'dart:convert';

void main(List<String> arguments) {
  // print('Hello world: ${dart_zlib_example.calculate()}!');
  int zlib_length = testCompress(zlib);
  int gzip_length = testCompress(gzip);
  print('zlib = ${zlib_length}');
  print('gzip = ${gzip_length}');
}

String generateData() {
  String data = '';
  for (int i = 0; i < 100; i++) {
    data += 'Hello world\r\n';
  }

  return data;
}

int testCompress(var codec) {
  String data = generateData();
  List<int> original = utf8.encode(data);
  List<int> compressed = codec.encode(original);
  List<int> decompress = codec.decode(compressed);

  print('Testing ${codec.toString()}');
  print('original ${original.length} bytes');
  print('compressed ${compressed.length} bytes');
  print('decompressed ${decompress.length} bytes');

  print('');
  String decoded = utf8.decode(decompress);
  assert(data == decoded);

  return compressed.length;
}
