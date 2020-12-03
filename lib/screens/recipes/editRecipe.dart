import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ready_set_cook/shared/constants.dart';

class EditRecipe extends StatefulWidget {
  final Function toggleView;
  EditRecipe({this.toggleView});
  @override
  _EditRecipeState createState() => _EditRecipeState();
}

class _EditRecipeState extends State<EditRecipe> {
  final _formKey = GlobalKey<FormState>();
  final recipeDB = FirebaseFirestore.instance;

  String _recipeName = "";
  List<String> _ingredient = [];
  int _quantity = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Update Recipe'),
        backgroundColor: Colors.cyan,
      ),
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
                  RaisedButton(
                      color: Colors.blue[400],
                      child: Text(
                        'Save changes',
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () async {
                        recipeDB.collection("recipeList").add({
                          "ingredientName": _recipeName,
                          "quantity": _quantity
                        });
                        //传到database
                      }),
                ],
              ),
            )),
      ),
    );
  }
}
