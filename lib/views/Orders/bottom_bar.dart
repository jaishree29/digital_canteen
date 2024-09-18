import 'package:flutter/material.dart';

class BottomBar extends StatefulWidget {
  const BottomBar({super.key});

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  int selectedQuantity = 1;
  double totalPrice = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              IconButton(
                icon: const Icon(Icons.remove_circle_outline),
                onPressed: () {
                  if (selectedQuantity > 1) {
                    setState(() {
                      selectedQuantity--;
                    });
                  }
                },
              ),
              Text(
                '$selectedQuantity',
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
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

          Row(
            children: [
              ElevatedButton(
                onPressed: () {},
                child: const Text('Add Item'),
              ),
              const SizedBox(width: 10),
              Text(
                '\$${(selectedQuantity * totalPrice).toStringAsFixed(2)}',
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
