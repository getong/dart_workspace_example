import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:web_socket_channel/status.dart' as status;

// websocat -s 1234
// type message in
void main(List<String> arguments) async {
  final wsUrl = Uri.parse('ws://localhost:1234');
  var channel = WebSocketChannel.connect(wsUrl);

  channel.stream.listen((message) {
      print("receive $message");
      channel.sink.add('data from dart!');
      channel.sink.close(status.goingAway);
  });
}
