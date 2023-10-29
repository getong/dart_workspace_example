// import 'package:dart_number_operation_example/dart_number_operation_example.dart' as dart_number_operation_example;

void main(List<String> arguments) {
  // print('Hello world: ${dart_number_operation_example.calculate()}!');

  final list = [211, 13, 67];

  for (final number in list) {
    print('${intTo8bitString(number)} = $number');
  }
  // 11010011 = 211
  // 00001101 = 13
  // 01000011 = 67

  for (final number in list) {
    print('${intTo8bitString(number, prefix: true)} = $number');
  }
  // 0x11010011 = 211
  // 0x00001101 = 13
  // 0x01000011 = 67

  print(binaryStringToInt('0x11010011')); // 211
  print(binaryStringToInt('1101')); // 13
  print(binaryStringToInt('01000011')); // 67
}

String intTo8bitString(int number, {bool prefix = false}) => prefix
    ? '0x${number.toRadixString(2).padLeft(8, '0')}'
    : '${number.toRadixString(2).padLeft(8, '0')}';

final _pattern = RegExp(r'(?:0x)?(\d+)');

int binaryStringToInt(String binaryString) =>
    int.parse(_pattern.firstMatch(binaryString)!.group(1)!, radix: 2);
