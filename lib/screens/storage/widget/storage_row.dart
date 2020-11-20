import 'package:flutter/material.dart';

class StorageRow extends StatelessWidget {
  final ingredientName;
  final quantity;
  final date;

  StorageRow(this.ingredientName, this.quantity, this.date);

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
          Text(ingredientName),
          Text(quantity.toString())
        ]));
  }
}
