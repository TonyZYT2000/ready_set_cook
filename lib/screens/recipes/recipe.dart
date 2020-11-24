import 'package:flutter/material.dart';
import 'package:ready_set_cook/services/recipes_database.dart';
import 'package:provider/provider.dart';
import 'package:ready_set_cook/models/recipe.dart' as model;
import 'package:ready_set_cook/screens/recipes/recipeslist.dart';

class Recipe extends StatefulWidget {
  final Function toggleView;
  Recipe({this.toggleView});
  @override
  _RecipeState createState() => _RecipeState();
}

class _RecipeState extends State<Recipe> {

  @override
  Widget build(BuildContext context) {
    StreamProvider<List<model.Recipe>>.value(
      value: RecipesDatabaseService().recipes,
    );

    return StreamProvider<List<model.Recipe>>.value(
      value: RecipesDatabaseService().recipes,
      child: Scaffold(
        body: RecipesList(),
      ),
    );
  }
}

/*
    return Scaffold(
        body: StreamBuilder(
            stream: _recipesDB.getRecipesList(),
            builder: (ctx, recipesSnapshot) {
              if (recipesSnapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              }

              final recipesSnap = recipesSnapshot.data.documents;
              return ListView.builder(
                  itemCount: recipesSnap.length,
                  itemBuilder: (ctx, index) {
                    final recipeId = recipesSnap[index]["recipeId"];
                    // final recipeRating = recipesSnap[index]["rating"];
                    // final recipeCookedBefore = recipesSnap[index]["cookedBefore"];
                    return Container(
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: <Widget>[
                          Text(recipeId),
                          // Text(recipeRating.toString()),
                          // Text(recipeCookedBefore.toString())
                        ]));
                  });
            }));*/
