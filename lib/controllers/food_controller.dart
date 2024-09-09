import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:digital_canteen/models/menu_model.dart';

class FoodController {

//Adding food item to firebase
  Future<void> addFoodItem(Food food) async {
    await FirebaseFirestore.instance.collection('foodItems').add(food.toMap());
  }

//Converting Firestore document to Food object
  Food fromFirestore(DocumentSnapshot doc) {
    var data = doc.data() as Map<String, dynamic>;
    return Food(
      title: data['title'],
      description: data['description'],
      longDescription: data['longDescription'],
      imagePath: data['imagePath'],
      price: data['price'],
      time: data['time'],
      category: FoodCategory.values.firstWhere(
        (e) => e.toString() == 'FoodCategory.${data['category']}',
      ),
      rating: data['rating'],
    );
  }

  //Fetched food items
  Future<List<Food>> fetchFoodItems() async {
    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection('foodItems').get();
    return querySnapshot.docs.map((doc) => fromFirestore(doc)).toList();
  }
}
