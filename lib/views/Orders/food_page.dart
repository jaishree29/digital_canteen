import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:digital_canteen/views/Orders/food_details.dart';
import 'package:digital_canteen/views/Orders/bottom_bar.dart';
import 'package:digital_canteen/utils/constants/image_strings.dart';

class FoodPage extends StatefulWidget {
  final String foodId;
  const FoodPage({super.key, required this.foodId});

  @override
  State<FoodPage> createState() => _FoodPageState();
}

class _FoodPageState extends State<FoodPage> {
  late Future<DocumentSnapshot> _foodData;

  @override
  void initState() {
    super.initState();
    _foodData =
        FirebaseFirestore.instance.collection('menu').doc(widget.foodId).get();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
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

            // Food details
            Positioned(
              top: MediaQuery.of(context).size.height * 0.30,
              left: 0,
              right: 0,
              child: Container(
                padding: const EdgeInsets.all(20),
                height: MediaQuery.of(context).size.height * 0.75,
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
                          child: Text('No data found for this item.'));
                    }

                    var data = snapshot.data!.data() as Map<String, dynamic>;

                    return FoodDetails(data: data);
                  },
                ),
              ),
            ),
          ],
        ),
      ),

      bottomNavigationBar: const BottomBar(),
    );
  }
}
