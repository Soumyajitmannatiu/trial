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
    apiKey: 'AIzaSyC8NPg1er3031ONRIVhfMRx5mVokUvUTWg',
    appId: '1:142592316476:web:e424623fc947bf37d69f39',
    messagingSenderId: '142592316476',
    projectId: 'wasuup-c22a8',
    authDomain: 'wasuup-c22a8.firebaseapp.com',
    storageBucket: 'wasuup-c22a8.appspot.com',
    measurementId: 'G-P6JWDNLMF6',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCkmAnRHjAy38VkousMm_CChwJWU9XMKYQ',
    appId: '1:142592316476:android:7c6979eff0715825d69f39',
    messagingSenderId: '142592316476',
    projectId: 'wasuup-c22a8',
    storageBucket: 'wasuup-c22a8.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDe4ZWbuTh8Wl1nOVjAr2WF9BoMC3dECVA',
    appId: '1:142592316476:ios:8254206db11d9a19d69f39',
    messagingSenderId: '142592316476',
    projectId: 'wasuup-c22a8',
    storageBucket: 'wasuup-c22a8.appspot.com',
    iosBundleId: 'com.example.first',
  );
}
