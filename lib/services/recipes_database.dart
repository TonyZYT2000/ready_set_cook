import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ready_set_cook/models/recipe.dart';

class RecipesDatabaseService {
  // uid of user
  final String uid;
  RecipesDatabaseService({this.uid});

  // obtains instance of the recipes collection from firestore
  final CollectionReference recipeCollection =
      FirebaseFirestore.instance.collection('recipes');

  // sets entire recipe list
  Future updateUserRecipes(List<Recipe> recipes) async {
    return await recipeCollection.doc(uid).set({'recipes': recipes});
  }

  Future addUserRecipes(Recipe r) async {
    return await recipeCollection.doc(uid).set({
      'recipes': [r]
    });
  }

  // get recipes stream
  Stream<QuerySnapshot> get recipes {
    return recipeCollection.snapshots();
  }
}
