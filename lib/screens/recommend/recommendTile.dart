import 'package:flutter/material.dart';
import 'package:ready_set_cook/screens/recipes/viewRecipe.dart';

// ignore: must_be_immutable
class RecommendTile extends StatelessWidget {
  final String name;
  final String recipeId;
  final String imageType;
  final double rating = 4.0;
  RecommendTile({this.name, this.recipeId, this.imageType});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        child: Container(
      margin: EdgeInsets.fromLTRB(15, 5, 15, 10),
      child: Column(children: [
        Column(children: <Widget>[
          Container(
              child: Text(name,
                  style: TextStyle(
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Colors.blueGrey))),
          Container(
              height: 160,
              decoration: new BoxDecoration(
                  image: DecorationImage(
                    // https://spoonacular.com/recipeImages/{ID}-{SIZE}.{TYPE}
                    image: NetworkImage("https://spoonacular"
                            ".com/recipeImages/" +
                        recipeId +
                        "-480x360"
                            "." +
                        imageType),
                  ),
                  borderRadius: new BorderRadius.circular(8))),
          SizedBox(height: 2),
        ]),
        Center(
          child: Text("Rating: " + rating.toString(),
              textAlign: TextAlign.left,
              style: TextStyle(
                  fontStyle: FontStyle.italic,
                  fontSize: 18,
                  color: Colors.blueGrey)),
        ),
        _buildRatingStar(rating),
      ]),
      constraints: BoxConstraints(
          minWidth: 10, maxWidth: 50, minHeight: 50, maxHeight: 250),
      decoration: BoxDecoration(
          color: Colors.blue[100], borderRadius: BorderRadius.circular(15)),
    ));
  }
}

Widget _buildRatingStar(rating) {
  List<Widget> icons = [];
  double i = 0;
  while (i < rating - 0.5) {
    icons.add(new Icon(Icons.star, color: Colors.blue));

    i = i + 1;
  }
  if (rating - i >= 0.5) {
    icons.add(new Icon(Icons.star_half, color: Colors.blue));
  }

  while (icons.length != 5) {
    icons.add(new Icon(Icons.star_border, color: Colors.grey));
  }

  return new Padding(
    padding: EdgeInsets.fromLTRB(90, 5, 70, 0),
    child: new Row(children: icons),
  );
}
