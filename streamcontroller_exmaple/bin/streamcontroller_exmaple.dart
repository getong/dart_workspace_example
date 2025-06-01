import 'dart:async';
import 'package:streamcontroller_exmaple/streamcontroller_exmaple.dart' as streamcontroller_exmaple;

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
}
