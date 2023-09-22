// import 'package:observe_bloc_example/observe_bloc_example.dart' as observe_bloc_example;
import 'package:bloc/bloc.dart';

sealed class CounterEvent {}

final class CounterIncrementPressed extends CounterEvent {}

class CounterBloc extends Bloc<CounterEvent, int> {
  CounterBloc() : super(0) {
    on<CounterIncrementPressed>((event, emit) => emit(state + 1));
  }

  @override
  void onChange(Change<int> change) {
    super.onChange(change);
    print(change);
  }
}

void main(List<String> arguments) {
  // print('Hello world: ${observe_bloc_example.calculate()}!');
  CounterBloc()
    ..add(CounterIncrementPressed())
    ..close();
}
