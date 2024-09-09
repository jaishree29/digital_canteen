import 'package:digital_canteen/widgets/app_bar.dart';
import 'package:digital_canteen/widgets/cards.dart';
import 'package:digital_canteen/widgets/image_carousel.dart';
import 'package:digital_canteen/widgets/search_bar.dart';
import 'package:digital_canteen/widgets/text_button.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  int selectedIndex = 0;
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _selectTab(int index) {
    setState(() {
      _tabController.index = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
          text: 'Home',
          child: NSearchBar(),
          ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              children: [
                const ImageCarousel(),
                const SizedBox(height: 25),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: NTextButton(
                          onTap: () => _selectTab(0),
                          text: 'Sort',
                          selected: _tabController.index == 0,
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(10),
                            bottomLeft: Radius.circular(10),
                          ),
                        ),
                      ),
                      Expanded(
                        child: NTextButton(
                          onTap: () => _selectTab(1),
                          text: 'Favourites ❤️',
                          selected: _tabController.index == 1,
                          borderRadius: const BorderRadius.only(
                            topRight: Radius.circular(10),
                            bottomRight: Radius.circular(10),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                SizedBox(
                  height: 250, // You can adjust the height as needed
                  child: TabBarView(
                    controller: _tabController,
                    children: const [
                      // First tab content
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            NCards(
                              title: 'Honey Chilli Potato',
                              description:
                                  'Half Plate - \$1.99 | Full Plate - \$2.5',
                            ),
                            NCards(
                              title: 'Honey Chilli Potato',
                              description:
                                  'Half Plate - \$1.99 | Full Plate - \$2.5',
                            ),
                            NCards(
                              title: 'Honey Chilli Potato',
                              description:
                                  'Half Plate - \$1.99 | Full Plate - \$2.5',
                            ),
                            NCards(
                              title: 'Honey Chilli Potato',
                              description:
                                  'Half Plate - \$1.99 | Full Plate - \$2.5',
                            ),
                          ],
                        ),
                      ),
                      // Second tab content
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            NCards(
                              title: 'French Fries',
                              description:
                                  'Half Plate - \$1.99 | Full Plate - \$2.5',
                            ),
                            NCards(
                              title: 'French Fries',
                              description:
                                  'Half Plate - \$1.99 | Full Plate - \$2.5',
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const Text(
                  'Recently Added',
                  style: TextStyle(
                    fontSize: 25,
                  ),
                ),
                const SizedBox(height: 10),
                const NCards(
                    description: 'Half Plate - \$1.99 | Full Plate - \$2.5',
                    title: 'Chowmin',
                    isMenu: true,
                    rating: '⭐ 4.3'),
                const NCards(
                    description: 'Half Plate - \$1.99 | Full Plate - \$2.5',
                    title: 'Chowmin',
                    isMenu: true,
                    rating: '⭐ 4.3'),
                const NCards(
                    description: 'Half Plate - \$1.99 | Full Plate - \$2.5',
                    title: 'Chowmin',
                    isMenu: true,
                    rating: '⭐ 4.3'),
                const NCards(
                    description: 'Half Plate - \$1.99 | Full Plate - \$2.5',
                    title: 'Chowmin',
                    isMenu: true,
                    rating: '⭐ 4.3'),
                const NCards(
                    description: 'Half Plate - \$1.99 | Full Plate - \$2.5',
                    title: 'Chowmin',
                    isMenu: true,
                    rating: '⭐ 4.3'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
