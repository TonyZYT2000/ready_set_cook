import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ready_set_cook/shared/constants.dart';
import 'package:uuid/uuid.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:ready_set_cook/services/recipes_database.dart';
import 'package:ready_set_cook/models/recipe.dart';
import 'package:ready_set_cook/screens/recipes/createRecipe.dart';
import 'package:ready_set_cook/models/ingredient.dart';

class AddIngredientPage extends StatefulWidget {
  final String instruction;
  AddIngredientPage({this.instruction});

  @override
  _AddIngredientPage createState() => _AddIngredientPage();
}

class _AddIngredientPage extends State<AddIngredientPage> {

  String _ingredientName = "";
  int _quantity = 0;
  String _unit = "";

  final _controller1 = TextEditingController();
  final _controller2 = TextEditingController();
  final _controller3 = TextEditingController();

  @override
  Widget build(BuildContext context) {
    _controller1.clear();
    _controller2.clear();
    _controller3.clear();
    return new Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text("Add New Ingredient"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: new Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            SizedBox(
              height: 24,
            ),
            TextField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Enter Ingredient Name'),
                controller: _controller1),
            SizedBox(height: 12),
            SizedBox(
              height: 24,
            ),
            TextField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(), labelText: 'Enter Quantity'),
                controller: _controller2),
            SizedBox(
              height: 24,
            ),
            TextField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(), labelText: 'Enter Units'),
                controller: _controller3),
            SizedBox(
              height: 24,
            ),
            RaisedButton(
              color: Colors.blue[400],
              child: Text(
                'Add Ingredient',
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () {
                if (_controller1.text == "") {
                  print("Ingredient Name Not Found");
                } else {
                  final newIngedient = new Ingredient(
                      name: _controller1.text, quantity: int.parse(_controller2.text), unit: _controller3.text);

                  Navigator.of(context).pop(newIngedient);
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
