import 'package:flutter/material.dart';
import 'package:ready_set_cook/screens/recipes/viewRecipe.dart';
import 'package:ready_set_cook/screens/recipes/BorderIcon.dart';
import 'package:ready_set_cook/shared/constants.dart';
import 'dart:math';

// ignore: must_be_immutable
class RecommendTile extends StatelessWidget {
  final String name;
  final String recipeId;
  final String imageType;
  double spoonRating;
  RecommendTile({this.name, this.recipeId, this.imageType, this.spoonRating});

  @override
  Widget build(BuildContext context) {
    // Generate Random Rating

    this.spoonRating = 5.0 * (this.spoonRating * 0.01);
    double rating = double.parse((this.spoonRating).toStringAsFixed(1));

    // How the tiles look
    final Size size = MediaQuery.of(context).size;
    final double padding = 25;
    final sidePadding = EdgeInsets.symmetric(horizontal: padding);
    final ThemeData themeData = Theme.of(context);
    return GestureDetector(
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Center(
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(25.0),
                        child: Image.network("https://spoonacular"
                                ".com/recipeImages/" +
                            recipeId +
                            "-312x231"
                                "." +
                            imageType))),
                Positioned(
                    top: 20,
                    right: 30,
                    child: BorderIcon(
                        child: Icon(
                      Icons.favorite_border,
                      color: COLOR_BLACK,
                    )))
              ],
            ),
            SizedBox(height: 5),
            Row(
              children: [
                Expanded(
                  child: Text(
                    "$name",
                    style: themeData.textTheme.headline5,
                  ),
                ),
              ],
            ),
            SizedBox(height: 7),
            Row(children: [
              Text(
                "$rating / 5.0",
                style: themeData.textTheme.subtitle1,
              ),
              _buildRatingStar(rating)
            ]),
          ],
        ),
      ),
    );
  }
}

Widget _buildRatingStar(rating) {
  List<Widget> icons = [];
  double i = 0;
  while (rating - i >= 0.75) {
    icons.add(new Icon(Icons.star, color: Colors.blue));
    i = i + 1;
  }

  if (rating - i >= 0.25) {
    icons.add(new Icon(Icons.star_half, color: Colors.blue));
  }

  while (icons.length < 5) {
    icons.add(new Icon(Icons.star_border, color: Colors.grey));
  }

  return new Padding(
    padding: EdgeInsets.fromLTRB(10, 0, 0, 3),
    child: new Row(children: icons),
  );
}
