import 'package:flutter/material.dart';

class BottomBar extends StatefulWidget {
  final VoidCallback onAddToCart;
  final double totalPrice;
  
  const BottomBar({super.key, required this.onAddToCart, required this.totalPrice});

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  int selectedQuantity = 0;

  @override
  Widget build(BuildContext context) {
    double totalAmount = widget.totalPrice * selectedQuantity;
    
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              border: Border.all(),
            ),
            child: Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.remove_circle_outline),
                  onPressed: () {
                    if (selectedQuantity > 0) {
                      setState(() {
                        selectedQuantity--;
                      });
                    }
                  },
                ),
                Text(
                  '$selectedQuantity',
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                IconButton(
                  icon: const Icon(Icons.add_circle_outline),
                  onPressed: () {
                    setState(() {
                      selectedQuantity++;
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
                child: const Text('Add Item'),
              ),
              const SizedBox(width: 10),
              Text(
                '₹${totalAmount.toStringAsFixed(2)}',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
