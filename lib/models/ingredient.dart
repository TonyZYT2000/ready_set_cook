import 'package:ready_set_cook/models/nutrition.dart';

class Ingredient {
  final String ingredientId;
  final int userId;
  final String nameOfIngredient;
  final int startDate;
  final int shelfLife;
  final int quantity;
  final int useDate;
  final Nutrition nutrition;
  final bool spoilage;

  Ingredient({
    this.ingredientId,
    this.userId,
    this.nameOfIngredient,
    this.shelfLife,
    this.startDate,
    this.quantity,
    this.spoilage,
    this.useDate,
    this.nutrition,
  });
}
