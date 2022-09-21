// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';

import 'package:coffe_shop/bloc/favorite_bloc.dart';
import 'package:coffe_shop/bloc/favorite_event.dart';
import 'package:coffe_shop/bloc/favorite_state.dart';
import 'package:coffe_shop/blocCounter/CounterEvent.dart';
import 'package:coffe_shop/main.dart';
import 'package:coffe_shop/popOut_screen/firstListScreen.dart';
import 'package:coffe_shop/screens/pageNew.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocCounter/CounterBloc.dart';
import '../blocCounter/CounterState.dart';
import 'counterWidget.dart';

class FirstScreen extends StatefulWidget {
  const FirstScreen({super.key});

  @override
  State<FirstScreen> createState() => _FirstScreenState();
}

class Coffee {
  String title;
  String desc;
  String img;
  double price;
  String coffeType;
  String coffeDesc;
  String volumeOz;

  Coffee(
      {required this.title,
      required this.desc,
      required this.img,
      required this.price,
      required this.coffeType,
      required this.coffeDesc,
      required this.volumeOz});
}

var titleList1 = ['Chemex', 'French Press'];
var titleList2 = ['Latte', 'Cappuccino '];

var coffeType1 = ['Bewing', 'Bewing'];
var coffeType2 = ['Espresso', 'Espresso'];

var descList1 = [
  'Try coffes from Kenya, Ethiopia',
  'Try coffes from Sumatra,Mexico',
];

var descList2 = [
  'Espresso steamed milk and thin of foam',
  'Espresso steamed milk and a lot of foam'
];

var imgList1 = [
  'images/coffe3.png',
  'images/coffe6.png',
];

var imgList2 = ['images/coffe6.png', 'images/coffe5.png'];

var price1 = [2.25, 3.25];
var price2 = [4.25, 2.25];

var coffeDesc1 = [
  'Coffee is a beverage brewed from the roasted and ground seeds of the tropical evergreen coffee plant.',
  'Coffee is a drink prepared from roasted coffee beans, seeds of the Coffea plant species. It is darkly colored, bitter, slightly acidic, and has a stimulating effect on humans, primarily due to its caffeine content, and is one of the most popular drinks in the world.'
];
var coffeDesc2 = [
  'Coffee is one of the three most popular beverages in the world (alongside water and tea), and it is one of the most profitable international commodities.',
  'Coffee is a drink prepared from roasted coffee beans, seeds of the Coffea plant species. It is darkly colored, bitter, slightly acidic, and has a stimulating effect on humans, primarily due to its caffeine content, and is one of the most popular drinks in the world.'
];

var volumeOz1 = ['32 Oz', '23 Oz'];
var volumeOz2 = ['34 Oz', '45 Oz'];

List<Coffee> coffees1 = List.generate(
    titleList1.length,
    (index) => Coffee(
        title: titleList1[index],
        desc: descList1[index],
        img: imgList1[index],
        price: price1[index],
        coffeType: coffeType1[index],
        coffeDesc: coffeDesc1[index],
        volumeOz: volumeOz1[index]));

List<Coffee> coffees2 = List.generate(
  titleList1.length,
  (index) => Coffee(
      title: titleList2[index],
      desc: descList2[index],
      img: imgList2[index],
      price: price2[index],
      coffeType: coffeType2[index],
      coffeDesc: coffeDesc2[index],
      volumeOz: volumeOz2[index]),
);

