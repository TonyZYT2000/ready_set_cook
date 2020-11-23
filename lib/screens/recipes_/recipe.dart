import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:ready_set_cook/screens/recipes_/view_recipe.dart';

class Recipe extends StatefulWidget {
  final Function toggleView;
  Recipe({this.toggleView});
  @override
  _RecipeState createState() => _RecipeState();
}

class _RecipeState extends State<Recipe> {
  List<String> recipes = [
    "chicken breast",
    "pizza",
    "Buffalo chicken",
    "salad",
    "chicken breast",
    "pizza",
    "Buffalo chicken",
    "salad"
  ];
  List<List<String>> ingredient = [
    ["ingredient for CB"],
    ["ingredient for pizza"],
    ["ingredient for BC"],
    ["ingredient for salad"],
    ["ingredient for CB"],
    ["ingredient for pizza"],
    ["ingredient for BC"],
    ["ingredient for salad"]
  ];
  List<List<String>> quantity = [
    ["quantity for CB"],
    ["quantity for pizza"],
    ["quantity for BC"],
    ["quantity for salad"],
    ["quantity for CB"],
    ["quantity for pizza"],
    ["quantity for BC"],
    ["quantity for salad"]
  ];
  // Recipes(this.recipes);
  List a = [
    "assets/images/chicken breast.jpg",
    "assets/images/pizza.jpg",
    "assets/images/Buffalo chicken.jpg",
    "assets/images/salad.jpg",
    "assets/images/chicken breast.jpg",
    "assets/images/pizza.jpg",
    "assets/images/Buffalo chicken.jpg",
    "assets/images/salad.jpg",
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: ListView.builder(
            itemCount: a.length,
            itemBuilder: (context, i) {
              return GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                ViewRecipe(a[i], ingredient[i], quantity[i])));
                  },
                  child: Container(
                    padding: EdgeInsets.all(50.0),
                    height: 150,
                    width: 350,
                    decoration: BoxDecoration(
                        // backgroundBlendMode: BlendMode.softLight,
                        border: Border.all(color: Colors.blue[100], width: 10),
                        borderRadius: BorderRadius.circular(20),
                        image: DecorationImage(
                            colorFilter: ColorFilter.mode(
                                Colors.blue.withOpacity(1.0),
                                BlendMode.softLight),
                            fit: BoxFit.cover,
                            image: AssetImage(a[i]))),
                    // Text(
                    //   recipes[i],
                    //   style: TextStyle(
                    //       color: Colors.purple,
                    //       fontSize: 25,
                    //       backgroundColor: Colors.grey),
                    //   textAlign: TextAlign.center,
                    // )
                  ));

              // leading: Image.asset(a[i]),
              // leading: IconButton(
              //     icon: Image.asset(a[i]),
              //     iconSize: 200,
              //     onPressed: () {
              //       Navigator.push(
              //           context,
              //           MaterialPageRoute(
              //               builder: (context) => Search()));
              //     }),
              // title: Text(recipes[i], textScaleFactor: 1.5),
              // onLongPress: () {
              //   Navigator.push(context,
              //       MaterialPageRoute(builder: (context) => Search()));
              // }
              // child: IconButton(
              //   icon: Image.asset(a[i]),
              //   iconSize: 500,
              //   onPressed: () {
              //     Navigator.push(
              //         context, MaterialPageRoute(builder: (context) => Search()));
              //   },
              // )
            }),
      ),
    );
    // children: [
    //   Column(
    //     children: recipes
    //         .map(
    //           (element) => Card(
    //             child: Column(
    //               children: <Widget>[Image.asset(a[i]), Text(element)],
    //             ),
    //           ),
    //         )
    //         .toList(),
    //   ),
    // ],
  }
}
