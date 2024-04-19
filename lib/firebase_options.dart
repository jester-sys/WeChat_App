// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyAin8q5YQaB0obaEc6U3KffArdfkP0kWus',
    appId: '1:114246473114:web:8d92ce9aaa86510c935623',
    messagingSenderId: '114246473114',
    projectId: 'we-chat-30aee',
    authDomain: 'we-chat-30aee.firebaseapp.com',
    storageBucket: 'we-chat-30aee.appspot.com',
    measurementId: 'G-2EJ32SX7L4',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyA57GzTdNHRhqApBZ8GPfkgu9AXyVSu24I',
    appId: '1:114246473114:android:ec6d55984d6eea37935623',
    messagingSenderId: '114246473114',
    projectId: 'we-chat-30aee',
    storageBucket: 'we-chat-30aee.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCVJQLNgjuEuo4nhdXheNDnzpKsWXagAEU',
    appId: '1:114246473114:ios:dd80d4dff90978c7935623',
    messagingSenderId: '114246473114',
    projectId: 'we-chat-30aee',
    storageBucket: 'we-chat-30aee.appspot.com',
    androidClientId: '114246473114-g9d10mp8b45npvttml3dus5r2jmi9ect.apps.googleusercontent.com',
    iosClientId: '114246473114-635oqgri4holqtoe1cjfl3hocm18rn5f.apps.googleusercontent.com',
    iosBundleId: 'com.example.weChat',
  );
}