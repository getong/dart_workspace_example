import 'dart:async';

void addLessThanFive(StreamController controller, int value) {
  if (value < 5) {
    controller.sink.add(value);
  } else {
    controller.sink.addError(StateError('$value is no less than 5'));
  }
}

void main() {
  final controller = StreamController();

  // controller.sink.add(1);
  // controller.sink.add(2);
  // controller.sink.add(3);
  // controller.sink.add(4);
  // controller.sink.add(5);
  // controller.sink.add(6);
  addLessThanFive(controller, 1);
  addLessThanFive(controller, 2);
  addLessThanFive(controller, 3);
  addLessThanFive(controller, 4);
  addLessThanFive(controller, 5);


  controller.sink.add(10.0);
  controller.sink.add('a string');
  controller.sink.add([10, 13.2, 'another string']);
  controller.sink.add(null);

  controller.close();

  controller.stream.listen((value) {
    print(value);
  }, onError: (error) {
    print(error);
  }, onDone: () {
    print("done");
  });
}
