import 'package:either_example/either_example.dart';
import 'package:test/test.dart';

void main() {
  test('home route renders all examples', () {
    final String output = renderOutput(runRoute('/'));
    expect(output, contains('/examples/parse-user-id'));
    expect(output, contains('/examples/split-budget'));
    expect(output, contains('/examples/normalize-email'));
  });

  test('dynamic example route succeeds', () {
    final String output = renderOutput(runRoute('/examples/split-budget'));
    expect(output, contains('Split Budget'));
    expect(output, contains('Each member gets 20.00 credits.'));
  });

  test('unknown slug returns not-found message', () {
    final String output = renderOutput(runRoute('/examples/does-not-exist'));
    expect(output, contains('No dart_either example found'));
  });

  test('parsePositiveInt returns Left for invalid number', () {
    final result = parsePositiveInt('-7', label: 'userId');
    expect(result.isLeft, isTrue);
  });

  test('normalizeEmail trims and lowercases', () {
    final result = normalizeEmail('  Team@Example.COM  ');
    expect(result.isRight, isTrue);
    expect(
      result.fold(ifLeft: (_) => '', ifRight: (value) => value),
      equals('team@example.com'),
    );
  });
}
