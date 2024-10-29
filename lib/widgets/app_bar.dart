import 'package:digital_canteen/utils/constants/colors.dart';
import 'package:digital_canteen/views/Home/search_menu.dart';
import 'package:digital_canteen/views/cart/cart_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String text;
  final Widget? child;
  final bool isMenuOpen;
  final Function(bool highToLow, bool lowToHigh, bool shortTime, bool longTime)
      onApplyFilters;

  const MyAppBar({
    super.key,
    required this.text,
    this.child,
    required this.isMenuOpen,
    required this.onApplyFilters,
  });

  @override
  Size get preferredSize =>
      isMenuOpen ? const Size.fromHeight(210) : const Size.fromHeight(171);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      surfaceTintColor: const Color.fromARGB(255, 239, 239, 239),
      scrolledUnderElevation: 5,
      shadowColor: NColors.lightGrey,
      systemOverlayStyle:
          const SystemUiOverlayStyle(statusBarColor: NColors.primary),
      toolbarHeight: isMenuOpen ? 210 : 171,
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
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const CartPage(),
                      ),
                    ),
                    child: const Icon(Icons.shopping_cart_rounded),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              child!,
              const SizedBox(height: 20),
              if (isMenuOpen) MenuContainer(onApplyFilters: onApplyFilters),
            ],
          ),
        ),
      ),
    );
  }
}
