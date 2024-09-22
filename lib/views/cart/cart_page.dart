import 'package:flutter/material.dart';

class CartPage extends StatelessWidget {
  final String foodId;
  final double? selectedItem;
  final int selectedQuantity;
  final double totalPrice;

  const CartPage({super.key, required this.foodId, required this.selectedItem, required this.selectedQuantity, required this.totalPrice});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Text(foodId),
            Text(selectedItem.toString()),
            Text(selectedQuantity.toString()),
            Text(totalPrice.toString()),
          ],
        ),
      ),
    );
  }
}
