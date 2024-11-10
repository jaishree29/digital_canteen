
import 'package:digital_canteen/controllers/auth_controller.dart';
import 'package:digital_canteen/views/Profile/about_us.dart';
import 'package:digital_canteen/views/Profile/edit_profile.dart';
import 'package:digital_canteen/views/Profile/feedback_page.dart';
import 'package:digital_canteen/views/Profile/profile_card.dart';
import 'package:digital_canteen/views/Profile/rate_us/rate_us.dart';
import 'package:digital_canteen/views/Profile/terms_and_condition/terms_and_conditions.dart';
import 'package:digital_canteen/views/auth/sign_up_screen.dart';
import 'package:digital_canteen/views/navigation_page.dart';
import 'package:digital_canteen/views/splash_screen.dart';
import 'package:digital_canteen/widgets/elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'about_page/about_us.dart';
import 'edit_profile.dart';
class MyProfilePage extends StatefulWidget {
  const MyProfilePage({super.key});

  @override
  State<MyProfilePage> createState() => _MyProfilePageState();
}

class _MyProfilePageState extends State<MyProfilePage> {
  final AuthController _authController = AuthController();

  // User Log out
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

  void _openUrl() async {
    const String url =
        'https://www.instagram.com/notclgcom?igsh=czVybmJlNjVvNWVq';

    if (!await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url), mode: LaunchMode.inAppBrowserView);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Could not launch Play Store')),
      );
    }
  }

  // Show dialog to enter email for password reset
  void _showChangePasswordDialog() {
    showDialog(
      context: context,
      builder: (context) {
        String email = '';
        return AlertDialog(
          title: const Text('Change Password'),
          content: TextField(
            onChanged: (value) {
              email = value;
            },
            decoration: const InputDecoration(hintText: 'Enter your email'),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () async {
                try {
                  await _authController.sendPasswordResetEmail(email);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Password reset email sent')),
                  );
                  Navigator.of(context).pop();
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Error: $e')),
                  );
                }
              },
              child: const Text('Send'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              expandedHeight: 185, // Height of the sticky header
              flexibleSpace: FlexibleSpaceBar(
                background: Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 20),
                      InkWell(
                        onTap: () => Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const NavigationPage(),
                          ),
                        ),
                        child: const Row(
                          children: [
                            Icon(Icons.arrow_back_ios_new_sharp,
                                size: 20, color: Colors.grey),
                            SizedBox(width: 10),
                            Text(
                              "Go Back",
                              style:
                                  TextStyle(fontSize: 18, color: Colors.grey),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 10),
                      const Padding(
                        padding: EdgeInsets.only(left: 4.0),
                        child: Text(
                          "Account Details",
                          style: TextStyle(
                              fontSize: 27, fontWeight: FontWeight.bold),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(left: 4.0),
                        child: Text(
                          "Update your settings like notifications,\nprofile edit etc.",
                          style: TextStyle(color: Colors.grey, fontSize: 16),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              pinned: false,
              backgroundColor: Colors.white,
              elevation: 4,
            ),
            SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 10),
                  SizedBox(
                    width: double.infinity,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          ProfileCard(
                            title: "Profile Information",
                            subtitle: "Change your account info",
                            icon: Icons.person,
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => EditProfile()),
                              );
                            },
                          ),
                          ProfileCard(
                            title: "Change Password",
                            subtitle: "Change your password",
                            icon: Icons.lock,
                            onTap: _showChangePasswordDialog,
                          ),
                        ],
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(left: 25.0, top: 10),
                    child: Text("More", style: TextStyle(fontSize: 19)),
                  ),
                  const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8.0, vertical: 20),
                    child: Column(
                      children: [
                        ProfileCard(
                          title: "Rate Us",
                          subtitle: "Rate us on Playstore, Appstore",
                          icon: Icons.star,
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => RateUsPage()),
                            );
                          },
                        ),
                        ProfileCard(
                          title: "About Us",
                          subtitle: "Frequently asked questions",
                          icon: Icons.book,
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => AboutUsPage()),
                            );
                          },
                        ),
                        ProfileCard(
                          title: "Feedback",
                          subtitle: "Frequently asked questions",
                          icon: Icons.book,
                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const FeedbackPage()),
                          ),
                        ),
                        ProfileCard(
                          title: "Privacy",
                          subtitle: "Frequently asked questions",
                          icon: Icons.book,
                          onTap: () {},
                        ),
                        ProfileCard(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => TermsAndConditionsPage()),
                            );
                          },
                          title: "Terms and Conditions",
                          subtitle: "Click to view",
                          icon: Icons.book,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Center(
                          child: NElevatedButton(
                            text: 'Logout',
                            onPressed: _userLogOut,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
