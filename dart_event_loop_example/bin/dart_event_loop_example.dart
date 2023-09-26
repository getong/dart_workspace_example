// import 'package:dart_event_loop_example/dart_event_loop_example.dart' as dart_event_loop_example;

import 'dart:async';

void main(List<String> arguments) {
  // print('Hello world: ${dart_event_loop_example.calculate()}!');
  print('into main');
  Timer.run(() {
    scheduleMicrotask(() => print('move microtask 1'));
    print('event 1');
  });
  Timer.run(() => print('event 2'));
  Timer.run(() => print('event 3'));
  scheduleMicrotask(() => print('move microtask 2'));
  scheduleMicrotask(() => print('move microtask 3'));
  print('exit main');
}
