import 'package:digital_canteen/models/menu_model.dart';

class AvailableFood {
  final List<Food> _menu = [
    Food(
        description: 'description',
        imagePath: 'imagePath',
        price: 40,
        title: 'title',
        category: FoodCategory.burgers,
        rating: 0,
        quantity: [Quantity(fullPrice: 100, halfPrice: 50)]),
    Food(
        description: 'description',
        imagePath: 'imagePath',
        price: 40,
        title: 'title',
        category: FoodCategory.burgers,
        rating: 0,
        quantity: [Quantity(fullPrice: 100, halfPrice: 50)]),
    Food(
        description: 'description',
        imagePath: 'imagePath',
        price: 40,
        title: 'title',
        category: FoodCategory.burgers,
        rating: 0,
        quantity: [Quantity(fullPrice: 100, halfPrice: 50)]),
    Food(
        description: 'description',
        imagePath: 'imagePath',
        price: 40,
        title: 'title',
        category: FoodCategory.burgers,
        rating: 0,
        quantity: [Quantity(fullPrice: 100, halfPrice: 50)]),
  ];

  //Getters
  List<Food> get menu => _menu;

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
