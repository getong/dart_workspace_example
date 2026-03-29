import 'package:either_example/either_example.dart' as either_example;

void main(List<String> arguments) {
  final String requested = arguments.isEmpty ? '/' : arguments.first.trim();
  final String route = requested.startsWith('/')
      ? requested
      : '/examples/$requested';

  final String output = either_example.renderOutput(
    either_example.runRoute(route),
  );
  print(output);
}
