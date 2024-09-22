import 'package:cloud_firestore/cloud_firestore.dart';

class CartItems {
  final String foodId;
  final int selectedQuantity;
  final bool isHalf;

  const CartItems({
    required this.foodId,
    this.selectedQuantity = 1,
    required this.isHalf,
  });

  //total price
  Future<double> getTotalPrice() async {
    try {
      DocumentSnapshot foodItem = await FirebaseFirestore.instance.collection('menu').doc(foodId).get();

      // If food item does not exists
      if (!foodItem.exists) {
        throw Exception('Food item not found');
      }

      final data = foodItem.data() as Map<String, dynamic>;
      final foodItemPrice = isHalf ? data['half'] : data['full'];

      if (foodItemPrice is! num) {
        throw Exception('Invalid price data');
      }

      // total price
      return (foodItemPrice * selectedQuantity).toDouble();
    } catch (e) {
      print('Error fetching total price: $e');
      return 0.0;
    }
  }
}