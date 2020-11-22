import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ready_set_cook/models/recipe.dart';

class RecipesDatabaseService {
  
  final String uid;
  DatabaseService({ this.uid });

  final CollectionReference recipeCollection = FirebaseFirestore.instance.collection('recipes');

  Future updateUserRecipes(List<Recipe> recipes) async {
    return await recipeCollection.doc(uid).set({
      'recipes': recipes
    });
  }
}