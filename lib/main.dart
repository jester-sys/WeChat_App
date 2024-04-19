import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:we_chat/Screen/SplashScreen.dart';
import 'package:we_chat/Screen/HomeScreen/home_screen.dart';
import 'package:we_chat/auth/loginScreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

late Size mq;
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  // SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky)



  // for Setting Orientation to portrait only
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp,DeviceOrientation.portraitDown])
      .then((value)  {
    _initializeFirebase();
    runApp( MyApp());
  });

}

class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
  return MaterialApp(
    debugShowCheckedModeBanner: false,
    title: "We Chat",
    theme: ThemeData(
      appBarTheme: AppBarTheme(
        centerTitle: true,
        elevation: 1,
        backgroundColor: Colors.yellowAccent,
      )
    ),
    home: SplashScreen(),
  );
  }

}

_initializeFirebase() async {
  await Firebase.initializeApp(

    options: DefaultFirebaseOptions.currentPlatform,

  );
}