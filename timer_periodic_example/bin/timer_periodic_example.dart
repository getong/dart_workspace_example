// import 'package:timer_periodic_example/timer_periodic_example.dart' as timer_periodic_example;

// void main(List<String> arguments) {
//   print('Hello world: ${timer_periodic_example.calculate()}!');
// }

import 'dart:async';

void main() async {
    final streamController = StreamController<DateTime>();
    Timer.periodic(Duration(seconds: 1), (timer) {
      streamController.add(DateTime.now());
    });

    streamController.stream.listen((event) {
      print(event);
    });
}