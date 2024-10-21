import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SeeOrderDetails extends StatelessWidget {
  final String globalOrderId;
  final Map<String, dynamic> order;

  const SeeOrderDetails({
    Key? key,
    required this.globalOrderId,
    required this.order,
  }) : super(key: key);

  // Function to show the cancel order confirmation dialog
  void _showCancelDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirm Cancellation'),
          content: const Text('Are you sure you want to cancel this order?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text('No'),
            ),
            ElevatedButton(
              onPressed: () async {
                // Perform the cancellation operation here
                await FirebaseFirestore.instance
                    .collection('global_orders')
                    .doc(globalOrderId)
                    .update({
                  'cancellationStatus': 'Cancelled',
                });

                // Close the dialog and show a confirmation message
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Order has been cancelled')),
                );
              },
              child: const Text('Yes, Cancel'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Order Details'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),
            Text('Food Title: ${order['foodTitle'] ?? 'Unknown'}'),
            Text('Items: ${order['selectedItems'] ?? 0}'),
            Text('Total Price: \₹${order['totalPrice']?.toStringAsFixed(2) ?? '0.0'}'),
            Text('Order Status: ${order['orderStatus'] ?? 'Unknown'}'),
            Text('Global Order ID: ${order['globalOrderId'] ?? 'N/A'}'),
            const SizedBox(height: 30),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  _showCancelDialog(context); // Show the dialog on button press
                },
                child: const Text('Cancel Order'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
