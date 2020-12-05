import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:ready_set_cook/shared/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:ready_set_cook/shared/constants.dart';
import 'package:ready_set_cook/models/recipe.dart';
import 'package:ready_set_cook/models/ingredient.dart';
import 'package:ready_set_cook/services/recipes_database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class EditRecipe extends StatefulWidget {
  final String recipeId;
  EditRecipe(this.recipeId);

  @override
  _EditState createState() => _EditState();
} // EditRecipe

class _EditState extends State<EditRecipe> {
  String _recipeName = null;
  double _rating = null;
  List<Ingredient> _ingredients = null;
  List<String> _instructions = null;

  final _formKey = GlobalKey<FormState>();

  TextEditingController _controller1 = TextEditingController();
  TextEditingController _controller2 = TextEditingController();
  TextEditingController _controller3 = TextEditingController();
  TextEditingController _controller4 = TextEditingController();

  void _onSubmit() {
    final currentRec =
        RecipesDatabaseService().allRecipesCollection.doc(widget.recipeId);
    currentRec.update({"name": _recipeName});

    _recipeName = null;
    _rating = null;
    _ingredients = null;
    _instructions = null;
    _controller1.clear();
    _controller2.clear();
    _controller3.clear();
    _controller4.clear();
    _formKey.currentState.save();
  }

  Widget build(BuildContext context) {
    String uid = FirebaseAuth.instance.currentUser.uid;
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('recipes')
            .doc(uid)
            .collection('allrecipe')
            .doc(widget.recipeId)
            .snapshots(),
        builder: (ctx, recipesSnapshot) {
          if (recipesSnapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          final recipeName = recipesSnapshot.data['name'];
          final recipeRating = recipesSnapshot.data['rating'];
          return Scaffold(
            appBar: AppBar(
                title: const Text('Edit Items'), backgroundColor: Colors.cyan),
            body: Container(
              child: Form(
                key: _formKey,
                child: SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      SizedBox(height: 20.0),
                      TextFormField(
                        controller: _controller1,
                        key: ValueKey("Recipe Name"),
                        decoration: textInputDecoration.copyWith(
                            hintText: 'Update Name: ' + recipeName),
                        onChanged: (val) {
                          setState(() => _recipeName = val);
                        },
                      ),
                      SizedBox(height: 20.0),
                      RaisedButton(
                          color: Colors.blue[400],
                          child: Text(
                            'Update',
                            style: TextStyle(color: Colors.white),
                          ),
                          onPressed: _onSubmit),
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }
}
