import 'package:factory_user_example/factory_user_example.dart';
import 'package:test/test.dart';

void main() {
  test('calculate', () {
    expect(calculate(), 42);
  });

  test('Player.fromCache returns the cached instance', () {
    final first = Player.fromCache('Ada', 'Lovelace');
    final second = Player.fromCache('Ada', 'Lovelace');

    expect(identical(first, second), isTrue);
  });
}
