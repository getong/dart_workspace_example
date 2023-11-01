// import 'package:dart_class_construstor_example/dart_class_construstor_example.dart' as dart_class_construstor_example;

// copy from https://itnext.io/deep-dive-in-dart-constructors-51e4c006fb8f

class MyClass {
  MyClass(); // Fires immediately when created (this guy is cons.)
}

void main(List<String> arguments) {
  // print('Hello world: ${dart_class_construstor_example.calculate()}!');
  // Creates an instance
  final ehe = MyClass();

  // 这将给出现在的编译时错误
  Print.log("abc");
}

// Default Constructor
// Does nothing special
class User1 {
  String name = 'ehe';
  User1();
} ///////////////////

// Constructor with parameters
// Gets parameters and assigns to them to their variables
class User2 {
  String name;
  User2(this.name);
} ///////////////////

// Constructor with the initial method
// Fires the codes immediately
class User3 {
  String name;
  User3(this.name) {
    // do some magic
  }
} /////////////////

// Constructor with assertion
// Asserts some rules to parameters
class User4 {
  String name;
  User4(this.name) : assert(name.length > 3);
} ////////////////

// Constructor with initializer
// You can also initialize the values with customizations tho!
class User5 {
  static String uppercase(String e) => e.toUpperCase();
  String name;
  User5(name) : name = yell(name);
  static String yell(String e) => e.toUpperCase();
} /////////////////////

// Constructor with super()
// you can override the values it extends
abstract class Person {
  String id;
  Person(this.id);
}


class Print {
  // 这将阻止创建实例
  Print._();
  static void log(String message) => print(message);
}


class User6 {
  String name;
  int salary;
  User6.worker(this.name) : salary = 10;
  User6.boss(this.name) : salary = 99999999;
  User6._mafia(this.name) : salary = 9999999999999;
}

class User7 {
  User7._privateConstructor();
  static final User7 instance = User7._privateConstructor();
}

class User8 {
  final String name;
  User8(this.name);

  factory User8.fromJson(Map<String, dynamic> json) {
    return User8(json["name"]);
  }
}

// Singleton Example
class User9 {
  User9._internal();
  static final User9 _singleton = User9._internal();

  factory User9() => _singleton;
}
// copy from https://segmentfault.com/a/1190000041760217