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
    apiKey: 'AIzaSyDfhDD4KXtCNDqgjPZwOcckLF5fpeiEErA',
    appId: '1:190090293913:web:c86047c977fa5d9544fe08',
    messagingSenderId: '190090293913',
    projectId: 'justap-bdc9a',
    authDomain: 'firebase.justap.us',
    storageBucket: 'justap-bdc9a.appspot.com',
    measurementId: 'G-ZPBYL65DYH',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDnyehxF1FmtnmaBoVZregBILLTXOy_zOA',
    appId: '1:190090293913:android:8d292f4f691a83fa44fe08',
    messagingSenderId: '190090293913',
    projectId: 'justap-bdc9a',
    storageBucket: 'justap-bdc9a.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCXnXHlAEPNzIebIquQ_vn1TbMDiqNXQ5g',
    appId: '1:190090293913:ios:f8d258f5d05f395344fe08',
    messagingSenderId: '190090293913',
    projectId: 'justap-bdc9a',
    storageBucket: 'justap-bdc9a.appspot.com',
    iosClientId:
        '190090293913-5048om259ivucef35ieirhq2dv3hl91i.apps.googleusercontent.com',
    iosBundleId: 'us.justap.app',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCXnXHlAEPNzIebIquQ_vn1TbMDiqNXQ5g',
    appId: '1:190090293913:ios:f8d258f5d05f395344fe08',
    messagingSenderId: '190090293913',
    projectId: 'justap-bdc9a',
    storageBucket: 'justap-bdc9a.appspot.com',
    iosClientId:
        '190090293913-5048om259ivucef35ieirhq2dv3hl91i.apps.googleusercontent.com',
    iosBundleId: 'us.justap.app',
  );
}
