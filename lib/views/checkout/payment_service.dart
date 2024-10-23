import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:digital_canteen/views/checkout/phone_payment_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
class PaymentService {
  final double totalPrice;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final FirebaseAuth auth = FirebaseAuth.instance;
  final PhonePaymentService phonePaymentService = PhonePaymentService();

  PaymentService(List<QueryDocumentSnapshot<Object?>> cartItems, this.totalPrice);

  // Function that integrates payment completion with order creation
  Future<void> completePayment(List<QueryDocumentSnapshot> cartItems,totalPrice) async {
    final user = auth.currentUser; // Get the current user
    if (user == null) {
      throw Exception('User not authenticated');
    }

    try {
      // Call the phone payment service to process payment
      bool paymentSuccess = await phonePaymentService.processPhonePayment(totalPrice);

      if (!paymentSuccess) {
        throw Exception('Payment failed'); // Handle failed payment
      }

      // If payment is successful, create orders
      for (var item in cartItems) {
        final cartItemData = item.data() as Map<String, dynamic>;

        String userOrderId = firestore.collection('orders').doc().id;
        String globalOrderId = firestore.collection('global_orders').doc().id;

        // Set order data for each item in the user's orders collection
        await firestore
            .collection('users')
            .doc(user.uid)
            .collection('orders')
            .doc(userOrderId)
            .set({
          'orderStatus': 'Pending', // Status of the order
          'timestamp': FieldValue.serverTimestamp(), // Order creation time
          'totalPrice': cartItemData['totalPrice'], // Total price of this item
          'foodId': cartItemData['foodId'], // Food item details
          'foodTitle': cartItemData['foodTitle'],
          'selectedPrice': cartItemData['selectedPrice'],
          'selectedItems': cartItemData['selectedItems'],
          'globalOrderId': globalOrderId, // Reference to the global order
        });

        print('Order created successfully for item: ${cartItemData['foodTitle']}');

        // Set order data for each item in the global orders collection
        await firestore
            .collection('global_orders')
            .doc(globalOrderId)
            .set({
          'userId': user.uid, // User ID for the global order
          'userOrderId': userOrderId, // Reference to the user's order ID
          'cancellationStatus': 'Pending', // Status of the order
          'timestamp': FieldValue.serverTimestamp(), // Order creation time
          'totalPrice': cartItemData['totalPrice'], // Total price of this item
          'foodId': cartItemData['foodId'], // Food item details
          'foodTitle': cartItemData['foodTitle'],
          'selectedPrice': cartItemData['selectedPrice'],
          'selectedItems': cartItemData['selectedItems'],
        });

        print('Global order created successfully for item: ${cartItemData['foodTitle']}');
        // After successfully placing the order, delete the item from the user's cart
        await firestore
            .collection('users')
            .doc(user.uid)
            .collection('cart') // Assuming the cart collection is under the user's document
            .doc(cartItemData['cartItemId']) // Deleting the specific cart item by its document ID
            .delete();

        print('Cart item deleted successfully: ${cartItemData['foodTitle']}');
      }

      print('All orders created successfully for the user and global orders.');


    } catch (e) {
      throw Exception('Error during payment or order processing: $e');
    }
  }
}
