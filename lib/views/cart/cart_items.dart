import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class CartItems {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> addToCart(String imageUrl, String foodId, String foodTitle, double selectedPrice, int selectedItems) async {
    final user = _auth.currentUser;
    if (user == null) {
      throw Exception('User not authenticated');
    }

    // Generate a new document reference to get the unique ID for the cart item
    DocumentReference docRef = _firestore
        .collection('users')
        .doc(user.uid)
        .collection('cart')
        .doc(); // Creates a document reference with a unique ID

    String cartItemId = docRef.id; // Get the generated ID

    // Use the ID to add it as a field in the cart item
    await docRef.set({
      'imageUrl': imageUrl,
      'cartItemId': cartItemId, 
      'foodId': foodId,
      'foodTitle': foodTitle,
      'selectedPrice': selectedPrice,
      'selectedItems': selectedItems,
      'totalPrice': selectedPrice * selectedItems,
      'timestamp': FieldValue.serverTimestamp(),
    });

    print('Item added to cart with ID: $cartItemId');
  }


  Stream<QuerySnapshot> getCartItems() {
    final user = _auth.currentUser;
    if (user == null) {
      throw Exception('User not authenticated');
    }

    return _firestore
        .collection('users')
        .doc(user.uid)
        .collection('cart')
        .orderBy('timestamp', descending: true)
        .snapshots();
  }

  Future<void> deleteCartItem(String documentId) async {
    final user = _auth.currentUser;
    if (user == null) {
      throw Exception('User not authenticated');
    }

    await _firestore
        .collection('users')
        .doc(user.uid)
        .collection('cart')
        .doc(documentId)
        .delete();
  }
}
