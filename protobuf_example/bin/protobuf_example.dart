import 'package:protobuf/protobuf.dart';
import 'package:protobuf_example/messages/mymessage.pb.dart' as mymessage;
import 'package:protobuf_example/protobuf_message_num.dart';
import 'package:protobuf_example/export.dart';

// part 'package:protobuf_example/protobuf_message_num.dart';

void main(List<String> arguments) {
  final requestMessage = mymessage.MyMessage(
    text: "Hello from Dart!",
    number: 1,
  );
  List<int> list = requestMessage.writeToBuffer();
  print('encode list is ${list}');
  print('');
  final decodeMsg = mymessage.MyMessage.fromBuffer(list);
  print('decodeMsg: ${decodeMsg}');

  print(MYPACKAGE_MYMESSAGE);
  var a = [mymessage.MyMessage];
  print("a: ${a}");

  String typeName = mymessage.MyMessage().info_.qualifiedMessageName;
  print('Message type name: $typeName');
}
