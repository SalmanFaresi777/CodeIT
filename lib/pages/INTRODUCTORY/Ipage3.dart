import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class Introductory3 extends StatefulWidget {
  const Introductory3({Key? key}) : super(key: key);

  @override
  State<Introductory3> createState() => _Introductory1State();
}

class _Introductory1State extends State<Introductory3> {
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
                    'Dive into CodeIT',
                    style: TextStyle(
                      fontSize: 14,
                      color: Color(0xff1473e6),
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Comfortaa',
                    ),
                  ),
                ),
                Center(
                  child: Text(
                    '– the app that fuels your passion ',
                    style: TextStyle(
                      fontSize: 14,
                      color: Color(0xff1473e6),
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Comfortaa',
                    ),
                  ),
                ),
                Center(
                  child: Text(
                    'For Competitive Programming',
                    style: TextStyle(
                      fontSize: 14,
                      color: Color(0xff1473e6),
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Comfortaa',
                    ),
                  ),
                ),
                Center(
                    child: Lottie.asset(
                      'lib/images/I3.json',
                      height: 400,
                      width: 400,
                    )
                ),
                const SizedBox(height: 20,),
                Center(
                  child: Text(
                    'Elevate your skills, conquer challenges',
                    style: TextStyle(
                        fontSize: 14,
                        color: Color(0xff1473e6),
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Comfortaa',
                    ),
                  ),
                ),
                Center(
                  child: Text(
                    'and emerge as a coding champion!',
                    style: TextStyle(
                        fontSize: 14,
                        color: Color(0xff1473e6),
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Comfortaa',
                    ),
                  ),
                ),
                const SizedBox(height: 100,),
              ],
            ),
          ),
        ),
    );
  }
}
