// import 'package:function_example/function_example.dart' as function_example;
import 'package:fpdart/fpdart.dart';

void sayHello(String name) {
  print('Hello $name');
}

Either<FormatException, double> parseNumber(String value) {
  try {
    return Either.right(double.parse(value));
  } on FormatException catch (e) {
    return Either.left(e);
  }
}

Either<String, double> divide(int a, int b) {
  if (b == 0) {
    return Left("cannot divide by 0");
  } else {
    return Right(a / b);
  }
}

void divideEither1() {
  final result = divide(10, 0);
  result.fold((error) => print(error), (value) => print(value));
}

void divideEither() {
  final result = divide(10, 0);
  switch (result) {
    case Left(value: final error):
      print(error);
    case Right(value: final value):
      print(value);
  }
}

void main(List<String> arguments) {
  // print('Hello world: ${function_example.calculate()}!');
  final fnOne = sayHello;
  final fnTwo = sayHello.call;
  fnOne('John');
  fnTwo('Jane');

  divideEither();
}
