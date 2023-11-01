// import 'package:streamcontroller_pause_resume_example/streamcontroller_pause_resume_example.dart' as streamcontroller_pause_resume_example;
import 'dart:async';

void main(List<String> arguments) {
  // print('Hello world: ${streamcontroller_pause_resume_example.calculate()}!');
  streamcontroller_pause_resume_example();
}

void streamcontroller_pause_resume_example() {
  var streamController = StreamController<String>();

  // Listener
  var su = streamController.stream.listen((event) {
    print('Received event: ${event}');
  });

  // Adding an event
  streamController.add("a");

  // Pausing the stream
  print('Pausing the stream...');
  su.pause();
  // This won't be received immediately since the stream is paused
  streamController.add("b");

  // Resuming the stream after a delay
  Future.delayed(Duration(seconds: 1), () {
    print('Resuming the stream...');
    su.resume();
    // This will be received since the stream is now resumed
    streamController.add("c");
  });

  // Canceling the subscription after a further delay
  Future.delayed(Duration(seconds: 2), () {
    print('Canceling the subscription...');
    su.cancel();
    // This won't be received since the subscription is canceled
    streamController.add("d");
    streamController.close();
  });
}
