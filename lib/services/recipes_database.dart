import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ready_set_cook/models/recipe.dart';
import 'dart:developer';

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

  final CollectionReference allRecipesCollection =
      FirebaseFirestore.instance.collection('allRecipes');

  String _recipeName;
  double _recipeRating;
  bool _recipeCookedBefore;

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

  // work in progress
  Future addCustomRecipe(Recipe recipe) async {
    await allRecipesCollection
        .add({"recipeId": recipe.recipeId, "cookedBefore": recipe.cookedBefore, "name": recipe.name,
          "rating": recipe.rating, "userId": recipe.userId});

    
    // await allRecipesCollection.doc(recipe.recipeId).collection("ingredients").

    await recipeCollection
        .doc(uid)
        .collection("recipesList")
        .add({"recipeId": recipe.recipeId});
  }

  Future getRecipesHelper(QueryDocumentSnapshot qds) async {
    DocumentSnapshot recipeSnapshot =
        await allRecipesCollection.doc(qds.get('recipeId')).get();
    _recipeName = recipeSnapshot.get('name');
    _recipeRating = recipeSnapshot.get('rating');
    _recipeCookedBefore = recipeSnapshot.get('cookedBefore');

    debugger(when: true);
    print('hello debug time');
    print(qds.get('recipeId'));
    print('The recipe name is {$_recipeName}');
    print('The rating is ${_recipeRating}');
    print('The cookedBefore is ${_recipeCookedBefore}');
  }

  // list of recipes from snapshot
  List<Recipe> _recipesList(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      getRecipesHelper(doc);
      log('called helper');
      return Recipe(
          recipeId: doc.get('recipeId'),
          userId: uid,
          name: _recipeName,
          ingredients: null,
          instructions: null,
          rating: _recipeRating,
          cookedBefore: _recipeCookedBefore);
    }).toList();
  }

  /*QuerySnapshot list;
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
    }).toList();*/

  // get recipes stream
  Stream<List<Recipe>> get recipes {
    return recipeCollection
        .doc(uid)
        .collection("recipesList")
        .snapshots()
        .map(_recipesList);
  }

  // List<Recipe>  get recipes {

  //   StreamBuilder(
  //     stream:
  //   )

  //   return recipeCollection
  //       .doc(uid)
  //       .collection("recipesList")
  //       .snapshots()
  //       .map(_recipesList);
  // }
}
