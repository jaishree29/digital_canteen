import 'package:digital_canteen/utils/constants/colors.dart';
import 'package:digital_canteen/utils/constants/image_strings.dart';
import 'package:flutter/material.dart';
import 'package:image_card/image_card.dart';

class NCards extends StatelessWidget {
  const NCards({super.key, required this.title, required this.description});
  final String title;
  final String description;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0, right: 8.0, bottom: 8.0),
      child: Container(
        height: 220,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          boxShadow: List.filled(
            4,
            const BoxShadow(
              blurStyle: BlurStyle.outer,
              blurRadius: BorderSide.strokeAlignOutside,
              color: NColors.lightGrey),
          ),
        ),
        child: FillImageCard(
          height: 220,
          borderRadius: 15,
          width: 220,
          heightImage: 140,
          imageProvider: const NetworkImage(NImages.menuImageOne),
          // tags: [_tag('Category', () {}), _tag('Product', () {})],
          title: Text(
            title,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          description: Text(
            description,
            style: const TextStyle(fontSize: 12),
          ),
        ),
      ),
    );
  }
}
