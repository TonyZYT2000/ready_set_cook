import 'package:flutter/material.dart';
import 'package:ready_set_cook/models/ingredient.dart';
import 'package:ready_set_cook/models/nutrition.dart';
import 'package:ready_set_cook/screens/recipes/BorderIcon.dart';
import 'package:ready_set_cook/shared/constants.dart';

class ViewRecipeTile extends StatelessWidget {
  final List<Ingredient> ingredient;
  final List<String> instruction;
  final Nutrition nutrition;
  ViewRecipeTile({this.ingredient, this.instruction, this.nutrition});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final ThemeData themeData = Theme.of(context);
    final double padding = 25;
    final sidePadding = EdgeInsets.symmetric(horizontal: padding);
    return ListView(
      physics: BouncingScrollPhysics(),
      children: <Widget>[
      Container(
          child: Column(children: <Widget>[
        Stack(
                      children: [
                        Image.asset("assets/images/chicken_breast.png"),
                        Positioned(
                          width: size.width,
                          top: padding,
                          child: Padding(padding: sidePadding,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end, 
                            children: [
                              BorderIcon(height: 50, width: 50, 
                              child: Icon(Icons.favorite_border, color: COLOR_BLACK, ))],))
                        ),
                      ],
                    ),
                    SizedBox(height: 15),
        Container(
            padding: EdgeInsets.all(12.0),
            child: Column(children: [
            Wrap(children: <Widget>[
              Text(
                "Ingredients",
                style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold, decoration: TextDecoration.underline),
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
                                    // color: Colors.blue[700],
                                    fontSize: 19,
                                    height: 1.8))),
                        TableCell(
                            child: Text(
                                (ingredient[i].quantity).toString() +
                                    ' ' +
                                    ingredient[i].unit,
                                textAlign: TextAlign.right,
                                style: TextStyle(
                                    // color: Colors.blue[700],
                                    fontSize: 19,
                                    height: 1.8))),
                      ])
                    ]),
              SizedBox(height: 100),
              Text(
                "Instructions",
                style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold, decoration: TextDecoration.underline),
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
                              // color: Colors.blue[700],
                              fontSize: 18,
                              height: 1.8),
                          textAlign: TextAlign.left,
                        )),
                      ])
                    ]),
              SizedBox(height: 100),
              Text(
                "Nutritional Facts (per serving)",
                style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold, decoration: TextDecoration.underline),
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
                              // color: Colors.blue[700],
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
                              // color: Colors.blue[700],
                              fontSize: 19,
                              height: 1.8),
                          textAlign: TextAlign.right,
                        )),
                      ])
                    ]),
                    SizedBox(height: 200),
            ])])
      )]))
    ]);
  }
}
