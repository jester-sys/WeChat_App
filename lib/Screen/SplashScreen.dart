

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:we_chat/Screen/HomeScreen/home_screen.dart';
import 'package:we_chat/api/Apis.dart';
import 'package:we_chat/auth/loginScreen.dart';

class SplashScreen extends StatefulWidget{
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(milliseconds: 1500), () {
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
      SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(statusBarColor: Colors.transparent));
      if(APIs.auth.currentUser !=null) {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) =>HomeScreen()));
      }
      else {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => LoginScreen()));
      }

    });
    }




  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 250,
            height: 250,
            child: Image(image: AssetImage('assets/logo/chat_logo.png')),
          )
        ],
      ),
    );
  }
}
