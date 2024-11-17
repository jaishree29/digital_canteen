import 'package:digital_canteen/utils/constants/colors.dart';
import 'package:digital_canteen/views/Orders/food_page.dart';
import 'package:flutter/material.dart';
import 'package:image_card/image_card.dart';

class NCards extends StatelessWidget {
  const NCards({
    super.key,
    required this.title,
    required this.description,
    this.isMenu = false,
    this.rating = '0',
    required this.foodId,
    required this.imageUrl, // Add imageUrl parameter
  });

  final String title;
  final String description;
  final bool? isMenu;
  final String rating;
  final String foodId;
  final String imageUrl; // Add imageUrl parameter

  @override
  Widget build(BuildContext context) {
    void whenTapped(BuildContext context, foodId) {
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
              return FoodPage(
                  foodId: foodId, scrollController: scrollController);
            },
          );
        },
      );
    }

    return Padding(
      padding: isMenu == false
          ? const EdgeInsets.only(right: 16.0, left: 2)
          : const EdgeInsets.only(bottom: 20),
      child: Container(
        height: 220,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          boxShadow: List.filled(
            10,
            const BoxShadow(
                blurStyle: BlurStyle.outer,
                blurRadius: BorderSide.strokeAlignOutside,
                color: NColors.lightGrey),
          ),
        ),
        child: InkWell(
          onTap: () => whenTapped(context, foodId),
          child: FillImageCard(
            height: 220,
            borderRadius: 15,
            width: isMenu == false ? 220 : 355,
            heightImage: 140,
            imageProvider: NetworkImage(imageUrl), // Use the imageUrl parameter
            title: Text(
              title,
              style: TextStyle(
                  fontSize: isMenu == false ? 18 : 20,
                  fontWeight: FontWeight.bold),
            ),
            description: isMenu == true
                ? Row(
                    children: [
                      Text(
                        rating,
                        style: TextStyle(fontSize: isMenu == false ? 12 : 15),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        description,
                        style: TextStyle(fontSize: isMenu == false ? 12 : 15),
                      ),
                    ],
                  )
                : Text(
                    description,
                    style: TextStyle(fontSize: isMenu == false ? 12 : 15),
                  ),
          ),
        ),
      ),
    );
  }
}
