import 'package:flutter/material.dart';

class StorageRow extends StatelessWidget {
  final ingredientName;
  final quantity;
  final date;
  final unit;

  StorageRow(this.ingredientName, this.quantity, this.date, this.unit);

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
          Text(ingredientName),
          Text(quantity.toString()),
          Text(unit)
        ]));
  }
}
