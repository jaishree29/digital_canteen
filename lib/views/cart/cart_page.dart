import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:digital_canteen/utils/constants/colors.dart';
import 'package:digital_canteen/views/cart/cart_item.dart';
import 'package:digital_canteen/views/cart/cart_items.dart';
import 'package:flutter/material.dart';

import '../checkout/checkout_page.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  final CartItems _cartItems = CartItems();

  double _calculateTotalPrice(List<QueryDocumentSnapshot> cartItems) {
    double totalPrice = 0.0;
    for (var item in cartItems) {
      final data = item.data() as Map<String, dynamic>;
      final double price = data['selectedPrice'] ?? 0.0;
      final int quantity = data['selectedItems'] ?? 1; // Default to 1 if not provided
      totalPrice += price * quantity; // Multiply price by quantity
    }
    return totalPrice;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context); // Navigate back
          },
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              const Text(
                'Cart Items',
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              Expanded(
                child: StreamBuilder<QuerySnapshot>(
                  stream: _cartItems.getCartItems(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    if (!snapshot.hasData ||
                        snapshot.data == null ||
                        snapshot.data!.docs.isEmpty) {
                      return const Center(child: Text('No items added yet!', style: TextStyle(fontSize: 20)));
                    }

                    final cartItems = snapshot.data!.docs;
                    final totalPrice = _calculateTotalPrice(cartItems);

                    return Column(
                      children: [
                        Expanded(
                          child: ListView.builder(
                            itemCount: cartItems.length,
                            itemBuilder: (context, index) {
                              final cartItem = cartItems[index];
                              final data = cartItem.data() as Map<String, dynamic>;

                              return CartItem(
                                foodId: data['foodId'],
                                foodTitle: data['foodTitle'] ?? 'Unknown Item',
                                selectedPrice: data['selectedPrice'],
                                selectedItems: data['selectedItems'],
                                onDelete: () {
                                  _cartItems.deleteCartItem(cartItem.id);
                                },
                              );
                            },
                          ),
                        ),
                        const SizedBox(height: 16),
                        // Total price and Place Order button
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Total: ₹${totalPrice.toStringAsFixed(2)}',
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => CheckoutPage(
                                      cartItems: snapshot.data!.docs, // Pass cartItems
                                      totalPrice: totalPrice, // Pass totalPrice
                                    ),
                                  ),
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: NColors.primary,
                                padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              child: const Text(
                                'Continue',
                                style: TextStyle(fontSize: 18, color: Colors.white),
                              ),
                            ),
                          ],
                        ),
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
