import 'package:flutter/material.dart';
import 'package:ready_set_cook/screens/storage/storage.dart';
import 'package:ready_set_cook/services/recipes_database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ready_set_cook/screens/recipes/recipeTile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:ready_set_cook/shared/constants.dart';
import 'package:ready_set_cook/screens/recipes/BorderIcon.dart';
import 'package:ready_set_cook/screens/recipes/viewRecipe.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ready_set_cook/screens/home/home.dart';
import 'dart:io';
import 'dart:math';

import 'createRecipe.dart';

class Recipe extends StatefulWidget {
  final Function toggleView;
  Recipe({this.toggleView});
  @override
  _RecipeState createState() => _RecipeState();
}

class _RecipeState extends State<Recipe> {
  double roundDouble(double value, int places) {
    double mod = pow(10.0, places);
    return ((value * mod).round().toDouble() / mod);
  }

  void helper() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final uid = FirebaseAuth.instance.currentUser.uid;
    String name = "";
    double rating = 0;
    String _imageUrl;
    final Size size = MediaQuery.of(context).size;
    double padding = 25;
    final sidePadding = EdgeInsets.symmetric(horizontal: padding);
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('recipes')
            .doc(uid)
            .collection('recipesList')
            .snapshots(),
        builder: (ctx, recipesSnapshot) {
          if (recipesSnapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          final recipesdoc = recipesSnapshot.data.documents;
          return Scaffold(
              backgroundColor: Colors.blue[50],
              floatingActionButton: FloatingActionButton.extended(
                  icon: Icon(Icons.add),
                  label: Text("Create"),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => CreateRecipe()));
                  }),
              resizeToAvoidBottomPadding: false,
              body: Container(
                width: size.width,
                height: size.height,
                child: Stack(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 10),
                        Expanded(
                          child: Padding(
                            padding: sidePadding,
                            child: ListView.builder(
                                physics: BouncingScrollPhysics(),
                                itemCount: recipesdoc.length,
                                itemBuilder: (ctx, index) {
                                  final recipeId =
                                      recipesdoc[index]['recipeId'];
                                  final fav = recipesdoc[index]['fav'];
                                  return FutureBuilder<DocumentSnapshot>(
                                      future: FirebaseFirestore.instance
                                          .collection('allRecipes')
                                          .doc(recipeId)
                                          .get(),
                                      // ignore: non_constant_identifier_names
                                      builder: (ctx, Rsnapshot) {
                                        if (Rsnapshot.data != null) {
                                          name = Rsnapshot.data.get('name');
                                          var temp =
                                              Rsnapshot.data.get('rating');
                                          rating =
                                              roundDouble(temp.toDouble(), 1);
                                          _imageUrl =
                                              Rsnapshot.data.get('imageUrl');
                                        }

                                        return RecipeItem(
                                          name: name,
                                          rating: rating,
                                          recipeId: recipeId,
                                          imageUrl: _imageUrl,
                                          fav: fav,
                                          uid: uid,
                                        );
                                      });
                                }),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ));
        });
  }
}

class RecipeItem extends StatelessWidget {
  final String name;
  final double rating;
  final String recipeId;
  final String imageUrl;
  final bool fav;
  final String uid;

  const RecipeItem(
      {Key key,
      this.name,
      this.rating,
      this.recipeId,
      this.imageUrl,
      this.fav,
      this.uid})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var icon = Icons.favorite_border;
    var color = Colors.red;
    var _fav = fav;
    var _name = name;
    var recipeDB = RecipesDatabaseService(uid: uid);

    final ThemeData themeData = Theme.of(context);

    if (_fav) {
      icon = Icons.favorite;
    }
    return GestureDetector(
      onTap: () {
        Navigator.of(context)
            .push(MaterialPageRoute(
                builder: (context) =>
                    ViewRecipe(recipeId, _name, imageUrl, _fav)))
            .then((value) async {
          _name = await recipeDB.getRecipeName(recipeId);
        });
      },
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
                  child: (imageUrl == null)
                      ? Image(
                          image: NetworkImage(
                              "https://upload.wikimedia.org/wikipedia/commons/thumb/a/ac/No_image_available.svg/480px-No_image_available.svg.png"))
                      : Image(image: NetworkImage(imageUrl)),
                )),
                Positioned(
                    top: 15,
                    right: 15,
                    child: GestureDetector(
                        onTap: () async {
                          if (fav) {
                            await recipeDB.unFavRecipe(recipeId);
                            icon = Icons.favorite_border;
                          }

                          if (!fav) {
                            await recipeDB.favRecipe(recipeId);
                            icon = Icons.favorite;
                          }
                        },
                        child: BorderIcon(
                            child: Icon(
                          icon,
                          color: color,
                        ))))
              ],
            ),
            SizedBox(height: 5),
            Row(
              children: [
                Flexible(
                  flex: 2,
                  child: Text(
                    " $_name",
                    textAlign: TextAlign.left,
                    style: themeData.textTheme.headline5,
                  ),
                ),
              ],
            ),
            SizedBox(height: 7),
            Row(children: [
              Text(
                "  $rating / 5.0",
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
