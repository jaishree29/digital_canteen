import 'package:digital_canteen/app.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:url_strategy/url_strategy.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart'; // Required for path_provider

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase
  FirebaseOptions firebaseOptions = const FirebaseOptions(
    apiKey: "AIzaSyDVbk65CSWprjL8CaFefZN6GWAXHqXO5ZM",
    appId: "1:842577050248:android:63819da5a5e7124099fd3d",
    messagingSenderId: "842577050248",
    projectId: "digital-canteen-be010",
  );

  await Firebase.initializeApp(options: firebaseOptions);

  // Initialize Hive with Flutter
  await Hive.initFlutter(); // Ensure Hive is initialized properly

  // Open a box for storing user data
  await Hive.openBox('userBox'); // Open the box for profile image path or user data

  // Set path strategy for web
  setPathUrlStrategy();

  runApp(const MyApp());
}
