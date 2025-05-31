// import 'package:long_running_isolate/long_running_isolate.dart' as long_running_isolate;

// void main(List<String> arguments) {
//   print('Hello world: ${long_running_isolate.calculate()}!');
// }

// Copyright (c) 2021, the Dart project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

/// Demonstrates various isolate patterns in Dart including:
/// - File processing in isolates
/// - CPU-intensive computations
/// - Error handling and timeouts
/// - Bidirectional communication
import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:isolate';
import 'dart:math';

import 'package:async/async.dart';

const filenames = [
  'json_01.json',
  'json_02.json',
  'json_03.json',
];

/// Main entry point demonstrating different isolate usage patterns
void main() async {
  print('=== Dart Isolate Examples ===\n');

  // Example 1: File processing
  print('1. File Processing Example:');
  await _demonstrateFileProcessing();

  print('\n2. CPU-Intensive Computation Example:');
  await _demonstrateCpuIntensiveWork();

  print('\n3. Bidirectional Communication Example:');
  await _demonstrateBidirectionalCommunication();

  print('\n4. Error Handling Example:');
  await _demonstrateErrorHandling();
}

/// Demonstrates file processing using isolates
Future<void> _demonstrateFileProcessing() async {
  await for (final jsonData in _sendAndReceive(filenames)) {
    print('Received JSON with ${jsonData.length} keys');
  }
}

/// Demonstrates CPU-intensive work in an isolate
Future<void> _demonstrateCpuIntensiveWork() async {
  const numbers = [1000000, 2000000, 3000000];

  for (final number in numbers) {
    final stopwatch = Stopwatch()..start();
    final result = await _computePrimesInIsolate(number);
    stopwatch.stop();

    print(
        'Found ${result.length} primes up to $number in ${stopwatch.elapsedMilliseconds}ms');
  }
}

/// Demonstrates bidirectional communication with an isolate
Future<void> _demonstrateBidirectionalCommunication() async {
  final calculator = await CalculatorIsolate.spawn();

  try {
    final sum = await calculator.add(15, 25);
    print('15 + 25 = $sum');

    final product = await calculator.multiply(7, 8);
    print('7 × 8 = $product');

    final factorial = await calculator.factorial(10);
    print('10! = $factorial');
  } finally {
    await calculator.dispose();
  }
}

/// Demonstrates error handling in isolates
Future<void> _demonstrateErrorHandling() async {
  try {
    await _computeWithError();
  } catch (e) {
    print('Caught error from isolate: $e');
  }
}

/// Spawns an isolate and asynchronously sends a list of filenames for it to
/// read and decode. Waits for the response containing the decoded JSON
/// before sending the next.
///
/// Returns a stream that emits the JSON-decoded contents of each file.
///
/// Throws [FileSystemException] if any file cannot be read.
/// Throws [FormatException] if any file contains invalid JSON.
Stream<Map<String, dynamic>> _sendAndReceive(List<String> filenames) async* {
  final p = ReceivePort();
  await Isolate.spawn(_readAndParseJsonService, p.sendPort);

  // Convert the ReceivePort into a StreamQueue to receive messages from the
  // spawned isolate using a pull-based interface. Events are stored in this
  // queue until they are accessed by `events.next`.
  final events = StreamQueue<dynamic>(p);

  // The first message from the spawned isolate is a SendPort. This port is
  // used to communicate with the spawned isolate.
  SendPort sendPort = await events.next;

  for (var filename in filenames) {
    // Send the next filename to be read and parsed
    sendPort.send(filename);

    // Receive the parsed JSON
    Map<String, dynamic> message = await events.next;

    // Add the result to the stream returned by this async* function.
    yield message;
  }

  // Send a signal to the spawned isolate indicating that it should exit.
  sendPort.send(null);

  // Dispose the StreamQueue.
  await events.cancel();
}

/// The entrypoint that runs on the spawned isolate. Receives messages from
/// the main isolate, reads the contents of the file, decodes the JSON, and
/// sends the result back to the main isolate.
///
/// Protocol:
/// - Sends a [SendPort] as the first message
/// - Receives filename strings to process
/// - Sends back decoded JSON maps
/// - Exits when receiving null
Future<void> _readAndParseJsonService(SendPort p) async {
  print('Spawned isolate started.');

  // Send a SendPort to the main isolate so that it can send JSON strings to
  // this isolate.
  final commandPort = ReceivePort();
  p.send(commandPort.sendPort);

  // Wait for messages from the main isolate.
  await for (final message in commandPort) {
    if (message is String) {
      try {
        // Read and decode the file.
        final contents = await File(message).readAsString();
        final decoded = jsonDecode(contents);

        // Send the result to the main isolate.
        p.send(decoded);
      } catch (e) {
        // Send error back to main isolate
        p.send({'error': e.toString(), 'filename': message});
      }
    } else if (message == null) {
      // Exit if the main isolate sends a null message, indicating there are no
      // more files to read and parse.
      break;
    }
  }

  print('Spawned isolate finished.');
  Isolate.exit();
}

