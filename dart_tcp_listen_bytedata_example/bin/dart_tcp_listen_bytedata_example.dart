// import 'package:dart_tcp_listen_bytedata_example/dart_tcp_listen_bytedata_example.dart' as dart_tcp_listen_bytedata_example;

import 'dart:io';
import 'dart:typed_data';


void main(List<String> arguments) async {
  // Start a TCP server
  ServerSocket serverSocket = await ServerSocket.bind('127.0.0.1', 12345);
  print('Server listening on ${serverSocket.address}:${serverSocket.port}');

  await for (Socket clientSocket in serverSocket) {
    handleClient(clientSocket);
  }
}

void handleClient(Socket clientSocket) {
  print('Client connected: ${clientSocket.remoteAddress}:${clientSocket.remotePort}');

  clientSocket.listen(
    (List<int> data) {
      // Convert raw bytes to ByteData
      ByteData byteData = ByteData.sublistView(Uint8List.fromList(data));

      // Example: Reading a 32-bit integer from the ByteData
      int intValue = byteData.getInt32(0, Endian.little); // Assuming little-endian byte order
      print('Received Integer Value: $intValue');

      // Example: Reading a 64-bit double from the ByteData
      double doubleValue = byteData.getFloat64(4, Endian.little); // Assuming little-endian byte order, starts at position 4
      print('Received Double Value: $doubleValue');
    },
    onDone: () {
      print('Client disconnected');
      clientSocket.destroy();
    },
    onError: (error) {
      print('Error: $error');
      clientSocket.destroy();
    },
    cancelOnError: true,
  );
}
