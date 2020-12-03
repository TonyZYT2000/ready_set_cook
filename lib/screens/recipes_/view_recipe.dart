import 'package:flutter/material.dart';

import '../recipes/edit_recipe.dart';

class ViewRecipe extends StatefulWidget {
  final Function toggleView;
  final String name;
  final bool cookedBefore;
  final int quantity;
  ViewRecipe(this.name, this.cookedBefore, this.quantity, {this.toggleView});
  @override
  _ViewRecipeState createState() => _ViewRecipeState();
}

class _ViewRecipeState extends State<ViewRecipe> {
  String name = "";
  bool cookedBefore = false;

  @override
  void initState() {
    super.initState();
    this.image = widget.recipe;
    this.quantity = widget.quantity;
    this.ingredient = widget.ingredient;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton.extended(
            icon: Icon(Icons.edit),
            label: Text("Edit"),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => EditRecipe()));
            }),
        appBar: AppBar(
          title: Text('Edit Recipe'),
        ),
        body: ListView(children: <Widget>[
          SizedBox(height: 20),
          Container(
              child: Column(children: <Widget>[
            Container(
              height: 180,
              width: 240,
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.blue[200], width: 10),
                  borderRadius: BorderRadius.circular(20),
                  image: DecorationImage(
                      image: AssetImage(image), fit: BoxFit.cover)),
            ),
            Container(
                padding: EdgeInsets.all(35.0),
                child: Wrap(children: <Widget>[
                  for (int i = 0; i < ingredient.length; i++)
                    Table(
                        border: TableBorder.symmetric(
                            inside:
                                BorderSide(width: 3, color: Colors.blue[200]),
                            outside:
                                BorderSide(width: 3, color: Colors.blue[200])),
                        defaultColumnWidth: FixedColumnWidth(150),
                        children: [
                          TableRow(children: [
                            TableCell(
                                child: Center(
                                    child: Text(ingredient[i],
                                        style: TextStyle(
                                            color: Colors.blueGrey,
                                            fontSize: 18,
                                            height: 1.8)))),
                            TableCell(
                                child: Center(
                                    child: Text(quantity[i],
                                        style: TextStyle(
                                            color: Colors.blueGrey,
                                            fontSize: 18,
                                            height: 1.8))))
                          ])
                        ])
                ]))
          ]))
        ])
        // body: Padding(
        // padding: EdgeInsets.all(50.0),
        // child: Container(
        //     decoration: BoxDecoration(
        //         border: Border.all(color: Colors.blue[100], width: 10),
        //         borderRadius: BorderRadius.circular(10),
        //         image: DecorationImage(
        //             colorFilter: ColorFilter.mode(
        //                 Colors.blue.withOpacity(1.0), BlendMode.softLight),
        //             fit: BoxFit.cover,
        //             image: AssetImage(image[0]))),
        //     child: ListView.builder(
        //         itemCount: ingredientsList.length,
        //         itemBuilder: (context, i) {
        //           return Table(
        //             border: TableBorder.all(
        //                 color: Colors.blue,
        //                 width: 3,
        //                 style: BorderStyle.solid),
        //             children: [
        //               TableRow(children: [
        //                 TableCell(
        //                   child: Center(
        //                     child: Text(ingredientsList[i],
        //                         style: TextStyle(
        //                             color: Colors.blueGrey,
        //                             fontSize: 18,
        //                             height: 1.5)),
        //                   ),
        //                 ),
        //                 TableCell(
        //                   child: Center(
        //                       child: Text(quantity[i],
        //                           style: TextStyle(
        //                               color: Colors.blueGrey,
        //                               fontSize: 18,
        //                               height: 1.5))),
        //                 ),
        //               ]),
        //             ],
        //           );
        //         })))
        );
  }
}
