// import 'package:dart_runes_example/dart_runes_example.dart' as dart_runes_example;

void codeunits_example() {
  String gfg = 'GeeksforGeeks';
  print("the codeunits is ${gfg.codeUnits}");
}

void runes_example() {
  String gfg = "GFG";
  gfg.runes.forEach((int x) {
    var ch = new String.fromCharCode(x);
    print("the ch is ${ch}");
  });
}

void codeunitat_example() {
  String gfg = 'GeeksforGeeks';
  print("at 3 is ${gfg.codeUnitAt(3)}");
}

void runes_to_list_example() {
  const string = 'GeeksforGeeks';
  final runes = string.runes.toList();
  print(runes); // [68, 97, 114, 116]
}

void emoji_runes_example() {
  const emojiMan = '👨';
  print(emojiMan.runes); // (128104)

  // Surrogate pairs:
  for (final item in emojiMan.codeUnits) {
    print(item.toRadixString(16));
    // d83d
    // dc68
  }
}

void main(List<String> arguments) {
  // print('Hello world: ${dart_runes_example.calculate()}!');
  codeunits_example();
  runes_example();
  codeunitat_example();
  runes_to_list_example();
  emoji_runes_example();
}
