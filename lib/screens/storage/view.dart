import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ready_set_cook/services/grocery.dart';
import 'package:ready_set_cook/models/ingredient.dart';
import 'package:ready_set_cook/screens/storage/edit.dart';

class View extends StatefulWidget {
  final Ingredient _ingredient;
  View(this._ingredient);

  @override
  _ViewState createState() => _ViewState();
}

class _ViewState extends State<View> {
  GroceryDatabase _groceryDB = null;

  Widget build(BuildContext context) {
    if (_groceryDB == null) {
      _groceryDB = GroceryDatabase(context);
    }

    return Scaffold(
        appBar: AppBar(backgroundColor: Colors.cyan),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Edit(widget._ingredient)),
            );
          },
          child: Icon(Icons.edit),
        ),
        body: Container(
          padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
          child: SingleChildScrollView(
              child: Column(children: <Widget>[
            (widget._ingredient.imageUrl == null)
                ? Image(
                    image: NetworkImage(
                        "https://upload.wikimedia.org/wikipedia/commons/thumb/a/ac/No_image_available.svg/480px-No_image_available.svg.png"))
                : Image(image: NetworkImage(widget._ingredient.imageUrl)),
            SizedBox(height: 20),
            Text(
                widget._ingredient.name +
                    "   " +
                    widget._ingredient.quantity.toString() +
                    " " +
                    widget._ingredient.unit,
                style: TextStyle(fontSize: 36)),
            SizedBox(height: 20),
            Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Add Date: " +
                      DateFormat('Md').format(widget._ingredient.startDate),
                  style: TextStyle(fontSize: 20),
                )),
            SizedBox(height: 10),
            Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Spoil in " +
                      (widget._ingredient.shelfLife -
                              DateTime.now().day +
                              widget._ingredient.startDate.day)
                          .toString() +
                      " days",
                  style: TextStyle(fontSize: 20),
                ))
          ])),
        ));
  }
}
