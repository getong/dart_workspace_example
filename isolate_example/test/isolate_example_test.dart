import 'package:isolate_example/isolate_example.dart';
import 'package:test/test.dart';

void main() {
  test('findIsolateDemo returns matching spec', () {
    final demo = findIsolateDemo('spawn-sum');
    expect(demo, isNotNull);
    expect(demo!.title, equals('Spawn + SendPort'));
  });

  test('runIsolateDemo executes spawn-sum demo', () async {
    final List<String> lines = await runIsolateDemo('spawn-sum');
    expect(lines, isNotEmpty);
    expect(lines.first, equals('Demo: spawn-sum'));
  });

  test('runIsolateDemo rejects unknown slug', () async {
    expect(() => runIsolateDemo('unknown-slug'), throwsA(isA<ArgumentError>()));
  });
}
