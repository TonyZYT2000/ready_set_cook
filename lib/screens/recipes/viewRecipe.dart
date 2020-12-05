import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ready_set_cook/models/ingredient.dart';
import 'package:ready_set_cook/screens/recipes/deleteConfirmation.dart';
import 'editRecipe.dart';
import 'package:ready_set_cook/screens/recipes/viewRecipeTile.dart';
import 'package:ready_set_cook/models/nutrition.dart';
import 'package:ready_set_cook/models/recipe.dart';

class ViewRecipe extends StatefulWidget {
  final Function toggleView;
  String recipeId = "";
  ViewRecipe(this.recipeId, {this.toggleView});
  @override
  _ViewRecipeState createState() => _ViewRecipeState();
}

class _ViewRecipeState extends State<ViewRecipe> {
  String recipeId = "";
  List<Ingredient> _ingredientsList = [];
  List<String> _instructionsList = [];
  List<Nutrition> _nutritionList = [];
  List<Recipe> _recipes = [];

  @override
  void initState() {
    super.initState();
    this.recipeId = widget.recipeId;
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
                        nameOfIngredient: ingredient['name'],
                        quantity: ingredient['quantity'].toString(),
                        unit: ingredient['unit']));
                  });

                  nutritionSnapshot.data.documents.forEach((nutrition) {
                    _nutritionList.add(new Nutrition(
                        calories: nutrition['Calories'].toString(),
                        protein: nutrition['Protein'],
                        totalCarbs: nutrition['Total Carbohydrate'],
                        totalFat: nutrition['Total Fat']));
                  });

                  return Scaffold(
                      appBar: AppBar(
                        title: Text("View Recipe"),
                        elevation: 0,
                        actions: <Widget>[
                          FlatButton.icon(
                            minWidth: 20,
                            icon: Icon(Icons.delete),
                            label: Text('Delete'),
                            onPressed: () async {
                              DeleteConfirmation(context)
                                  .showDeleteConfirmation(context, recipeId);
                            },
                          ),
                        ],
                      ),
                      floatingActionButton: FloatingActionButton.extended(
                          icon: Icon(Icons.edit),
                          label: Text("Edit"),
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => EditRecipe()));
                          }),
                      body: Container(
                          child: ViewRecipeTile(
                              ingredient: _ingredientsList,
                              instruction: _instructionsList,
                              nutrition: _nutritionList)));
                },
              );
            },
          );
        });
  }
}
