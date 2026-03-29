import 'dart:async';
import 'dart:isolate';

import 'isolate_catalog.dart';

export 'isolate_catalog.dart';

Future<List<String>> runIsolateDemo(String slug) {
  switch (slug) {
    case 'spawn-sum':
      return _runSpawnSumDemo();
    case 'isolate-run-prime':
      return _runIsolateRunPrimeDemo();
    case 'worker-text':
      return _runWorkerTextDemo();
    default:
      throw ArgumentError.value(slug, 'slug', 'Unknown isolate demo slug');
  }
}

Future<Map<String, List<String>>> runAllIsolateDemos() async {
  final Map<String, List<String>> output = <String, List<String>>{};
  for (final IsolateDemoSpec demo in isolateDemos) {
    output[demo.slug] = await runIsolateDemo(demo.slug);
  }
  return output;
}

Future<List<String>> _runSpawnSumDemo() async {
  final ReceivePort receivePort = ReceivePort();
  await Isolate.spawn<List<Object>>(_sumRangeEntryPoint, <Object>[
    receivePort.sendPort,
    1,
    1000000,
  ]);

  final Map<Object?, Object?> result =
      await receivePort.first as Map<Object?, Object?>;
  receivePort.close();

  return <String>[
    'Demo: spawn-sum',
    'Range: ${result['start']}..${result['end']}',
    'Sum: ${result['sum']}',
  ];
}

void _sumRangeEntryPoint(List<Object> message) {
  final SendPort replyPort = message[0] as SendPort;
  final int start = message[1] as int;
  final int end = message[2] as int;

  var sum = 0;
  for (var i = start; i <= end; i++) {
    sum += i;
  }

  replyPort.send(<String, Object>{'start': start, 'end': end, 'sum': sum});
}

Future<List<String>> _runIsolateRunPrimeDemo() async {
  const nth = 7500;
  final Stopwatch stopwatch = Stopwatch()..start();
  final int prime = await Isolate.run<int>(() => _nthPrime(nth));
  stopwatch.stop();

  return <String>[
    'Demo: isolate-run-prime',
    '${nth}th prime: $prime',
    'Elapsed: ${stopwatch.elapsedMilliseconds} ms',
  ];
}

int _nthPrime(int n) {
  var count = 0;
  var candidate = 1;
  while (count < n) {
    candidate++;
    if (_isPrime(candidate)) {
      count++;
    }
  }
  return candidate;
}

bool _isPrime(int value) {
  if (value < 2) {
    return false;
  }
  if (value == 2) {
    return true;
  }
  if (value.isEven) {
    return false;
  }
  for (var i = 3; i * i <= value; i += 2) {
    if (value % i == 0) {
      return false;
    }
  }
  return true;
}

Future<List<String>> _runWorkerTextDemo() async {
  final ReceivePort receivePort = ReceivePort();
  final Isolate isolate = await Isolate.spawn<SendPort>(
    _textWorkerEntryPoint,
    receivePort.sendPort,
  );

  final Completer<SendPort> workerPortCompleter = Completer<SendPort>();
  final Completer<void> shutdownCompleter = Completer<void>();
  final Map<int, Completer<Map<Object?, Object?>>> pending =
      <int, Completer<Map<Object?, Object?>>>{};
  var nextRequestId = 0;

  final StreamSubscription<dynamic> subscription = receivePort.listen((
    dynamic message,
  ) {
    if (message is SendPort) {
      if (!workerPortCompleter.isCompleted) {
        workerPortCompleter.complete(message);
      }
      return;
    }

    if (message is! Map<Object?, Object?>) {
      return;
    }

    final String? type = message['type'] as String?;
    if (type == 'response') {
      final int id = message['id'] as int;
      pending.remove(id)?.complete(message);
      return;
    }
    if (type == 'shutdown_ack' && !shutdownCompleter.isCompleted) {
      shutdownCompleter.complete();
    }
  });

  Future<Map<Object?, Object?>> request(
    SendPort workerPort,
    String action,
    String text,
  ) {
    final int requestId = nextRequestId++;
    final Completer<Map<Object?, Object?>> completer =
        Completer<Map<Object?, Object?>>();
    pending[requestId] = completer;

    workerPort.send(<String, Object>{
      'type': 'request',
      'id': requestId,
      'action': action,
      'text': text,
    });
    return completer.future.timeout(const Duration(seconds: 2));
  }

  final SendPort workerPort = await workerPortCompleter.future;
  final Map<Object?, Object?> reversed = await request(
    workerPort,
    'reverse',
    'isolate worker',
  );
  final Map<Object?, Object?> upper = await request(
    workerPort,
    'uppercase',
    'dart isolate',
  );
  final Map<Object?, Object?> words = await request(
    workerPort,
    'wordCount',
    'one two two three three three',
  );

  workerPort.send(<String, Object>{'type': 'shutdown'});
  await shutdownCompleter.future.timeout(const Duration(seconds: 2));

  await subscription.cancel();
  receivePort.close();
  isolate.kill(priority: Isolate.immediate);

  return <String>[
    'Demo: worker-text',
    'reverse => ${reversed['result']}',
    'uppercase => ${upper['result']}',
    'wordCount => ${words['result']}',
  ];
}

void _textWorkerEntryPoint(SendPort mainSendPort) {
  final ReceivePort workerReceivePort = ReceivePort();
  mainSendPort.send(workerReceivePort.sendPort);

  workerReceivePort.listen((dynamic message) {
    if (message is! Map<Object?, Object?>) {
      return;
    }

    final String? type = message['type'] as String?;
    if (type == 'shutdown') {
      mainSendPort.send(<String, Object>{'type': 'shutdown_ack'});
      workerReceivePort.close();
      return;
    }

    if (type != 'request') {
      return;
    }

    final int id = message['id'] as int;
    final String action = message['action'] as String;
    final String text = message['text'] as String;
    final String result;

    switch (action) {
      case 'reverse':
        result = text.split('').reversed.join();
      case 'uppercase':
        result = text.toUpperCase();
      case 'wordCount':
        result = _wordFrequency(text);
      default:
        result = 'unsupported action: $action';
    }

    mainSendPort.send(<String, Object>{
      'type': 'response',
      'id': id,
      'result': result,
    });
  });
}

String _wordFrequency(String text) {
  final Map<String, int> counts = <String, int>{};
  for (final String part in text.split(RegExp(r'\s+'))) {
    if (part.isEmpty) {
      continue;
    }
    counts.update(part, (int value) => value + 1, ifAbsent: () => 1);
  }
  final List<String> words = counts.keys.toList()..sort();
  return words.map((String word) => '$word:${counts[word]}').join(', ');
}
