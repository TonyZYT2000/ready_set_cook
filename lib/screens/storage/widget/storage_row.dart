import 'package:flutter/material.dart';
import 'package:ready_set_cook/models/ingredient.dart';

class StorageRow extends StatelessWidget {
  final Ingredient _ingredient;

  StorageRow(this._ingredient);

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
          Text(_ingredient.name),
          Text(_ingredient.quantity.toString()),
          Text(_ingredient.unit),
          Text(_ingredient.id)
        ]));
  }
}
