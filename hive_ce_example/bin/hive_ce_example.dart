import 'dart:io';

import 'package:hive_ce/hive_ce.dart';
import 'package:path/path.dart' as p;

Future<void> example() async {
  final hiveDir = Directory(
    p.join(Directory.current.path, '.dart_tool', 'hive_boxes'),
  );
  await hiveDir.create(recursive: true);

  Hive.init(hiveDir.path);

  final box = await Hive.openBox<String>('myBox');
  await box.put('name', 'David');
  final name = box.get('name');
  print('Name: $name');

  await Hive.close();
}

Future<void> main(List<String> arguments) async {
  await example();
}
