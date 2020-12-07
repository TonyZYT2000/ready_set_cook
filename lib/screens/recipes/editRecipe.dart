import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ready_set_cook/models/ingredient.dart';
import 'package:ready_set_cook/models/nutrition.dart';
import 'package:ready_set_cook/models/recipe.dart';
import 'package:ready_set_cook/services/recipes_database.dart';
import 'package:firebase_auth/firebase_auth.dart';

class EditRecipe extends StatefulWidget {
  final Function toggleView;
  String recipeId = "";
  String name = "";
  EditRecipe(this.recipeId, this.name, {this.toggleView});

  @override
  _EditState createState() => _EditState();
} // EditRecipe

class _EditState extends State<EditRecipe> {
  String recipeId = "";
  String currentName = "";

  @override
  void initState() {
    super.initState();
    this.recipeId = widget.recipeId;
    this.currentName = widget.name;
  }

  // Editable Variables
  String updatedName = "";
  String quantity = "";
  String unit = "";
  String instruction = "";
  List<Ingredient> _ingredientsList = [];
  List<String> _instructionsList = [];
  Nutrition nutrition;
  final _formKey = GlobalKey<FormState>();
  // Nutrition
  String calories = "";
  String protein = "";
  String totalCarbs = "";
  String totalFat = "";

  // Boolean Check to See if Values were updated
  bool name_updated = false;
  bool nutrition_updated = false;
  bool instruction_updated = false;
  bool ingredient_updated = false;

  // Recipe Database
  RecipesDatabaseService recipeDB;

  Future<void> _updateRecipe() async {
    final currentRec =
        RecipesDatabaseService().allRecipesCollection.doc(widget.recipeId);
    currentRec.update({"name": updatedName});

    updatedName = "";
    _ingredientsList = null;
    _instructionsList = null;
    _formKey.currentState.save();
  }

