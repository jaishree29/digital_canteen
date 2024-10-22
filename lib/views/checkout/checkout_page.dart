import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:digital_canteen/views/checkout/payment_page.dart';
import 'package:flutter/material.dart';

import '../../models/canteen/canteen_info.dart';
import '../../models/canteen/canteen_model.dart';

class CheckoutPage extends StatelessWidget {
  final List<QueryDocumentSnapshot> cartItems; // Receive cart items
  final double totalPrice; // Receive total price

   CheckoutPage({
    super.key,
    required this.cartItems,
    required this.totalPrice,
  });

  final Canteen canteen = Canteen(
    imageUrl: 'assets/images/canteen_img.png', // Update this path if needed
    name: 'Pehli Fursat Canteen',
    rating: 4.8,
    bio: 'good food,good vibes!',
  );

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text("Review Your Order"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context); // Navigate back
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            CanteenInfo(canteen: canteen),
            const SizedBox(height: 16),
            // Display list of cart items
            Expanded(
              child: ListView.builder(
                itemCount: cartItems.length,
                itemBuilder: (context, index) {
                  final cartItem = cartItems[index];
                  final data = cartItem.data() as Map<String, dynamic>;

                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 3.0),
                    child: Card(
                      //color: Colors.white,

                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: ListTile(
                        // leading: const CircleAvatar(
                        //   backgroundImage: NetworkImage(NImages.menuImageOne), // Use the image
                        //   radius: 30, // Adjust the radius as needed
                        // ),
                        title: Text(
                          '${data['foodTitle'] ?? 'Unknown Item'} x ${data['selectedItems']}', // Update title to include quantity
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        // subtitle: Text('₹${data['selectedPrice']} x ${data['selectedItems']}'), // Subtitle can be uncommented if needed
                        trailing: Text(
                          '₹${(data['selectedPrice'] * data['selectedItems']).toStringAsFixed(2)}',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PaymentPage(totalPrice: totalPrice,), // Navigate to OrderPage
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child:  Text(
                      'Checkout - Total: ₹${totalPrice.toStringAsFixed(2)}',
                      style: const TextStyle(fontSize: 18, color: Colors.white),
                    ),
                  ),
                ),


          ],
        ),
      ),
    );
  }
}
