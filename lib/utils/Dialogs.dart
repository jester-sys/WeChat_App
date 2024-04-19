
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:we_chat/api/Apis.dart';
import 'package:we_chat/auth/loginScreen.dart';

class CustomDialogs {
  static void showSnackbar(BuildContext context, String msg) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(msg),
        backgroundColor: CupertinoColors.systemBlue.withOpacity(0.8),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  static void showprogressBar(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => Center(child: CircularProgressIndicator()),
    );
  }

  static void showAlertDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('LogOut'),
          content: const Text(' Are Your LogOut'),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Confirm'),
              onPressed: () async {
                await APIs.auth.signOut().then((value) async{
                  await GoogleSignIn().signOut().then((value) {
                    Navigator.pop(context);
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => LoginScreen()));
                  });
                });


              },
            ),
          ],
        );
      },
    );
  }
}
