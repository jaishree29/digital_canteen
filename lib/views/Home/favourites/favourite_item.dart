import 'package:flutter/material.dart';
import 'package:digital_canteen/utils/constants/image_strings.dart';

class FavouriteItem extends StatelessWidget {
  final String foodId;
  final String title;
  final String price;
  final String rating;

  const FavouriteItem({
    super.key,
    required this.foodId,
    required this.title,
    required this.price,
    required this.rating,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
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
                  title,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  price,
                  style: const TextStyle(fontSize: 17),
                ),
                const SizedBox(height: 5),
                Text(
                  rating,
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
                NImages.menuImageOne,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
