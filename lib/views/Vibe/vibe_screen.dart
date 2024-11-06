import 'package:flutter/material.dart';

import '../../pacman/game_page.dart';
import 'upi_payment_screen.dart';

class VibeScreen extends StatelessWidget {
  const VibeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Vibe Screen'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop(); // Navigate back to the previous screen
          },
        ),
      ),
      body: Column(
        children: [
          Center(
            child: ElevatedButton(
              onPressed: () {
                // Navigate to existing GamePage when button is pressed
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const GamePage()),
                );
              },
              child: const Text('Play Game'),
            ),
          ),

        ],
      ),
    );
  }
}
