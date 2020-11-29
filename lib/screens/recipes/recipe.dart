import 'package:flutter/material.dart';
import 'package:ready_set_cook/services/recipes_database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ready_set_cook/screens/recipes/recipeTile.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'create_recipe.dart';

class Recipe extends StatefulWidget {
  final Function toggleView;
  Recipe({this.toggleView});
  @override
  _RecipeState createState() => _RecipeState();
}

class _RecipeState extends State<Recipe> {
  @override
  Widget build(BuildContext context) {
    /*StreamProvider<List<model.Recipe>>.value(
      value: RecipesDatabaseService().recipes,
    );*/

    final uid = FirebaseAuth.instance.currentUser.uid;
    final RecipesObject = RecipesDatabaseService(uid: uid);
    String name = "";
    bool cookedBefore = false;
    int rating = 0;

    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('recipes')
            .doc(uid)
            .collection('recipesList')
            .snapshots(),
        builder: (ctx, recipesSnapshot) {
          if (recipesSnapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          final recipesdoc = recipesSnapshot.data.documents;
          return Scaffold(
              floatingActionButton: FloatingActionButton.extended(
                  icon: Icon(Icons.add),
                  label: Text("Create"),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => CreateRecipe()));
                  }),
              resizeToAvoidBottomPadding: false,
              body: Container(
                  padding: EdgeInsets.all(20),
                  child: ListView.builder(
                      itemCount: recipesdoc.length,
                      itemBuilder: (ctx, index) {
                        final recipeId = recipesdoc[index]['recipeId'];
                        return FutureBuilder<DocumentSnapshot>(
                            future: FirebaseFirestore.instance
                                .collection('allRecipes')
                                .doc(recipeId)
                                .get(),
                            builder: (ctx, Rsnapshot) {
                              if (Rsnapshot.data != null) {
                                name = Rsnapshot.data.get("name");
                                cookedBefore =
                                    Rsnapshot.data.get('cookedBefore');
                                rating = Rsnapshot.data.get('rating');
                              }
                              return RecipeTile(
                                  name: name,
                                  cookedBefore: cookedBefore,
                                  rating: rating,
                                  recipeId: recipeId);
                            });
                      })));
        });
  }
}
