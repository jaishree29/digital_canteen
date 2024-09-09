class Food {
  final String title;
  final String description;
  final String? longDescription;
  final String imagePath;
  final double? price;
  final double? time;
  final FoodCategory category;
  final double rating;
  final List<Quantity>? quantity;

  Food({
    required this.description,
    required this.imagePath,
    this.price,
    required this.title,
    this.time,
    this.longDescription,
    required this.category,
    required this.rating,
    this.quantity,
  });

  //Food object to map

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'description': description,
      'longDescription': longDescription,
      'imagePath': imagePath,
      'price': price,
      'time': time,
      'category': category.toString().split('.').last,
      'rating': rating,
    };
  }
}

//Quantity
class Quantity {
  double halfPrice;
  double fullPrice;

  Quantity({required this.fullPrice, required this.halfPrice});
}

//Food Categories

enum FoodCategory {
  burgers,
  desserts,
  drinks,
  snacks,
  chinese,
}
