import 'package:flutter/material.dart';

class TermsAndConditionsPage extends StatelessWidget {
  const TermsAndConditionsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Terms and Conditions"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Section(
              title: "Introduction",
              content:
              "Welcome to Digital Canteen. By accessing or using our app, you agree to be bound by these terms and conditions. Please read them carefully.",
            ),
            Section(
              title: "Use of the App",
              content:
              "You agree to use the app only for lawful purposes and in a way that does not infringe the rights of, restrict, or inhibit anyone else's use and enjoyment of the app.",
            ),
            Section(
              title: "User Accounts",
              content:
              "To access some features of the app, you may need to register an account. You are responsible for keeping your account information accurate and secure.",
            ),
            Section(
              title: "Privacy Policy",
              content:
              "We respect your privacy. Please read our Privacy Policy to understand how we collect, use, and protect your information.",
            ),
            Section(
              title: "Intellectual Property",
              content:
              "All content, trademarks, and data on this app are the property of  Digital Canteen or its licensors. Unauthorized use is strictly prohibited.",
            ),
            Section(
              title: "Termination",
              content:
              "We reserve the right to terminate or restrict your access to the app at any time, without notice, for any reason whatsoever.",
            ),
            Section(
              title: "Changes to Terms",
              content:
              "We may revise these terms and conditions from time to time. Continued use of the app implies acceptance of any updates.",
            ),
            Section(
              title: "Contact Us",
              content:
              "If you have any questions about these terms, please contact us at lochanchugh@gmail.com.",
            ),
          ],
        ),
      ),
    );
  }
}

class Section extends StatelessWidget {
  final String title;
  final String content;

  const Section({
    Key? key,
    required this.title,
    required this.content,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            content,
            style: const TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }
}
