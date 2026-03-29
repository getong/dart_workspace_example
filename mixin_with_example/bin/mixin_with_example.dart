import 'package:mixin_with_example/mixin_with_example.dart'
    as mixin_with_example;

void main(List<String> arguments) {
  final Iterable<String> slugs = arguments.isEmpty
      ? mixin_with_example.layoutSpecs.map(
          (mixin_with_example.LayoutSpec s) => s.slug,
        )
      : arguments;

  for (final String slug in slugs) {
    print(mixin_with_example.renderLayoutDemo(slug));
    print('');
  }
}
