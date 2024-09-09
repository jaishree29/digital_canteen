import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:digital_canteen/controllers/auth_controller.dart';
import 'package:digital_canteen/views/auth/sign_up_screen.dart';
import 'package:digital_canteen/views/splash_screen.dart';
import 'package:digital_canteen/widgets/elevated_button.dart';
import 'package:digital_canteen/widgets/text_field_input.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_auth/firebase_auth.dart'; // Add this for authentication

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final AuthController _authController = AuthController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  final FirebaseAuth _auth = FirebaseAuth.instance;

  //User Log out
  void _userLogOut() async {
    await _authController.signOutFromGoogle();

    var sharedPref = await SharedPreferences.getInstance();
    sharedPref.setBool(SplashScreenState.KEYLOGIN, false);

    if (!mounted) return;

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const SignUpScreen()),
    );

    ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Successfully logged out!')));
  }

  // Save User Details
  Future<void> _saveDetails() async {
    final name = _nameController.text.trim();
    final phone = _phoneController.text.trim();
    final User? currentUser = _auth.currentUser;

    if (name.isEmpty || phone.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Please fill in all the details first')));
    } else {
      if (currentUser != null) {
        //Current user UID
        String uid = currentUser.uid;

        //Details to be updated
        await FirebaseFirestore.instance.collection('users').doc(uid).set({
          'Name': name,
          'Phone Number': phone,
        }, SetOptions(merge: true));

        _nameController.clear();
        _phoneController.clear();

        if (!mounted) return;

        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Details updated successfully!')));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('No user is currently logged in.')));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              children: [
                NTextFieldInput(
                  hintText: 'Name',
                  icon: Icons.person,
                  isPass: false,
                  textController: _nameController
                ),
                NTextFieldInput(
                  hintText: 'Phone',
                  icon: Icons.phone,
                  isPass: false,
                  textController: _phoneController
                ),
              ],
            ),
            Column(
              children: [
                NElevatedButton(text: 'Update', onPressed: _saveDetails),
                const SizedBox(
                  height: 25,
                ),
                NElevatedButton(text: 'Logout', onPressed: _userLogOut),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
