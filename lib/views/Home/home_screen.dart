import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:digital_canteen/views/Home/popular.dart';
import 'package:digital_canteen/views/Home/recently_added.dart';
import 'package:digital_canteen/views/Home/recently_ordered.dart';
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
  bool _isMenuOpen = false;
  String _searchQuery = '';
  bool _highToLow = false;
  bool _lowToHigh = false;
  bool _shortTime = false;
  bool _longTime = false;

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

  void _toggleMenu() {
    setState(() {
      _isMenuOpen = !_isMenuOpen;
    });
  }

  void _onSearchChanged(String query) {
    setState(() {
      _searchQuery = query;
      print('Search query updated: $_searchQuery');
    });
  }

  void _applyFilters(
      bool highToLow, bool lowToHigh, bool shortTime, bool longTime) {
    setState(() {
      _highToLow = highToLow;
      _lowToHigh = lowToHigh;
      _shortTime = shortTime;
      _longTime = longTime;
      print(
          'Filters applied: highToLow=$_highToLow, lowToHigh=$_lowToHigh, shortTime=$_shortTime, longTime=$_longTime');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        text: 'Home',
        isMenuOpen: _isMenuOpen,
        onApplyFilters: _applyFilters,
        child: NSearchBar(
          onMenuPressed: _toggleMenu,
          onSearchChanged: _onSearchChanged,
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: _searchQuery.isEmpty
                ? _buildDefaultContent()
                : _buildSearchResults(),
          ),
        ),
      ),
    );
  }

  Widget _buildDefaultContent() {
    return Column(
      children: [
        const ImageCarousel(),
        const SizedBox(height: 25),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: NTextButton(
                  onTap: () => _selectTab(0),
                  text: 'Popular ❤️',
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
                  text: 'Recently Ordered',
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
          height: 250,
          child: TabBarView(
            physics: const ScrollPhysics(parent: NeverScrollableScrollPhysics()),
            controller: _tabController,
            children: const [
              // First tab content
              Popular(),
              // Second tab content
              RecentlyOrdered(),
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
        const RecentlyAdded(),
        const SizedBox(height: 20),
      ],
    );
  }

  Widget _buildSearchResults() {
    print(
        'Building search results with filters: highToLow=$_highToLow, lowToHigh=$_lowToHigh, shortTime=$_shortTime, longTime=$_longTime');
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('menu').snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return const Center(
            child: Text('No food items available'),
          );
        }

        List<DocumentSnapshot> foodItems = snapshot.data!.docs;
        List<DocumentSnapshot> filteredItems = foodItems
            .where((doc) =>
                (doc['title'] as String)
                    .toLowerCase()
                    .contains(_searchQuery.toLowerCase()) ||
                _searchQuery.isEmpty)
            .toList();

        // Apply filters
        if (_highToLow) {
          filteredItems.sort((a, b) =>
              (b['price']['full'] as num).compareTo(a['price']['full'] as num));
        } else if (_lowToHigh) {
          filteredItems.sort((a, b) =>
              (a['price']['full'] as num).compareTo(b['price']['full'] as num));
        } else if (_shortTime) {
          filteredItems.sort((a, b) =>
              (a['time'] as num).compareTo(b['time'] as num));
        } else if (_longTime) {
          filteredItems.sort((a, b) =>
              (b['time'] as num).compareTo(a['time'] as num));
        }

        if (filteredItems.isEmpty) {
          return const Center(child: Text('No results match your search.'));
        }

        return ListView.builder(
          shrinkWrap: true,
          physics: const BouncingScrollPhysics(),
          itemCount: filteredItems.length,
          itemBuilder: (context, index) {
            var data = filteredItems[index].data() as Map<String, dynamic>;
            var foodId = filteredItems[index].id;

            var price = data['price'] as Map<String, dynamic>?;

            String priceDescription = 'Unknown';
            if (price != null) {
              var halfPrice = price['half'];
              var fullPrice = price['full'];

              if (halfPrice != null && fullPrice != null) {
                priceDescription = 'Half: ₹$halfPrice | Full: ₹$fullPrice';
              } else if (fullPrice != null) {
                priceDescription = 'Price: ₹$fullPrice';
              } else {
                priceDescription = '₹0.00';
              }
            }

            return NCards(
              foodId: foodId,
              title: data['title'] ?? 'Unknown',
              description: priceDescription,
              rating: '⭐ ${data['rating']?.toString() ?? '0.0'}',
              isMenu: true,
            );
          },
        );
      },
    );
  }
}
