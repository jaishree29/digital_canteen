import 'package:flutter/material.dart';

import '../../utils/constants/colors.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool showBackButton;

  const CustomAppBar({super.key, required this.title, this.showBackButton = true});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title),
      leading: showBackButton
          ? IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: () {
          Navigator.pop(context);
        },
      )
          : null, // If showBackButton is false, the back button won't appear
      backgroundColor: NColors.lightGrey, // You can customize the color here
      elevation: 4.0, // Customize elevation or other properties
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(65); // AppBar height
}
