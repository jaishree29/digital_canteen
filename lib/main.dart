import 'package:digital_canteen/app.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:url_strategy/url_strategy.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  FirebaseOptions firebaseOptions = const FirebaseOptions(
    apiKey: "AIzaSyDVbk65CSWprjL8CaFefZN6GWAXHqXO5ZM",
    appId: "1:842577050248:android:63819da5a5e7124099fd3d",
    messagingSenderId: "842577050248",
    projectId: "digital-canteen-be010",
  );

  await Firebase.initializeApp(options: firebaseOptions);
  setPathUrlStrategy();

  runApp(const MyApp());
}
