import 'package:digital_canteen/utils/constants/colors.dart';
import 'package:digital_canteen/views/Home/home_screen.dart';
import 'package:digital_canteen/views/Orders/orders_page.dart';
import 'package:digital_canteen/views/vibe_screen/vibe_screen.dart';
import 'package:flutter/material.dart';

import 'Profile/my_profile_page.dart';

class NavigationPage extends StatefulWidget {
  const NavigationPage({super.key});

  @override
  State<NavigationPage> createState() => _NavigationPageState();
}

class _NavigationPageState extends State<NavigationPage> {
  int myCurrentIndex = 0;

  final List<Widget> pages = [
    const HomeScreen(),
    const OrdersPage(),
    const VibeScreen(),
    const MyProfilePage(),
  ];

  void _showModalBottomSheet(BuildContext context, int index) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true, 
      backgroundColor: Colors.transparent, 
      builder: (BuildContext context) {
        return DraggableScrollableSheet(
          initialChildSize: 1.0,
          maxChildSize: 1.0,
          minChildSize: 1.0,
          expand: true,
          builder: (context, scrollController) {
            return Container(
              height: MediaQuery.of(context).size.height,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(20),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 10,
                    spreadRadius: 5,
                  ),
                ],
              ),
              // padding: const EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                controller: scrollController, 
                child: SizedBox(
                  height: MediaQuery.of(context).size.height * 2, 
                  child: index == 1 ? const OrdersPage() : const VibeScreen(),
                ),
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(vertical: 3),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              spreadRadius: 5,
              blurRadius: 10,
            ),
          ],
        ),
        child: ClipRRect(
          child: BottomNavigationBar(
            backgroundColor: Colors.white,
            currentIndex: myCurrentIndex,
            onTap: (index) {
              if (index == 1 || index == 2) {
                _showModalBottomSheet(context, index);
              } else {
                setState(() {
                  myCurrentIndex = index; 
                });
              }
            },
            selectedItemColor: NColors.primary,
            unselectedItemColor: NColors.secondary,
            type: BottomNavigationBarType.fixed,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.dining_outlined),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.payment),
                label: 'Orders',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.emoji_emotions_outlined),
                label: 'Vibe',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person),
                label: 'Profile',
              ),
            ],
          ),
        ),
      ),
      // Regular pages for Home and Profile
      body: pages[myCurrentIndex],
    );
  }
}
