import 'package:digital_canteen/utils/constants/colors.dart';
import 'package:digital_canteen/views/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: NColors.primary
      ),
      child: MaterialApp(
        theme: ThemeData(
          scaffoldBackgroundColor: Colors.white
        ),
        debugShowCheckedModeBanner: false,
        home: const SplashScreen(),
      ),
    );
  }
}