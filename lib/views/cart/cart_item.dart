import 'package:digital_canteen/utils/constants/image_strings.dart';
import 'package:flutter/material.dart';

class CartItem extends StatelessWidget {
  final String foodId;
  final String foodTitle;
  final double selectedPrice;
  final int selectedItems;
  final VoidCallback onDelete;

  const CartItem({
    super.key,
    required this.foodId,
    required this.foodTitle,
    required this.selectedPrice,
    required this.selectedItems,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    double totalAmount = selectedPrice * selectedItems;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Container(
        decoration: BoxDecoration(
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 7,
              spreadRadius: 2,
              offset: Offset(0, 3),
            ),
          ],
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20),
                bottomLeft: Radius.circular(20),
              ),
              child: Image.network(
                NImages.menuImageOne,
                height: 150,
                width: 150,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 16),
            // Details
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(top: 8.0, bottom: 8.0, right: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          foodTitle,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        InkWell(
                          onTap: onDelete,
                          child: const Icon(Icons.delete),
                        )
                      ],
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'Total Items: $selectedItems',
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.black54,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'Price: ₹${selectedPrice.toStringAsFixed(2)}',
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'Total Price: ₹${(totalAmount).toStringAsFixed(2)}',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.green,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
