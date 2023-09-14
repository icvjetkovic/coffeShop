import 'package:coffe_shop/bloc_counter/counter_bloc.dart';
import 'package:coffe_shop/bloc_counter/counter_state.dart';
import 'package:coffe_shop/screens/intro_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/favorite_bloc.dart';
import '../bloc/favorite_event.dart';
import '../bloc/favorite_state.dart';
import 'CounterWidget.dart';

class PageNew extends StatelessWidget {
  final Coffee coffee;
  const PageNew({
    Key? key,
    required this.coffee,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var fav = ModalRoute.of(context)!.settings.arguments as bool;
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => FavoriteBloc(),
        ),
        BlocProvider(
          create: (context) => CounterBloc(),
        ),
      ],
      child: BlocBuilder<FavoriteBloc, FavoriteState>(
        builder: (context, favoriteState) {
          return Scaffold(
            extendBodyBehindAppBar: true,
            appBar: AppBar(
              elevation: 0,
              backgroundColor: Colors.transparent,
              leading: IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () {
                  fav = favoriteState.isFavorite;
                  Navigator.pop(context, fav);
                },
              ),
              actions: [
                () {
                  if (fav) {
                    favoriteState.isFavorite = true;
                  }
                  return IconButton(
                    icon: const Icon(Icons.favorite),
                    color: favoriteState.isFavorite ? Colors.red : Colors.white,
                    onPressed: () {
                      fav = false;
                      context.read<FavoriteBloc>().add(FavoriteToggleEvent());
                    },
                  );
                }()
              ],
            ),
            body: Stack(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * 1,
                  padding: const EdgeInsets.all(20),
                  decoration: const BoxDecoration(
                    color: Colors.brown,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 300,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10, top: 10),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            '//${coffee.coffeType}',
                            style: const TextStyle(fontSize: 15, color: Colors.white),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10, top: 10),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            coffee.title,
                            // ignore: prefer_const_constructors
                            style: TextStyle(fontSize: 20, color: Colors.white, fontStyle: FontStyle.italic),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      CounterWidget(coffee: coffee),
                      const SizedBox(
                        height: 50,
                      ),
                      Text(
                        '$coffee.coffeDesc',
                        style: const TextStyle(fontSize: 15, fontStyle: FontStyle.italic, fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                      const SizedBox(
                        height: 70,
                      ),
                      Text(
                        'Volume: ${coffee.volumeOz}',
                        style: const TextStyle(fontSize: 15, fontStyle: FontStyle.italic, fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: MediaQuery.of(context).size.height * 0.4,
                  padding: const EdgeInsets.all(20),
                  // ignore: prefer_const_constructors
                  decoration: BoxDecoration(
                    // ignore: prefer_const_constructors
                    borderRadius: BorderRadius.only(
                        bottomLeft: const Radius.circular(30),

                        // ignore: prefer_const_constructors
                        bottomRight: Radius.circular(30)),
                    color: const Color.fromARGB(255, 46, 32, 27),
                  ),
                  child: Image.asset(coffee.img),
                ),
                BlocBuilder<CounterBloc, CounterState>(
                  builder: (context, counterState) {
                    return Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 50.0, vertical: 20),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                            backgroundColor: const Color.fromARGB(255, 46, 38, 35),
                          ),
                          onPressed: () => showDialog(
                            context: context,
                            builder: ((context) => AlertDialog(
                                  backgroundColor: Colors.brown.shade100,
                                  title: Text('Successfully ordered'
                                      ' ${coffee.title}!'),
                                  content: Text('You ordered '
                                      '${counterState.counter}'
                                      ' ${coffee.title}!'),
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
                          child: const Text(
                            'Order now!',
                            style: TextStyle(fontSize: 20, color: Colors.white),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
            backgroundColor: Colors.brown,
          );
        },
      ),
    );
  }
}
