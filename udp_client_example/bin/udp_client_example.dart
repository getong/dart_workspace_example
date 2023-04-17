// import 'package:udp_client_example/udp_client_example.dart' as udp_client_example;

// void main(List<String> arguments) {
//   print('Hello world: ${udp_client_example.calculate()}!');
// }

import 'dart:io';

void main() {
  RawDatagramSocket.bind(InternetAddress.anyIPv4, 0)
      .then((RawDatagramSocket socket) {
    print('UDP client ready');

    // Send a message to the server
    String message = 'Hello server!';
    List<int> data = message.codeUnits;
    InternetAddress serverAddress = InternetAddress('192.168.1.101');
    int serverPort = 9999;
    socket.send(data, serverAddress, serverPort);

    // Receive a response from the server
    socket.listen((RawSocketEvent event) {
      if (event == RawSocketEvent.read) {
        // Datagram datagram = socket.receive();
        // String message = String.fromCharCodes(datagram.data);
        // print('Received message from server: $message');
        Datagram? datagram = socket.receive();
        if (datagram != null) {
          String message = String.fromCharCodes(datagram.data);
          print('Received message from server: $message');
        }
      }
    });
  });
}