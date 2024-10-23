import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class RecentlyOrderedPage extends StatelessWidget {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  RecentlyOrderedPage({super.key});

  Future<List<Map<String, dynamic>>> fetchRecentlyDeliveredOrders() async {
    final user = _auth.currentUser;
    if (user == null) {
      return []; // Return empty if user is not authenticated
    }

    // Fetch the user's orders
    final QuerySnapshot snapshot = await _firestore
        .collection('users')
        .doc(user.uid)
        .collection('orders')
        .where('orderStatus', isEqualTo: 'Order Delivered')
        .orderBy('timestamp', descending: true) // Ensure the most recent orders come first
        .limit(5) // Limit to the 5 most recent delivered orders
        .get();


    return snapshot.docs.map((doc) => doc.data() as Map<String, dynamic>).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Recently Ordered'),
      ),
      body: SafeArea(
        child: FutureBuilder<List<Map<String, dynamic>>>(
          future: fetchRecentlyDeliveredOrders(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            if (snapshot.hasError) {
              print('Error fetching orders: ${snapshot.error}'); // Log the error
              return const Center(child: Text('Error fetching recently ordered items.'));
            }

            final recentlyDeliveredOrders = snapshot.data ?? [];

            if (recentlyDeliveredOrders.isEmpty) {
              return const Center(child: Text('No recently ordered items.'));
            }

            return ListView.builder(
              itemCount: recentlyDeliveredOrders.length,
              itemBuilder: (context, index) {
                final order = recentlyDeliveredOrders[index];
                return ListTile(
                  title: Text(order['foodTitle']),
                  subtitle: Text('Price: ₹${order['totalPrice']}'),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