  Future<void> updateIngredients() async {
    final ingredientColl = RecipesDatabaseService()
        .allRecipesCollection
        .doc(recipeId)
        .collection("ingredients")
        .snapshots();

    ingredientColl.forEach((ingredient) {
      ingredient.docs.asMap().forEach((index, data) {
        ingredient.docs.elementAt(index).data().updateAll((key, value) => _instructionsList);
      });
    });
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
                return StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection('allRecipes')
                      .doc(recipeId)
                      .collection("nutrition")
                      .snapshots(),
                  builder: (ctx, nutritionSnapshot) {
                    if (ingredientSnapshot.connectionState ==
                        ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    }

                    if (instructionSnapshot.connectionState ==
                        ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    }

                    if (nutritionSnapshot.connectionState ==
                        ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    }

                    instructionSnapshot.data.documents.forEach((instruction) {
                      _instructionsList.add(instruction['instruction']);
                    });

                    ingredientSnapshot.data.documents.forEach((ingredient) {
                      _ingredientsList.add(new Ingredient(
                          name: ingredient['name'],
                          quantity: ingredient['quantity'],
                          unit: ingredient['unit']));
                    });

                    nutritionSnapshot.data.documents.forEach((nut) {
                      nutrition = Nutrition(
                          calories: nut['Calories'],
                          protein: nut['Protein'],
                          totalCarbs: nut['Total Carbohydrate'],
                          totalFat: nut['Total Fat']);
                    });

                    return Scaffold(
                        appBar: AppBar(
                            title: TextFormField(
                                style: TextStyle(
                                    color: Colors.white, fontSize: 20),
                                decoration: InputDecoration(
                                  hintText: widget.name,
                                  hintStyle: TextStyle(
                                      fontStyle: FontStyle.italic,
                                      color: Colors.white),
                                  contentPadding: new EdgeInsets.symmetric(
                                      vertical: 50.0, horizontal: 0),
                                ),
                                onChanged: (val) {
                                  setState(() => updatedName = val);
                                })),
                        floatingActionButton: FloatingActionButton.extended(
                            icon: Icon(Icons.edit),
                            label: Text("Update Changes"),
                            onPressed: () {
                              Navigator.of(context).pop();
                            }),
                        body: Form(
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            child: Container(
                                child: Column(children: <Widget>[
                              ListView.builder(
                                  physics: BouncingScrollPhysics(),
                                  padding: const EdgeInsets.all(15),
                                  itemCount: _ingredientsList.length,
                                  itemBuilder: (context, index) {
                                    return Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.baseline,
                                        children: [
                                          TextFormField(
                                            decoration: new InputDecoration(
                                              labelText:
                                                  _ingredientsList[index].name,
                                              border: new OutlineInputBorder(
                                                borderSide: new BorderSide(),
                                              ),
                                            ),
                                            validator: (value) {
                                              if (value.length > 16) {
                                                return "Ingredient name too long";
                                              }
                                              if (value.isEmpty) {
                                                return "Please enter Ingredient Name";
                                              }
                                              return null;
                                            },
                                            onChanged: (text) {
                                              _ingredientsList[index].name =
                                                  text;
                                            },
                                          ),
                                          TextFormField(
                                            decoration: new InputDecoration(
                                              labelText: _ingredientsList[index]
                                                  .quantity
                                                  .toString(),
                                              border: new OutlineInputBorder(
                                                borderSide: new BorderSide(),
                                              ),
                                            ),
                                            validator: (value) {
                                              if (int.parse(value) > 9999) {
                                                return "Ingredient name too long";
                                              }
                                              if (!isNumeric(value)) {
                                                return "Please enter an integer";
                                              }
                                              return null;
                                            },
                                            onChanged: (text) {
                                              _ingredientsList[index].quantity =
                                                  int.parse(text);
                                            },
                                          ),
                                          TextFormField(
                                            decoration: new InputDecoration(
                                              labelText:
                                                  _ingredientsList[index].unit,
                                              border: new OutlineInputBorder(
                                                borderSide: new BorderSide(),
                                              ),
                                            ),
                                            validator: (value) {
                                              if (value.isEmpty) {
                                                return "Please enter a unit";
                                              }
                                              if (value.length > 9) {
                                                return "Unit of Measure Invalid";
                                              }
                                              return null;
                                            },
                                            onChanged: (text) {
                                              _ingredientsList[index].quantity =
                                                  int.parse(text);
                                            },
                                          )
                                        ]);
                                  }),
                              ListView.builder(
                                  physics: BouncingScrollPhysics(),
                                  padding: const EdgeInsets.all(15),
                                  itemBuilder: (context, index) {
                                    return Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.baseline,
                                        children: [
                                          TextFormField(
                                            decoration: new InputDecoration(
                                              labelText: "Calories" +
                                                  nutrition.calories,
                                              border: new OutlineInputBorder(
                                                borderSide: new BorderSide(),
                                              ),
                                            ),
                                            onChanged: (text) {
                                              nutrition.calories = text;
                                            },
                                          ),
                                          TextFormField(
                                            decoration: new InputDecoration(
                                              labelText: "Protein: " +
                                                  nutrition.protein,
                                              border: new OutlineInputBorder(
                                                borderSide: new BorderSide(),
                                              ),
                                            ),
                                            onChanged: (text) {
                                              _ingredientsList[index].name =
                                                  text;
                                            },
                                          ),
                                          TextFormField(
                                            decoration: new InputDecoration(
                                              labelText: "Total Carbs: " +
                                                  nutrition.totalCarbs,
                                              border: new OutlineInputBorder(
                                                borderSide: new BorderSide(),
                                              ),
                                            ),
                                            onChanged: (text) {
                                              _ingredientsList[index].name =
                                                  text;
                                            },
                                          ),
                                          TextFormField(
                                            decoration: new InputDecoration(
                                              labelText: "Total Fat: " +
                                                  nutrition.totalFat,
                                              border: new OutlineInputBorder(
                                                borderSide: new BorderSide(),
                                              ),
                                            ),
                                            onChanged: (text) {
                                              _ingredientsList[index].name =
                                                  text;
                                            },
                                          ),
                                        ]);
                                  })
                            ]))));
                  },
                );
              });
        });
  } //Build
}

bool isNumeric(String s) {
  if (s == null) {
    return false;
  }
  return double.parse(s, (e) => null) != null;
}
