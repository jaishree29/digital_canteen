import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../Orders/food/food_page.dart';

class ReorderItem extends StatefulWidget {
  final String foodId;
  final String title;
  final String price;
  final Timestamp time;
  final String imageUrl; 

  const ReorderItem({
    super.key,
    required this.foodId,
    required this.title,
    required this.price,
    required this.time,
    required this.imageUrl, 
  });

  @override
  State<ReorderItem> createState() => _ReorderItemState();
}

class _ReorderItemState extends State<ReorderItem> {
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
    // Format the date and time
    final formattedDate = DateFormat('dd/MM/yyyy').format(widget.time.toDate());

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
                    'On: $formattedDate',
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
                  widget.imageUrl, 
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
