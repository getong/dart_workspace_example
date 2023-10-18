import 'package:protobuf/protobuf.dart';
import 'package:protobuf_example/messages/mymessage.pb.dart' as mymessage;

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
}
