import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ready_set_cook/screens/recipes/view_recipeIngTile.dart';
import 'package:ready_set_cook/screens/recipes/view_recipeInsTile.dart';
import 'edit_recipe.dart';

class ViewRecipe extends StatefulWidget {
  final Function toggleView;
  String recipeId = "";
  ViewRecipe(this.recipeId, {this.toggleView});
  @override
  _ViewRecipeState createState() => _ViewRecipeState();
}

class _ViewRecipeState extends State<ViewRecipe> {
  String recipeId = "";
  String name = "";
  String quantity = "";
  String unit = "";
  String instruction = "";
  @override
  void initState() {
    super.initState();
    this.recipeId = widget.recipeId;
  }

  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('allRecipes')
          .doc(recipeId)
          .collection("ingredients")
          .snapshots(),
      builder: (ctx, ingredientSnapshot) {
        return StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('allRecipes')
              .doc(recipeId)
              .collection("instructions")
              .snapshots(),
          builder: (ctx, instructionSnapshot) {
            if (ingredientSnapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }
            final ingredientDoc = ingredientSnapshot.data.documents;

            if (instructionSnapshot.connectionState ==
                ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }
            final instructionDoc = instructionSnapshot.data.documents;

            return Scaffold(
                appBar: AppBar(title: Text("View Recipe")),
                floatingActionButton: FloatingActionButton.extended(
                    icon: Icon(Icons.edit),
                    label: Text("Edit"),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => EditRecipe()));
                    }),
                body: Container(
                  // height: 100000,
                  padding: EdgeInsets.symmetric(vertical: 0),
                  // foregroundDecoration: BoxDecoration(
                  //     image: DecorationImage(
                  //         scale: 0.9,
                  //         colorFilter: ColorFilter.mode(
                  //             Colors.blue.withOpacity(1.0),
                  //             BlendMode.softLight),
                  //         alignment: Alignment.topCenter,
                  //         image:
                  //             AssetImage("assets/images/chicken breast.jpg"))),
                  // child: SingleChildScrollView(
                  child: Column(children: <Widget>[
                    SizedBox(
                      height: 300,
                      child: ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        itemCount: ingredientDoc.length,
                        itemBuilder: (ctx, index) {
                          if (ingredientDoc[index].data != null) {
                            name = ingredientDoc[index]['name'];
                            quantity = ingredientDoc[index]['quantity'];
                            unit = ingredientDoc[index]['unit'];
                          }
                          return ViewRecipeIngTile(
                              name: name, quantity: quantity, unit: unit);
                        },
                      ),
                    ),
                    SizedBox(
                        child: ListView.builder(
                            shrinkWrap: true,
                            scrollDirection: Axis.vertical,
                            itemCount: instructionDoc.length,
                            itemBuilder: (ctx, index) {
                              if (instructionDoc[index].data != null) {
                                instruction =
                                    instructionDoc[index]['instruction'];
                              }
                              return ViewRecipeInsTile(instruction);
                            }))
                  ]),
                ));
          },
        );
      },
    );
  }
}
