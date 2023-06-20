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
    apiKey: 'AIzaSyAa8Jh5JbAe7MUGdnE_x8wMmsEM004MBws',
    appId: '1:139769463785:web:e3dbca0477382e62390178',
    messagingSenderId: '139769463785',
    projectId: 'mybnetfit',
    authDomain: 'mybnetfit.firebaseapp.com',
    storageBucket: 'mybnetfit.appspot.com',
    measurementId: 'G-SVLFX13M0K',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBhTq9AQ3CtPJh5qI2QJIZ7KRG8SvN1wb0',
    appId: '1:139769463785:android:08b015d2980563e8390178',
    messagingSenderId: '139769463785',
    projectId: 'mybnetfit',
    storageBucket: 'mybnetfit.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAsdfVxvCOWqH5-D9fuswIgxi_mTU41_HI',
    appId: '1:139769463785:ios:b6cba33f4833da21390178',
    messagingSenderId: '139769463785',
    projectId: 'mybnetfit',
    storageBucket: 'mybnetfit.appspot.com',
    iosClientId: '139769463785-jn9ss7oqbpr4loqbucc61daraffgi8q1.apps.googleusercontent.com',
    iosBundleId: 'com.jlm.mynetvolve',
  );
}
