import 'package:flutter/material.dart';
import 'package:ready_set_cook/models/ingredient.dart';

class ViewRecipeTile extends StatelessWidget {
  List<Ingredient> ingredient;
  List<String> instruction;
  ViewRecipeTile({this.ingredient, this.instruction});

  @override
  Widget build(BuildContext context) {
    return ListView(children: <Widget>[
      SizedBox(height: 20),
      Container(
          child: Column(children: <Widget>[
        Container(
            padding: EdgeInsets.all(35.0),
            child: Wrap(children: <Widget>[
              for (int i = 0; i < (ingredient.length); i++)
                Table(
                    border: TableBorder.symmetric(
                        inside: BorderSide(width: 3, color: Colors.blue[200]),
                        outside: BorderSide(width: 3, color: Colors.blue[200])),
                    defaultColumnWidth: FixedColumnWidth(150),
                    children: [
                      TableRow(children: [
                        TableCell(
                            child: Center(
                                child: Text(ingredient[i].nameOfIngredient,
                                    style: TextStyle(
                                        color: Colors.blueGrey,
                                        fontSize: 18,
                                        height: 1.8)))),
                        TableCell(
                            child: Center(
                                child: Text(
                                    (ingredient[i].quantity).toString() +
                                        '   ' +
                                        ingredient[i].unit,
                                    style: TextStyle(
                                        color: Colors.blueGrey,
                                        fontSize: 18,
                                        height: 1.8)))),
                      ])
                    ]),
              SizedBox(height: 75),
              for (int i = 0; i < (instruction.length); i++)
                Table(
                    border: TableBorder.symmetric(
                        inside: BorderSide(width: 3, color: Colors.blue[200]),
                        outside: BorderSide(width: 3, color: Colors.blue[200])),
                    defaultColumnWidth: FixedColumnWidth(300),
                    children: [
                      TableRow(children: [
                        TableCell(
                            child: Center(
                                child: Text(
                          instruction[i],
                          style: TextStyle(
                              color: Colors.blueGrey,
                              fontSize: 18,
                              height: 1.8),
                          textAlign: TextAlign.center,
                        ))),
                      ])
                    ])
            ]))
      ]))
    ]);
  }
}
