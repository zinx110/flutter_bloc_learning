import "package:flutter_bloc/flutter_bloc.dart";

class CounterCubit extends Cubit<int> {
  CounterCubit() : super(0);
  void increment() {
    print("Before $state");
    emit(state + 1);
    print("After $state");
  }

  void decrement() {
    if (state == 0) return;
    emit(state - 1);
  }
}
