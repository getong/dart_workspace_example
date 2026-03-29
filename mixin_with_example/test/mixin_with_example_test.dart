import 'package:mixin_with_example/mixin_with_example.dart';
import 'package:test/test.dart';

void main() {
  test('findLayoutSpec returns a catalog item for existing slug', () {
    final LayoutSpec? spec = findLayoutSpec('row-rainbow');
    expect(spec, isNotNull);
    expect(spec?.kind, LayoutKind.row);
  });

  test('renderLayoutDemo shows mixin-built output for row slug', () {
    final String output = renderLayoutDemo('row-chips');

    expect(output, contains('ROW DEMO :: Row Chips (row-chips)'));
    expect(
      output,
      contains('Message: A Row can act like a compact command bar.'),
    );
    expect(output, contains('Steps:'));
    expect(output, contains('1. Create a horizontal container'));
  });

  test('renderLayoutDemo returns helpful message for unknown slug', () {
    expect(
      renderLayoutDemo('missing-slug'),
      'Layout "missing-slug" was not found.',
    );
  });
}
