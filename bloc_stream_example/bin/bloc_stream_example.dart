// import 'package:bloc_stream_example/bloc_stream_example.dart' as bloc_stream_example;

import 'package:bloc/bloc.dart';

sealed class CounterEvent {}

final class CounterIncrementPressed extends CounterEvent {}

class CounterBloc extends Bloc<CounterEvent, int> {
  CounterBloc() : super(0) {
    on<CounterIncrementPressed>((event, emit) {
      emit(state + 1);
    });
  }
}

Future<void> main() async {
  final bloc = CounterBloc();
  final subscription = bloc.stream.listen(print); // 1
  bloc.add(CounterIncrementPressed());
  await Future.delayed(Duration.zero);
  await subscription.cancel();
  await bloc.close();
}
