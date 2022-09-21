import 'package:coffe_shop/blocCounter/CounterEvent.dart';
import 'package:coffe_shop/blocCounter/CounterState.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CounterBloc extends Bloc<CounterEvent, CounterState> {
  CounterBloc() : super(CounterState(counter: 0)) {
    on<CounterIncrementEvent>(_increment);
    on<CounterDecrementEvent>(_decrement);
  }

  Future<void> _increment(
      CounterIncrementEvent event, Emitter<CounterState> emit) async {
    emit(state.copyWith(counter: state.counter + 1));
  }

  Future<void> _decrement(
      CounterDecrementEvent event, Emitter<CounterState> emit) async {
    emit(state.copyWith(counter: state.counter - 1));
  }
}
