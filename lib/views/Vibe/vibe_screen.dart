import 'package:digital_canteen/utils/constants/colors.dart';
import 'package:flutter/material.dart';


class VibeScreen extends StatelessWidget {
  const VibeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        foregroundColor: Colors.white,
        backgroundColor: NColors.primary,
        title: const Text(
          'Vibe',
          style: TextStyle(
            color: Colors.white,
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),
        toolbarHeight: 100,

      ),
      body: const Center(child: Text('Coming soon...')),
    );
  }
}
