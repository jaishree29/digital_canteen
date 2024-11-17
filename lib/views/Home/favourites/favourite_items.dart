import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'favourite_item.dart'; // Import your FavouriteItem widget

class FavouriteItems extends StatefulWidget {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  FavouriteItems({super.key});

  Stream<QuerySnapshot> getFavouriteItems() {
    final user = _auth.currentUser;
    if (user == null) {
      throw Exception('User not authenticated');
    }

    return _firestore
        .collection('users')
        .doc(user.uid)
        .collection('favorites')
        .snapshots();
  }

  @override
  State<FavouriteItems> createState() => _FavouriteItemsState();
}

class _FavouriteItemsState extends State<FavouriteItems> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: widget.getFavouriteItems(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return const Center(
            child: Text('No favourite items available'),
          );
        }

        List<FavouriteItem> favouriteItems = snapshot.data!.docs.map((doc) {
          var data = doc.data() as Map<String, dynamic>;


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

          return FavouriteItem(
            imageUrl: data['imageUrl'],
            foodId: data['foodId'],
            title: data['title'] ?? 'Unknown',
            price: priceDescription,
            rating: '⭐ ${data['rating']?.toString() ?? '0.0'}',
          );
        }).toList();

        return ListView(
          children: favouriteItems,
        );
      },
    );
  }
}
