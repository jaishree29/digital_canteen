import 'package:flutter/material.dart';

class CarouselItem extends StatelessWidget {
  final String imageUrl;
  final VoidCallback onTap;

  const CarouselItem({
    Key? key,
    required this.imageUrl,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Image.network(
        imageUrl,
        fit: BoxFit.cover,
        width: double.infinity,
      ),
    );
  }
}
