import 'package:isolate_basic_example/isolate_basic_example.dart';
import 'package:test/test.dart';

void main() {
  test('calculate', () {
    expect(calculate(), 42);
  });
}
