import 'package:digital_canteen/utils/constants/colors.dart';
import 'package:flutter/material.dart';

class BottomBar extends StatefulWidget {
  final Function(double totalAmount, int selectedItems) onAddToCart;
  final double totalPrice;
  // final String selectedQuantityType;

  const BottomBar({
    super.key,
    required this.onAddToCart,
    required this.totalPrice,
    // required this.selectedQuantityType,
  });

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  int selectedItems = 0;
  bool isAddedToCart = false;

  @override
  Widget build(BuildContext context) {
    double totalAmount = widget.totalPrice * selectedItems;

    return Container(
      padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: NColors.primary),
            ),
            child: Row(
              children: [
                IconButton(
                  icon: const Icon(
                    Icons.remove,
                    color: NColors.primary,
                  ),
                  onPressed: () {
                    if (selectedItems > 0) {
                      setState(() {
                        selectedItems--;
                      });
                    }
                  },
                ),
                Text(
                  '$selectedItems',
                  style: const TextStyle(
                      fontSize: 28, fontWeight: FontWeight.bold),
                ),
                IconButton(
                  icon: const Icon(Icons.add, color: NColors.primary),
                  onPressed: () {
                    setState(() {
                      selectedItems++;
                    });
                  },
                ),
              ],
            ),
          ),
          Row(
            children: [
              ElevatedButton(
                onPressed: () {
                  widget.onAddToCart(totalAmount, selectedItems);
                  setState(() {
                    isAddedToCart = selectedItems!=0 ? true : false;
                  });
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: NColors.primary,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: Row(
                    children: [
                      Text(
                        isAddedToCart ? 'Added' :'₹${totalAmount.toStringAsFixed(2)} Add to Cart',
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Icon(
                        isAddedToCart ? Icons.check_circle : Icons.shopping_cart,
                        size: 20,
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
