// ignore_for_file: prefer_const_constructors

import 'package:coffe_shop/main.dart';
import 'package:coffe_shop/screens/first_Screen.dart';
import 'package:flutter/material.dart';

class GetStartedScreen extends StatelessWidget {
  const GetStartedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 209, 106, 69),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 50.0, vertical: 20),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            shape: new RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30)),
            primary: Color.fromARGB(255, 46, 38, 35),
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => FirstScreen()),
            );
          },
          // ignore: prefer_const_constructors
          child: Text(
            'Get started',
            // ignore: prefer_const_constructors
            style: TextStyle(
                color: Colors.white,
                fontStyle: FontStyle.italic,
                fontWeight: FontWeight.bold,
                fontSize: 20),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 100, horizontal: 100),
        child: Column(
          children: [
            Container(
              width: 250,
              height: 350,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('images/coffe1.png'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
