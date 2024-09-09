import 'package:digital_canteen/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MyAppBar({super.key, required this.text, this.child});

  final String text;
  final Widget? child;

  @override
  Size get preferredSize => const Size.fromHeight(170);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      surfaceTintColor: NColors.secondary,
      scrolledUnderElevation: 5,
      shadowColor: NColors.lightGrey,
      systemOverlayStyle: const SystemUiOverlayStyle(statusBarColor: NColors.primary),
      toolbarHeight: 170,
      flexibleSpace: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Home',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  CircleAvatar(
                    backgroundColor: NColors.primary,
                    radius: 25,
                  ),
                ],
              ),
              const SizedBox(height: 20),
              child!,
            ],
          ),
        ),
      ),
    );
  }
}
