import 'package:dart_either/dart_either.dart';

enum EitherExampleKind { parsing, math, validation, recovery }

class EitherExampleSpec {
  const EitherExampleSpec({
    required this.slug,
    required this.title,
    required this.description,
    required this.kind,
  });

  final String slug;
  final String title;
  final String description;
  final EitherExampleKind kind;
}

const List<EitherExampleSpec> eitherExamples = <EitherExampleSpec>[
  EitherExampleSpec(
    slug: 'parse-user-id',
    title: 'Parse User ID',
    description: 'Convert a string ID into a positive integer.',
    kind: EitherExampleKind.parsing,
  ),
  EitherExampleSpec(
    slug: 'split-budget',
    title: 'Split Budget',
    description: 'Compose parsing and division with flatMap.',
    kind: EitherExampleKind.math,
  ),
  EitherExampleSpec(
    slug: 'normalize-email',
    title: 'Normalize Email',
    description: 'Validate and normalize optional user input.',
    kind: EitherExampleKind.validation,
  ),
  EitherExampleSpec(
    slug: 'recover-timeout',
    title: 'Recover Timeout',
    description: 'Recover from invalid config with handleError.',
    kind: EitherExampleKind.recovery,
  ),
];

EitherExampleSpec? findEitherExample(String slug) {
  for (final EitherExampleSpec example in eitherExamples) {
    if (example.slug == slug) {
      return example;
    }
  }
  return null;
}

String buildHomePage() {
  final StringBuffer buffer = StringBuffer()
    ..writeln('Dart Either Catalog')
    ..writeln('-------------------')
    ..writeln('Open one route to run the demo:')
    ..writeln();

  for (final EitherExampleSpec example in eitherExamples) {
    buffer.writeln('/examples/${example.slug}  ->  ${example.title}');
  }

  buffer.writeln();
  buffer.writeln('Tip: you can pass only a slug in CLI, e.g. "split-budget".');
  return buffer.toString().trimRight();
}

Either<String, String> runRoute(String route) {
  if (route == '/') {
    return Either.right(buildHomePage());
  }

  const String prefix = '/examples/';
  if (!route.startsWith(prefix)) {
    return Either.left(
      'Unsupported route "$route". Try "/" or "/examples/<slug>".',
    );
  }

  final String slug = route.substring(prefix.length).trim();
  if (slug.isEmpty) {
    return Either.left(
      'Missing slug in "$route". Expected "/examples/<slug>".',
    );
  }

  final EitherExampleSpec? example = findEitherExample(slug);
  if (example == null) {
    return Either.left('No dart_either example found for "$slug".');
  }

  return runExample(slug).map((String value) => _renderDetail(example, value));
}

Either<String, String> runExample(String slug) {
  switch (slug) {
    case 'parse-user-id':
      return parsePositiveInt(
        '42',
        label: 'userId',
      ).map((int value) => 'Parsed user id: $value');
    case 'split-budget':
      return parsePositiveInt('120', label: 'budget').flatMap(
        (int budget) => parsePositiveInt('6', label: 'members').flatMap(
          (int members) => safeDivide(budget, members).map(
            (double perMember) =>
                'Each member gets ${perMember.toStringAsFixed(2)} credits.',
          ),
        ),
      );
    case 'normalize-email':
      return normalizeEmail(
        '  Team@Example.COM  ',
      ).map((String email) => 'Normalized email: $email');
    case 'recover-timeout':
      return parsePositiveInt('0', label: 'timeoutSeconds')
          .handleError((String _) => 30)
          .map((int value) => 'Recovered timeout: $value seconds.');
    default:
      return Either.left('No runnable example for "$slug".');
  }
}

Either<String, int> parsePositiveInt(String raw, {required String label}) {
  final int? parsed = int.tryParse(raw.trim());
  if (parsed == null) {
    return Either.left('$label must be an integer, got "$raw".');
  }
  if (parsed <= 0) {
    return Either.left('$label must be > 0, got $parsed.');
  }
  return Either.right(parsed);
}

Either<String, double> safeDivide(int numerator, int denominator) {
  if (denominator == 0) {
    return Either.left('Cannot divide by zero.');
  }
  return Either.right(numerator / denominator);
}

Either<String, String> normalizeEmail(String? value) {
  return Either.fromNullable<String>(value)
      .mapLeft((_) => 'Email is required.')
      .map((String email) => email.trim().toLowerCase())
      .flatMap(
        (String email) => email.contains('@')
            ? Either.right(email)
            : Either.left('Invalid email "$email".'),
      );
}

String renderOutput(Either<String, String> result) {
  return result.fold(
    ifLeft: (String error) => 'Error: $error',
    ifRight: (String output) => output,
  );
}

String _renderDetail(EitherExampleSpec example, String result) {
  return [
    example.title,
    'Route: /examples/${example.slug}',
    'Kind: ${example.kind.name}',
    example.description,
    'Result: $result',
  ].join('\n');
}
