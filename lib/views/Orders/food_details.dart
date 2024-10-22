import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:digital_canteen/views/Orders/quantity_selector.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class FoodDetails extends StatefulWidget {
  final Map<String, dynamic> data;
  final Function(double selectedPrice, int selectedQuantity) onPriceUpdated;

  const FoodDetails({
    super.key,
    required this.data,
    required this.onPriceUpdated,
  });

  @override
  _FoodDetailsState createState() => _FoodDetailsState();
}

class _FoodDetailsState extends State<FoodDetails> {
  bool isFavorite = false;

  final user = FirebaseAuth.instance.currentUser;



  @override
  void initState() {
    super.initState();
    _checkIfFavorite(); // Check if the food is already in the favorites
  }

  // Check if the food is already in the user's favorites collection
  Future<void> _checkIfFavorite() async {
    DocumentSnapshot doc = await FirebaseFirestore.instance
        .collection('users')
        .doc(user?.uid)
        .collection('favorites')
        .doc(widget.data['id'].toString())
        .get();

    setState(() {
      isFavorite = doc.exists; // Set to true if the document exists
    });
  }

  // Toggle the favorite status of the food item
  Future<void> _toggleFavorite() async {
    if (isFavorite) {
      // Remove from favorites
      await FirebaseFirestore.instance
          .collection('users')
          .doc(user?.uid)
          .collection('favorites')
          .doc(widget.data['id'].toString())
          .delete();
    } else {
      // Add to favorites
      await FirebaseFirestore.instance
          .collection('users')
          .doc(user?.uid)
          .collection('favorites')
          .doc(widget.data['id'].toString())
          .set(widget.data); // Storing the entire food data
    }

    // Update the state to reflect the change in the UI
    setState(() {
      isFavorite = !isFavorite;
    });
  }

  @override
  Widget build(BuildContext context) {
    String title = widget.data['title'] ?? 'Unknown';
    String description = widget.data['description'] ?? 'No description';
    Map<String, dynamic>? priceData = widget.data['price'] as Map<String, dynamic>?;

    double? halfPrice = priceData?['half'] != null
        ? (priceData!['half'] as num).toDouble()
        : null;
    double? fullPrice = priceData?['full'] != null
        ? (priceData!['full'] as num).toDouble()
        : null;

    double rating = (widget.data['rating'] as num?)?.toDouble() ?? 0.0;
    double? time = (widget.data['time'] as num?)?.toDouble();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
              IconButton(
                icon: Icon(
                  isFavorite ? Icons.favorite : Icons.favorite_border,
                  color: isFavorite ? Colors.red : Colors.grey,
                ),
                onPressed: _toggleFavorite,
              ),
            ],
          ),

          // Prices
          if (halfPrice != null && fullPrice != null) ...[
            Row(
              children: [
                Text(
                  'Half - ₹${halfPrice.toStringAsFixed(2)}',
                  style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black54),
                ),
                const SizedBox(width: 10),
                Text(
                  '|  Full - ₹${fullPrice.toStringAsFixed(2)}',
                  style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black54),
                ),
              ],
            ),
          ] else if (fullPrice != null) ...[
            Text(
              'Full - ₹${fullPrice.toStringAsFixed(2)}',
              style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black54),
            ),
          ],
          const SizedBox(height: 8),

          // Rating and Time
          Row(
            children: [
              const Text(
                '⭐',
                style: TextStyle(fontSize: 16),
              ),
              Text(
                ' $rating Ratings  •',
                style: const TextStyle(fontSize: 16, color: Colors.black54),
              ),
              if (time != null) ...[
                Text(
                  '  ${time.toStringAsFixed(0)}min',
                  style: const TextStyle(fontSize: 16, color: Colors.black54),
                ),
              ]
            ],
          ),

          const SizedBox(height: 10),

          // Description
          Text(
            description,
            style: const TextStyle(fontSize: 18),
          ),

          const SizedBox(height: 16),

          Container(
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.grey.shade100),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.3),
                    spreadRadius: 0.1,
                    blurRadius: 5,
                    offset: const Offset(0, 3),
                  ),
                ]),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Place Order',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const Text(
                    'Select the Quantity',
                    style: TextStyle(fontSize: 15, color: Colors.black54),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  // Quantity Selector
                  if (priceData != null)
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        borderRadius:
                        const BorderRadius.all(Radius.circular(16)),
                        border: Border.all(color: Colors.black12),
                      ),
                      child: QuantitySelector(
                        priceData: priceData,
                        onSelectionChanged: widget.onPriceUpdated,
                      ),
                    )
                  else
                    const Text(
                      'Price data not available',
                      style: TextStyle(color: Colors.red),
                    ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}
