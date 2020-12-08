import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/number_symbols_data.dart';
import 'package:ready_set_cook/models/recipe.dart';
import 'dart:developer';
import 'package:flutter/material.dart';

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

  Future favRecipe(String recipeId) async {
    print("in favRecipe");
    String id;

    CollectionReference _documentRef =
        recipeCollection.doc(uid).collection('recipesList');
    return _documentRef.get().then((ds) {
      if (ds != null) {
        ds.docs.forEach((recipe) {
          id = recipe['recipeId'];
          print("The id is");
          print(id);
          if (id == recipeId) {
            print("we are in");
            return FirebaseFirestore.instance
                .collection('recipes')
                .doc(uid)
                .collection("recipesList")
                .doc(recipe.id)
                .set({"recipeId": recipeId, "fav": true});
          }
        });
      }
    });
  }

  Future unFavRecipe(String recipeId) async {
    String id;

    CollectionReference _documentRef =
        recipeCollection.doc(uid).collection('recipesList');
    return _documentRef.get().then((ds) {
      if (ds != null) {
        ds.docs.forEach((recipe) {
          id = recipe['recipeId'];
          print("The id is");
          print(id);
          if (id == recipeId) {
            print("we are in");
            return FirebaseFirestore.instance
                .collection('recipes')
                .doc(uid)
                .collection("recipesList")
                .doc(recipe.id)
                .set({"recipeId": recipeId, "fav": false});
          }
        });
      }
    });
  }

  Future addRecipe(String recipeId) async {
    return await recipeCollection
        .doc(uid)
        .collection("recipesList")
        .add({"recipeId": recipeId, "fav": false});
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
    allRecipesCollection.doc(recipe.recipeId).collection("uids").add({});

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

  // get recipes stream
  Stream<List<Recipe>> get recipes {
    return recipeCollection
        .doc(uid)
        .collection("recipesList")
        .snapshots()
        .map(_recipesList);
  }
}
