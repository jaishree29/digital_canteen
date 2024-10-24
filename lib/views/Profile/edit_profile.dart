import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:digital_canteen/views/Profile/profile_info_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class EditProfile extends StatelessWidget {
  EditProfile({super.key});

  // Access the current user from FirebaseAuth
  final User? user = FirebaseAuth.instance.currentUser;

  // Function to get user data from Firestore
  Future<Map<String, dynamic>> getUserData(String userId) async {
    DocumentSnapshot doc =
        await FirebaseFirestore.instance.collection('users').doc(userId).get();
    return doc.data() as Map<String, dynamic>;
  }

  // Function to update user data in Firestore
  Future<void> updateUserData(
      String userId, Map<String, dynamic> updatedData) async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .update(updatedData);
  }

  @override
  Widget build(BuildContext context) {
    // Get the current user's UID, check if user is logged in
    if (user == null) {
      // If no user is logged in, show an error or redirect
      return const Scaffold(
        body: Center(child: Text('No user is logged in. Please log in.')),
      );
    }

    String userId = user!.uid; // Safely access the UID

    return Scaffold(
      body: SafeArea(
        child: FutureBuilder<Map<String, dynamic>>(
          future: getUserData(userId),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (!snapshot.hasData) {
              return const Center(child: Text('No user data found.'));
            }

            var userData = snapshot.data!;

            return Column(
              children: [
                Stack(
                  clipBehavior: Clip.none,
                  children: [
                    // Main Container
                    Container(
                      height: 240,
                      width: double.infinity,
                      color: Colors.red,
                      child: Padding(
                        padding: const EdgeInsets.all(18.0),
                        child: Column(
                          children: [
                            const SizedBox(height: 20),
                            Row(
                              children: [
                                IconButton(
                                  icon: const Icon(
                                      Icons.arrow_back_ios_new_rounded,
                                      color: Colors.white,
                                      size: 15),
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                ),
                                // const Spacer(),
                                const Text(
                                  "Edit Profile",
                                  style: TextStyle(
                                      fontSize: 20, color: Colors.white),
                                ),
                                const Spacer(),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    // Positioned Image at the top center
                    const Positioned(
                      top: 100,
                      left: 0,
                      right: 0,
                      child: Center(
                        child: CircleAvatar(
                          radius: 55,
                          backgroundImage:
                              AssetImage('asset/images/profile_pic.png'),
                        ),
                      ),
                    ),
                    // SizedBox(
                    //   height: 20,
                    // ),
                  ],
                ),
                const SizedBox(height: 10),
                Flexible(
                  child: Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: ListView(
                      children: [
                        ProfileInfoPage(
                          label: 'Name',
                          initialValue: userData['Name'],
                          hintText: 'Enter your name here',
                          onChange: (newValue) async {
                            await updateUserData(userId, {'Name': newValue});
                          },
                        ),
                        ProfileInfoPage(
                          label: 'Email',
                          initialValue: userData['email'],
                          hintText: 'Enter your email here',
                          onChange: (newValue) async {
                            await updateUserData(userId, {'email': newValue});
                          },
                        ),
                        ProfileInfoPage(
                          label: 'Phone',
                          initialValue: userData['Phone Number'],
                          hintText: 'Enter your phone here',
                          onChange: (newValue) async {
                            await updateUserData(
                                userId, {'Phone Number': newValue});
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
