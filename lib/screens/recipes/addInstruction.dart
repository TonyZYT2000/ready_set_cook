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
  final _controller1 = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    _controller1.clear();
    return Scaffold(
      backgroundColor: Colors.blue[50],
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text("Add an Instruction"),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
              child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                SizedBox(height: 15),
                TextFormField(
                      decoration: new InputDecoration(
                        labelText: "Enter Instruction Here",
                        border: new OutlineInputBorder(
                          borderSide: new BorderSide(
                          ),
                        ),
                      ),
                      controller: _controller1,
                      validator: (value){
                        if(value.isEmpty) {
                          return "Please enter an Instruction";
                        }
                        return null;
                      }
                ),
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
                    if(_formKey.currentState.validate()) {
                    Navigator.pop(context, _controller1.text);
                    }
                  },
                ),
              ],
            ),
          ),
    ),
      ));
  }
}
