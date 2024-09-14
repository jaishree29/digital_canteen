import 'package:flutter/material.dart';
import 'package:image_card/image_card.dart';

class OrderTile extends StatelessWidget {
  const OrderTile({super.key});

  @override
  Widget build(BuildContext context) {
    return const FillImageCard(
      imageProvider: NetworkImage(''),
      
    );
  }
}