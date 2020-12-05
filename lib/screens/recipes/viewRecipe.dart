import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ready_set_cook/models/ingredient.dart';
import 'editRecipe.dart';
import 'package:ready_set_cook/screens/recipes/viewRecipeTile.dart';
import 'package:ready_set_cook/models/nutrition.dart';

class ViewRecipe extends StatefulWidget {
  final Function toggleView;
  String recipeId = "";
  ViewRecipe(this.recipeId, {this.toggleView});
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
  List<Ingredient> _ingredientsList = [];
  List<String> _instructionsList = [];
  Nutrition nutrition;

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
            if (ingredientSnapshot.connectionState == ConnectionState.waiting) {
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
                appBar: AppBar(title: Text("View Recipe")),
                floatingActionButton: FloatingActionButton.extended(
                    icon: Icon(Icons.edit),
                    label: Text("Edit"),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => EditRecipe(this.recipeId)));
                    }),
                body: Container(
                    child: ViewRecipeTile(
                        ingredient: _ingredientsList,
                        instruction: _instructionsList,
                        nutrition: nutrition))
                );
          },
        );
      },
    );
  });
}}