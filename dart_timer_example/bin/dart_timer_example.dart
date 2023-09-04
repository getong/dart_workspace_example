//import 'package:dart_timer_example/dart_timer_example.dart' as dart_timer_example;
import 'dart:async';
int counter = 0;

void main(List<String> arguments) {
  // print('Hello world: ${dart_timer_example.calculate()}!');
  Duration duration = new Duration(seconds: 1);
  Timer timer = new Timer.periodic(duration, timeout);
  print('Start ${getTime()}');
}


void timeout(Timer timer) {
  print('Timeout: ${getTime()}');

  counter++;
  if(counter >= 5) timer.cancel();
}

String getTime() {
  DateTime dt = new DateTime.now();
  return dt.toString();
}