import 'package:animate_do/animate_do.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:google_sign_in/google_sign_in.dart';
class RegisterPage extends StatefulWidget {
  final Function()? ontap;

  const RegisterPage({Key? key, required this.ontap}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final emailcontroller = TextEditingController();
  final passwordcontroller = TextEditingController();
  final confirmpasswordcontroller = TextEditingController();
  final userNameController = TextEditingController();
  bool _obscureText = true;

  void signInWithGoogle() async {
    showDialog(
      context: context,
      builder: (context) {
        return const Center(
          child: CircularProgressIndicator(color: Color(0xff26b051)),
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
      int unixTimestamp = -2556088426;
      int millisecondsSinceEpoch = unixTimestamp * 1000;
      Timestamp timestamp = Timestamp.fromMillisecondsSinceEpoch(millisecondsSinceEpoch);
      await FirebaseAuth.instance.signInWithCredential(credential);
      FirebaseFirestore.instance.collection("Users").doc(googleEmail).set({
        'dp': 'https://i.postimg.cc/CL3mxvsB/emptyprofile.jpg',
        'username': googleEmail.split('@')[0],
        'Email': googleEmail,
        'institute':'University Name',
        'dateOfBirth': timestamp,
        'gender':'Male',
      });
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
          child: CircularProgressIndicator(color: Color(0xff26b051)),
        );
      },
    );

    GithubAuthProvider githubAuthProvider = GithubAuthProvider();

    try{
      await FirebaseAuth.instance.signInWithProvider(githubAuthProvider);
      if (context.mounted) Navigator.of(context).pop();
    }on FirebaseAuthException catch (e){
      if (context.mounted) Navigator.of(context).pop();
      errorShowMessage(context,e.code);
    }
  }
  void signUserUp() async {
    showDialog(
      context: context,
      builder: (context) {
        return const Center(
          child: CircularProgressIndicator(color: Color(0xff26b051),),
        );
      },
    );
    int unixTimestamp = -2556088426;
    int millisecondsSinceEpoch = unixTimestamp * 1000;
    Timestamp timestamp = Timestamp.fromMillisecondsSinceEpoch(millisecondsSinceEpoch);
    try {
        if (passwordcontroller.text == confirmpasswordcontroller.text) {
        UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailcontroller.text,
          password: passwordcontroller.text,
        );
        FirebaseFirestore.instance
        .collection("Users")
        .doc(userCredential.user!.email)
        .set({
          'dp' : 'https://i.postimg.cc/CL3mxvsB/emptyprofile.jpg',
          'username' : userNameController.text,
          'Email' : userCredential.user!.email,
          'institute':'University Name',
          'dateOfBirth': timestamp,
          'gender':'Male',
        });
        if (context.mounted) Navigator.of(context).pop();
      } else {
          if (context.mounted) Navigator.of(context).pop();
          errorShowMessage(context, 'Password Don\'t Match');
      }
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
                      color: Color(0xff26b051),
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
      backgroundColor: Colors.white,
      body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20.0,70,20,20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
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
                  const SizedBox(height: 30,),
                  ZoomIn(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(10,0,0,0),
                      child: const Text(
                        'Register Account',
                        style: TextStyle(
                            color: Colors.deepPurpleAccent,
                            fontSize: 16,
                            fontFamily: 'Comfortaa',
                            fontWeight: FontWeight.bold
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 30,),
                  SlideInRight(
                    child: TextField(
                      controller: userNameController,
                      decoration: InputDecoration(
                        hintText: 'UserName',
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
                  const SizedBox(height: 20,),
                  SlideInRight(
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
                  const SizedBox(height: 20,),
                  SlideInRight(
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
                  const SizedBox(height: 20,),
                  SlideInRight(
                    child: TextField(
                      controller: confirmpasswordcontroller,
                      obscureText: _obscureText, // Add this line to set initial obscureText value
                      decoration: InputDecoration(
                        hintText: 'Confirm Password',
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
                              signUserUp();
                            },
                            child: 2+2==5
                                ?CircularProgressIndicator(color: Colors.white,)
                                :Text(
                              'Sign Up',
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
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Already a member?',
                          style: TextStyle(
                            color: Colors.deepPurpleAccent,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Comfortaa',
                          ),
                        ),
                        const SizedBox(width: 4,),
                        GestureDetector(
                          onTap: widget.ontap,
                          child: const Text(
                            'Login now',
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
