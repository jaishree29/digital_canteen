import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:digital_canteen/views/checkout/phone_payment_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class PaymentService {
  final double totalPrice;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final FirebaseAuth auth = FirebaseAuth.instance;
  final PhonePaymentService phonePaymentService = PhonePaymentService();
  late Razorpay razorpay;

  PaymentService(
      List<QueryDocumentSnapshot<Object?>> cartItems, this.totalPrice) {
    razorpay = Razorpay();
    razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  void openCheckout() {
    var options = {
      'key': 'rzp_test_QKIt1H3MVWezZs',
      'amount': (totalPrice * 100).toInt(),
      'name': 'NotClg',
      'description': 'Food Order Payment',
      'timeout': 60,
      'prefill': {
        'contact': '+919625043169',
        'email': 'jaishreeofficial29@gmail.com',
      },
      'external': {
        'wallets': ['paytm']
      }
    };

    try {
      razorpay.open(options);
    } catch (e) {
      print('Error: $e');
    }
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) async {
    print('Payment successful: ${response.paymentId}');
    Fluttertoast.showToast(msg: 'Payment successful');
    // Call the complete payment function here with cart items
    final user = auth.currentUser;
    if (user == null) {
      throw Exception('User not authenticated');
    }
    try {
      List<QueryDocumentSnapshot> cartItems = await getCartItems(user.uid);
      final String imageUrl =
          cartItems.isNotEmpty ? cartItems.first['imageUrl'] : '';
      await completePayment(imageUrl, cartItems, totalPrice);
    } catch (e) {
      print('Error handling payment success: $e');
    }
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    print('Payment failed: ${response.message}');
    Fluttertoast.showToast(msg: 'Payment failed');
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    print('External wallet selected: ${response.walletName}');
    Fluttertoast.showToast(msg: response.toString());
  }

  Future<List<QueryDocumentSnapshot>> getCartItems(String userId) async {
    QuerySnapshot querySnapshot = await firestore
        .collection('users')
        .doc(userId)
        .collection('cart')
        .orderBy('timestamp', descending: true)
        .get();
    return querySnapshot.docs;
  }

  // Function that integrates payment completion with order creation
  Future<void> completePayment(String imageUrl,
      List<QueryDocumentSnapshot> cartItems, double totalPrice) async {
    final user = auth.currentUser; // Get the current user
    if (user == null) {
      throw Exception('User not authenticated');
    }

    try {
      // Fetch user details from Firestore
      DocumentSnapshot userDoc =
          await firestore.collection('users').doc(user.uid).get();
      if (!userDoc.exists) {
        throw Exception('User details not found');
      }

      // Extract user details from the document
      final userData = userDoc.data() as Map<String, dynamic>;
      final userName = userData['Name'];
      final userPhone = userData['Phone Number'];

      // Call the phone payment service to process payment
      bool paymentSuccess =
          await phonePaymentService.processPhonePayment(totalPrice);

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
          'imageUrl': imageUrl,
          'orderStatus': 'Pending', // Status of the order
          'timestamp': FieldValue.serverTimestamp(), // Order creation time
          'totalPrice': cartItemData['totalPrice'], // Total price of this item
          'foodId': cartItemData['foodId'], // Food item details
          'foodTitle': cartItemData['foodTitle'],
          'selectedPrice': cartItemData['selectedPrice'],
          'selectedItems': cartItemData['selectedItems'],
          'globalOrderId': globalOrderId, // Reference to the global order
          'OrderId': userOrderId,
          'preparationDuration': 600, // Example: 10 minutes in seconds
          'userName': userName, // Added user name
          'userPhone': userPhone, // Added user phone
        });

        print(
            'Order created successfully for item: ${cartItemData['foodTitle']}');

        // Set order data for each item in the global orders collection
        await firestore.collection('global_orders').doc(globalOrderId).set({
          'userId': user.uid, // User ID for the global order
          'userOrderId': userOrderId, // Reference to the user's order ID
          'cancellationStatus': 'Pending', // Status of the order
          'timestamp': FieldValue.serverTimestamp(), // Order creation time
          'totalPrice': cartItemData['totalPrice'], // Total price of this item
          'foodId': cartItemData['foodId'], // Food item details
          'foodTitle': cartItemData['foodTitle'],
          'selectedPrice': cartItemData['selectedPrice'],
          'selectedItems': cartItemData['selectedItems'],
          'deliveryStatus': 'Pending',
          'userName': userName, // Added user name
          'userPhone': userPhone, // Added user phone
          'notification': 'null',
        });

        print(
            'Global order created successfully for item: ${cartItemData['foodTitle']}');

        // After successfully placing the order, delete the item from the user's cart
        await firestore
            .collection('users')
            .doc(user.uid)
            .collection(
                'cart') // Assuming the cart collection is under the user's document
            .doc(cartItemData[
                'cartItemId']) // Deleting the specific cart item by its document ID
            .delete();

        print('Cart item deleted successfully: ${cartItemData['foodTitle']}');
      }

      print('All orders created successfully for the user and global orders.');
    } catch (e) {
      throw Exception('Error during payment or order processing: $e');
    }
  }
}
