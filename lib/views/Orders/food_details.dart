import 'package:digital_canteen/views/Orders/quantity_selector.dart';
import 'package:flutter/material.dart';

class FoodDetails extends StatelessWidget {
  final Map<String, dynamic> data;
  const FoodDetails({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    String title = data['title'] ?? 'Unknown';
    String description = data['description'] ?? 'No description';
    double price = (data['price'] as num).toDouble();
    double rating = (data['rating'] as num?)?.toDouble() ?? 0.0;
    double? time = (data['time'] as num?)?.toDouble();
    List<dynamic> quantityOptions = data['quantity'] ?? [];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            IconButton(
              icon: const Icon(Icons.favorite_border),
              onPressed: () {},
            ),
          ],
        ),

        const SizedBox(height: 8),
        // Price
        Text(
          '\$${price.toStringAsFixed(2)}',
          style: const TextStyle(
            fontSize: 18,
            color: Colors.grey,
          ),
        ),

        const SizedBox(height: 8),
        // Rating and Time
        Row(
          children: [
            Text(
              '⭐ $rating',
              style: const TextStyle(fontSize: 16),
            ),
            if (time != null) ...[
              const SizedBox(width: 10),
              Text(
                'Time: ${time.toStringAsFixed(1)} min',
                style: const TextStyle(fontSize: 16),
              ),
            ]
          ],
        ),

        const SizedBox(height: 16),
        // Description
        Text(
          description,
          style: const TextStyle(fontSize: 16, color: Colors.black54),
        ),

        const SizedBox(height: 16),
        const Text(
          'Place Order',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),

        const Text(
          'Select Quantity',
          style: TextStyle(fontSize: 16),
        ),

        // Radio buttons
        QuantitySelector(quantityOptions: quantityOptions, price: price),
      ],
    );
  }
}
