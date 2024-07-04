import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttericon/font_awesome_icons.dart';
import 'package:fluttericon/linecons_icons.dart';
import 'package:realpalooza/Screens/profile.dart';
import 'package:realpalooza/Screens/settings.dart';
import 'package:realpalooza/pages/competitive.dart';
import 'learning.dart';

class BaseScreen extends StatefulWidget {
  final int selectedIndex;

  const BaseScreen({Key? key, required this.selectedIndex}) : super(key: key);

  @override
  State<BaseScreen> createState() => _BaseScreenState(selectedIndex);
}

class _BaseScreenState extends State<BaseScreen> {
  int _selectedIndex;
  final user = FirebaseAuth.instance.currentUser!;

  _BaseScreenState(this._selectedIndex);

  static final List<Widget> _widgetOptions = <Widget>[
    const Profile(),
    LearnProgrammingPage(),
    const Competitive(),
    Settings(),
  ];

  @override
  Widget build(BuildContext context) {
    final items = <Widget>[
      Icon(Icons.person_outline,size: 30,),
      Icon(FontAwesome.lightbulb,size: 30,),
      Icon(Linecons.desktop,size: 30,),
      Icon(Icons.settings_outlined,size: 30,),
    ];
    return Scaffold(
      body: Center(
       child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
          iconTheme: IconThemeData(color: Theme.of(context).brightness == Brightness.dark ? Colors.black : Colors.black,)
        ),
        child: CurvedNavigationBar(
          color: Theme.of(context).colorScheme.primary,
          backgroundColor: Colors.white54,
          buttonBackgroundColor: Colors.greenAccent,
          height: 60,
          animationCurve: Curves.decelerate,
          index: _selectedIndex,
          items: items,
          onTap: (index) => setState(() {
            this._selectedIndex = index;
          }),
        ),
      ),
    );
  }
}
