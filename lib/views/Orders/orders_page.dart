import 'package:digital_canteen/views/Orders/seeorderdetails_page.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'custom_appbar.dart';

class OrdersPage extends StatefulWidget {
  const OrdersPage({super.key});

  @override
  State<OrdersPage> createState() => _OrdersPageState();
}

class _OrdersPageState extends State<OrdersPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    final user = _auth.currentUser;

    if (user == null) {
      return const Scaffold(
        body: Center(child: Text('User not authenticated')),
      );
    }

    return Scaffold(
      appBar: const CustomAppBar(title: 'My Orders', showBackButton: true,), //custom AppBar used here
      body: SafeArea(
        child: StreamBuilder<QuerySnapshot>(
          stream: _firestore
              .collection('users')
              .doc(user.uid)
              .collection('orders')
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
        
            if (snapshot.hasError) {
              return const Center(child: Text('Error fetching orders'));
            }
        
            final orders = snapshot.data?.docs ?? [];
        
            if (orders.isEmpty) {
              return const Center(child: Text('No orders found.'));
            }
        
            return ListView.builder(
              itemCount: orders.length,
              itemBuilder: (context, index) {
                final order = orders[index].data() as Map<String, dynamic>;
                final orderId = orders[index].id; // Get the document ID
                final globalOrderId = order['globalOrderId'] ?? '';
                final orderStatus = order['orderStatus'] ?? 'Unknown';
                final foodTitle = order['foodTitle'] ?? 'Unknown';
                final selectedItems = order['selectedItems'] ?? 0;
                final totalPrice = order['totalPrice'] ?? 0.0;
        
                // Highlight order status based on its value
                Color statusColor;
                String statusText;
        
                switch (orderStatus) {
                  case 'Pending':
                    statusColor = Colors.orange;
                    statusText = 'Pending';
                    break;
                  case 'Available':
                    statusColor = Colors.green;
                    statusText = 'Available';
                    break;
                  case 'Not Available':
                    statusColor = Colors.red;
                    statusText = 'Not Available';
                    break;
                  case 'Order Preparing':
                    statusColor = Colors.red;
                    statusText = 'Order Preparing';
                    break;
                  case 'Order Prepared':
                    statusColor = Colors.red;
                    statusText = 'Order Prepared';
                    break;
                  case 'Order Delivered':
                    statusColor = Colors.red;
                    statusText = 'Order Delivered';
                    break;
                  default:
                    statusColor = Colors.grey;
                    statusText = 'Unknown';
                }
        
                return GestureDetector(
                  onTap: () {
                    // Handle the tap action, like navigating to the order details page
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SeeOrderDetails(
                          globalOrderId: globalOrderId,
                          order: order,
                        ),
                      ),
                    );
                    print(orderId);
                  },
                  child: Card(
                    margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                    child: ListTile(
                      title: Text(foodTitle),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Items: $selectedItems'),
                          Container(
                            margin: const EdgeInsets.only(top: 4),
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              color: statusColor.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Text(
                              statusText,
                              style: TextStyle(
                                color: statusColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text('₹${totalPrice.toStringAsFixed(2)}'),
                          // Conditionally show cancel icon based on orderStatus
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}


