import 'package:flutter/material.dart';
import 'package:realpalooza/Services/auth_page.dart';
import 'package:realpalooza/pages/INTRODUCTORY/Ipage1.dart';
import 'package:realpalooza/pages/INTRODUCTORY/Ipage3.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import 'INTRODUCTORY/Ipage2.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  PageController _controller = PageController();
  bool onlastPage = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            physics: NeverScrollableScrollPhysics(),
            controller: _controller,
            onPageChanged: (index) {
              setState(() {
                onlastPage = (index == 2);
              });
            },
            children: [
              Introductory1(),
              Introductory2(),
              Introductory3(),
            ],
          ),
          Container(
            alignment: Alignment(0, 0.75),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  onTap: () {
                    _controller.jumpToPage(2);
                  },
                  child: Text(
                    'Skip',
                    style: TextStyle(
                        color: Colors.redAccent,
                        fontFamily: 'Comfortaa',
                        fontWeight: FontWeight.bold),
                  ),
                ),
                onlastPage
                    ? GestureDetector(
                  onTap: () {
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (BuildContext context) {
                          return Authpage();
                        },
                      ),
                          (route) => false,
                    );
                  },
                  child: Text(
                    'done',
                    style: TextStyle(
                        color: Colors.redAccent,
                        fontFamily: 'Comfortaa',
                        fontWeight: FontWeight.bold),
                  ),
                )
                    : GestureDetector(
                  onTap: () {
                    _controller.nextPage(
                        duration: Duration(milliseconds: 500),
                        curve: Curves.easeIn);
                  },
                  child: Text(
                    'next',
                    style: TextStyle(
                        color: Colors.redAccent,
                        fontFamily: 'Comfortaa',
                        fontWeight: FontWeight.bold),
                  ),
                )
              ],
            ),
          ),
          Positioned(
            bottom: 110.0, // Adjust the position as needed
            left: 0,
            right: 0,
            child: Center(
              child: SmoothPageIndicator(
                controller: _controller,
                count: 3,
                effect: WormEffect(
                  radius: 10,
                  dotWidth: 10,
                  dotHeight: 10,
                  activeDotColor: Colors.redAccent,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
