// import 'package:fixnum_example/fixnum_example.dart' as fixnum_example;

// void main(List<String> arguments) {
//   print('Hello world: ${fixnum_example.calculate()}!');
// }


import 'package:fixnum/fixnum.dart';

void main() {
  int regularInt = 42;

  // Convert int to Int64
  Int64 int64Value = Int64(regularInt);

  print('Int64 value: $int64Value');
}
