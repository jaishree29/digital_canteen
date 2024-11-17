import 'package:digital_canteen/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'favourite_items.dart';
import '../reorder/reorder_screen.dart';

class FavouriteScreen extends StatelessWidget {
  const FavouriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          automaticallyImplyLeading: false,
          title: GestureDetector(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(
                  Icons.arrow_back_ios_new_rounded,
                  color: Colors.grey,
                ),
                SizedBox(width: 10,),
                Text(
                  'Go back',
                  style: TextStyle(color: Colors.grey, fontSize: 18),
                ),
              ],
            ),
          ),
          bottom: TabBar(
            overlayColor: const WidgetStatePropertyAll(NColors.light),
            splashBorderRadius: BorderRadius.circular(10),
            labelStyle: const TextStyle(
                fontSize: 18, color: Colors.black, fontWeight: FontWeight.w500),
            indicatorColor: NColors.primary,
            tabs: const [
              Tab(text: 'Favorites'),
              Tab(text: 'Reorder'),
            ],
          ),
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 10),
            child: TabBarView(
              children: [
                FavouriteItems(),
                ReorderScreen(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
