// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
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
        return windows;
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
    apiKey: 'AIzaSyAWe3IL4VsLyxFubcSix5wZRBrivHztRFs',
    appId: '1:1017179988017:web:48f906aa80f89f3d98f510',
    messagingSenderId: '1017179988017',
    projectId: 'fb-api-720ab',
    authDomain: 'fb-api-720ab.firebaseapp.com',
    storageBucket: 'fb-api-720ab.firebasestorage.app',
    measurementId: 'G-QG365W69BY',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDrBArjz4VqxJFKIwD5Az9binp-GFt5JkA',
    appId: '1:1017179988017:android:0bc840281307c22698f510',
    messagingSenderId: '1017179988017',
    projectId: 'fb-api-720ab',
    storageBucket: 'fb-api-720ab.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBSUKoiP1hXq_F9FbM0XLI257l3HvGneAE',
    appId: '1:1017179988017:ios:3453a2901f9881a398f510',
    messagingSenderId: '1017179988017',
    projectId: 'fb-api-720ab',
    storageBucket: 'fb-api-720ab.firebasestorage.app',
    iosBundleId: 'com.example.eventosApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBSUKoiP1hXq_F9FbM0XLI257l3HvGneAE',
    appId: '1:1017179988017:ios:3453a2901f9881a398f510',
    messagingSenderId: '1017179988017',
    projectId: 'fb-api-720ab',
    storageBucket: 'fb-api-720ab.firebasestorage.app',
    iosBundleId: 'com.example.eventosApp',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyAWe3IL4VsLyxFubcSix5wZRBrivHztRFs',
    appId: '1:1017179988017:web:14fc48457cc3b52298f510',
    messagingSenderId: '1017179988017',
    projectId: 'fb-api-720ab',
    authDomain: 'fb-api-720ab.firebaseapp.com',
    storageBucket: 'fb-api-720ab.firebasestorage.app',
    measurementId: 'G-VCC7X93HJ6',
  );

}