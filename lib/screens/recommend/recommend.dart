import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ready_set_cook/screens/recipes/recipe.dart';
import 'package:ready_set_cook/screens/recommend/filtered_recommend.dart';
import 'package:ready_set_cook/screens/recommend/randomRecommended.dart';

class Recommend extends StatefulWidget {
  @override
  _RecommendState createState() => _RecommendState();
}

class _RecommendState extends State<Recommend> {
  List<String> ingredientArray = [];

  Future<void> loadFromStorage() async {
    final uid = FirebaseAuth.instance.currentUser.uid;
    CollectionReference _documentRef = FirebaseFirestore.instance
        .collection('grocery')
        .doc(uid)
        .collection('groceryList');

    await _documentRef.get().then((ds) {
      // print(ds.toString());
      if (ds != null) {
        ds.docs.forEach((ingredient) {
          ingredientArray.add(ingredient['name']);
          print("storage stuff is" + ingredient['name']);
        });
      }
    });
  }

  Future<bool> getFav(String recipeId) async {
    final uid = FirebaseAuth.instance.currentUser.uid;
    bool result = false;
    CollectionReference _documentRef = FirebaseFirestore.instance
        .collection('recipes')
        .doc(uid)
        .collection('recipesList');

    await _documentRef.get().then((ds) {
      if (ds != null) {
        ds.docs.forEach((recipe) {
          var id = recipe['recipeId'];

          if (id == recipeId) {
            result = true;
          }
        });
      }
    });

    return result;
  }

  double roundDouble(double value, int places) {
    double mod = pow(10.0, places);
    return ((value * mod).round().toDouble() / mod);
  }

  @override
  Widget build(BuildContext context) {
    final uid = FirebaseAuth.instance.currentUser.uid;
    String name = "";
    double rating = 0;
    String imageUrl;
    bool fav;
    String recipeId;
    final Size size = MediaQuery.of(context).size;
    double padding = 25;
    final sidePadding = EdgeInsets.symmetric(horizontal: padding);
    return FutureBuilder(
        future: loadFromStorage(),
        builder: (context, loadSnapshot) {
          return StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('allRecipes')
                .orderBy("rating", descending: true)
                .snapshots(),
            builder: (ctx, allRecipeSnapshot) {
              if (allRecipeSnapshot.connectionState ==
                  ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              }
              final recipesdoc = allRecipeSnapshot.data.documents;
              print(recipesdoc.length);
              return Container(
                width: size.width,
                height: size.height,
                child: Stack(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 10),
                        Expanded(
                          child: Padding(
                            padding: sidePadding,
                            child: ListView.builder(
                                physics: BouncingScrollPhysics(),
                                itemCount: recipesdoc.length,
                                itemBuilder: (ctx, index) {
                                  print(index);
                                  recipeId = allRecipeSnapshot
                                      .data.documents[index]["recipeId"];
                                  name = allRecipeSnapshot.data.documents[index]
                                      ['name'];
                                  var temp = allRecipeSnapshot
                                      .data.documents[index]['rating'];
                                  rating = roundDouble(temp.toDouble(), 1);
                                  imageUrl = allRecipeSnapshot
                                      .data.documents[index]['imageUrl'];
                                  // return Text("jsjs");
                                  return FilteredRecipe(
                                    recipeId: recipeId,
                                    ingredientArray: ingredientArray,
                                    name: name,
                                    rating: rating,
                                    imageUrl: imageUrl,
                                    fav: fav,
                                    uid: uid,
                                  );
                                }),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
          );
        });
  }
}
