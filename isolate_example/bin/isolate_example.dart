import 'dart:io';

import 'package:isolate_example/isolate_example.dart';

Future<void> main(List<String> arguments) async {
  if (arguments.isEmpty || arguments.first == '--help') {
    _printUsage();
    return;
  }

  if (arguments.first == '--all') {
    final Map<String, List<String>> results = await runAllIsolateDemos();
    for (final IsolateDemoSpec demo in isolateDemos) {
      final List<String> lines = results[demo.slug]!;
      _printSection(demo, lines);
    }
    return;
  }

  final String slug = arguments.first;
  final IsolateDemoSpec? demo = findIsolateDemo(slug);
  if (demo == null) {
    stderr.writeln('Unknown demo slug: $slug');
    _printUsage();
    return;
  }

  final List<String> lines = await runIsolateDemo(slug);
  _printSection(demo, lines);
}

void _printUsage() {
  stdout.writeln('Dart Isolate Demo Catalog');
  stdout.writeln('');
  stdout.writeln('Usage:');
  stdout.writeln('  dart run bin/isolate_example.dart <slug>');
  stdout.writeln('  dart run bin/isolate_example.dart --all');
  stdout.writeln('');
  stdout.writeln('Available demos:');
  for (final IsolateDemoSpec demo in isolateDemos) {
    stdout.writeln('  - ${demo.slug}: ${demo.title}');
    stdout.writeln('    ${demo.description}');
  }
}

void _printSection(IsolateDemoSpec demo, List<String> lines) {
  stdout.writeln('');
  stdout.writeln('${demo.title} (${demo.slug})');
  stdout.writeln('-' * (demo.title.length + demo.slug.length + 3));
  for (final String line in lines) {
    stdout.writeln(line);
  }
}
