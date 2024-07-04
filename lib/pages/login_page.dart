import 'package:animate_do/animate_do.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:realpalooza/components/my_button.dart';
import 'package:realpalooza/components/square_tile.dart';
import 'package:realpalooza/pages/forgot_password.dart';
class LoginPage extends StatefulWidget {
  final Function()? ontap;

  const LoginPage({super.key, required this.ontap});//here there was changed called Key? key

  @override
  State<LoginPage> createState() => _LoginPageState();

}

class _LoginPageState extends State<LoginPage> {

  final emailcontroller = TextEditingController();
  final passwordcontroller = TextEditingController();
  bool _obscureText = true;
  void signInWithGoogle() async {
    showDialog(
      context: context,
      builder: (context) {
        return const Center(
          child: CircularProgressIndicator(color: Color(0xff673ab7)),
        );
      },
    );

    try {
      final GoogleSignInAccount? gUser = await GoogleSignIn().signIn();

      if (gUser == null) {
        // User canceled the sign-in
        if (context.mounted) Navigator.of(context).pop();
        return;
      }

      // Obtain details
      final String googleEmail = gUser.email; // Get the Google email

      final GoogleSignInAuthentication gAuth = await gUser.authentication;

      // Create new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: gAuth.accessToken,
        idToken: gAuth.idToken,
      );

      // Check if user data already exists in Firebase
      var userDoc = await FirebaseFirestore.instance.collection("Users").doc(googleEmail).get();
      await FirebaseAuth.instance.signInWithCredential(credential);
      if (userDoc.exists) {
        print('User data already exists. You may want to update it or take other actions.');
      } else {
        int unixTimestamp = -2556088426;
        int millisecondsSinceEpoch = unixTimestamp * 1000;
        Timestamp timestamp = Timestamp.fromMillisecondsSinceEpoch(millisecondsSinceEpoch);
        await FirebaseFirestore.instance.collection("Users").doc(googleEmail).set({
          'dp': 'https://i.postimg.cc/CL3mxvsB/emptyprofile.jpg',
          'username': googleEmail.split('@')[0],
          'Email': googleEmail,
          'institute': 'University Name',
          'dateOfBirth': timestamp,
          'gender': 'Male',
        });
      }

      if (context.mounted) Navigator.of(context).pop();
    } catch (error) {
      print(error);
    }
  }

  void signInwithGithub() async{
    showDialog(
      context: context,
      builder: (context) {
        return const Center(
          child: CircularProgressIndicator(color: Color(0xff673ab7)),
        );
      },
    );
    GithubAuthProvider githubAuthProvider = GithubAuthProvider();
    try{
      await FirebaseAuth.instance.signInWithProvider(githubAuthProvider);
      if (context.mounted) Navigator.of(context).pop();
    }on FirebaseAuthException catch (e){
      if (context.mounted) Navigator.of(context).pop();
      errorShowMessage(context, e.code);
    }
  }

  void signUserIn() async {
    showDialog(
      context: context,
      builder: (context) {
        return const Center(
          child: CircularProgressIndicator(color: Color(0xff673ab7)),
        );
      },
    );

    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailcontroller.text,
        password: passwordcontroller.text,
      );
      if (context.mounted) Navigator.of(context).pop();
    } on FirebaseAuthException catch (e) {
      if (context.mounted) Navigator.of(context).pop();
      errorShowMessage(context, e.code);
    }
  }

  void errorShowMessage(BuildContext context, String text) {
    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: '',
      transitionDuration: const Duration(milliseconds: 400),
      pageBuilder: (context, animation1, animation2) {
        return Container();
      },
      transitionBuilder: (context, a1, a2, widget) {
        return ScaleTransition(
          scale: Tween<double>(begin: 0.5, end: 1.0).animate(a1),
          child: FadeTransition(
            opacity: Tween<double>(begin: 0.5, end: 1.0).animate(a1),
            child: Dialog(
              backgroundColor: const Color(0xffe4f3ec),
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(16)),
              ),
              alignment: Alignment.bottomCenter,
              child: SizedBox(
                height: 80,
                child: Padding(
                  padding: const EdgeInsets.all(25.0),
                  child: Text(
                    text,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Color(0xff673ab7),
                      fontSize: 16,
                      fontFamily: 'Comfortaa',
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:  Colors.white,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 20),
                Bounce(
                  infinite: true,
                  child: Center(
                    child: SizedBox(
                      width: 80,
                      height: 80,
                      child: Image.asset('lib/images/Cute.png'),
                    ),
                  ),
                ),
                BounceInDown(
                  child: Center(
                    child: AnimatedTextKit(
                      repeatForever: true,
                      animatedTexts: [
                        TyperAnimatedText(
                            'CodeIT',
                            speed: const Duration(milliseconds: 800),
                            textStyle: TextStyle(
                                fontFamily: 'Comfortaa',
                                fontSize: 30,
                                color: Color(0xff000000)
                            )
                        )
                      ],
                      onTap: () {
                        print("Tap Event");
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 10,),
                BounceInLeft(
                  child: const Text(
                    'Welcome Back',
                    style: TextStyle(
                        color: Colors.deepPurpleAccent,
                        fontSize: 16,
                        fontFamily: 'Comfortaa',
                        fontWeight: FontWeight.w100
                    ),
                  ),
                ),
                const SizedBox(height: 45,),
                SlideInRight(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: TextField(
                      controller: emailcontroller,
                      decoration: InputDecoration(
                        hintText: 'Email',
                        hintStyle: TextStyle(
                            color: Colors.grey,
                            fontFamily: 'Comfortaa'
                        ),
                        fillColor: Colors.grey[200],
                        filled: true,
                        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                  ),
                ),
                SlideInRight(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(20,5,20,0),
                    child: TextField(
                      controller: passwordcontroller,
                      obscureText: _obscureText, // Add this line to set initial obscureText value
                      decoration: InputDecoration(
                        hintText: 'Password',
                        hintStyle: TextStyle(
                            color: Colors.grey,
                            fontFamily: 'Comfortaa'
                        ),
                        fillColor: Colors.grey[200],
                        filled: true,
                        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide.none,
                        ),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _obscureText ? Icons.visibility : Icons.visibility_off,
                            color: Colors.grey,
                          ),
                          onPressed: () {
                            setState(() {
                              _obscureText = !_obscureText;
                            });
                          },
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10,),
                ZoomIn(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        GestureDetector(
                          onTap: (){
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const ForgotPasswordPage(),
                                )
                            );
                          },
                          child: Text(
                            'Forgot Password?',
                            style: TextStyle(
                                color: Colors.blueAccent,
                                fontFamily: 'Comfortaa'
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 30,),
                ZoomIn(
                  child: Center(
                    child: Container(
                      height: 40,
                      width: 150,
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              textStyle: TextStyle(fontSize: 24),
                              minimumSize: Size.fromHeight(50),
                              shape: StadiumBorder(),
                              backgroundColor: Colors.deepPurpleAccent
                          ),
                          onPressed: (){
                            signUserIn();
                          },
                          child: 2+2==5
                              ?CircularProgressIndicator(color: Colors.white,)
                              :Text(
                            'Sign In',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontFamily: 'Comfortaa'
                            ),
                          )
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 30,),
                FadeIn(
                  child: Center(
                    child: Text(
                      'Or Continue with ',
                      style: TextStyle(
                          color: Colors.deepPurpleAccent,
                          fontFamily: 'Comfortaa',
                          fontWeight: FontWeight.bold
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 22,),
                SlideInLeft(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: (){
                          signInWithGoogle();
                        },
                        child: Container(
                          padding: EdgeInsets.all(8.0),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.grey,
                              width: 1.0,
                            ),
                            borderRadius: BorderRadius.circular(12.0), ),
                          child: Icon(
                            FontAwesome5.google,
                            size: 40,
                          ),
                        ),
                      ),
                      const SizedBox(width: 50),
                      GestureDetector(
                        onTap: (){
                          signInwithGithub();
                        },
                        child: Container(
                          padding: EdgeInsets.all(8.0),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.grey,
                              width: 1.0,
                            ),
                            borderRadius: BorderRadius.circular(12.0), ),
                          child: Icon(
                            FontAwesome5.github,
                            size: 40,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 30,),
                FadeIn(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Already a member?',
                        style: TextStyle(
                            color: Colors.deepPurpleAccent,
                            fontFamily: 'Comfortaa',
                            fontWeight: FontWeight.bold
                        ),
                      ),
                      const SizedBox(width: 4,),
                      GestureDetector(
                        onTap: widget.ontap,
                        child: const Text(
                          'Register now',
                          style: TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Comfortaa',
                          ),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}