class _FirstScreenState extends State<FirstScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          leading: GestureDetector(
            child: const Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            ),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          actions: [
            const Icon(
              Icons.search,
              color: Colors.black,
              size: 33,
            ),
          ],
        ),
        body: Stack(alignment: AlignmentDirectional.bottomCenter, children: <
            Widget>[
          Container(
            decoration: const BoxDecoration(
              color: Color(0xff7c94b6),
              image: DecorationImage(
                image: AssetImage('images/coffe2.png'),
                fit: BoxFit.fitHeight,
              ),
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height * 0.7,
            padding: const EdgeInsets.all(20),
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30), topRight: Radius.circular(30)),
              color: Colors.brown,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Text(
                      'Brewing Coffee',
                      style: TextStyle(fontSize: 25, color: Colors.white),
                    ),
                  ],
                ),
                SizedBox(
                  height: 220,
                  child: ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    padding: const EdgeInsets.all(30),
                    scrollDirection: Axis.horizontal,
                    itemCount: imgList1.length,
                    itemBuilder: (context, index) {
                      var result;
                      return BlocProvider(
                        create: (context) => FavoriteBloc(),
                        child: BlocBuilder<FavoriteBloc, FavoriteState>(
                          builder: (context, favoriteState) {
                            return GestureDetector(
                              onTap: () async {
                                result = await Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        PageNew(coffee: coffees1[index]),
                                    settings: RouteSettings(
                                      arguments: favoriteState.isFavorite,
                                    ),
                                  ),
                                );
                                if (favoriteState.isFavorite != result) {
                                  context
                                      .read<FavoriteBloc>()
                                      .add(FavoriteToggleEvent());
                                }
                              },
                              child: Container(
                                width: 150,
                                margin: const EdgeInsets.only(right: 20),
                                // ignore: sort_child_properties_last
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Column(
                                    children: [
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Flexible(
                                            child: Image.asset(
                                              coffees1[index].img,
                                            ),
                                          ),
                                          IconButton(
                                            icon: const Icon(Icons.favorite),
                                            color: favoriteState.isFavorite
                                                ? Colors.red
                                                : Colors.white,
                                            onPressed: () {
                                              context
                                                  .read<FavoriteBloc>()
                                                  .add(FavoriteToggleEvent());
                                            },
                                          ),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(coffees1[index].title),
                                          Text(coffees1[index].price.toString())
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 7,
                                      ),
                                      Text(
                                        descList1[index],
                                        style: const TextStyle(
                                            fontSize: 9,
                                            fontStyle: FontStyle.italic,
                                            fontWeight: FontWeight.bold),
                                      )
                                    ],
                                  ),
                                ),
                                decoration: const BoxDecoration(
                                    color: Color.fromARGB(255, 221, 169, 149),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(30))),
                              ),
                            );
                          },
                        ),
                      );
                    },
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Text(
                      'Espresso',
                      style: TextStyle(fontSize: 25, color: Colors.white),
                    ),
                  ],
                ),
                SizedBox(
                  height: 220,
                  child: ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      padding: const EdgeInsets.all(30),
                      scrollDirection: Axis.horizontal,
                      itemCount: imgList2.length,
                      itemBuilder: (context, index) {
                        return BlocProvider(
                          create: (context) => FavoriteBloc(),
                          child: BlocBuilder<FavoriteBloc, FavoriteState>(
                            builder: (context, favoriteState1) {
                              return GestureDetector(
                                  onTap: () async {
                                    bool result =
                                        await Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            PageNew(coffee: coffees2[index]),
                                        settings: RouteSettings(
                                          arguments: favoriteState1.isFavorite,
                                        ),
                                      ),
                                    );
                                    if (favoriteState1.isFavorite != result) {
                                      context
                                          .read<FavoriteBloc>()
                                          .add(FavoriteToggleEvent());
                                    }
                                  },
                                  child: Container(
                                    width: 150,
                                    margin: const EdgeInsets.only(right: 20),
                                    // ignore: sort_child_properties_last
                                    child: Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Column(
                                        children: [
                                          Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Flexible(
                                                child: Image.asset(
                                                  coffees2[index].img,
                                                ),
                                              ),
                                              IconButton(
                                                icon:
                                                    const Icon(Icons.favorite),
                                                color: favoriteState1.isFavorite
                                                    ? Colors.red
                                                    : Colors.white,
                                                onPressed: () {
                                                  context
                                                      .read<FavoriteBloc>()
                                                      .add(
                                                          FavoriteToggleEvent());
                                                },
                                              ),
                                            ],
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(titleList2[index]),
                                              Text(coffees2[index]
                                                  .price
                                                  .toString())
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 7,
                                          ),
                                          Text(
                                            descList1[index],
                                            style: const TextStyle(
                                                fontSize: 9,
                                                fontStyle: FontStyle.italic,
                                                fontWeight: FontWeight.bold),
                                          )
                                        ],
                                      ),
                                    ),
                                    decoration: const BoxDecoration(
                                        color:
                                            Color.fromARGB(255, 221, 169, 149),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(30))),
                                  ));
                            },
                          ),
                        );
                      }),
                )
              ],
            ),
          )
        ]));
  }
}
