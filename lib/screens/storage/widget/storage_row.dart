import 'package:flutter/material.dart';
import 'package:ready_set_cook/models/ingredient.dart';

class StorageRow extends StatelessWidget {
  final Ingredient _ingredient;

  StorageRow(this._ingredient);

  @override
  Widget build(BuildContext context) {
    return ListTile(
        leading: Container(height: 45, width: 45, child: Image(image: NetworkImage(_ingredient.imageUrl),)),
        title: Text(_ingredient.name),
        subtitle:
            Text(_ingredient.quantity.toString() + " " + _ingredient.unit),
        trailing: Text(DateTime.now().difference(_ingredient.startDate).inDays <
                _ingredient.shelfLife
            ? "Good"
            : "Bad"));
    /*
    return Container(
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
          Text(_ingredient.name),
          Text(_ingredient.quantity.toString()),
          Text(_ingredient.unit),
          Text(_ingredient.id)
        ]));
    */
  }
}
