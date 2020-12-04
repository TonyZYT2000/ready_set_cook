import 'package:flutter/material.dart';
import 'package:ready_set_cook/services/grocery.dart';
import 'package:ready_set_cook/models/ingredient.dart';
import 'package:ready_set_cook/shared/common_ingredients.dart';
import 'package:ready_set_cook/screens/storage/widget/ingredient_tile.dart';

class CommonAdd extends StatefulWidget {
  @override
  _CommonAddState createState() => _CommonAddState();
}

class _CommonAddState extends State<CommonAdd> {
  GroceryDatabase _groceryDB = null;

  Widget build(BuildContext context) {
    if (_groceryDB == null) {
      _groceryDB = GroceryDatabase(context);
    }

    CommonIngredient common = CommonIngredient();
    return Scaffold(
        body: GridView.count(crossAxisCount: 3, children: <Widget>[
      for (Ingredient item in common.commonIngredients) IngredientTile(item)
    ]));
  }
}
