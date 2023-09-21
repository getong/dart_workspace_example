// import 'package:observe_cubit_example/observe_cubit_example.dart' as observe_cubit_example;
import 'package:bloc/bloc.dart';

class CounterCubit extends Cubit<int> {
  CounterCubit() : super(0);

  void increment() => emit(state + 1);

  @override
  void onChange(Change<int> change) {
    super.onChange(change);
    print(change);
    print(change.currentState);
    print(change.nextState);
  }
}

void main(List<String> arguments) {
  // print('Hello world: ${observe_cubit_example.calculate()}!');
  CounterCubit()
    ..increment()
    ..close();
}

// see also https://bloclibrary.dev/#/coreconcepts