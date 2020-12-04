import 'package:flutter/material.dart';
import 'package:ready_set_cook/services/recipes_database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ready_set_cook/screens/recipes/recipeTile.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'createRecipe.dart';

class Recipe extends StatefulWidget {
  final Function toggleView;
  Recipe({this.toggleView});
  @override
  _RecipeState createState() => _RecipeState();
}

class _RecipeState extends State<Recipe> {
  @override
  Widget build(BuildContext context) {
    final uid = FirebaseAuth.instance.currentUser.uid;
    final RecipesObject = RecipesDatabaseService(uid: uid);
    String name = "";
    double rating = 0;

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
                            // ignore: non_constant_identifier_names
                            builder: (ctx, Rsnapshot) {
                              if (Rsnapshot.data != null) {
                                name = Rsnapshot.data.get('name');
                                var temp = Rsnapshot.data.get('rating');
                                rating = temp.toDouble();
                              }
                              return RecipeTile(
                                  name: name,
                                  rating: rating,
                                  recipeId: recipeId);
                            });
                      })));
        });
  }
}
