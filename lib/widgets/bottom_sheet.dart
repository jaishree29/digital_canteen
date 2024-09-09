import 'package:digital_canteen/utils/constants/colors.dart';
import 'package:flutter/material.dart';

class NBottomSheet extends StatelessWidget {
  const NBottomSheet({super.key, required this.icon, required this.widget, required this.text});
  final Icon icon;
  final Widget widget;
  final String text;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
          shape: const CircleBorder(),
          overlayColor: NColors.primary,
          elevation: 0,
          backgroundColor: Colors.white,
          foregroundColor: NColors.darkGrey,
        ),
        onPressed: () {
          showModalBottomSheet(
            context: context,
            backgroundColor: Colors.white,
            builder: (BuildContext ctx) {
              return SizedBox(
                height: 400,
                child: Padding(
                  padding: const EdgeInsets.all(25.0),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(text, style: const TextStyle(fontSize: 25)),
                          InkWell(
                            onTap: () {
                              Navigator.pop(ctx);
                            },
                            child: const Icon(Icons.close_rounded),
                          ),
                        ],
                      ),
                      widget,
                    ],
                  ),
                ),
              );
            },
          );
        },
        child: icon);
  }
}
