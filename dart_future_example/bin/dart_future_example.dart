// import 'package:dart_future_example/dart_future_example.dart' as dart_future_example;
import 'dart:io';
import 'dart:async';

void main(List<String> arguments) {
  // print('Hello world: ${dart_future_example.calculate()}!');

  String path = Directory.current.path + "/test.txt";
  print('Appending to ${path}');

  File file = File(path);
  Future<RandomAccessFile> f = file.open(mode: FileMode.append);

  f.then((RandomAccessFile raf) {
    print('File has been opened!');

    raf
        .writeString('Hello World')
        .then((value) {
          print('file has been appended!');
        })
        .catchError(() => print('An error occured'))
        .whenComplete(() => raf.close());
  });

  print('**** The end');
}
