// import 'package:cubit_stream_subscription_example/cubit_stream_subscription_example.dart' as cubit_stream_subscription_example;
import 'package:bloc/bloc.dart';
class CounterCubit extends Cubit<int>{
  CounterCubit() : super(0);

  void increment() => emit(state +1);
  void decrement() => emit(state -1);
}

Future<void> main(List<String> arguments) async{
  // print('Hello world: ${cubit_stream_subscription_example.calculate()}!');
  final cubit = CounterCubit();
  final streamSubscription = cubit.stream.listen(print);

  cubit.increment();
  cubit.increment();
  cubit.increment();
  cubit.increment();

  await Future.delayed(Duration.zero);
  await streamSubscription.cancel();
  await cubit.close();
}
