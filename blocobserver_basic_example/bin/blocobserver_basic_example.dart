// import 'package:blocobserver_basic_example/blocobserver_basic_example.dart' as blocobserver_basic_example;

import 'package:bloc/bloc.dart';

class CounterCubit extends Cubit<int>{
  CounterCubit() : super(0);

  void increment() => emit(state +1);
  void decrement() => emit(state -1);
}

class SimpleBlocObserver extends BlocObserver {
  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    print('${bloc.runtimeType} $change');
  }
}


void main(List<String> arguments) {
  // print('Hello world: ${blocobserver_basic_example.calculate()}!');
  Bloc.observer = SimpleBlocObserver();
  CounterCubit()
  ..increment()
  ..close();
}
