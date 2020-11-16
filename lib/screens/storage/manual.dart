import 'package:flutter/material.dart';
<<<<<<< HEAD
import 'package:ready_set_cook/shared/constants.dart';
import 'package:ready_set_cook/models/ingredient.dart';
import 'package:intl/intl_browser.dart';
=======
import 'package:flutter/services.dart';
import 'package:ready_set_cook/shared/constants.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

>>>>>>> b58109f53027ec99ece39b9eb064d14d227f76f2

class Manual extends StatefulWidget {
  @override
  _ManualState createState() => _ManualState();
}

class _ManualState extends State<Manual> {
<<<<<<< HEAD
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
                        'Sign In',
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () async {
                        _addDate = new DateTime.now();
                        //传到database
                      }),
                ],
              ),
            )),
=======

  // Cloud Database Reference
  final cloudReference = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {

    // text field state
    String _productName = '';
    int _quantity;
    int _expirationTime;

    return Scaffold(
      body: Container(
        child: ListView(
          children: <Widget>[
            SizedBox(height: 20.0),
            TextFormField(
              decoration:
              textInputDecoration.copyWith(hintText: 'Item Name'),
              onChanged: (val) {
                setState(() => _productName = val);
              },
            ),
            SizedBox(height: 20.0),
            TextFormField(
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              keyboardType: TextInputType.number,
              decoration:
              textInputDecoration.copyWith(hintText: 'Quantity'),
              validator: (val) => val.isEmpty ? 'Enter Quantity' : null,
              onChanged: (val) {
                setState(() => _quantity = int.parse(val));
              },
            ),
            SizedBox(height: 20.0),
            TextFormField(
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              keyboardType: TextInputType.number,
              decoration: textInputDecoration.copyWith(hintText: 'Expiration Time'),
              onChanged: (val) {
                setState(() => _expirationTime = int.parse(val));
              },
            ),

            SizedBox(height: 20.0),
            RaisedButton(
                color: Colors.blue[400],
                child: Text(
                  'Submit',
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () async {
                    cloudReference.collection("items").add(
                        {
                          "productName" : _productName,
                          "quantity" : _quantity,
                          "expirationTime" : _expirationTime,
                        }).then((value){
                      print(value.id);
                    });
                }),
          ],
        ),
>>>>>>> b58109f53027ec99ece39b9eb064d14d227f76f2
      ),
    );
  }
}
