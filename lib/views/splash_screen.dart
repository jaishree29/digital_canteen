import 'dart:async';

import 'package:digital_canteen/utils/constants/colors.dart';
import 'package:digital_canteen/views/navigation_page.dart';
import 'package:digital_canteen/views/sign_up_screen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {
  static const String KEYLOGIN = 'Login';
  @override
  void initState() {
    super.initState();
    whereToGo();
  }

  void whereToGo() async {
    var sharedPref = await SharedPreferences.getInstance();
    var isLoggedIn = sharedPref.getBool(KEYLOGIN);
    Timer(const Duration(seconds: 3), () {
      if(isLoggedIn!= null){
        if(isLoggedIn){
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const NavigationPage())
          );
        } else {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const SignUpScreen()),
          );
        }
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const SignUpScreen()),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: NColors.primary,
      body: Center(
        child: Text(
          'MyCanteen',
          style: TextStyle(
            fontSize: 50,
            fontWeight: FontWeight.w500,
            fontStyle: FontStyle.italic,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
