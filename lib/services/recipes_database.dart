import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ready_set_cook/models/recipe.dart';
import 'package:provider/provider.dart';
import 'package:ready_set_cook/models/user.dart';

class RecipesDatabaseService {
  // uid of user
  String uid;
  /*User _user;
  DocumentReference _recipeList;
  final _recipeReference = FirebaseFirestore.instance.collection('recipes');*/
  RecipesDatabaseService({this.uid});

  // obtains instance of the recipes collection from firestore
  final CollectionReference recipeCollection =
      FirebaseFirestore.instance.collection('recipes');

  // sets entire recipe list
  /*Future updateUserRecipes(List<String> recipeIds) async {
    return await recipeCollection
        .doc(uid)
        .collection("recipesList")
        .doc()
        .set({'recipes': recipes});
  }*/

  /*RecipesDatabaseService(context) {
    // _user = Provider.of<User>(context);
    /*if (_recipeReference.doc(_user.uid) == null) {
      _recipeReference.doc(_user.uid).set({"count": 0});
    }*/
    //_recipeList = _recipeReference.doc(_user.uid);
  }*/

  Future addRecipe(String recipeId) async {
    return await recipeCollection
        .doc(uid)
        .collection("recipesList")
        .add({"recipeId": recipeId});
  }

  // list of recipes from snapshot
  List<String> _recipesList(QuerySnapshot snapshot) {
    QuerySnapshot list;
    List<DocumentSnapshot> snap = snapshot.docs;
    for (var i in snap) {
      // var dss = i.data();

      // var key = dss.keys.firstWhere((k) => dss[k] == uid);

      if (i.id == uid) {
        list = i.get('recipesList');
      }
    }

    return list.docs.map((doc) {
      return doc.data()['recipeId'];
      /* return Recipe(
        doc.data['recipeId'],
        doc.data['userId'],
        doc.data['name'],
        null,
        null,
        doc.data['rating'],
        doc.data['cookedBefore'],
      );*/
    }).toList();
  }

  // get recipes stream
  Stream<List<String>> getRecipeIds() {
    return recipeCollection
        .doc(uid)
        .collection("recipesList")
        .snapshots()
        .map(_recipesList);
  }
}
