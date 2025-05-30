void main() async {
  int myDelay = 5;

  print('Hello');

  var value = await _customDelay(myDelay);
  var customText = myDelay == 1 ? "second later" : "seconds later";

  print('Its $value $customText');

  print('\n--- Multiple Future Examples ---');

  // Example 1: Parallel execution with Future.wait
  await _parallelFuturesExample();

  // Example 2: Future.any - first to complete
  await _futureAnyExample();

  // Example 3: Timeout handling
  await _timeoutExample();

  // Example 4: Future chaining
  await _futureChainingExample();

  // Example 5: Error handling with multiple futures
  await _errorHandlingExample();

  // Example 6: Future with different return types
  await _mixedReturnTypesExample();
}

Future<int> _customDelay(int delay) async {
  try {
    await Future.delayed(Duration(seconds: delay));
    return delay;
  } catch (e) {
    print(e);
    return delay;
  }
}

// Parallel execution example
Future<void> _parallelFuturesExample() async {
  print('\n1. Parallel Futures with Future.wait:');

  var stopwatch = Stopwatch()..start();

  var results = await Future.wait([
    _fetchData('API 1', 2),
    _fetchData('API 2', 3),
    _fetchData('API 3', 1),
  ]);

  stopwatch.stop();
  print('All results: $results');
  print('Total time: ${stopwatch.elapsedMilliseconds}ms');
}

// Future.any example
Future<void> _futureAnyExample() async {
  print('\n2. Future.any - first to complete:');

  var result = await Future.any([
    _fetchData('Slow API', 4),
    _fetchData('Medium API', 2),
    _fetchData('Fast API', 1),
  ]);

  print('First result: $result');
}

// Timeout example
Future<void> _timeoutExample() async {
  print('\n3. Timeout handling:');

  try {
    var result = await _slowOperation(6).timeout(Duration(seconds: 3));
    print('Result: $result');
  } catch (e) {
    print('Operation timed out: $e');
  }
}

// Future chaining example
Future<void> _futureChainingExample() async {
  print('\n4. Future chaining:');

  var result = await _fetchUserData(123)
      .then((user) => _fetchUserPosts(user))
      .then((posts) => _processPosts(posts))
      .catchError((error) => 'Error: $error');

  print('Final result: $result');
}

// Error handling with multiple futures
Future<void> _errorHandlingExample() async {
  print('\n5. Error handling with allSettled pattern:');

  var futures = [
    _reliableOperation(),
    _unreliableOperation(),
    _anotherReliableOperation(),
  ];

  var results = await Future.wait(
    futures.map((f) => f.catchError((e) => 'Failed: $e')),
  );

  for (int i = 0; i < results.length; i++) {
    print('Operation ${i + 1}: ${results[i]}');
  }
}

// Mixed return types example
Future<void> _mixedReturnTypesExample() async {
  print('\n6. Futures with different return types:');

  var stringFuture = _getString();
  var numberFuture = _getNumber();
  var boolFuture = _getBool();

  var results = await Future.wait([stringFuture, numberFuture, boolFuture]);
  print('Mixed results: ${results[0]}, ${results[1]}, ${results[2]}');
}

// Helper functions for examples
Future<String> _fetchData(String source, int delay) async {
  await Future.delayed(Duration(seconds: delay));
  return '$source data';
}

Future<String> _slowOperation(int seconds) async {
  await Future.delayed(Duration(seconds: seconds));
  return 'Slow operation completed';
}

Future<String> _fetchUserData(int userId) async {
  await Future.delayed(Duration(seconds: 1));
  return 'User$userId';
}

Future<List<String>> _fetchUserPosts(String user) async {
  await Future.delayed(Duration(seconds: 1));
  return ['${user}_post1', '${user}_post2', '${user}_post3'];
}

Future<String> _processPosts(List<String> posts) async {
  await Future.delayed(Duration(milliseconds: 500));
  return 'Processed ${posts.length} posts';
}

Future<String> _reliableOperation() async {
  await Future.delayed(Duration(seconds: 1));
  return 'Success from reliable operation';
}

Future<String> _unreliableOperation() async {
  await Future.delayed(Duration(seconds: 1));
  throw Exception('Something went wrong');
}

Future<String> _anotherReliableOperation() async {
  await Future.delayed(Duration(seconds: 2));
  return 'Success from another reliable operation';
}

Future<String> _getString() async {
  await Future.delayed(Duration(seconds: 1));
  return 'Hello World';
}

Future<int> _getNumber() async {
  await Future.delayed(Duration(seconds: 1));
  return 42;
}

Future<bool> _getBool() async {
  await Future.delayed(Duration(seconds: 1));
  return true;
}
