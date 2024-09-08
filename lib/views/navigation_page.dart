import 'package:digital_canteen/utils/constants/colors.dart';
import 'package:digital_canteen/views/favourite_screen.dart';
import 'package:digital_canteen/views/home_screen.dart';
import 'package:digital_canteen/views/orders_page.dart';
import 'package:digital_canteen/views/profile_page.dart';
import 'package:flutter/material.dart';

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
    const FavouriteScreen(),
    const ProfilePage(),
  ];

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
              setState(() {
                myCurrentIndex = index;
              });
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
      body: pages[myCurrentIndex],
    );
  }
}
