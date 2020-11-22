import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  
  final String uid;
  DatabaseService({ this.uid });

  final CollectionReference recipeCollection = FirebaseFirestore.instance.collection('recipes');

  Future updateUserRecipes()
}