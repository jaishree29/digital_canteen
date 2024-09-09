import 'package:digital_canteen/models/menu_model.dart';
import 'package:flutter/material.dart';

class Filters {
  //sorts out and returns a list of food items that belong to a specific category
  List<Food> _filterMenuByCategory(FoodCategory category, List<Food> fullMenu) {
    return fullMenu.where((food) => food.category == category).toList();
  }

  //return list of foods in given category
  List<Widget> getFoodInThisCategory(List<Food> fullMenu) {
    return FoodCategory.values.map((category) {
      List<Food> categoryMenu = _filterMenuByCategory(category, fullMenu);

      return ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          itemCount: categoryMenu.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(categoryMenu[index].title),
            );
          });
    }).toList();
  }
}
