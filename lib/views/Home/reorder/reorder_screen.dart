import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:digital_canteen/views/Home/reorder/reorder_item.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ReorderScreen extends StatefulWidget {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  ReorderScreen({super.key});

  Stream<QuerySnapshot> getReorderItems() {
    final user = _auth.currentUser;
    if (user == null) {
      throw Exception('User not authenticated');
    }

    return _firestore
        .collection('users')
        .doc(user.uid)
        .collection('recently_ordered')
        .orderBy('timestamp',
            descending: true) // Order by most recent timestamp
        .snapshots();
  }

  @override
  State<ReorderScreen> createState() => _ReorderItemsState();
}

class _ReorderItemsState extends State<ReorderScreen> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: widget.getReorderItems(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return const Center(
            child: Text('No items available!'),
          );
        }

        // Use a Set to filter out duplicates based on foodId
        Set<String> uniqueFoodIds = {};
        List<ReorderItem> favouriteItems = [];

        for (var doc in snapshot.data!.docs) {
          var data = doc.data() as Map<String, dynamic>;
          var foodId = data['foodId'];

          if (!uniqueFoodIds.contains(foodId)) {
            uniqueFoodIds.add(foodId);
            var price = data['totalPrice'] as double;

            favouriteItems.add(ReorderItem(
              imageUrl: data['imageUrl'],
              foodId: foodId,
              title: data['foodTitle'] ?? 'Unknown',
              price: 'Paid: ₹$price',
              time: data['timestamp'],
            ));
          }
        }

        return ListView(
          children: favouriteItems,
        );
      },
    );
  }
}
