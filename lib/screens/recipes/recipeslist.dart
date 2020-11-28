import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ready_set_cook/services/recipes_database.dart';
import 'package:ready_set_cook/models/recipe.dart';
import 'package:ready_set_cook/screens/recipes/recipeTile.dart';

/*class RecipesList extends StatefulWidget {
  @override
  _RecipesListState createState() => _RecipesListState();
}

class _RecipesListState extends State<RecipesList> {
  // RecipesDatabaseService _recipesDB = null;

  @override
  Widget build(BuildContext context) {
    final recipes = Provider.of<List<Recipe>>(context);
    
    if(recipes == null) {
      return Container(
        child: Text('Shit was null')
      );
    }

    // checks if the user has no recipes
    if(recipes == null || recipes.length == 0 ) {
      return Container(
        child: Text('Add some recipes to get started!')
      );
    }

    return ListView.builder(
        itemCount: recipes.length,
        itemBuilder: (context, index) {
          return RecipeTile(recipe: recipes[index]);
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
}*/
