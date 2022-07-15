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
        return macos;
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
    apiKey: 'AIzaSyBWkr5zanicQfksvCr2v9GaCg3CgNeh9wo',
    appId: '1:474274791962:web:a837d29a1fdf82ab5387a3',
    messagingSenderId: '474274791962',
    projectId: 'mynotes-a8b7c',
    authDomain: 'mynotes-a8b7c.firebaseapp.com',
    storageBucket: 'mynotes-a8b7c.appspot.com',
    measurementId: 'G-H7P4HE6CTM',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyA0tEy3zuMgNp4NRUnJJG8z02rySlIoePQ',
    appId: '1:474274791962:android:05e7a5c00608d61b5387a3',
    messagingSenderId: '474274791962',
    projectId: 'mynotes-a8b7c',
    storageBucket: 'mynotes-a8b7c.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyC8KFf5jG_XBn9PLSQER-4zt9qH2BRBhtA',
    appId: '1:474274791962:ios:33bc3ead661479f95387a3',
    messagingSenderId: '474274791962',
    projectId: 'mynotes-a8b7c',
    storageBucket: 'mynotes-a8b7c.appspot.com',
    iosClientId: '474274791962-togbbp2drctss247jgsvto3tm730vd9t.apps.googleusercontent.com',
    iosBundleId: 'eg.flotas.mynotes',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyC8KFf5jG_XBn9PLSQER-4zt9qH2BRBhtA',
    appId: '1:474274791962:ios:33bc3ead661479f95387a3',
    messagingSenderId: '474274791962',
    projectId: 'mynotes-a8b7c',
    storageBucket: 'mynotes-a8b7c.appspot.com',
    iosClientId: '474274791962-togbbp2drctss247jgsvto3tm730vd9t.apps.googleusercontent.com',
    iosBundleId: 'eg.flotas.mynotes',
  );
}