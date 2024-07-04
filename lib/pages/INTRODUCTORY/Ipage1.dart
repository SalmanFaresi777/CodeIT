import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class Introductory1 extends StatefulWidget {
  const Introductory1({super.key});

  @override
  State<Introductory1> createState() => _Introductory1State();
}

class _Introductory1State extends State<Introductory1> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white54,
          body: SafeArea(
            child: SlideInDown(
              child: Column(
                children: [
                  Center(
                            child: Lottie.asset(
                                'lib/images/I1.json',
                                height: 500,
                              width: 500,
                            )
                  ),
                  const SizedBox(height: 10,),
                  Text(
                    'CodeIT',
                    style: TextStyle(
                      fontSize: 20,
                      color: Color(0xff1473e6),
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Comfortaa'
                    ),
                  ),
                  const SizedBox(height: 20,),
                  Text(
                    'A competitive programming companion',
                    style: TextStyle(
                      fontSize: 16,
                      color: Color(0xff1473e6),
                      fontFamily: 'Comfortaa',

                    ),
                  ),
                  const SizedBox(height: 10,),
                  Text(
                    'Ignite your Competitive Excellence!',
                    style: TextStyle(
                        fontSize: 14,
                        color: Color(0xff1473e6),
                        fontFamily: 'Comfortaa',

                    ),
                  ),
                ],
              ),
            ),
          ),
    );
  }
}
