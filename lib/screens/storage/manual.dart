import 'package:flutter/material.dart';
import 'package:ready_set_cook/shared/constants.dart';
import 'package:ready_set_cook/models/ingredient.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Manual extends StatefulWidget {
  @override
  _ManualState createState() => _ManualState();
}

class _ManualState extends State<Manual> {
  final storageDB = FirebaseFirestore.instance;

  final _formKey = GlobalKey<FormState>();
  String _ingredientName = '';
  int _quantity = 0;
  DateTime _addDate;
  Ingredient ingredient;
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
                        hintText: 'Enter Ingredient Name'),
                    onChanged: (val) {
                      setState(() => _ingredientName = val);
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
                        'Add Item',
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () async {
                        _addDate = new DateTime.now();
                        storageDB.collection("storage").add({
                          "ingredientName": _ingredientName,
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
