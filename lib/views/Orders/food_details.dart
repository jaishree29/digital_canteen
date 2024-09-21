import 'package:digital_canteen/views/Orders/quantity_selector.dart';
import 'package:flutter/material.dart';

class FoodDetails extends StatelessWidget {
  final Map<String, dynamic> data;
  const FoodDetails({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    String title = data['title'] ?? 'Unknown';
    String description = data['description'] ?? 'No description';
    Map<String, dynamic>? priceData = data['price'] as Map<String, dynamic>?;

    double? halfPrice = priceData?['half'] != null
        ? (priceData!['half'] as num).toDouble()
        : null;
    double? fullPrice = priceData?['full'] != null
        ? (priceData!['full'] as num).toDouble()
        : null;

    double rating = (data['rating'] as num?)?.toDouble() ?? 0.0;
    double? time = (data['time'] as num?)?.toDouble();
    List<dynamic> quantityOptions = data['quantity'] ?? [];

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
                icon: const Icon(Icons.favorite_border),
                onPressed: () {},
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

                  // Quantity Selector
                  QuantitySelector(
                      quantityOptions: quantityOptions, price: fullPrice ?? 0),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
