import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ready_set_cook/screens/recipes/recipe.dart';

class FilteredRecipe extends StatelessWidget {
  final recipeId;
  final ingredientArray;
  final name;
  final rating;
  final imageUrl;
  final fav;
  final uid;

  FilteredRecipe(
      {this.recipeId,
      this.ingredientArray,
      this.name,
      this.rating,
      this.imageUrl,
      this.fav,
      this.uid});

  @override
  Widget build(BuildContext context) {
    bool contained = false;

    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('allRecipes')
          .doc(recipeId)
          .collection('ingredients')
          .snapshots(),
      builder: (context, ingSnapshot) {
        if (ingSnapshot.connectionState == ConnectionState.waiting) {
          return Container();
        } else {
          var ingDocs = ingSnapshot.data.documents;
          for (var i = 0; i < ingDocs.length; i++) {
            var ingredientName = ingDocs[i]['name'];
            if (ingredientArray.contains(ingredientName)) {
              contained = true;
            }
            // return CompareWithStorage(ingredientName: ingredientName);
          }
        }
        return (contained == true)
            ? RecipeItem(
                name: name,
                rating: rating,
                recipeId: recipeId,
                imageUrl: imageUrl,
                fav: fav,
                uid: uid,
              )
            : SizedBox();
      },
    );
  }
}
