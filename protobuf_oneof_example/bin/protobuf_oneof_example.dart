// import 'package:protobuf_oneof_example/protobuf_oneof_example.dart' as protobuf_oneof_example;

// void main(List<String> arguments) {
//   print('Hello world: ${protobuf_oneof_example.calculate()}!');
// }


import 'package:protobuf_oneof_example/my_message.pb.dart';


void main(List<String> arguments) {
  // Creating a MyMessage instance with text set
  MyMessage messageWithText = MyMessage()
  ..id = 1
  ..name = 'Example'
  ..text = 'Hello, protobuf!';

  // Creating a MyMessage instance with number set
  MyMessage messageWithNumber = MyMessage()
  ..id = 2
  ..name = 'Another Example'
  ..number = 42;

  // Creating a MyMessage instance with flag set
  MyMessage messageWithFlag = MyMessage()
  ..id = 3
  ..name = 'Yet Another Example'
  ..flag = true;

  // Accessing values
  print(messageWithText.text); // Output: Hello, protobuf!
  print(messageWithNumber.number); // Output: 42
  print(messageWithFlag.flag); // Output: true

  var textList = messageWithText.writeToBuffer();
  print("list : ${textList}");
  var originMsg = MyMessage.fromBuffer(textList);
  print("originMsg: ${originMsg}");

  var numberList = messageWithNumber.writeToBuffer();
  print("numberlist : ${numberList}");
  var originMsg2 = MyMessage.fromBuffer(numberList);
  print("originMsg: ${originMsg2}");

  var flagList = messageWithFlag.writeToBuffer();
  print("list : ${flagList}");
  var originMsg3 = MyMessage.fromBuffer(flagList);
  print("originMsg: ${originMsg3}");
}
