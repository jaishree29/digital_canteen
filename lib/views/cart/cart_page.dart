import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:digital_canteen/utils/constants/colors.dart';
import 'package:digital_canteen/views/cart/cart_item.dart';
import 'package:digital_canteen/views/cart/cart_items.dart';
import 'package:flutter/material.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  final CartItems _cartItems = CartItems();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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

                    return ListView.builder(
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
                    );
                  },
                ),
              ),
              const SizedBox(height: 16),
              // Place Order
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: NColors.primary,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text(
                  'Place Order',
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
