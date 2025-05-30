import 'dart:async';
import 'dart:math';

Stream<int> boatStream() async* {
  for (int i = 1; i <= 10; i++) {
    print("SENT boat no. " + i.toString());
    await Future.delayed(Duration(seconds: 1));

    // Simulate occasional errors
    if (i == 5) {
      throw Exception("Boat no. 5 encountered rough waters!");
    }

    yield i;
  }
}

// New weather stream
Stream<String> weatherStream() async* {
  final weather = ['Sunny', 'Cloudy', 'Rainy', 'Stormy', 'Foggy'];
  final random = Random();

  for (int i = 0; i < 8; i++) {
    await Future.delayed(Duration(milliseconds: 800));
    yield weather[random.nextInt(weather.length)];
  }
}

// Broadcast stream controller example
StreamController<double> temperatureController =
    StreamController<double>.broadcast();

void generateTemperature() async {
  final random = Random();
  for (int i = 0; i < 15; i++) {
    await Future.delayed(Duration(milliseconds: 600));
    double temp = 15 + random.nextDouble() * 20; // 15-35°C
    temperatureController.add(temp);
  }
  temperatureController.close();
}

void main() async {
  print("=== Boat Stream with Error Handling ===");
  Stream<int> stream = boatStream();

  // Original listener with error handling
  StreamSubscription<int> subscription = stream.listen(
    (receivedData) {
      print("RECEIVED boat no." + receivedData.toString());
    },
    onError: (error) {
      print("ERROR: $error");
    },
    onDone: () {
      print("Boat stream completed!");
    },
  );

  // Wait for boat stream to complete
  await Future.delayed(Duration(seconds: 12));

  print("\n=== Stream Transformations ===");

  // Create a new boat stream for transformations
  Stream<int> transformStream = boatStream();

  // Transform and filter the stream
  await transformStream
      .where((boat) => boat % 2 == 0) // Only even numbered boats
      .map((boat) => boat * 10) // Multiply by 10
      .take(3) // Take only first 3
      .listen((data) {
        print("Transformed boat data: $data");
      })
      .asFuture()
      .catchError((error) => print("Transform error: $error"));

  print("\n=== Weather Stream ===");

  // Weather stream example
  await weatherStream().listen((weather) {
    print("Current weather: $weather");
  }).asFuture();

  print("\n=== Broadcast Stream (Temperature) ===");

  // Multiple listeners on broadcast stream
  temperatureController.stream.listen((temp) {
    print("Thermometer 1: ${temp.toStringAsFixed(1)}°C");
  });

  temperatureController.stream.listen((temp) {
    if (temp > 25) {
      print("AC System: Temperature high! ${temp.toStringAsFixed(1)}°C");
    }
  });

  temperatureController.stream.where((temp) => temp < 18).listen((temp) {
    print("Heating System: Temperature low! ${temp.toStringAsFixed(1)}°C");
  });

  // Start generating temperature data
  generateTemperature();

  // Wait for temperature stream to complete
  await Future.delayed(Duration(seconds: 10));

  print("\n=== Stream Combination ===");

  // Combine multiple streams
  Stream<String> combinedStream = Stream.periodic(Duration(milliseconds: 500),
      (count) => "Periodic event #${count + 1}").take(5);

  await combinedStream.listen((event) {
    print("Combined: $event");
  }).asFuture();

  print("\nAll streams completed!");
}
