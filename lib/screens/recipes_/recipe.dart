import 'package:flutter/material.dart';
import 'package:ready_set_cook/screens/recipes/create_recipe.dart';
import 'package:ready_set_cook/screens/recipes/view_recipe.dart';
import 'package:ready_set_cook/shared/constants.dart';

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
    ["ingredient for CB", "chicken", "buffalo"],
    ["ingredient for pizza"],
    ["ingredient for BC"],
    ["ingredient for salad"],
    ["ingredient for CB"],
    ["ingredient for pizza"],
    ["ingredient for BC"],
    ["ingredient for salad"]
  ];
  List<List<String>> quantity = [
    ["quantity for CB", "0", "1"],
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
        floatingActionButton: FloatingActionButton.extended(
            icon: Icon(Icons.add),
            label: Text("Create"),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => CreateRecipe()));
            }),
        resizeToAvoidBottomPadding: false,
        body: Container(
            alignment: Alignment.center,
            padding: EdgeInsets.all(25),
            child: ListView.builder(
                itemCount: a.length * 2,
                itemBuilder: (context, i) {
                  if (i % 2 == 1) {
                    return Text(recipes[(i - 1) ~/ 2],
                        style: TextStyle(
                            fontSize: 20,
                            color: Colors.black54,
                            backgroundColor: Colors.cyan,
                            letterSpacing: 1.5,
                            height: 2),
                        textAlign: TextAlign.center);
                  } else {
                    return GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ViewRecipe(a[i ~/ 2],
                                      ingredient[i ~/ 2], quantity[i ~/ 2])));
                        },
                        child: Container(
                          padding: EdgeInsets.all(90.0),
                          height: 160,
                          width: 320,
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color: Colors.blue[100], width: 10),
                              borderRadius: BorderRadius.circular(20),
                              image: DecorationImage(
                                  colorFilter: ColorFilter.mode(
                                      Colors.blue.withOpacity(1.0),
                                      BlendMode.softLight),
                                  fit: BoxFit.cover,
                                  image: AssetImage(a[i ~/ 2]))),
                        ));
                  }
                })));
  }
}
