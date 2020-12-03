import 'package:ready_set_cook/models/nutrition.dart';

class Ingredient {
  String ingredientId;
  int userId;
  String nameOfIngredient;
  int startDate;
  int shelfLife;
  String quantity;
  int useDate;
  String unit;
  Nutrition nutrition;
  bool spoilage;

  set setIngredientId(String ingredientId) {
    this.ingredientId = ingredientId;
  }

  set setName(String name) {
    this.nameOfIngredient = name;
  }

  set duration(int duration) {
    this.shelfLife = duration;
  }

  set setQuantity(String quantity) {
    this.quantity = quantity;
  }

  setNutrition(int calories, int fat, int carb, int protein) {
    this.nutrition.calories = calories;
    this.nutrition.fat = fat;
    this.nutrition.carb = carb;
    this.nutrition.protein = protein;
  }

  set setSpoilage(bool spoilage) {
    this.spoilage = spoilage;
  }

  String get getIngredietId {
    return this.ingredientId;
  }

  int get getUserId {
    return this.userId;
  }

  String get getNameOfIngredient {
    return this.nameOfIngredient;
  }

  int get getStartDate {
    return this.startDate;
  }

  int get getShelfLife {
    return this.shelfLife;
  }

  String get getQuantity {
    return this.quantity;
  }

  int get getUseDate {
    return this.useDate;
  }

  Nutrition get getNutrition {
    return this.nutrition;
  }

  bool get getSpoilage {
    return this.spoilage;
  }

  Ingredient({
    this.ingredientId,
    this.userId,
    this.nameOfIngredient,
    this.shelfLife,
    this.startDate,
    this.quantity,
    this.unit,
    this.spoilage,
    this.useDate,
    this.nutrition,
  });
}
