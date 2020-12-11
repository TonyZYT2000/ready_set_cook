import 'package:flutter/material.dart';
import 'package:ready_set_cook/models/ingredient.dart';
import 'package:ready_set_cook/models/nutrition.dart';
import 'package:ready_set_cook/screens/recipes/BorderIcon.dart';
import 'package:ready_set_cook/shared/constants.dart';

class ViewRecommendedRecipe extends StatelessWidget {
  final String recipeId;
  final String description;
  final String imageUrl;
  ViewRecommendedRecipe({this.recipeId, this.description, this.imageUrl});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final ThemeData themeData = Theme.of(context);
    final double padding = 25;
    final sidePadding = EdgeInsets.symmetric(horizontal: padding);
    return ListView(physics: BouncingScrollPhysics(), children: <Widget>[
      Container(
          child: Column(children: <Widget>[
        Stack(
          children: [
            (imageUrl == null)
                ? Image(
                    image: NetworkImage(
                        "https://upload.wikimedia.org/wikipedia/commons/thumb/a/ac/No_image_available.svg/480px-No_image_available.svg.png"))
                : Image(image: NetworkImage(imageUrl)),
            Positioned(
                width: size.width,
                top: padding,
                child: Padding(
                    padding: sidePadding,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        BorderIcon(
                            height: 50,
                            width: 50,
                            child: Icon(
                              Icons.favorite_border,
                              color: COLOR_BLACK,
                            ))
                      ],
                    ))),
          ],
        ),
        SizedBox(height: 15),
        Container(
          padding: EdgeInsets.all(12.0),
          child: Text(this.description),
        )
      ]))
    ]);
  }
}
