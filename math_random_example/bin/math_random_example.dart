// import 'package:math_random_example/math_random_example.dart' as math_random_example;

import 'dart:math';

void main(List<String> arguments) {
  // print('Hello world: ${math_random_example.calculate()}!');
  var rng = Random();
  for (var i = 0; i < 10; i++) {
    print(rng.nextInt(100));
  }
}
