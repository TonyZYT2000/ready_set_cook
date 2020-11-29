import 'package:flutter/material.dart';
import 'package:ready_set_cook/screens/recipes/view_recipe.dart';

class RecipeTile extends StatelessWidget {
  final String name;
  final bool cookedBefore;
  final int rating;
  final int recipeId;
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
            child: InputDecorator(
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.blue[100], width: 100),
              borderRadius: BorderRadius.circular(20.0),
            ),
          ),
          child: Text(
              lst[0] +
                  name +
                  '   ' +
                  lst[1] +
                  cooked +
                  '   ' +
                  lst[2] +
                  rating.toString(),
              textAlign: TextAlign.center),
        ))
        // Container(
        //   padding: EdgeInsets.all(90.0),
        //   height: 160,
        //   width: 320,
        //   decoration: BoxDecoration(
        //       border: Border.all(color: Colors.blue[100], width: 10),
        //       borderRadius: BorderRadius.circular(20),
        //       image: DecorationImage(
        //           colorFilter: ColorFilter.mode(
        //               Colors.blue.withOpacity(1.0), BlendMode.softLight),
        //           fit: BoxFit.cover,
        //           image: AssetImage("assets/images/apple.png"))),
        // )
        );
  }
}
