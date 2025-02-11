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
    apiKey: 'AIzaSyC3L9FQCiWzGU_X7ETZlBvNhfZMMkH-v-Q',
    appId: '1:554869666953:web:abefc233e298e2db7f4258',
    messagingSenderId: '554869666953',
    projectId: 'location-share-app-db',
    authDomain: 'location-share-app-db.firebaseapp.com',
    storageBucket: 'location-share-app-db.firebasestorage.app',
    measurementId: 'G-5Z21C54G46',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyASWuZbAaCC1iCBbgcy9kxPTmqf6-r0zvA',
    appId: '1:554869666953:android:9907ba537cad73707f4258',
    messagingSenderId: '554869666953',
    projectId: 'location-share-app-db',
    storageBucket: 'location-share-app-db.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCFt5nGQ72ltilEwphWa0nRGWjZVub0Ggs',
    appId: '1:554869666953:ios:753e5c1347215b397f4258',
    messagingSenderId: '554869666953',
    projectId: 'location-share-app-db',
    storageBucket: 'location-share-app-db.firebasestorage.app',
    iosBundleId: 'com.example.locationSharingApp',
  );
}
