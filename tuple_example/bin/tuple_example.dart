import 'package:tuple_example/tuple_example.dart' as tuple_example;
import 'package:tuple/tuple.dart';

void main(List<String> arguments) {
  // print('Hello world: ${tuple_example.calculate()}!');
  const t = Tuple2<String, int>('a', 10);

  print(t.item1); // prints 'a'
  print(t.item2); // prints '10'


  const t1 = Tuple2<String, int>('a', 10);
  final t2 = t1.withItem1('c');
  // t2 is a new [Tuple2] object with item1 is 'c' and item2 is 10.

  print(t1);
  print(t2);
}
