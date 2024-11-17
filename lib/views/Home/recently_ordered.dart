import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:digital_canteen/utils/constants/colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:digital_canteen/widgets/cards.dart';

class RecentlyOrdered extends StatefulWidget {
  const RecentlyOrdered({super.key});

  @override
  State<RecentlyOrdered> createState() => _PopularState();
}

class _PopularState extends State<RecentlyOrdered> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection('recently_ordered')
          .orderBy('timestamp',
              descending: true) 
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return Center(
            child: Container(
              height: 230,
              width: 400,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: NColors.light),
              child: const Center(
                child: Text('Try ordering something!'),
              ),
            ),
          );
        }

        // Use a Set to filter out duplicates based on foodId
        Set<String> uniqueFoodIds = {};
        List<NCards> foodCards = [];

        for (var doc in snapshot.data!.docs) {
          var data = doc.data() as Map<String, dynamic>;
          var foodId = data['foodId'];

          if (!uniqueFoodIds.contains(foodId)) {
            uniqueFoodIds.add(foodId);
            var price = data['totalPrice'] as double;

            foodCards.add(NCards(
              imageUrl: data['imageUrl'],
              foodId: foodId,
              title: data['foodTitle'] ?? 'Unknown',
              description: 'Paid: ₹$price',
              rating: '⭐ ${data['rating']?.toString() ?? '0.0'}',
              isMenu: false,
            ));
          }
        }

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
