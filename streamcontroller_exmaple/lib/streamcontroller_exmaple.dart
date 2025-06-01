import 'dart:async';

void main() {
  runStreamExample();
}

Future<void> runStreamExample() async {
  final numberController = StreamController<int>();

  // Transform the stream
  final doubledStream = numberController.stream.map((n) => n * 2);

  // Listen to the transformed stream
  final subscription = doubledStream.listen(
    (doubled) => print('Doubled: $doubled'),
  );

  // Add numbers
  for (int i = 1; i <= 5; i++) {
    numberController.add(i);
    await Future.delayed(Duration(milliseconds: 50));
  }

  await numberController.close();
  await subscription.cancel();
}

StreamController<T> createController<T>() {
  return StreamController<T>();
}

Stream<T> createPeriodicStream<T>(Duration period, T Function() generator) {
  late StreamController<T> controller;
  Timer? timer;

  controller = StreamController<T>(
    onListen: () {
      timer = Timer.periodic(period, (_) {
        controller.add(generator());
      });
    },
    onCancel: () {
      timer?.cancel();
    },
  );

  return controller.stream;
}
