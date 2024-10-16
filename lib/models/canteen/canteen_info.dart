// canteen_model.dart
import 'package:flutter/material.dart';
import 'canteen_model.dart';

class CanteenInfo extends StatelessWidget {
  final Canteen canteen;

  const CanteenInfo({Key? key, required this.canteen}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          // Canteen Image
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.asset(
              canteen.imageUrl,
              height: 100,
              width: 100,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 16),
          // Canteen Details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  canteen.name,
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 5),
                Text(
                  'Rating: ${canteen.rating}',
                  style: const TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 5),
                Text(
                  canteen.bio,
                  style: const TextStyle(fontSize: 14, color: Colors.black54),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
