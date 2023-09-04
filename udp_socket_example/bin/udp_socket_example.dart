import 'package:udp_socket_example/udp_socket_example.dart' as udp_socket_example;

import 'dart:io';
import 'dart:convert';

void main(List<String> arguments) {
  // print('Hello world: ${udp_socket_example.calculate()}!');

  var data = 'Hello World';

  List<int> dataToSend = utf8.encode(data);
  int port = 3000;
  RawDatagramSocket.bind(InternetAddress.loopbackIPv4, port).then((RawDatagramSocket udpSocket){
      udpSocket.listen((RawSocketEvent event){
          if(event == RawSocketEvent.read){
          Datagram? dg = udpSocket.receive();
          print(utf8.decode(dg!.data));
        }
      });

      udpSocket.send(dataToSend, InternetAddress.loopbackIPv4, port);
      print('send!');
  });
}
