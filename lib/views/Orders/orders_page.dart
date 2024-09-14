import 'package:digital_canteen/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class OrdersPage extends StatefulWidget {
  const OrdersPage({super.key});

  @override
  State<OrdersPage> createState() => _OrdersPageState();
}

class _OrdersPageState extends State<OrdersPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
        systemOverlayStyle: const SystemUiOverlayStyle(statusBarColor: NColors.primary),
        title: const Text('Go back'),
      ),
      body: const Center(child: Text('No active orders. Try ordering some!')),
    );
  }
}