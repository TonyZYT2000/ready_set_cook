import 'package:ready_set_cook/models/user.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';

class GroceryDatabase {
  User _user;
  DocumentReference _groceryList;
  final _groceryReference = FirebaseFirestore.instance.collection("grocery");

  GroceryDatabase(context) {
    _user = Provider.of<User>(context);
    if (_groceryReference.doc(_user.uid) == null) {
      _groceryReference.doc(_user.uid).set({"count": 0});
    }
    _groceryList = _groceryReference.doc(_user.uid);
    print(_user.uid);
  }

  void addItem(String name, int quantity, DateTime date, String unit) {
    _groceryList.collection("groceryList").add({
      "ingredientName": name,
      "quantity": quantity,
      "dateAdded": date,
      "unit": unit
    });
  }

  Stream<QuerySnapshot> getGroceryList() {
    return _groceryList.collection("groceryList").snapshots();
  }
  /*Future createItem() async {
    try {
      await cloudReference.collection("books")
    } catch (e) {
      print(e.toString());
      return null;
    }
  }// createItem()
*/

}
