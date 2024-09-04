import 'package:digital_canteen/controllers/auth_controller.dart';
import 'package:digital_canteen/utils/constants/colors.dart';
import 'package:digital_canteen/views/navigation_page.dart';
import 'package:digital_canteen/views/sign_up_screen.dart';
import 'package:digital_canteen/widgets/elevated_button.dart';
import 'package:digital_canteen/widgets/text_field_input.dart';
import 'package:flutter/material.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final AuthController _authController = AuthController();

  // Sign-In with Email and Password
  void _handleSignIn() async {
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();
    final user = await _authController.signInWithEmailPassword(email, password);

    if (!mounted) return;
    
    if (email.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please fill in all fields.")),
      );
      return;
    }

    if (!mounted) {
      return;
    }

    if (user != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Welcome back, ${user.email}!")),
      );
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => const NavigationPage()));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text("User does not exist. Please sign up first.")),
      );
    }
  }

  // Sign-In with Google
  void _handleGoogleSignIn() async {
    await _authController.signOutFromGoogle();
    final user = await _authController.signInWithGoogle();

    if (!mounted) {
      return;
    }

    if (user != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Welcome back, ${user.email}!")),
      );
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => const NavigationPage()));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text("User does not exist. Please sign up first.")),
      );
    }
  }

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const SizedBox(height: 100),
                const Icon(Icons.mail, size: 70),
                const SizedBox(height: 80),

                // Email TextField
                TextFieldInput(
                  hintText: 'Email',
                  icon: Icons.email,
                  isPass: false,
                  textController: _emailController,
                ),

                // Password TextField
                TextFieldInput(
                  hintText: 'Password',
                  icon: Icons.lock,
                  isPass: true,
                  textController: _passwordController,
                ),
              ],
            ),
            const SizedBox(height: 80),
            Column(
              children: [
                // Sign-In Button
                NElevatedButton(
                  text: 'Sign In',
                  onPressed: _handleSignIn,
                  backgroundColor: NColors.primary,
                ),
                const SizedBox(height: 20),

                // Google Sign-In Button
                NElevatedButton(
                  text: 'Sign In with Google',
                  textColor: Colors.black,
                  onPressed: _handleGoogleSignIn,
                  backgroundColor: Colors.white,
                ),
              ],
            ),
            const SizedBox(height: 50),
            Column(
              children: [
                const SizedBox(height: 20),
                const Text(
                  'Don\'t have an account?',
                  style: TextStyle(fontSize: 17),
                ),
                TextButton(
                  onPressed: () => {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const SignUpScreen(),
                      ),
                    ),
                  },
                  child: const Text('Sign Up', style: TextStyle(fontSize: 17)),
                ),
              ],
            ),
          ],
        ),
      )),
    );
  }
}
