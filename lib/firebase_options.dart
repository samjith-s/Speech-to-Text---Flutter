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
    apiKey: 'AIzaSyCj4OuAkWoplWlBi7oQYBLx8rUrCY25tpU',
    appId: '1:53538905718:web:cb8850dcbbd41100afc957',
    messagingSenderId: '53538905718',
    projectId: 'speech-to-terms',
    authDomain: 'speech-to-terms.firebaseapp.com',
    storageBucket: 'speech-to-terms.appspot.com',
    measurementId: 'G-7ZQLLKTK6V',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyA08hW6BAK3mAOvgHVmYeE44YthcWgicL0',
    appId: '1:53538905718:android:2f4cf812eddee9c8afc957',
    messagingSenderId: '53538905718',
    projectId: 'speech-to-terms',
    storageBucket: 'speech-to-terms.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDTXKGmLbUdDs6jcN3E70LVIxiziO5tMG8',
    appId: '1:53538905718:ios:de26af8fd6ec7ddaafc957',
    messagingSenderId: '53538905718',
    projectId: 'speech-to-terms',
    storageBucket: 'speech-to-terms.appspot.com',
    iosBundleId: 'com.example.speechToTerms',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDTXKGmLbUdDs6jcN3E70LVIxiziO5tMG8',
    appId: '1:53538905718:ios:43b4cd91fe665559afc957',
    messagingSenderId: '53538905718',
    projectId: 'speech-to-terms',
    storageBucket: 'speech-to-terms.appspot.com',
    iosBundleId: 'com.example.speechToTerms.RunnerTests',
  );
}
