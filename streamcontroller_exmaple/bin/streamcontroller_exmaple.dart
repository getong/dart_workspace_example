import 'dart:async';
import 'package:streamcontroller_exmaple/streamcontroller_exmaple.dart'
    as streamcontroller_exmaple;

void main(List<String> arguments) async {
  print('StreamController Example\n');

  // Create a StreamController
  final controller = StreamController<String>();

  // Listen to the stream
  final subscription = controller.stream.listen(
    (data) => print('Received: $data'),
    onError: (error) => print('Error: $error'),
    onDone: () => print('Stream closed'),
  );

  // Add data to the stream
  controller.add('Hello');
  controller.add('World');
  controller.add('StreamController');

  // Wait a bit for async operations
  await Future.delayed(Duration(milliseconds: 100));

  // Close the stream
  await controller.close();

  // Cancel subscription
  await subscription.cancel();

  print('\nLibrary example:');
  await streamcontroller_exmaple.runStreamExample();

  print('\nBroadcast StreamController example:');
  await runBroadcastExample();
}

/// Demonstrates broadcast StreamController with multiple listeners
Future<void> runBroadcastExample() async {
  // Create a broadcast StreamController
  final broadcastController = StreamController<int>.broadcast();

  // Add multiple listeners
  final subscription1 = broadcastController.stream.listen(
    (data) => print('Listener 1 received: $data'),
  );

  final subscription2 = broadcastController.stream.listen(
    (data) => print('Listener 2 received: $data'),
  );

  final subscription3 = broadcastController.stream.listen(
    (data) => print('Listener 3 received: $data'),
  );

  // Send data to all listeners
  print('Broadcasting data...');
  broadcastController.add(10);
  broadcastController.add(20);
  broadcastController.add(30);

  await Future.delayed(Duration(milliseconds: 100));

  // Remove one listener
  print('\nRemoving listener 2...');
  await subscription2.cancel();

  broadcastController.add(40);

  await Future.delayed(Duration(milliseconds: 100));

  // Cleanup
  await broadcastController.close();
  await subscription1.cancel();
  await subscription3.cancel();

  print('Broadcast example completed');
}
