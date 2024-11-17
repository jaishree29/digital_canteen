import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:digital_canteen/widgets/cards.dart';

class Popular extends StatefulWidget {
  const Popular({super.key});

  @override
  State<Popular> createState() => _PopularState();
}

class _PopularState extends State<Popular> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<QuerySnapshot>(
      future: FirebaseFirestore.instance.collection('menu').get(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return const Center(
            child: Text('No food items available'),
          );
        }

        List<NCards> foodCards = snapshot.data!.docs.map((doc) {
          var data = doc.data() as Map<String, dynamic>;
          var foodId = doc.id; 

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
            imageUrl: data['imageUrl'],
            foodId: foodId,
            title: data['title'] ?? 'Unknown',
            description: priceDescription,
            rating: '⭐ ${data['rating']?.toString() ?? '0.0'}',
            isMenu: false,
          );
        }).toList();

        return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: foodCards,
          ),
        );
      },
    );
  }
}
