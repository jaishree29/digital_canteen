import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:digital_canteen/models/food_model.dart';

class FoodController {

//Adding food item to firebase
  Future<void> addFoodItem(FoodModel food) async {
    await FirebaseFirestore.instance.collection('menu').add(food.toMap());
  }

//Converting Firestore document to FoodModel object
  FoodModel fromFirestore(DocumentSnapshot doc) {
    var data = doc.data() as Map<String, dynamic>;
    return FoodModel(
      id: data['id'],
      title: data['title'],
      description: data['description'],
      imageUrl: data['imagePath'],
      price: data['price'],
      time: data['time'],
      category: FoodCategory.values.firstWhere(
        (e) => e.toString() == 'FoodCategory.${data['category']}',
      ),
      rating: data['rating'],
    );
  }

  //Fetched food items
  Future<List<FoodModel>> fetchFoodItems() async {
    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection('foodItems').get();
    return querySnapshot.docs.map((doc) => fromFirestore(doc)).toList();
  }
}
