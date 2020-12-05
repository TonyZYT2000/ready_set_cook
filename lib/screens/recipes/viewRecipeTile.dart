import 'package:flutter/material.dart';
import 'package:ready_set_cook/models/ingredient.dart';
import 'package:ready_set_cook/models/nutrition.dart';

class ViewRecipeTile extends StatelessWidget {
  final List<Ingredient> ingredient;
  final List<String> instruction;
  final Nutrition nutrition;
  ViewRecipeTile({this.ingredient, this.instruction, this.nutrition});

  @override
  Widget build(BuildContext context) {
    return ListView(children: <Widget>[
      SizedBox(height: 10),
      Container(
          child: Column(children: <Widget>[
        Container(
            padding: EdgeInsets.all(10.0),
            child: Wrap(children: <Widget>[
              Text(
                "Ingredients",
                style: TextStyle(color: Colors.blue[700], fontSize: 26),
              ),
              SizedBox(height: 50),
              for (int i = 0; i < (ingredient.length); i++)
                Table(
                    border: TableBorder.symmetric(
                        inside: BorderSide.none, outside: BorderSide.none),
                    defaultColumnWidth: FixedColumnWidth(180),
                    children: [
                      TableRow(children: [
                        TableCell(
                            child: Text(ingredient[i].name,
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    color: Colors.blue[700],
                                    fontSize: 19,
                                    height: 1.8))),
                        TableCell(
                            child: Text(
                                (ingredient[i].quantity).toString() +
                                    ' ' +
                                    ingredient[i].unit,
                                textAlign: TextAlign.right,
                                style: TextStyle(
                                    color: Colors.blue[700],
                                    fontSize: 19,
                                    height: 1.8))),
                      ])
                    ]),
              SizedBox(height: 100),
              Text(
                "Instructions",
                style: TextStyle(color: Colors.blue[700], fontSize: 26),
              ),
              SizedBox(height: 50),
              for (int i = 0; i < (instruction.length); i++)
                Table(
                    border: TableBorder.symmetric(
                        inside: BorderSide.none, outside: BorderSide.none),
                    defaultColumnWidth: FixedColumnWidth(350),
                    children: [
                      TableRow(children: [
                        TableCell(
                            child: Text(
                          (i + 1).toString() + ':  ' + instruction[i],
                          style: TextStyle(
                              color: Colors.blue[700],
                              fontSize: 18,
                              height: 1.8),
                          textAlign: TextAlign.left,
                        )),
                      ])
                    ]),
              SizedBox(height: 100),
              Text(
                "Nutritional Facts (per serving)",
                style: TextStyle(color: Colors.blue[700], fontSize: 26),
              ),
              SizedBox(height: 50),
                Table(
                    border: TableBorder.symmetric(
                        inside: BorderSide.none, outside: BorderSide.none),
                    defaultColumnWidth: FixedColumnWidth(180),
                    children: [
                      TableRow(children: [
                        TableCell(
                            child: Text(
                          'Calories: ' +
                              '\nProtein: ' +
                              '\nTotal Carbs: ' +
                              '\nTotal Fat: ',
                          style: TextStyle(
                              color: Colors.blue[700],
                              fontSize: 19,
                              height: 1.8),
                          textAlign: TextAlign.left,
                        )),
                        TableCell(
                            child: Text(
                          nutrition.calories.toString() +
                              '\n' +
                              nutrition.protein +
                              '\n' +
                              nutrition.totalCarbs +
                              '\n' +
                              nutrition.totalFat +
                              '\n',
                          style: TextStyle(
                              color: Colors.blue[700],
                              fontSize: 19,
                              height: 1.8),
                          textAlign: TextAlign.right,
                        )),
                      ])
                    ])
            ]))
      ]))
    ]);
  }
}
