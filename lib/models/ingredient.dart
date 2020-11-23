import 'package:ready_set_cook/models/nutrition.dart';

class Ingredient {
  String id;
  String name;
  int quantity;
  String unit;
  DateTime startDate;
  Nutrition nutrition;
  int shelfLife;
  bool spoilage;
  String imageUrl;

  Ingredient(this.id, this.name, this.quantity, this.unit, this.startDate,
      this.nutrition, this.shelfLife, this.spoilage, this.imageUrl);
}
