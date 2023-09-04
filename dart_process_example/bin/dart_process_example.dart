import 'package:dart_process_example/dart_process_example.dart' as dart_process_example;

import 'dart:io';

void main(List<String> arguments) {
  // print('Hello world: ${dart_process_example.calculate()}!');
  Process.run('ls', ['-l']).then((ProcessResult results){
      print(results.stdout);
      print('Exit code: ${results.exitCode}');
  });
}
