// import 'package:rxdart_basic_example/rxdart_basic_example.dart' as rxdart_basic_example;
import 'package:rxdart/rxdart.dart';

void main(List<String> arguments) {
  // print('Hello world: ${rxdart_basic_example.calculate()}!');
  final subject = PublishSubject();

  subject.stream.listen((event) => print("observer1 => $event"));
  subject.add(1);
  subject.add(2);

  subject.stream.listen((event) => print("observer2 => $event"));
  subject.add(3);
  subject.close();

  // 打印输出：
  // flutter: observer1 => 1
  // flutter: observer2 => 3
  // flutter: observer1 => 2
  // flutter: observer1 => 3
}
