// ignore_for_file: public_member_api_docs, sort_constructors_first

class CounterState {
  int counter;
  CounterState({
    required this.counter,
  });

  CounterState copyWith({
    int? counter,
  }) {
    return CounterState(
      counter: counter ?? this.counter,
    );
  }
}
