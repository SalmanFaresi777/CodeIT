import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class Introductory2 extends StatefulWidget {
  const Introductory2({Key? key}) : super(key: key);

  @override
  State<Introductory2> createState() => _Introductory1State();
}

class _Introductory1State extends State<Introductory2> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white54,
      body: SafeArea(
        child: SlideInDown(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                child: Text(
                  'Explore Algorithms, Tutorials, and',
                  style: TextStyle(
                    fontSize: 16,
                    color: Color(0xff1473e6),
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Comfortaa',
                  ),
                ),
              ),
              Center(
                child: Text(
                  'Various Coding Challenges!',
                  style: TextStyle(
                    fontSize: 16,
                    color: Color(0xff1473e6),
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Comfortaa',
                  ),
                ),
              ),
              const SizedBox(height: 50),
              Lottie.asset('lib/images/I2.json', height: 400, width: 400),
              const SizedBox(height: 100,)
            ],
          ),
        ),
      ),
    );
  }
}
