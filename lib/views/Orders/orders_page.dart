import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:digital_canteen/utils/constants/colors.dart';
import 'package:digital_canteen/views/Orders/order_history.dart';
import 'package:digital_canteen/views/Orders/seeorderdetails_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

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
      appBar: AppBar(
        automaticallyImplyLeading: false,
        foregroundColor: Colors.white,
        backgroundColor: NColors.primary,
        title: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                const SizedBox(
                  width: 10,
                ),
                const Text(
                  'My Orders',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ],
        ),
        toolbarHeight: 120,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
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
                  // final orderId = orders[index].id;
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
                      // Navigate to order details page
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SeeOrderDetails(
                            globalOrderId: globalOrderId,
                            order: order,
                          ),
                        ),
                      );
                    },
                    child: Card(
                      margin: const EdgeInsets.symmetric(
                          vertical: 8, horizontal: 10),
                      child: ListTile(
                        title: Text(foodTitle),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Items: $selectedItems'),
                            Container(
                              margin: const EdgeInsets.only(top: 4),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 4),
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
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navigate to the Recently Ordered page
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => RecentlyOrderedPage(),
            ),
          );
        },
        child: const Icon(Icons.access_time),
      ),
      // floatingActionButtonLocation: FloatingActionButtonLocation.endFloat, // Specify location
    );
  }
}
