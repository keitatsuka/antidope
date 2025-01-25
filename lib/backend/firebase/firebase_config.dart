import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

Future initFirebase() async {
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: const FirebaseOptions(
            apiKey: "AIzaSyBaxCW4B5yc3LmFQBFk3uLPce5TlFOHeuQ",
            authDomain: "anti-dope-pxt9o5.firebaseapp.com",
            projectId: "anti-dope-pxt9o5",
            storageBucket: "anti-dope-pxt9o5.firebasestorage.app",
            messagingSenderId: "586979748032",
            appId: "1:586979748032:web:7f79f6f708079dc924e525"));
  } else {
    await Firebase.initializeApp();
  }
}
