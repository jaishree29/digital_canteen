import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:digital_canteen/views/cart/cart_items.dart';
import 'package:flutter/material.dart';
import 'package:digital_canteen/views/Orders/food_details.dart';
import 'package:digital_canteen/views/Orders/bottom_bar.dart';
import 'package:digital_canteen/utils/constants/image_strings.dart';

class FoodPage extends StatefulWidget {
  final String foodId;
  final ScrollController scrollController;
  const FoodPage({
    super.key,
    required this.foodId,
    required this.scrollController,
  });

  @override
  State<FoodPage> createState() => _FoodPageState();
}

class _FoodPageState extends State<FoodPage> {
  late Future<DocumentSnapshot> _foodData;
  double selectedPrice = 0;
  int selectedQuantity = 0;
  final CartItems _cartItems = CartItems();

  @override
  void initState() {
    super.initState();
    _foodData =
        FirebaseFirestore.instance.collection('menu').doc(widget.foodId).get();
  }

  void _updateTotalPrice(double price, int quantity) {
    setState(() {
      selectedPrice = price;
      selectedQuantity = quantity;
    });
  }

  void _addToCart(double totalAmount, int selectedItems) async {
    if (selectedItems > 0 && selectedPrice > 0) {
      final foodData = await _foodData;
      final data = foodData.data() as Map<String, dynamic>;
      final foodTitle = data['title'] ?? 'Unknown Item';

      await _cartItems.addToCart(
        widget.foodId,
        foodTitle,
        selectedPrice,
        selectedItems,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            // Top image
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: Image.network(
                NImages.menuImageOne,
                height: MediaQuery.of(context).size.height * 0.4,
                width: MediaQuery.of(context).size.width,
                fit: BoxFit.cover,
              ),
            ),

            // Back button
            Positioned(
              top: 50,
              left: 15,
              child: Opacity(
                opacity: 0.7,
                child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.black54,
                    shape: BoxShape.circle,
                  ),
                  child: IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.arrow_back_ios_rounded),
                    color: Colors.white,
                  ),
                ),
              ),
            ),

            // Food details
            Positioned(
              top: MediaQuery.of(context).size.height * 0.3,
              left: 0,
              right: 0,
              bottom: 0,
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
                child: FutureBuilder<DocumentSnapshot>(
                  future: _foodData,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    if (!snapshot.hasData || snapshot.data == null) {
                      return const Center(
                        child: Text('No data found for this item.'),
                      );
                    }

                    var data = snapshot.data!.data() as Map<String, dynamic>;

                    return SingleChildScrollView(
                      controller: widget.scrollController,
                      child: FoodDetails(
                        data: data,
                        onPriceUpdated: _updateTotalPrice,
                        foodId: widget.foodId,
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomBar(
        totalPrice: selectedPrice * selectedQuantity,
        onAddToCart: (totalAmount, selectedItems) {
          _addToCart(totalAmount, selectedItems);
        },
      ),
    );
  }
}
