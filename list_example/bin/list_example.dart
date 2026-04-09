// import 'package:list_example/list_example.dart' as list_example;

void main(List<String> arguments) {
  list_cast();
}

void list_cast() {
  List<dynamic> dynamicList = ['a', 'b', 'c'];

  // 将 List<dynamic> 转换为 List<String>
  List<String> stringList = dynamicList.cast<String>();

  print(stringList); // 输出: [a, b, c]
  print(stringList is List<String>); // 输出: true
}
