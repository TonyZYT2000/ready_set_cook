import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ready_set_cook/shared/constants.dart';
import 'package:uuid/uuid.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:ready_set_cook/services/recipes_database.dart';
import 'package:ready_set_cook/models/recipe.dart';
import 'package:ready_set_cook/models/ingredient.dart';

class AddIngredient extends StatefulWidget {
  final Function toggleView;
  AddIngredient({this.toggleView});
  @override
  _AddIngredientState createState() => _AddIngredientState();
}

class _AddIngredientState extends State<AddIngredient> {
  final _formKey = GlobalKey<FormState>();

  String _recipeName = "";
  String _recipeId = Uuid().toString();
  bool _cookedBefore = false;
  double _rating = 0;
  int _numRatings = 0;
  List<Ingredient> _ingredients = [];
  int _quantity = 0;
  String _unit = "";
  List<String> _instructions = [];

  @override
  Widget build(BuildContext context) {
    final uid = FirebaseAuth.instance.currentUser.uid;
    final recipeDB = RecipesDatabaseService(uid: uid);
    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
        child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  SizedBox(height: 20.0),
                  TextFormField(
                    decoration: textInputDecoration.copyWith(
                        hintText: 'Enter Ingredient Name'),
                    onChanged: (val) {
                      setState(() => _recipeName = val);
                    },
                  ),
                  SizedBox(height: 20.0),
                  TextFormField(
                    decoration: textInputDecoration.copyWith(
                        hintText: 'Enter Quantity'),
                    onChanged: (val) {
                      setState(() => _quantity = int.parse(val));
                    },
                  ),
                  SizedBox(height: 20.0),
                  TextFormField(
                    decoration:
                        textInputDecoration.copyWith(hintText: 'Enter Unit'),
                    onChanged: (val) {
                      setState(() => _unit = val);
                    },
                  ),
                  SizedBox(height: 20.0),
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
                            cookedBefore: _cookedBefore,
                            numRatings:
                                _numRatings)); // adds to all recipes and personal collection
                      }),
                ],
              ),
            )),
      ),
    );
  }
}
