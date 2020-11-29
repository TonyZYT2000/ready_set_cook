import 'package:flutter/material.dart';
import 'package:ready_set_cook/models/ingredient.dart';
import 'package:ready_set_cook/screens/storage/view.dart';

class StorageRow extends StatefulWidget {
  final Ingredient _ingredient;

  StorageRow(this._ingredient);

  @override
  _StorageRowState createState() => _StorageRowState();
}

class _StorageRowState extends State<StorageRow> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
        leading: Container(
            height: 45,
            width: 45,
            child: (widget._ingredient.imageUrl != null)
                ? Image(
                    image: NetworkImage(widget._ingredient.imageUrl),
                  )
                : null),
        title: Text(widget._ingredient.name),
        subtitle:
            Text(widget._ingredient.quantity.toString() + " " + widget._ingredient.unit),
        trailing: Text(DateTime.now().difference(widget._ingredient.startDate).inDays <
                widget._ingredient.shelfLife
            ? "Good"
            : "Bad"),
        onTap: () {
          setState(() {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => View(widget._ingredient)));
          });
        });
  }
}
