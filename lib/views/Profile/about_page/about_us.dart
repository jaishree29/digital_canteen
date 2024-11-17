import 'package:flutter/material.dart';

class AboutUsPage extends StatelessWidget {
  const AboutUsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("About Us"),
      ),
      body: const SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AboutCard(
              title: "Welcome to Digital Canteen",
              subtitle:
              "We aim to make food ordering and management easier for students and vendors, saving time and making campus dining more convenient.",
              icon: Icons.fastfood,
            ),
            SizedBox(height: 16),
            AboutCard(
              title: "Features",
              subtitle:
              "• Browse menus and place orders\n"
                  "• Pay securely within the app\n"
                  "• Track your order status\n"
                  "• Real-time notifications for order updates",
              icon: Icons.featured_play_list,
            ),
            SizedBox(height: 16),
            AboutCard(
              title: "How It Works",
              subtitle:
              "1. Create an account\n"
                  "2. Select your canteen\n"
                  "3. Browse the menu and place an order\n"
                  "4. Pay directly in-app and enjoy hassle-free dining",
              icon: Icons.work_outline,
            ),
            SizedBox(height: 16),
            AboutCard(
              title: "Our Team",
              subtitle:
              "Digital Canteen was created by a group of students passionate about solving everyday problems. Our goal is to make campus dining more accessible and enjoyable.",
              icon: Icons.group,
            ),
            SizedBox(height: 16),
            AboutCard(
              title: "Contact Us",
              subtitle:
              "Have questions? Reach out to us at support@digitalcanteen.com or find us on Instagram @digital_canteen_app.",
              icon: Icons.contact_mail,
            ),
            SizedBox(height: 16),
            AboutCard(
              title: "Frequently Asked Questions",
              subtitle:
              "• How can I reset my password?\n"
                  "• What payment options are available?\n"
                  "• How do I cancel an order?\n\n"
                  "We’re here to help you with any questions or concerns you may have!",
              icon: Icons.question_answer,
            ),
            SizedBox(height: 16),
            AboutCard(
              title: "Feedback and Suggestions",
              subtitle:
              "We’re always looking to improve! Share your ideas or report an issue to help us make Digital Canteen even better.",
              icon: Icons.feedback,
            ),
          ],
        ),
      ),
    );
  }
}

class AboutCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final VoidCallback? onTap;

  const AboutCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.icon,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        color: Colors.grey[850],
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(icon, size: 40, color: Colors.amber),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      subtitle,
                      style: const TextStyle(
                        fontSize: 15,
                        color: Colors.white70,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
