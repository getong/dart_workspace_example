// import 'package:dart_unix_time_datetime_example/dart_unix_time_datetime_example.dart' as dart_unix_time_datetime_example;

// void main(List<String> arguments) {
//   print('Hello world: ${dart_unix_time_datetime_example.calculate()}!');
// }


void main() {
  // Unix timestamp in seconds
  int unixTimestamp = 1634371200; // Replace this with your Unix timestamp

  // Convert Unix timestamp to milliseconds
  int millisecondsSinceEpoch = unixTimestamp * 1000;

  // Create a DateTime object from the milliseconds since epoch
  DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(millisecondsSinceEpoch);

  print('Unix Timestamp: $unixTimestamp');
  print('DateTime: $dateTime');


  // Create a DateTime object representing a specific date and time
  DateTime dateTime2 = DateTime.now(); // You can use any DateTime object you want to convert

  // Convert DateTime to Unix timestamp in seconds
  int unixTimestamp2 = (dateTime2.millisecondsSinceEpoch / 1000).round();

  print('DateTime: $dateTime2');
  print('Unix Timestamp: $unixTimestamp2');
}
