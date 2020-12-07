import 'package:ready_set_cook/models/ingredient.dart';

import 'nutrition.dart';

class Recipe {
  String recipeId;
  String name;
  List<Ingredient> ingredients;
  List<String> instructions;
  Nutrition nutrition;
  double rating;
  int numRatings;
  String imageUrl;

  Recipe(
      {this.recipeId,
      this.name,
      this.ingredients,
      this.instructions,
      this.nutrition,
      this.rating,
      this.numRatings,
      this.imageUrl});

  String getRecipeId() {
    return recipeId;
  }
}
