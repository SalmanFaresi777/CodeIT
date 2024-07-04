import 'package:animate_do/animate_do.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttericon/font_awesome_icons.dart';
import 'package:fluttericon/mfg_labs_icons.dart';
import 'package:fluttericon/octicons_icons.dart';
import 'package:fluttericon/typicons_icons.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:realpalooza/Screens/chatPage.dart';
import 'package:realpalooza/Screens/edit_profile.dart';
import 'package:realpalooza/Services/auth_page.dart';
import 'package:shimmer/shimmer.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final currentUser = FirebaseAuth.instance.currentUser!;
  bool isLoading = true;
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(milliseconds: 3000), () {
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
    });
  }
  Future signUserOut() async {
    showDialog(
      context: context,
      builder: (context) {
        return const Center(
          child: CircularProgressIndicator(color: Color(0xff26b051)),
        );
      },
    );
    Future.delayed(const Duration(milliseconds: 1000), () async {
      try {
        GoogleSignIn().signOut();
        FirebaseAuth.instance.signOut();
        if (context.mounted) Navigator.of(context).pop();
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (BuildContext context) {
              return Authpage();
            },
          ),(route)=>false,
        );
      } on FirebaseAuthException catch (e) {
        if (context.mounted) Navigator.of(context).pop();
        print(e.code);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white54,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        centerTitle: true,
        title: Text(
          'My Profile',
          style: TextStyle(
            fontFamily: 'Comfortaa',
            fontSize: 25,
            color: Colors.black54,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              signUserOut();
            },
            icon: Icon(
                Icons.logout,
            ),
          ),
        ],
        leading: IconButton(
          onPressed: (){
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return ChatPage();
                },
              ),
            );
          },
          icon: (
              Icon(
                Theme.of(context).brightness == Brightness.dark
                    ? Icons.chat_bubble_outlined
                    : Icons.chat_bubble_outline,
                color: Theme.of(context).brightness == Brightness.dark
                    ?Colors.white.withOpacity(.8)
                    :Colors.grey[800],
              )
          ),
        ),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(25),
            bottomRight: Radius.circular(25),
          ),
        ),
      ),
      body: StreamBuilder<DocumentSnapshot>(
        stream: FirebaseFirestore.instance.collection("Users").doc(currentUser.email).snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            Map<String, dynamic> userData = <String, dynamic>{};
            if (snapshot.data!.data() != null) {
              userData = snapshot.data!.data() as Map<String, dynamic>;
            } else {
              userData['username'] = 'Set Your Name';
              userData['dp'] = 'https://i.postimg.cc/CL3mxvsB/emptyprofile.jpg';
            }
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
                child: Column(
                  children: [
                    SlideInDown(
                      child: Container(
                        width: double.infinity,
                        height: 180,
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.primary,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const SizedBox(width: 20),
                            Container(
                              width: 120,
                              height: 120,
                              child: ClipOval(
                                child: isLoading
                                    ? Shimmer.fromColors(
                                  baseColor: Colors.grey[300]!,
                                  highlightColor: Colors.grey[100]!,
                                  child: Container(
                                    color: Colors.white,
                                  ),
                                )
                                    : Image.network(
                                  userData['dp'],
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    userData['username'],
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontFamily: 'Comfortaa',
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 15),
                                  Text(
                                    currentUser.email!,
                                    textAlign: TextAlign.start,
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.black54,
                                      fontFamily: 'Comfortaa',
                                    ),
                                  ),
                                  const SizedBox(height: 5),
                                  Row(
                                    children: [
                                      Icon(
                                        Typicons.edit, size: 25,
                                        color: Colors.blueAccent,
                                      ),
                                      Text(
                                        '  Edit Profile',
                                        style: TextStyle(
                                          color: Colors.blueAccent,
                                          fontSize: 16,
                                          fontFamily: 'Comfortaa',
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      IconButton(
                                        onPressed: () {
                                          Navigator.pushAndRemoveUntil(
                                            context,
                                            MaterialPageRoute(
                                              builder: (BuildContext context) {
                                                return EditProfille();
                                              },
                                            ),(route) => false,
                                          );
                                        },
                                        icon: Icon(
                                          FontAwesome.angle_right,
                                          size: 20,
                                          color: Colors.blueAccent,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 30,),
                    SlideInLeft(
                      child: Row(
                        children: [
                          const SizedBox(width: 15,),
                          Expanded(
                            child: Column(
                              children: [
                                Container(
                                  width: 65,
                                  height: 65,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: Colors.redAccent,
                                      width: 3.0,
                                    ),
                                  ),
                                  child: IconButton(
                                    onPressed: () {},
                                    icon: Icon(Icons.bar_chart_rounded, size: 40, color: Colors.redAccent),
                                  ),
                                ),
                                const SizedBox(height: 8,),
                                Text(
                                  'Graph',
                                  style: TextStyle(fontSize: 14, fontFamily: 'Comfortaa', fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 20,),
                          Expanded(
                            child: Column(
                              children: [
                                Container(
                                  width: 65,
                                  height: 65,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: Colors.greenAccent,
                                      width: 3.0,
                                    ),
                                  ),
                                  child: IconButton(
                                    onPressed: () {},
                                    icon: Icon(Icons.task_outlined, size: 40, color: Colors.greenAccent),
                                  ),
                                ),
                                const SizedBox(height: 8,),
                                Text(
                                  'Streak',
                                  style: TextStyle(fontSize: 14, fontFamily: 'Comfortaa', fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 20,),
                          Expanded(
                            child: Column(
                              children: [
                                Container(
                                  width: 65,
                                  height: 65,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: Colors.blueAccent,
                                      width: 3.0,
                                    ),
                                  ),
                                  child: IconButton(
                                    onPressed: () {},
                                    icon: Icon(FontAwesome.wrench, size: 40, color: Colors.blueAccent),
                                  ),
                                ),
                                const SizedBox(height: 8,),
                                Text(
                                  'Skills',
                                  style: TextStyle(fontSize: 14, fontFamily: 'Comfortaa', fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 30,),
                    ZoomIn(
                      child: Row(
                        children: [
                          const SizedBox(width: 30,),
                          Text('More Tools',style: TextStyle(color: Colors.grey,fontSize:16,fontFamily: 'Comfortaa'),),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20,),
                    SlideInLeft(
                      child: Row(
                        children: [
                          Expanded(
                            child: Icon(
                              Octicons.organization, size: 30,
                              color: Colors.deepPurple,
                            ),
                          ),
                          Expanded(
                            flex: 3,
                            child: Text(
                              'Friend list',
                              style: TextStyle(
                                fontFamily: 'Comfortaa',
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                              child: IconButton(
                                onPressed: (){},
                                icon:Icon(Icons.navigate_next_rounded,),
                              )
                          ),
                        ],
                      ),
                    ),
                    SlideInLeft(
                      child: Divider(
                        thickness: 0.1,
                      ),
                    ),
                    SlideInRight(
                      child: Row(
                        children: [
                          Expanded(
                            child: Icon(
                              FontAwesome.award, size: 30,
                              color: Colors.red,
                            ),
                          ),
                          Expanded(
                            flex: 3,
                            child: Text(
                              'Achievements',
                              style: TextStyle(
                                fontFamily: 'Comfortaa',
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Expanded(
                              flex: 1,
                              child: IconButton(
                                onPressed: (){},
                                icon:Icon(Icons.navigate_next_rounded,),
                              )
                          ),
                        ],
                      ),
                    ),
                    SlideInRight(
                      child: Divider(
                        thickness: 0.3,
                        color: Colors.black,
                      ),
                    ),
                    SlideInLeft(
                      child: Row(
                        children: [
                          Expanded(
                            child: Icon(
                              FontAwesome.heart, size: 30,
                              color: Colors.blueAccent,
                            ),
                          ),
                          Expanded(
                            flex: 3,
                            child: Text(
                              'Favourites',
                              style: TextStyle(
                                fontFamily: 'Comfortaa',
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Expanded(
                              flex: 1,
                              child: IconButton(
                                onPressed: (){},
                                icon:Icon(Icons.navigate_next_rounded,),
                              )
                          ),
                        ],
                      ),
                    ),
                    SlideInLeft(
                      child: Divider(
                        thickness: 0.3,
                        color: Colors.black,
                      ),
                    ),
                    SlideInRight(
                      child: Row(
                        children: [
                          Expanded(
                            child: Icon(
                              FontAwesome.attach, size: 30,
                              color: Colors.deepOrange,
                            ),
                          ),
                          Expanded(
                            flex: 3,
                            child: Text(
                              'Linked Accounts',
                              style: TextStyle(
                                fontFamily: 'Comfortaa',
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Expanded(
                              flex: 1,
                              child: IconButton(
                                onPressed: (){},
                                icon:Icon(Icons.navigate_next_rounded,),
                              )
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 30,),
                    SlideInUp(
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Liking the app? ',
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Comfortaa',
                              ),
                            ),
                            Text(
                              'Please Rate Us',
                              style: TextStyle(
                                color: Colors.blue,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Comfortaa',
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            );
          } else if (snapshot.hasError) {
            // Handle error
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
