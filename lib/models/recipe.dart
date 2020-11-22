import 'package:ready_set_cook/models/ingredient.dart';

class Recipe {
  int recipeId;
  int userId;
  List<Ingredient> ingredients;
  List<String> instructions;
  double rating;
  bool cookedBefore;
}