// import 'package:communication_process_example/communication_process_example.dart' as communication_process_example;

import 'dart:io';
import 'dart:convert';

void main(List<String> arguments) {
  // print('Hello world: ${communication_process_example.calculate()}!');

  Process.start('cat', []).then((Process process) {
    // transform the output
    process.stdout.transform(utf8.decoder).listen((data) {
      print(data);
    });

    // send to the process
    process.stdin.writeln('hello world');

    // stop the process
    Process.killPid(process.pid);

    // get the exit code
    process.exitCode.then((int code) {
      print('Exit code: ${code}');

      // exit
      exit(0);
    });
  });
}
