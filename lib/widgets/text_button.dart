import 'package:digital_canteen/utils/constants/colors.dart';
import 'package:flutter/material.dart';

class NTextButton extends StatelessWidget {
  const NTextButton({
    super.key,
    required this.onTap,
    required this.text,
    required this.selected,
    required this.borderRadius,
  });

  final VoidCallback onTap;
  final String text;
  final bool selected;
  final BorderRadius borderRadius;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap, 
      child: Container(
        decoration: BoxDecoration(
          color: selected
              ? NColors.light
              : Colors.white, 
          border: Border.all(
            strokeAlign: BorderSide.strokeAlignInside,
            color: selected ? NColors.primary : NColors.secondary,
          ),
          borderRadius:
              borderRadius, 
        ),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        child: Center(
          child: Text(
            text,
            style: const TextStyle(
              color: NColors.darkGrey,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
