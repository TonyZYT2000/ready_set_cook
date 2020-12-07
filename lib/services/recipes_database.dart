import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/number_symbols_data.dart';
import 'package:ready_set_cook/models/recipe.dart';
import 'dart:developer';

class RecipesDatabaseService {
  // uid of user
  String uid;
  RecipesDatabaseService({this.uid});

  // obtains instance of the recipes collection from firestore
  final CollectionReference recipeCollection =
      FirebaseFirestore.instance.collection('recipes');

  final CollectionReference allRecipesCollection =
      FirebaseFirestore.instance.collection('allRecipes');

  String _recipeName;
  double _recipeRating;

  Future addRecipe(String recipeId) async {
    return await recipeCollection
        .doc(uid)
        .collection("recipesList")
        .add({"recipeId": recipeId});
  }

  deleteRecipe(String recipeId, String uid) {
    FirebaseFirestore.instance
        .collection('recipes')
        .doc(uid)
        .collection('recipesList')
        .snapshots()
        .listen((snapshot) {
      snapshot.docs.forEach((recipeIdField) {
        if (recipeIdField['recipeId'] == recipeId) {
          FirebaseFirestore.instance
              .collection('recipes')
              .doc(uid)
              .collection("recipesList")
              .doc(recipeIdField.id)
              .delete();
        }
      });
    });
  }

  Future addCustomRecipe(Recipe recipe) async {
    recipe.ingredients.forEach((ing) {
      allRecipesCollection
          .doc(recipe.recipeId)
          .collection("ingredients")
          .add({"name": ing.name, "quantity": ing.quantity, "unit": ing.unit});
    });

    recipe.instructions.forEach((ins) {
      allRecipesCollection
          .doc(recipe.recipeId)
          .collection("instructions")
          .add({"instruction": ins});
    });

    allRecipesCollection.doc(recipe.recipeId).collection("nutrition").add({
      "Calories": recipe.nutrition.calories,
      "Protein": recipe.nutrition.protein,
      "Total Fat": recipe.nutrition.totalFat,
      "Total Carbohydrate": recipe.nutrition.totalCarbs,
    });

    await allRecipesCollection.doc(recipe.recipeId).set({
      "recipeId": recipe.recipeId,
      "name": recipe.name,
      "rating": recipe.rating,
      "numRatings": recipe.numRatings,
      "imageUrl": recipe.imageUrl,
    });
    addRecipe(recipe.recipeId);
    recipe.ingredients.clear();
    recipe.instructions.clear();
  }

  Future getRecipesHelper(QueryDocumentSnapshot qds) async {
    DocumentSnapshot recipeSnapshot =
        await allRecipesCollection.doc(qds.get('recipeId')).get();
    _recipeName = recipeSnapshot.get('name');
    _recipeRating = recipeSnapshot.get('rating');
  }

  // list of recipes from snapshot
  List<Recipe> _recipesList(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      getRecipesHelper(doc);
      log('called helper');
      return Recipe(
        recipeId: doc.get('recipeId'),
        name: _recipeName,
        ingredients: null,
        instructions: null,
        rating: _recipeRating,
      );
    }).toList();
  }

  /*QuerySnapshot list;
    List<DocumentSnapshot> snap = snapshot.docs;
    for (var i in snap) {
      // var dss = i.data();

      // var key = dss.keys.firstWhere((k) => dss[k] == uid);

      if (i.id == uid) {
        list = i.get('recipesList');
      }
    }

    return list.docs.map((doc) {
      return doc.data()['recipeId'];
      /* return Recipe(
        doc.data['recipeId'],
        doc.data['userId'],
        doc.data['name'],
        null,
        null,
        doc.data['rating'],
      );*/
    }).toList();*/

  // get recipes stream
  Stream<List<Recipe>> get recipes {
    return recipeCollection
        .doc(uid)
        .collection("recipesList")
        .snapshots()
        .map(_recipesList);
  }

  // List<Recipe>  get recipes {

  //   StreamBuilder(
  //     stream:
  //   )

  //   return recipeCollection
  //       .doc(uid)
  //       .collection("recipesList")
  //       .snapshots()
  //       .map(_recipesList);
  // }
}
