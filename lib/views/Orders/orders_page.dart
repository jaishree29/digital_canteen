import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../timer/order_tracking_page.dart';
import '../../utils/constants/colors.dart';

class OrdersPage extends StatefulWidget {
  const OrdersPage({super.key});

  @override
  State<OrdersPage> createState() => _OrdersPageState();
}

class _OrdersPageState extends State<OrdersPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> updateVendorAndOrderStatus(
      String globalOrderId, String orderId) async {
    // Implement the function to update the vendor side data here.
    // This is a placeholder function, replace it with actual logic.
    await _firestore.collection('global_orders').doc(globalOrderId).update({
      'notification': 'User is picking up the order!',
    });

    // Update the order status to "Order Prepared" in the user's collection.
    await _firestore
        .collection('users')
        .doc(_auth.currentUser?.uid)
        .collection('orders')
        .doc(orderId)
        .update({
      'orderStatus': 'Order Prepared',
    });
  }

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
        title: const Text(
          'My Orders',
          style: TextStyle(
            color: Colors.white,
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),
        toolbarHeight: 100,
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
                return const Center(child: Text('No orders found!'));
              }

              return ListView.builder(
                itemCount: orders.length,
                itemBuilder: (context, index) {
                  final order = orders[index].data() as Map<String, dynamic>;
                  final orderId = orders[index].id;
                  final globalOrderId = order['globalOrderId'] ?? '';
                  final orderStatus = order['orderStatus'] ?? 'Unknown';
                  final foodTitle = order['foodTitle'] ?? 'Unknown';
                  final selectedItems = order['selectedItems'] ?? 0;
                  final totalPrice = order['totalPrice'] ?? 0.0;
                  final imageUrl = order['imageUrl'] ?? ''; // Fetch image URL

                  // Highlight order status based on its value
                  Color statusColor;
                  String statusText;

                  switch (orderStatus) {
                    case 'Pending':
                      statusColor = Colors.orange;
                      statusText = 'Pending';
                      break;
                    case 'Order is Ready':
                      statusColor = Colors.green;
                      statusText = 'Order is Ready';
                      break;
                    case 'Order Prepared':
                      statusColor = Colors.blue;
                      statusText = 'Order Prepared';
                      break;
                    default:
                      statusColor = Colors.grey;
                      statusText = 'Unknown';
                  }

                  return GestureDetector(
                    onTap: () async {
                      if (orderStatus == 'Order is Ready') {
                        // Show dialog asking if the user is going to pick the order
                        bool? isPickingUp = await showDialog<bool>(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Text('Order Pickup Confirmation'),
                              content: const Text(
                                  'Hey, are you going to pick up your order?'),
                              actions: <Widget>[
                                TextButton(
                                  onPressed: () =>
                                      Navigator.of(context).pop(false),
                                  child: const Text('No'),
                                ),
                                TextButton(
                                  onPressed: () =>
                                      Navigator.of(context).pop(true),
                                  child: const Text('Yes'),
                                ),
                              ],
                            );
                          },
                        );

                        if (isPickingUp == true) {
                          // Update vendor and change order status to "Order Prepared"
                          await updateVendorAndOrderStatus(
                              globalOrderId, orderId);

                          // Navigate to tracking page after confirmation
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => TrackingOrderPage(
                                globalOrderId: globalOrderId,
                                order: order,
                                orderId: orderId,
                                imageUrl: imageUrl,
                              ),
                            ),
                          );
                        }
                      } else {
                        // If status is not "Order is Ready", directly navigate to tracking page
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => TrackingOrderPage(
                              globalOrderId: globalOrderId,
                              order: order,
                              orderId: orderId, imageUrl: imageUrl,
                            ),
                          ),
                        );
                      }
                    },
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                        side: const BorderSide(color: NColors.lightGrey),
                      ),
                      color: Colors.white,
                      margin: const EdgeInsets.symmetric(
                          vertical: 8, horizontal: 10),
                      child: Row(
                        children: [
                          ClipRRect(
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(10),
                              bottomLeft: Radius.circular(10),
                            ),
                            child: Image.network(
                              imageUrl, // Use the imageUrl parameter
                              width: 100,
                              height: 100,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Expanded(
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
                              trailing:
                                  Text('₹${totalPrice.toStringAsFixed(2)}'),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
