import 'package:ready_set_cook/models/ingredient.dart';

class Recipe {
  String recipeId;
  String userId;
  String name;
  List<Ingredient> ingredients;
  List<String> instructions;
  double rating;
  bool cookedBefore;

  Recipe({
    this.recipeId,
    this.userId,
    this.name,
    this.ingredients,
    this.instructions,
    this.rating,
    this.cookedBefore,
  });

  String getRecipeId() {
    return recipeId;
  }
}
