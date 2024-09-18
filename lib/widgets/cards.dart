import 'package:digital_canteen/utils/constants/colors.dart';
import 'package:digital_canteen/utils/constants/image_strings.dart';
import 'package:flutter/material.dart';
import 'package:image_card/image_card.dart';

class NCards extends StatelessWidget {
  const NCards({
    super.key,
    required this.title,
    required this.description,
    this.isMenu = false,
    this.rating = '0',
    required this.onTap, 
    required this.foodId,
  });

  final String title;
  final String description;
  final bool? isMenu;
  final String rating;
  final Function onTap;
  final String foodId;

  @override
  Widget build(BuildContext context) {
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
          onTap: () => onTap,
          child: FillImageCard(
            height: 220,
            borderRadius: 15,
            width: isMenu == false ? 220 : 350,
            heightImage: 140,
            imageProvider: const NetworkImage(NImages.menuImageOne),
            // tags: [_tag('Category', () {}), _tag('Product', () {})],
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
