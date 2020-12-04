import 'package:flutter/material.dart';
import 'package:ready_set_cook/models/ingredient.dart';
import 'package:ready_set_cook/screens/recipes/addIngredient.dart';
import 'package:ready_set_cook/screens/recipes/addInstruction.dart';
import 'package:ready_set_cook/models/recipe.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:ready_set_cook/services/recipes_database.dart';
import 'package:ready_set_cook/models/recipe.dart';
import 'package:uuid/uuid.dart';

class CreateRecipe extends StatefulWidget {
  final Function toggleView;
  CreateRecipe({this.toggleView});
  @override
  _CreateRecipeState createState() => _CreateRecipeState();
}

class _CreateRecipeState extends State<CreateRecipe> {
  String _recipeName = "";
  String _recipeId = Uuid().toString();
  double _rating = 0;
  int _numRatings = 0;
  List<Ingredient> _ingredients = [];
  List<String> _instructions = [];
  @override
  Widget build(BuildContext context) {
    final _uid = FirebaseAuth.instance.currentUser.uid;
    final recipeDB = RecipesDatabaseService(uid: _uid);
    final _tabPages = <Widget>[
      Center(child: AddIngredient()),
      Center(child: AddInstruction()),
    ];
    final _tabs = <Tab>[
      const Tab(icon: Icon(Icons.add), text: 'Add Ingredient'),
      const Tab(icon: Icon(Icons.add), text: 'Add Instruction')
    ];
    return DefaultTabController(
      length: _tabs.length,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Create Recipe'),
          backgroundColor: Colors.cyan,
          actions: <Widget>[
            FlatButton.icon(
              color: Colors.blue[400],
              icon: Icon(Icons.done),
              label: Text('Add Recipe'),
              onPressed: () {
                RaisedButton(
                    color: Colors.blue[400],
                    child: Text(
                      'Add Ingredient',
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () async {
                      recipeDB.addCustomRecipe(new Recipe(
                          recipeId: _recipeId,
                          name: _recipeName,
                          ingredients: _ingredients,
                          instructions: _instructions,
                          rating: _rating,
                          numRatings:
                              _numRatings)); // adds to all recipes and personal collection
                    });
              },
            ),
          ],
          // If `TabController controller` is not provided, then a
          // DefaultTabController ancestor must be provided instead.
          // Another way is to use a self-defined controller, c.f. "Bottom tab
          // bar" example.
          bottom: TabBar(
            tabs: _tabs,
          ),
        ),
        body: TabBarView(
          children: _tabPages,
        ),
      ),
    );
  }
}
