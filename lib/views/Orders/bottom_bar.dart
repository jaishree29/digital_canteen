import 'package:digital_canteen/utils/constants/colors.dart';
import 'package:flutter/material.dart';

class BottomBar extends StatefulWidget {
  final VoidCallback onAddToCart;
  final double totalPrice;
  
  const BottomBar({super.key, required this.onAddToCart, required this.totalPrice});

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  int selectedItems = 0;

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
              border: Border.all(
                color: NColors.primary
              ),
            ),
            child: Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.remove, color: NColors.primary,),
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
                  style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
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
                onPressed: widget.onAddToCart,
                style: ElevatedButton.styleFrom(
                  backgroundColor: NColors.primary,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric( vertical: 16),
                  child: Row(
                    children: [
                      Text('₹${totalAmount.toStringAsFixed(2)} Add to Cart',),
                      const SizedBox(width: 5,),
                      const Icon(Icons.shopping_cart, size: 20,)
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
