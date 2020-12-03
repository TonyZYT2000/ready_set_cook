import 'package:flutter/material.dart';
import 'package:ready_set_cook/screens/recipes/view_recipe.dart';

class RecipeTile extends StatelessWidget {
  final String name;
  final bool cookedBefore;
  final int rating;
  final String recipeId;
  List<String> lst = ['Name: ', 'Cooked before: ', 'Rating:  '];
  RecipeTile({this.name, this.cookedBefore, this.rating, this.recipeId});

  @override
  Widget build(BuildContext context) {
    String cooked = "";
    if (cookedBefore == false) {
      cooked = "No";
    } else {
      cooked = "Yes";
    }
    return GestureDetector(
        onTap: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => ViewRecipe(recipeId)));
        },
        child: Container(
            padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
            child: SingleChildScrollView(
                child: Column(children: <Widget>[
              Image(
                image: AssetImage("assets/images/apple.png"),
                height: 140,
                alignment: Alignment.centerLeft,
              ),
              SizedBox(height: 10),
              Center(
                  child: Text(
                      lst[0] +
                          name +
                          '   ' +
                          lst[1] +
                          cooked +
                          '   ' +
                          lst[2] +
                          rating.toString(),
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          fontStyle: FontStyle.italic,
                          fontSize: 18,
                          color: Colors.blueGrey)))
            ]))));
    // padding: EdgeInsets.all(10.0),
    // width: 120,
    // height: 120,
    // decoration: BoxDecoration(
    //   border: Border.all(color: Colors.blue[100], width: 10),
    //   borderRadius: BorderRadius.circular(20),
    //   image:
    //       DecorationImage(image: AssetImage("assets/images/apple.png")),
    // ),
    // child: Center(
    //     child: Text(
    //         lst[0] +
    //             name +
    //             '   ' +
    //             lst[1] +
    //             cooked +
    //             '   ' +
    //             lst[2] +
    //             rating.toString(),
    //         textAlign: TextAlign.left,
    //         style: TextStyle(fontSize: 18))),
    // image: DecorationImage(
    //     colorFilter: ColorFilter.mode(
    //         Colors.blue.withOpacity(1.0), BlendMode.softLight),
    //     fit: BoxFit.cover,
    //     image: AssetImage("assets/images/apple.png"))),
  }
}
