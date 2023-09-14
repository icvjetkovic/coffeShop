import 'package:coffe_shop/bloc_counter/counter_bloc.dart';
import 'package:coffe_shop/bloc_counter/counter_event.dart';
import 'package:coffe_shop/bloc_counter/counter_state.dart';
import 'package:coffe_shop/screens/intro_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CounterWidget extends StatelessWidget {
  final Coffee coffee;

  const CounterWidget({
    super.key,
    required this.coffee,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(
                Radius.circular(30),
              ),
              border: Border.all(color: Colors.white),
            ),
            child: Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.remove),
                  onPressed: () {
                    context.read<CounterBloc>().add(CounterDecrementEvent());
                  },
                  iconSize: 30,
                  color: Colors.white,
                ),
                BlocBuilder<CounterBloc, CounterState>(
                  builder: (context, counterState) {
                    return Text(
                      '${counterState.counter}',
                      style: const TextStyle(color: Colors.white),
                    );
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: () {
                    context.read<CounterBloc>().add(CounterIncrementEvent());
                  },
                  iconSize: 30,
                  color: Colors.white,
                ),
              ],
            )),
        BlocBuilder<CounterBloc, CounterState>(
          builder: (context, state) {
            return Text('\$' '${coffee.price * state.counter}');
          },
        ),
      ],
    );
  }
}
