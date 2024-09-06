import 'package:carousel_slider/carousel_slider.dart';
import 'package:digital_canteen/utils/constants/image_strings.dart';
import 'package:flutter/material.dart';
import 'package:digital_canteen/widgets/carousel_item.dart';

class ImageCarousel extends StatelessWidget {
  const ImageCarousel({super.key});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20.0), 
      child: CarouselSlider.builder(
        itemCount: NImages.carouselImages.length,
        itemBuilder: (context, index, realIndex) {
          return CarouselItem(
            imageUrl: NImages.carouselImages[index],
            onTap: () {
              _onImageTap(context, index);
            },
          );
        },
        options: CarouselOptions(
          autoPlay: true,
          autoPlayInterval: const Duration(seconds: 3),
          autoPlayCurve: Curves.ease,
          height: 170,
          aspectRatio: 16 / 9,
          viewportFraction: 1.0,
          enableInfiniteScroll: true,
        ),
      ),
    );
  }

  void _onImageTap(BuildContext context, int index) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Image $index clicked')),
    );
  }
}
