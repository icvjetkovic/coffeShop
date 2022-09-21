import 'package:coffe_shop/blocCounter/CounterState.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/favorite_bloc.dart';
import '../bloc/favorite_event.dart';
import '../bloc/favorite_state.dart';
import '../blocCounter/CounterBloc.dart';
import '../popOut_screen/firstListScreen.dart';
import 'CounterWidget.dart';
import 'first_Screen.dart';

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
                icon: Icon(Icons.arrow_back),
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
                    icon: Icon(Icons.favorite),
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
                  //height: double.infinity,
                  padding: EdgeInsets.all(20),
                  // ignore: prefer_const_constructors
                  decoration: BoxDecoration(
                    color: Colors.brown,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // ignore: prefer_const_constructors
                      SizedBox(
                        height: 300,
                      ),

                      // ignore: prefer_const_constructors
                      Padding(
                        padding: EdgeInsets.only(left: 10, top: 10),
                        // ignore: prefer_const_constructors
                        child: Align(
                          alignment: Alignment.centerLeft,
                          // ignore: prefer_const_constructors
                          child: Text(
                            '//${coffee.coffeType}',

                            // ignore: prefer_const_constructors
                            style: TextStyle(fontSize: 15, color: Colors.white),
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
                            style: TextStyle(
                                fontSize: 20,
                                color: Colors.white,
                                fontStyle: FontStyle.italic),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      CounterWidget(coffee: coffee),

                      SizedBox(
                        height: 50,
                      ),
                      Text(
                        '${coffee.coffeDesc}',
                        style: TextStyle(
                            fontSize: 15,
                            fontStyle: FontStyle.italic,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                      SizedBox(
                        height: 70,
                      ),
                      Text(
                        'Volume: ' + coffee.volumeOz,
                        style: TextStyle(
                            fontSize: 15,
                            fontStyle: FontStyle.italic,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: MediaQuery.of(context).size.height * 0.4,
                  padding: EdgeInsets.all(20),
                  // ignore: prefer_const_constructors
                  decoration: BoxDecoration(
                    // ignore: prefer_const_constructors
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(30),

                        // ignore: prefer_const_constructors
                        bottomRight: Radius.circular(30)),
                    color: Color.fromARGB(255, 46, 32, 27),
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
                        padding: const EdgeInsets.symmetric(
                            horizontal: 50.0, vertical: 20),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            shape: new RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30)),
                            primary: Color.fromARGB(255, 46, 38, 35),
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
                                      onPressed: () =>
                                          Navigator.pop(context, 'Cancel'),
                                      child: const Text(
                                        'Cancel',
                                        style: TextStyle(color: Colors.black),
                                      ),
                                    ),
                                    TextButton(
                                      onPressed: () =>
                                          Navigator.pop(context, 'OK'),
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
            // bottomNavigationBar: Padding(
            //   padding:
            //       const EdgeInsets.symmetric(horizontal: 50.0, vertical: 20),
            //   child: ElevatedButton(
            //     style: ElevatedButton.styleFrom(
            //       shape: new RoundedRectangleBorder(
            //           borderRadius: BorderRadius.circular(30)),
            //       primary: Color.fromARGB(255, 46, 38, 35),
            //     ),
            //     onPressed: () {
            //       Navigator.push(
            //         context,
            //         MaterialPageRoute(
            //             builder: (context) => OrderNow(coffee: coffee)),
            //       );
            //     },
            //     // ignore: prefer_const_constructors
            //     child: Text(
            //       'Order Now',
            //       // ignore: prefer_const_constructors
            //       style: TextStyle(
            //           color: Colors.white,
            //           fontStyle: FontStyle.italic,
            //           fontWeight: FontWeight.bold,
            //           fontSize: 20),
            //     ),
            //   ),
            // ),
          );
        },
      ),
    );
  }
}
