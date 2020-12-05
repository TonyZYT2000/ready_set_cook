import 'package:flutter/material.dart';
import 'package:ready_set_cook/screens/recipes/viewRecipe.dart';

class RecipeTile extends StatelessWidget {
  final String name;
  final double rating;
  final String recipeId;
  List<String> lst = ['Name: ', 'Rating:  '];
  RecipeTile({this.name, this.rating, this.recipeId});

  @override
  Widget build(BuildContext context) {
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
                  child: Text(name + '\n' + lst[1] + rating.toString(),
                      textAlign: TextAlign.center,
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
