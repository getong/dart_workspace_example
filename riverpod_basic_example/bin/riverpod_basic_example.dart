import 'package:riverpod/riverpod.dart';

void main(List<String> arguments) {
  final Provider<String> provider = Provider((ref){
      return 'hello';
  });

  final container = ProviderContainer();

  final hello = container.read(provider);
  print(hello);
}