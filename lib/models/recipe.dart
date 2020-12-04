import 'package:ready_set_cook/models/ingredient.dart';

class Recipe {
  String recipeId;
  String name;
  List<Ingredient> ingredients;
  List<String> instructions;
  double rating;
  int numRatings;

  Recipe(
      {this.recipeId,
      this.name,
      this.ingredients,
      this.instructions,
      this.rating,
      this.numRatings});

  String getRecipeId() {
    return recipeId;
  }
}
