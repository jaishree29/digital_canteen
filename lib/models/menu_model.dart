class Food {
  final String title;
  final String description;
  final String? longDescription;
  final String imagePath;
  final double price;
  final double? time;
  final FoodCategory category;
  final double rating;

  Food({
    required this.description,
    required this.imagePath,
    required this.price,
    required this.title,
    this.time,
    this.longDescription,
    required this.category,
    required this.rating,
  });
}

//Food Category

enum FoodCategory {
  burgers,
  desserts,
  drinks,
  snacks,
  chinese,
}

