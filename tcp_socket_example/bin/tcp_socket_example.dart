// import 'package:tcp_socket_example/tcp_socket_example.dart' as tcp_socket_example;

import 'dart:io';

// nc -l 12345

void main() async {
  // Define the server's IP address and port
  final String serverIp = '127.0.0.1'; // Change to the server's IP address
  final int serverPort = 12345; // Change to the server's port

  try {
    // Create a socket connection to the server
    final socket = await Socket.connect(serverIp, serverPort);

    // Send data to the server
    socket.writeln('Hello, server!');

    // Listen for data from the server
    socket.listen(
      (data) {
        print('Received from server: ${String.fromCharCodes(data)}');
      },
      onDone: () {
        print('Server disconnected.');
        socket.destroy();
      },
      onError: (error) {
        print('Error: $error');
        socket.destroy();
      },
    );

    // Close the socket when you're done
    // socket.close();
  } catch (e) {
    print('Error: $e');
  }
}

// copy from https://medium.com/@buddi/establish-a-client-side-tcp-socket-connection-for-data-communication-using-the-dart-io-117e2f76b540