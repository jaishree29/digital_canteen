import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class CancellationService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  /// Cancels an order by deleting the user's order document.
  Future<void> cancelOrder(String orderId) async {
    try {
      final user = _auth.currentUser;

      if (user == null) {
        throw Exception('User not authenticated');
      }

      final userId = user.uid;

      // Reference to the user's order document
      DocumentReference userOrderRef = _firestore
          .collection('users')
          .doc(userId)
          .collection('orders')
          .doc(orderId);

      // Delete the user's order from their collection
      await userOrderRef.delete();
      print('User order $orderId deleted successfully.');
    } catch (e) {
      print('Error during order cancellation: $e');
      throw Exception('Cancellation failed: $e');
    }
  }
}
