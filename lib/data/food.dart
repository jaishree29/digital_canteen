import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:digital_canteen/models/food_model.dart';

class AvailableFood {
  final List<FoodModel> menuItems = [
    FoodModel(
      id: '1',
      description: 'description',
      imageUrl: 'imagePath',
      price: [Price(fullPrice: 50, halfPrice: 100)],
      title: 'title',
      category: FoodCategory.burgers,
      rating: 0,
      time: Timestamp.now(),
    ),
  ];

  //Getters
  List<FoodModel> get menu => menuItems;

  //Operations

  //Add to cart

  //Remove from cart

  //Get global price of the cart

  //get total number of items in cart

  //clear the cart

  //Helper methods

  //Generate a receipt

  //Format double value into money

  //
}
