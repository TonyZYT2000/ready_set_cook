import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ready_set_cook/shared/constants.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class Manual extends StatefulWidget {
  @override
  _ManualState createState() => _ManualState();
}

class _ManualState extends State<Manual> {

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
      ),
    );
  }
}
