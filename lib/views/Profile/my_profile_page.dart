import 'package:digital_canteen/views/Profile/profile_card.dart';
import 'package:digital_canteen/views/navigation_page.dart';
import 'package:flutter/material.dart';

import 'edit_profile.dart';

class MyProfilePage extends StatelessWidget {
  const MyProfilePage({super.key});

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
                      Row(
                        children: [
                          const Icon(Icons.arrow_back_ios_new_sharp,
                              size: 20, color: Colors.grey),
                          const SizedBox(width: 10),
                          InkWell(
                            onTap: () => Navigator.pushReplacement(context,
                              MaterialPageRoute(
                                builder: (context) => const NavigationPage(),
                              ),
                            ),
                            child: const Text(
                              "Go Back",
                              style:
                                  TextStyle(fontSize: 18, color: Colors.grey),
                            ),
                          ),
                        ],
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
              pinned: true, // Makes the header sticky
              backgroundColor: Colors.white, // Background color of the header
              elevation: 4, // Shadow for the header
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
                            onTap: () {},
                          ),
                        ],
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(
                        left: 25.0, top: 10), // Added padding for alignment
                    child: Text("More", style: TextStyle(fontSize: 19)),
                  ),
                  const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        ProfileCard(
                          title: "Rate Us",
                          subtitle: "Rate us on Playstore, Appstore",
                          icon: Icons.star,
                          onTap: () {},
                        ),
                        ProfileCard(
                          title: "About Us",
                          subtitle: "Frequently asked questions",
                          icon: Icons.book,
                          onTap: () {},
                        ),
                        ProfileCard(
                          title: "Support Us",
                          subtitle: "Frequently asked questions",
                          icon: Icons.book,
                          onTap: () {},
                        ),
                        ProfileCard(
                          title: "Feedback",
                          subtitle: "Frequently asked questions",
                          icon: Icons.book,
                          onTap: () {},
                        ),
                        ProfileCard(
                          title: "Privacy",
                          subtitle: "Frequently asked questions",
                          icon: Icons.book,
                          onTap: () {},
                        ),
                        TextButton(
                          onPressed: () {},
                          child: const Text(
                            "Terms and Conditions",
                            style: TextStyle(fontSize: 24, color: Colors.black),
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
