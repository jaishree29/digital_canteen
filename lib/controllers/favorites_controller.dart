import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FavoritesController extends GetxController {
  var isFavorite = false.obs; // Observable variable for favorite status
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Function to check if a food item is already in favorites
  Future<void> checkIfFavorite(String foodId) async {
    final user = _auth.currentUser;
    if (user == null) {
      return;
    }

    DocumentSnapshot doc = await _firestore
        .collection('users')
        .doc(user.uid)
        .collection('favorites')
        .doc(foodId)
        .get();

    isFavorite.value = doc.exists;
  }

  // Function to toggle the favorite status of a food item
  Future<void> toggleFavorite(String foodId, Map<String, dynamic> foodData) async {
    final user = _auth.currentUser;
    if (user == null) {
      return;
    }

    if (isFavorite.value) {
      // Remove from favorites
      await _firestore
          .collection('users')
          .doc(user.uid)
          .collection('favorites')
          .doc(foodId)
          .delete();
    } else {
      // Add to favorites
      await _firestore
          .collection('users')
          .doc(user.uid)
          .collection('favorites')
          .doc(foodId)
          .set({
        ...foodData, // Storing the entire food data
        'foodId': foodId, // Adding the foodId explicitly
      });
    }

    isFavorite.value = !isFavorite.value; // Toggle the favorite status
  }
}
