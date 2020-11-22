import 'package:ready_set_cook/models/user.dart';
import 'package:ready_set_cook/models/ingredient.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';

class GroceryDatabase {
  User _user;
  DocumentReference _groceryDoc;
  final _groceryReference = FirebaseFirestore.instance.collection("grocery");



  GroceryDatabase(context) {
    _user = Provider.of<User>(context);
    if (_groceryReference.doc(_user.uid) == null) {
      _groceryReference.doc(_user.uid).set({"count": 0});
    }
    _groceryDoc = _groceryReference.doc(_user.uid);
    print(_user.uid);
  }

  void addItem(Ingredient ingredient) {
    _groceryDoc.collection("groceryList").add({
      "name": ingredient.name,
      "quantity": ingredient.quantity,
      "unit": ingredient.unit,
      "startDate": ingredient.startDate,
      "nutrition": null,
      "shelfLife": ingredient.shelfLife,
      "spoilage": ingredient.spoilage
    });
  }

  void deleteItem(String id) {
    _groceryDoc.collection("groceryList").doc(id).delete();
  }

  Stream<QuerySnapshot> getGrocerySnap() {
    return _groceryDoc.collection("groceryList").snapshots();
  }
}
