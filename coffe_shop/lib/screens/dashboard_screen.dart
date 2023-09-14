// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:coffe_shop/bloc_counter/counter_bloc.dart';
import 'package:coffe_shop/bloc_counter/counter_state.dart';
import 'package:coffe_shop/screens/intro_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OrderNow extends StatelessWidget {
  const OrderNow({
    Key? key,
    required this.coffee,
  }) : super(key: key);

  final Coffee coffee;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CounterBloc(),
      child: BlocBuilder<CounterBloc, CounterState>(
        builder: (context, counterState) {
          return SizedBox(
            width: 100,
            child: Material(
              color: Colors.brown,
              child: Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: InkWell(
                  onTap: () => showDialog(
                    context: context,
                    builder: ((context) => AlertDialog(
                          title: Text('Successfully ordered' ' ${coffee.title}'),
                          // ignore: prefer_interpolation_to_compose_strings
                          content: Text('You ordered  ' '${counterState.counter}' '  amount'),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(context, 'Cancel'),
                              child: const Text(
                                'Cancel',
                                style: TextStyle(color: Colors.black),
                              ),
                            ),
                            TextButton(
                              onPressed: () => Navigator.pop(context, 'OK'),
                              child: const Text(
                                'OK',
                                style: TextStyle(color: Colors.black),
                              ),
                            ),
                          ],
                        )),
                  ),
                  child: const Center(
                      child: Text(
                    'Order Now',
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  )),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
