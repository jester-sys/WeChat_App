
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:we_chat/Screen/HomeScreen/home_screen.dart';
import 'package:we_chat/api/Apis.dart';
import 'package:we_chat/utils/Dialogs.dart';

import '../main.dart';

class LoginScreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _LoginScreen();
  }
}
class _LoginScreen extends State<LoginScreen>{
  final emailController = TextEditingController();

  final passwordController = TextEditingController();
  bool _isVisible = true;

  // handles google login button click
  _handleGoogleBtnClick() {
    //for showing progress bar
    CustomDialogs.showprogressBar(context);

    _signInWithGoogle().then((user) async {
      //for hiding progress bar
      Navigator.pop(context);

      if (user != null) {
        // log('\nUser: ${user.user}');
        // log('\nUserAdditionalInfo: ${user.additionalUserInfo}');

        if ((await APIs.userExists())) {
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (_) => HomeScreen()));
        } else {
          await APIs.createUser().then((value) {
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (_) =>  HomeScreen()));
          });
        }
      }
    });
  }

  Future<UserCredential?> _signInWithGoogle() async {
    try {
      await InternetAddress.lookup('google.com');
      // Trigger the authentication flow
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      // Obtain the auth details from the request
      final GoogleSignInAuthentication? googleAuth =
      await googleUser?.authentication;

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      // Once signed in, return the UserCredential
      return await APIs.auth.signInWithCredential(credential);
    } catch (e) {
      // log('\n_signInWithGoogle: $e');
      CustomDialogs.showSnackbar(context, 'Something Went Wrong (Check Internet!)');
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: SingleChildScrollView(
        child: Column(
          children: [
          AnimatedOpacity(
            opacity: _isVisible ? 1.0 : 0.0,
            duration: Duration(milliseconds: 500),
            child:
            Container(
              width: 300,
              height: 300,
              child: Image(

                image: AssetImage('assets/logo/login.png'),
              ),
            ),
          ),
            SizedBox(
              height: 20,
            ),
            Container(
              width: 400,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  controller: passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                   suffixIcon: Icon(
                     CupertinoIcons.mail,
                      color: Colors.blue,
                      size: 24.0,
                    ),
                    hintText: "Enter the Email",
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.lightBlueAccent, width: 2.0),
                      borderRadius: BorderRadius.circular(11),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(11),
                      borderSide: BorderSide(color: Colors.lightBlueAccent, width: 2.0),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(11),
                      borderSide: BorderSide(color: Colors.lightBlueAccent, width: 2.0),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              width: 400,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  controller: emailController,
                  obscureText: true,
                  decoration: InputDecoration(
                    suffixIcon: Icon(
                      CupertinoIcons.lock,
                      color: Colors.blue,
                      size: 24.0,
                    ),

                    hintText: "Enter the Password",
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.lightBlueAccent , width: 2.0),
                      borderRadius: BorderRadius.circular(11),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(11),
                      borderSide: BorderSide(color: Colors.lightBlueAccent , width: 2.0),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(11),
                      borderSide: BorderSide(color: Colors.deepOrange, width: 2.0),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              "Forgot Password",
              style: TextStyle(
                color: Colors.lightBlueAccent,
                fontWeight: FontWeight.w500,
                fontSize: 16,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              width: 400,
              height: 50,
              child: Padding(
                padding: const EdgeInsets.only(top: 5,right: 10,left: 10),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                        context, MaterialPageRoute(builder: (_) => HomeScreen()));
                  },
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0), // Set border radius here
                    ),
                    elevation: 5, // Set elevation here
                    backgroundColor: Colors.blue, // Set background color here
                  ),
                  child: Text(
                    "Sign In",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),

            Container(
              width: 400,
              height: 50,
              child: Padding(
                padding: const EdgeInsets.only(top: 5,right: 10,left: 10),
                child: ElevatedButton(
                  onPressed: ()
                  {
                    _handleGoogleBtnClick();
                  },
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0), // Set border radius here
                    ),
                    elevation: 5, // Set elevation here
                    backgroundColor: Colors.black, // Set background color here
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                    Image(
                        image: AssetImage('assets/logo/google_icon.png'),
                      width: 24, // Set the width of the image
                      height: 24,
                      ),
                      SizedBox(width: 10), // Add some spacing between the icon and the text
                      Text(
                        "Sign in with Google",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              width: 400,
              height: 50,
              child: Padding(
                padding: const EdgeInsets.only(top: 5,right: 10,left: 10),
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0), // Set border radius here
                    ),
                    elevation: 5, // Set elevation here
                    backgroundColor: Colors.black, // Set background color here
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image(
                        image: AssetImage('assets/logo/apple_logo.png'),
                        width: 24, // Set the width of the image
                        height: 24,
                      ),
                      SizedBox(width: 10), // Add some spacing between the icon and the text
                      Text(
                        "Sign in with Google",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}