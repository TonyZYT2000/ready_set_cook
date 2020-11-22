import 'package:flutter/material.dart';
import 'package:ready_set_cook/services/recipes_database.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ready_set_cook/screens/Recipe/recipeslist.dart';

class Recipe extends StatefulWidget {
  final Function toggleView;
  Recipe({this.toggleView});
  @override
  _RecipeState createState() => _RecipeState();
}

class _RecipeState extends State<Recipe> {
  @override
  Widget build(BuildContext context) {
    /*return StreamProvider<QuerySnapshot>.value(
      value: RecipesDatabaseService().recipes,
      body: RecipesList(),
    );*/
    return new Scaffold(
      body: new Center(
        child: new ListView(
          children: [
            Image.asset(
              'assets/images/Buffalo chicken.png',
              width: 600.0,
              height: 240.0,
              fit: BoxFit.cover,
            ),
            Image.asset(
              'assets/images/pizza.png',
              width: 600.0,
              height: 240.0,
              fit: BoxFit.cover,
            ),
            Image.asset(
              'assets/images/salad.jpg',
              width: 600.0,
              height: 240.0,
              fit: BoxFit.cover,
            ),
            Image.asset(
              'assets/images/chicken breast.jpg',
              width: 600.0,
              height: 240.0,
              fit: BoxFit.cover,
            )
          ],
        ),
      ),
    );
  }
}
