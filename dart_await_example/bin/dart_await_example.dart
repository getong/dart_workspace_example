// import 'package:dart_await_example/dart_await_example.dart' as dart_await_example;
import 'dart:io';
import 'dart:async';

Future<void> main(List<String> arguments) async {
  // print('Hello world: ${dart_await_example.calculate()}!');

  print('Starting');

  File file = await appendFile();

  print('Appended to file ${file.path}');

  print('*** End');

  print('another example');
  countSeconds(4);
  await printOrderMessage();
}

Future<File> appendFile() {
  File file = File(Directory.current.path + '/test.txt');
  DateTime now = DateTime.now();
  return file.writeAsString(now.toString() + '\r\n', mode: FileMode.append);
}

// ------------- begin of another example --------------------
Future<void> printOrderMessage() async {
  print('Awaiting user order...');
  var order = await fetchUserOrder();
  print('Your order is: $order');
}

Future<String> fetchUserOrder() {
  // Imagine that this function is more complex and slow.
  return Future.delayed(const Duration(seconds: 4), () => 'Large Latte');
}

// You can ignore this function - it's here to visualize delay time in this example.
void countSeconds(int s) {
  for (var i = 1; i <= s; i++) {
    Future.delayed(Duration(seconds: i), () => print(i));
  }
}
// ------------- end of another example --------------------
// copy from https://dart.dev/codelabs/async-await
