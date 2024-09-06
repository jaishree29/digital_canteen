import 'package:digital_canteen/widgets/image_carousel.dart';
import 'package:digital_canteen/widgets/search_bar.dart';
import 'package:digital_canteen/widgets/text_button.dart';
import 'package:flutter/material.dart';
import 'package:digital_canteen/utils/constants/colors.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedIndex = 0; 

  void _sort() {
    setState(() {
      selectedIndex = 0; 
    });
  }

  void _favourites() {
    setState(() {
      selectedIndex = 1; 
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(25.0),
            child: Column(
              children: [
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Home',
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    CircleAvatar(
                      backgroundColor: NColors.primary,
                      radius: 25,
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                NSearchBar(),
                const SizedBox(height: 20),
                const ImageCarousel(),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: NTextButton(
                          onTap: _sort,
                          text: 'Sort',
                          selected: selectedIndex == 0, 
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(10),
                            bottomLeft: Radius.circular(10),
                          ),
                        ),
                      ),
                      Expanded(
                        child: NTextButton(
                          onTap: _favourites,
                          text: 'Favourites ❤️',
                          selected: selectedIndex == 1, 
                          borderRadius: const BorderRadius.only(
                            topRight: Radius.circular(10),
                            bottomRight: Radius.circular(10),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  'Recently Added',
                  style: TextStyle(
                    fontSize: 25,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
