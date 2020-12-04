import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ready_set_cook/shared/constants.dart';
import 'package:uuid/uuid.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:ready_set_cook/services/recipes_database.dart';
import 'package:ready_set_cook/models/recipe.dart';
import 'package:ready_set_cook/models/ingredient.dart';

class AddInstruction extends StatefulWidget {
  final Function toggleView;
  AddInstruction({this.toggleView});
  @override
  _AddInstructionState createState() => _AddInstructionState();
}

class _AddInstructionState extends State<AddInstruction> {
  final _formKey = GlobalKey<FormState>();

  String instruction = "";
  List<String> _instructions = [];

  @override
  Widget build(BuildContext context) {
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
                        hintText: 'Enter Instruction'),
                    onChanged: (val) {
                      setState(() => instruction = val);
                    },
                  ),
                  SizedBox(height: 20.0),
                  RaisedButton(
                      color: Colors.blue[400],
                      child: Text(
                        'Add Instruction',
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () async {
                        _instructions.add(
                            instruction); // adds to all recipes and personal collection
                      }),
                ],
              ),
            )),
      ),
    );
  }
}
