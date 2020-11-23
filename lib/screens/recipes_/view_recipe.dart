import 'package:flutter/material.dart';

class ViewRecipe extends StatefulWidget {
  final Function toggleView;
  final String recipe;
  final List<String> ingredient;
  final List<String> quantity;
  ViewRecipe(this.recipe, this.ingredient, this.quantity, {this.toggleView});
  @override
  _ViewRecipeState createState() => _ViewRecipeState();
}

class _ViewRecipeState extends State<ViewRecipe> {
  List<String> ingredientsList = [
    "Ingredient Lists",
    "cooked chicken",
    "Buffalo sauce",
    "shredded lettuce",
    "ranch"
  ];
  List<String> quantityList = [
    "Quantity",
    "2 cup",
    "1/2 cup",
    "1 cup",
    "1/4 cup"
  ];
  String image = "";
  List<String> quantity = [];
  List<String> ingredient = [];

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
        appBar: AppBar(
          title: Text('Ingredients'),
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
