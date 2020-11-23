import 'package:ready_set_cook/models/ingredient.dart';

class Recipe {
  String recipeId;
  String userId;
  String name;
  List<Ingredient> ingredients;
  List<String> instructions;
  double rating;
  bool cookedBefore;

  Recipe(
      String recipeId,
      String userId,
      String name,
      List<Ingredient> ingredients,
      List<String> instructions,
      double rating,
      bool cookedBefore) {
    this.recipeId = recipeId;
    this.userId = userId;
    this.name = name;
    this.ingredients = ingredients;
    this.instructions = instructions;
    this.rating = rating;
    this.cookedBefore = cookedBefore;
  }
}
