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

  Future addRecipe(Recipe recipe) async {
    return await recipeCollection
        .doc(uid)
        .collection("recipesList")
        .add({"recipe": recipe});
  }

  // list of recipes from snapshot
  List<Recipe> _recipesList(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return Recipe(
        recipeId: doc(uid).collection("recipesList").data['recipeId'],
        userId: doc(uid).collection("recipesList").data['userId'],
        name: doc(uid).collection("recipesList").data['name'],
        name: doc(uid).collection("recipesList").data['name'],
        name: doc(uid).collection("recipesList").data['name'],
      );
    });
  }

  // get recipes stream
  Stream<QuerySnapshot> get recipes {
    return recipeCollection.snapshots();
  }
}