/// Computes prime numbers up to [max] using an isolate for CPU-intensive work.
///
/// Returns a list of all prime numbers from 2 to [max].
Future<List<int>> _computePrimesInIsolate(int max) async {
  final receivePort = ReceivePort();
  await Isolate.spawn(_computePrimesService, [receivePort.sendPort, max]);

  final result = await receivePort.first;
  return List<int>.from(result);
}

/// Isolate service that computes prime numbers using the Sieve of Eratosthenes.
///
/// Parameters: [List] containing [SendPort] and [int] max value.
void _computePrimesService(List<dynamic> params) {
  final SendPort sendPort = params[0];
  final int max = params[1];

  final primes = _sieveOfEratosthenes(max);
  sendPort.send(primes);
  Isolate.exit();
}

/// Implements the Sieve of Eratosthenes algorithm for finding prime numbers.
List<int> _sieveOfEratosthenes(int max) {
  if (max < 2) return [];

  final sieve = List<bool>.filled(max + 1, true);
  sieve[0] = sieve[1] = false;

  for (int i = 2; i * i <= max; i++) {
    if (sieve[i]) {
      for (int j = i * i; j <= max; j += i) {
        sieve[j] = false;
      }
    }
  }

  return [
    for (int i = 2; i <= max; i++)
      if (sieve[i]) i
  ];
}

/// Demonstrates error handling by spawning an isolate that throws an error.
Future<void> _computeWithError() async {
  final receivePort = ReceivePort();
  await Isolate.spawn(_errorService, receivePort.sendPort);

  final result = await receivePort.first;
  if (result is String && result.startsWith('ERROR:')) {
    throw Exception(result);
  }
}

/// Isolate service that intentionally throws an error.
void _errorService(SendPort sendPort) {
  try {
    throw Exception('Intentional error for demonstration');
  } catch (e) {
    sendPort.send('ERROR: $e');
  }
  Isolate.exit();
}

/// A calculator that runs in a separate isolate for demonstration of
/// bidirectional communication patterns.
class CalculatorIsolate {
  final SendPort _sendPort;
  final ReceivePort _receivePort;
  final StreamQueue<dynamic> _responseQueue;
  int _requestId = 0;

  CalculatorIsolate._(this._sendPort, this._receivePort, this._responseQueue);

  /// Spawns a new calculator isolate and returns a [CalculatorIsolate] instance
  /// for communicating with it.
  static Future<CalculatorIsolate> spawn() async {
    final receivePort = ReceivePort();
    await Isolate.spawn(_calculatorService, receivePort.sendPort);

    final responseQueue = StreamQueue<dynamic>(receivePort);
    final sendPort = await responseQueue.next;

    return CalculatorIsolate._(sendPort, receivePort, responseQueue);
  }

  /// Performs addition in the isolate.
  Future<double> add(double a, double b) async {
    final result = await _sendRequest('add', [a, b]);
    return (result as num).toDouble();
  }

  /// Performs multiplication in the isolate.
  Future<double> multiply(double a, double b) async {
    final result = await _sendRequest('multiply', [a, b]);
    return (result as num).toDouble();
  }

  /// Computes factorial in the isolate.
  Future<int> factorial(int n) async {
    final result = await _sendRequest('factorial', [n]);
    return (result as num).toInt();
  }

  /// Sends a request to the isolate and waits for the response.
  Future<dynamic> _sendRequest(String operation, List<dynamic> params) async {
    final requestId = _requestId++;
    _sendPort.send({
      'id': requestId,
      'operation': operation,
      'params': params,
    });

    final response = await _responseQueue.next;
    if (response['error'] != null) {
      throw Exception(response['error']);
    }

    return response['result'];
  }

  /// Disposes the calculator isolate and closes communication channels.
  Future<void> dispose() async {
    _sendPort.send({'operation': 'exit'});
    await _responseQueue.cancel();
  }
}

/// Calculator isolate service that handles mathematical operations.
void _calculatorService(SendPort mainSendPort) {
  final receivePort = ReceivePort();
  mainSendPort.send(receivePort.sendPort);

  receivePort.listen((message) {
    if (message['operation'] == 'exit') {
      Isolate.exit();
      return;
    }

    try {
      final operation = message['operation'] as String;
      final params = message['params'] as List<dynamic>;
      final id = message['id'];

      dynamic result;
      switch (operation) {
        case 'add':
          result = (params[0] as double) + (params[1] as double);
          break;
        case 'multiply':
          result = (params[0] as double) * (params[1] as double);
          break;
        case 'factorial':
          result = _factorial(params[0] as int);
          break;
        default:
          throw Exception('Unknown operation: $operation');
      }

      mainSendPort.send({
        'id': id,
        'result': result,
        'error': null,
      });
    } catch (e) {
      mainSendPort.send({
        'id': message['id'],
        'result': null,
        'error': e.toString(),
      });
    }
  });
}

/// Computes factorial recursively.
int _factorial(int n) {
  if (n <= 1) return 1;
  return n * _factorial(n - 1);
}
