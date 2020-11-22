import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import 'package:ready_set_cook/services/recipes_database.dart';
import 'package:ready_set_cook/models/recipe.dart';

class RecipesList extends StatefulWidget {
  @override
  _RecipesListState createState() => _RecipesListState();
}

class _RecipesListState extends State<RecipesList> {
  // RecipesDatabaseService _recipesDB = null;

  @override
  Widget build(BuildContext context) {
    final recipes = Provider.of<List<String>>(context);

    return ListView.builder(
        itemCount: recipes.length,
        itemBuilder: (context, index) {
          return Text("recipeId: recipes[recipeId]");
        });
  }

  /*return Scaffold(
      body: StreamBuilder(
        stream: _recipesDB.(),
        builder: (ctx, recipesSnapshot) {
          if(recipesSnapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          final recipesSnap = recipesSnapshot.data.documents;
          return ListView.builder(
            itemCount: 1,
            itemBuilder: (ctx, index) {
              final 
            }
          )
        }
      )
    )
    */
}
