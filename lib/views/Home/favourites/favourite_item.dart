import 'package:flutter/material.dart';

import '../../Orders/food/food_page.dart';

class FavouriteItem extends StatefulWidget {
  final String foodId;
  final String title;
  final String price;
  final String rating;
  final String imageUrl; // Add imageUrl parameter

  const FavouriteItem({
    super.key,
    required this.foodId,
    required this.title,
    required this.price,
    required this.rating,
    required this.imageUrl, // Add imageUrl parameter
  });

  @override
  State<FavouriteItem> createState() => _FavouriteItemState();
}

class _FavouriteItemState extends State<FavouriteItem> {
  void whenTapped(BuildContext context, foodId) {
    print(foodId);
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return DraggableScrollableSheet(
          initialChildSize: 1.0,
          maxChildSize: 1.0,
          minChildSize: 1.0,
          expand: true,
          builder: (context, scrollController) {
            return FoodPage(foodId: foodId, scrollController: scrollController);
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => whenTapped(context, widget.foodId),
      child: Container(
        margin: const EdgeInsets.all(10),
        height: 110,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20),
            bottomLeft: Radius.circular(20),
            topRight: Radius.circular(20),
            bottomRight: Radius.circular(20),
          ),
          border: Border.all(
            color: Colors.black12,
            width: 1,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 12.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.title,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    widget.price,
                    style: const TextStyle(fontSize: 17),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    widget.rating,
                    style: const TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 110,
              width: 110,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10.0),
                child: Image.network(
                  widget.imageUrl, // Use the imageUrl parameter
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
