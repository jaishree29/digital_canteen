import 'package:digital_canteen/utils/constants/colors.dart';
import 'package:digital_canteen/views/splash_screen.dart';
import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        scaffoldBackgroundColor: NColors.secondary
      ),
      debugShowCheckedModeBanner: false,
      home: const SplashScreen(),
    );
  }
}