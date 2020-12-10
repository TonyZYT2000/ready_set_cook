import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ready_set_cook/models/ingredient.dart';
import 'editRecipe.dart';
import 'package:ready_set_cook/screens/recipes/viewRecipeTile.dart';
import 'package:ready_set_cook/models/nutrition.dart';
import 'package:ready_set_cook/screens/recipes/deleteConfirmation.dart';
import 'package:ready_set_cook/screens/recipes/rateRecipe.dart';

class ViewRecipe extends StatefulWidget {
  final Function toggleView;
  String recipeId = "";
  String name = "";
  String imageUrl = "";
  bool fav = false;
  ViewRecipe(this.recipeId, this.name, this.imageUrl, this.fav,
      {this.toggleView});
  @override
  _ViewRecipeState createState() => _ViewRecipeState();
}

class _ViewRecipeState extends State<ViewRecipe> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  String recipeId = "";
  String name = "";
  String quantity = "";
  String unit = "";
  String instruction = "";
  String imageUrl = "";
  bool fav = false;
  List<Ingredient> _ingredientsList = [];
  List<String> _instructionsList = [];
  Nutrition nutrition;

  @override
  void initState() {
    super.initState();
    this.recipeId = widget.recipeId;
    this.name = widget.name;
    this.imageUrl = widget.imageUrl;
    this.fav = widget.fav;
  }

  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('allRecipes')
            .doc(recipeId)
            .collection("ingredients")
            .snapshots(),
        builder: (ctx, ingredientSnapshot) {
          return StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('allRecipes')
                .doc(recipeId)
                .collection("instructions")
                .snapshots(),
            builder: (ctx, instructionSnapshot) {
              return StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('allRecipes')
                    .doc(recipeId)
                    .collection("nutrition")
                    .snapshots(),
                builder: (ctx, nutritionSnapshot) {
                  if (ingredientSnapshot.connectionState ==
                      ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  }

                  if (instructionSnapshot.connectionState ==
                      ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  }

                  if (nutritionSnapshot.connectionState ==
                      ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  }

                  instructionSnapshot.data.documents.forEach((instruction) {
                    _instructionsList.add(instruction['instruction']);
                  });

                  ingredientSnapshot.data.documents.forEach((ingredient) {
                    _ingredientsList.add(new Ingredient(
                        name: ingredient['name'],
                        quantity: ingredient['quantity'],
                        unit: ingredient['unit']));
                  });

                  nutritionSnapshot.data.documents.forEach((nut) {
                    nutrition = Nutrition(
                        calories: nut['Calories'],
                        protein: nut['Protein'],
                        totalCarbs: nut['Total Carbohydrate'],
                        totalFat: nut['Total Fat']);
                  });

                  return Scaffold(
                    backgroundColor: Colors.blue[50],
                    appBar: AppBar(
                      title: Text(name),
                      elevation: 0,
                      actions: <Widget>[
                        FlatButton(
                          minWidth: 20,
                          child: Text(
                            'Delete',
                            style: TextStyle(color: Colors.white, fontSize: 14),
                          ),
                          onPressed: () async {
                            DeleteConfirmation(context)
                                .showDeleteConfirmation(context, recipeId);
                          },
                        ),
                      ],
                    ),
                    floatingActionButtonLocation:
                        FloatingActionButtonLocation.centerDocked,
                    floatingActionButton: Padding(
                        padding: EdgeInsets.all(15.0),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              FloatingActionButton.extended(
                                  heroTag: "edit",
                                  icon: Icon(Icons.edit),
                                  label: Text("Edit",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 14)),
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => EditRecipe(
                                                ingredient: _ingredientsList,
                                                instruction: _instructionsList,
                                                nutrition: nutrition,
                                                imageUrl: imageUrl,
                                                fav: fav,
                                                recipeId: recipeId,
                                                name: name)));
                                  }),
                              FloatingActionButton.extended(
                                heroTag: "rate",
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(50.0),
                                    side: BorderSide(color: Colors.blue)),
                                icon: Icon(Icons.star,
                                    color: Colors.white, size: 20),
                                label: Text(
                                  'Rate',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 15),
                                ),
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              RatingBar(recipeId)));
                                },
                              )
                            ])),
                    body: Container(
                      child: ViewRecipeTile(
                          ingredient: _ingredientsList,
                          instruction: _instructionsList,
                          nutrition: nutrition,
                          imageUrl: imageUrl,
                          fav: fav,
                          recipeId: recipeId),
                    ),
                  );
                },
              );
            },
          );
        });
  }
}
