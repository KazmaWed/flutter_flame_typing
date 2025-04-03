import 'package:firebase_core/firebase_core.dart';

class DefaultFirebaseOptions {
  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'FIREBASE_API_KEY',
    appId: 'FIREBASE_APP_ID',
    messagingSenderId: 'FIREBASE_MESSAGING_SENDER_ID',
    projectId: 'FIREBASE_PROJECT_ID',
    authDomain: 'FIREBASE_AUTH_DOMAIN',
    storageBucket: 'FIREBASE_STORAGE_BUCKET',
    measurementId: 'FIREBASE_MEASUREMENT_ID',
  );
}
