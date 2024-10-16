import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CancelOrder extends StatelessWidget {
  final String globalOrderId;

  const CancelOrder({
    Key? key,
    required this.globalOrderId,
  }) : super(key: key);

  Future<void> _cancelOrder(BuildContext context) async {
    try {
      // Access the 'global_orders' collection and update the cancellationStatus
      await FirebaseFirestore.instance
          .collection('global_orders')
          .doc(globalOrderId)
          .update({
        'cancellationStatus': 'Cancelled',
      });

      // Show confirmation or navigate back
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Order has been cancelled')),
      );

      Navigator.pop(context); // Go back to the previous screen after cancellation
    } catch (e) {
      // Handle errors (e.g., show an error message)
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error cancelling order: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cancel Order'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () => _cancelOrder(context),
          child: const Text('Confirm Cancel Order'),
        ),
      ),
    );
  }
}
