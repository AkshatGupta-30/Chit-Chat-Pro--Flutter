import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart' show defaultTargetPlatform, kIsWeb, TargetPlatform;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {

    if (kIsWeb) {
      return FirebaseOptions(
        apiKey: dotenv.env["FIREBASE_WEB_API_KEY"]!,
        appId: dotenv.env['FIREBASE_WEB_APP_ID']!,
        messagingSenderId: dotenv.env['FIREBASE_MESSAGE_SENDER_ID']!,
        projectId: dotenv.env['FIREBASE_PROJECT_ID']!,
        authDomain: dotenv.env['FIREBASE_WEB_AUTH_DOMAIN'],
        storageBucket: dotenv.env['FIREBASE_STORAGE_BUCKET'],
      );
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return FirebaseOptions(
          apiKey: dotenv.env['FIREBASE_ANDROID_API_KEY']!,
          appId: dotenv.env['FIREBASE_ANDROID_APP_ID']!,
          messagingSenderId: dotenv.env['FIREBASE_MESSAGE_SENDER_ID']!,
          projectId: dotenv.env['FIREBASE_PROJECT_ID']!,
          storageBucket: dotenv.env['FIREBASE_STORAGE_BUCKET'],
        );
      case TargetPlatform.iOS:
        return FirebaseOptions(
          apiKey: dotenv.env['FIREBASE_IOS_API_KEY']!,
          appId: dotenv.env['FIREBASE_IOS_APP_ID']!,
          messagingSenderId: dotenv.env['FIREBASE_MESSAGE_SENDER_ID']!,
          projectId: dotenv.env['FIREBASE_PROJECT_ID']!,
          storageBucket: dotenv.env['FIREBASE_STORAGE_BUCKET'],
          iosBundleId: dotenv.env['FIREBASE_IOS_IOS_BUNDLE_ID'],
        );
      case TargetPlatform.macOS:
        return FirebaseOptions(
          apiKey: dotenv.env['FIREBASE_MACOS_API_KEY']!,
          appId: dotenv.env['FIREBASE_MACOS_APP_ID']!,
          messagingSenderId: dotenv.env['FIREBASE_MESSAGE_SENDER_ID']!,
          projectId: dotenv.env['FIREBASE_PROJECT_ID']!,
          storageBucket: dotenv.env['FIREBASE_STORAGE_BUCKET'],
          iosBundleId: dotenv.env['FIREBASE_MACOS_IOS_BUNDLE_ID'],
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
}