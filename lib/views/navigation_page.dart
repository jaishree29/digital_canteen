import 'package:digital_canteen/utils/constants/colors.dart';
import 'package:digital_canteen/views/favourite_screen.dart';
import 'package:digital_canteen/views/home_screen.dart';
import 'package:digital_canteen/views/menu_page.dart';
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
    const MenuPage(),
    const FavouriteScreen(),
    const ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(vertical: 3),
        decoration: BoxDecoration(
          color: NColors.primary, // Background color of the navigation bar
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1), // Shadow color
              spreadRadius: 5,
              blurRadius: 10,
            ),
          ],
        ),
        child: ClipRRect(
          child: BottomNavigationBar(
            backgroundColor: NColors.primary, 
            currentIndex: myCurrentIndex,
            onTap: (index) {
              setState(() {
                myCurrentIndex = index;
              });
            },
            selectedItemColor: Colors.white, // Color when an item is selected
            unselectedItemColor: NColors.lightOne,            
            type: BottomNavigationBarType.fixed,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home_outlined),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.dining_outlined),
                label: 'Menu',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.star_border_outlined),
                label: 'Favorites',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person_outline),
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
