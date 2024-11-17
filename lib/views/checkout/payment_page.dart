import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:digital_canteen/views/checkout/payment_service.dart';
import 'package:digital_canteen/views/navigation_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class PaymentPage extends StatelessWidget {
  final double totalPrice;
  const PaymentPage({
    super.key,
    required this.totalPrice,
  });

  Future<List<QueryDocumentSnapshot>> getAllCartItems() async {
    final user = FirebaseAuth.instance.currentUser; // Get the current user
    if (user == null) {
      throw Exception('User not authenticated');
    }

    try {
      // Fetch the cart items for the current user
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .collection('cart')
          .orderBy('timestamp', descending: true)
          .get();

      return querySnapshot.docs; // Return the list of cart items
    } catch (e) {
      throw Exception('Error fetching cart items: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Payment'),
      ),
      body: const Center(
        child: Text(
          'Proceed with Payment',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () async {
              try {
                // Get all cart items
                List<QueryDocumentSnapshot> cartItems = await getAllCartItems();

                // Move cart items to recently ordered sub-collection
                final user = FirebaseAuth.instance.currentUser;
                if (user == null) {
                  throw Exception('User not authenticated');
                }

                WriteBatch batch = FirebaseFirestore.instance.batch();

                for (var cartItem in cartItems) {
                  batch.set(
                    FirebaseFirestore.instance
                        .collection('users')
                        .doc(user.uid)
                        .collection('recently_ordered')
                        .doc(),
                    cartItem.data(),
                  );
                  batch.delete(cartItem.reference);
                }

                await batch.commit();

                // Fetch the image URL from the first cart item (assuming all items have the same image URL)
                final String imageUrl =
                    cartItems.isNotEmpty ? cartItems.first['imageUrl'] : '';

                PaymentService paymentService = PaymentService([], totalPrice);
                paymentService.openCheckout();
                await paymentService.completePayment(
                    imageUrl, cartItems, totalPrice);

                // // Show success message
                // ScaffoldMessenger.of(context).showSnackBar(
                //   const SnackBar(
                //       content: Text('Payment successful! Order placed.')),
                // );

                // Wait for a short duration to display the SnackBar before navigating
                await Future.delayed(const Duration(seconds: 2));

                // Navigate to the homepage and clear the navigation stack
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const NavigationPage(),
                  ),
                  (Route<dynamic> route) => false,
                );
              } catch (e) {
                // Handle errors
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Error: $e')),
                );
              }
            },
            child: const Text(
              'Pay',
              style: TextStyle(fontSize: 18),
            ),
          ),
        ),
      ),
    );
  }
}
