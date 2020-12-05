import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ready_set_cook/shared/constants.dart';
import 'package:uuid/uuid.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:ready_set_cook/services/recipes_database.dart';
import 'package:ready_set_cook/models/recipe.dart';
import 'package:ready_set_cook/screens/recipes/createRecipe.dart';
import 'package:ready_set_cook/models/ingredient.dart';

class AddInstructionsPage extends StatefulWidget {
  @override
  _AddInstructionsPage createState() => _AddInstructionsPage();
}

class _AddInstructionsPage extends State<AddInstructionsPage> {
  String instruction = "";
  final _controller1 = TextEditingController();

  @override
  Widget build(BuildContext context) {
    _controller1.clear();
    return new Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text("Add New Instruction"),
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
                    labelText: 'Enter Instruction'),
                controller: _controller1),
            SizedBox(
              height: 24,
            ),
            RaisedButton(
              color: Colors.blue[400],
              child: Text(
                'Add Instruction',
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () {
                if (_controller1.text == "") {
                  print("Didn't Enter Anything");
                } else {
                  Navigator.pop(context, instruction);
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
