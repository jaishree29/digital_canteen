import 'package:digital_canteen/utils/constants/colors.dart';
import 'package:digital_canteen/views/cart/cart_page.dart';
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    text,
                    style: const TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  InkWell(
                    onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const CartPage())),
                    child: const Icon(Icons.shopping_cart_rounded))
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
