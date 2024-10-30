import 'package:digital_canteen/views/Vibe/upi_payment_screen.dart';
import 'package:flutter/material.dart';

import '../../pacman/game_page.dart';

class Vibe extends StatefulWidget {
  const Vibe({super.key});

  @override
  State<Vibe> createState() => _VibeState();
}

class _VibeState extends State<Vibe> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Vibe'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context); // Navigate back to the previous screen
          },
        ),
      ),
      body: Column(
        children: [
          // Center(
          //   child: ElevatedButton(
          //     onPressed: () {
          //       Navigator.push(
          //         context,
          //         MaterialPageRoute(builder: (context) => const GamePage()),
          //       );
          //     },
          //     child: const Text('Play Game'),
          //   ),
          // ),
          Center(
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) =>  UpiPaymentScreen()),
                );
              },
              child: const Text('PAY'),
            ),
          ),
        ],
      ),
    );
  }
}
