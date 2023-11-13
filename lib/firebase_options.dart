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
    apiKey: 'AIzaSyDw3Ee3gwnN1j8sz9UyfJJmCK7XZtOvVeM',
    appId: '1:763235405748:web:52999b9fbd5df033b36ce1',
    messagingSenderId: '763235405748',
    projectId: 'csci4100u-ksommm-final-project',
    authDomain: 'csci4100u-ksommm-final-project.firebaseapp.com',
    storageBucket: 'csci4100u-ksommm-final-project.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyA9jpKAwI0v-XXKhFbF_TGl63dEQWQn63w',
    appId: '1:763235405748:android:741ab075e5ef4b4db36ce1',
    messagingSenderId: '763235405748',
    projectId: 'csci4100u-ksommm-final-project',
    storageBucket: 'csci4100u-ksommm-final-project.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyB5086nk2T7EwYnDxfg9Df0Ey7mGCPSKvY',
    appId: '1:763235405748:ios:da91d80d257b0f9fb36ce1',
    messagingSenderId: '763235405748',
    projectId: 'csci4100u-ksommm-final-project',
    storageBucket: 'csci4100u-ksommm-final-project.appspot.com',
    iosBundleId: 'com.example.main',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyB5086nk2T7EwYnDxfg9Df0Ey7mGCPSKvY',
    appId: '1:763235405748:ios:ee4a8b3ff8f14cfbb36ce1',
    messagingSenderId: '763235405748',
    projectId: 'csci4100u-ksommm-final-project',
    storageBucket: 'csci4100u-ksommm-final-project.appspot.com',
    iosBundleId: 'com.example.main.RunnerTests',
  );
}
