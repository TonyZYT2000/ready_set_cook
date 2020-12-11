import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'recommendTile.dart';
import "package:charcode/charcode.dart";
import 'viewRecommendedRecipe.dart';

// Consts for API
const apiKey = '4b2f81fdb7cd4dcdb1c96fb533073092';
const apiURL = 'https://api.spoonacular.com';
const imageUrl = 'https://spoonacular.com/recipeImages/';

class RandomRecommend extends StatefulWidget {
  @override
  _RandomRecommend createState() => _RandomRecommend();
}

class RandomRecipe {
  int id;
  int calories;
  String carbs;
  String fat;
  String image;
  String imageType;
  String protein;
  String title;
  double spoonacularScore;
  String summary;

  RandomRecipe(
      {this.id,
      this.carbs,
      this.fat,
      this.protein,
      this.image,
      this.imageType,
      this.title,
      this.spoonacularScore,
      this.summary});

  RandomRecipe.fromMap(Map<String, dynamic> json) {
    id = json['id'];
    calories = json['calories'];
    carbs = json['carbs'];
    fat = json['fat'];
    protein = json['protein'];
    image = json['image'];
    imageType = json['imageType'];
    title = json['title'];
    spoonacularScore = json['spoonacularScore'];
    summary = json['summary'];
  }
}

class RecipeMapper {
  final List<RandomRecipe> recipes;

  RecipeMapper({
    this.recipes,
  });

  factory RecipeMapper.fromMap(Map<String, dynamic> map) {
    List<RandomRecipe> recipes = [];
    if (map['recipes'] != null) {
      map['recipes']
          .forEach((recipe) => recipes.add(RandomRecipe.fromMap(recipe)));
    }
    return RecipeMapper(
      recipes: recipes,
    );
  }
}

Future<RecipeMapper> getRecipesForDay() async {
  // Tags are separated by commas
  final response =
      await http.get('$apiURL/recipes/random?number=5&tags=vegetarian,'
          'dessert&apiKey=$apiKey');

  if (response.statusCode == 200) {
    Map<String, dynamic> recipesData = jsonDecode(response.body);
    RecipeMapper recipeList = RecipeMapper.fromMap(recipesData);

    // Return the Recipe List
    return recipeList;
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load recipes');
  }
}

class _RandomRecommend extends State<RandomRecommend> {
  Future<RecipeMapper> futureRecipes;

  @override
  void initState() {
    super.initState();
    futureRecipes = getRecipesForDay();
  }

  // Recommended API
  Widget build(BuildContext context) {
    // Design Vars
    final Size size = MediaQuery.of(context).size;
    double padding = 25;
    final sidePadding = EdgeInsets.symmetric(horizontal: padding);

    return Scaffold(
      backgroundColor: Colors.blue[50],
      resizeToAvoidBottomPadding: false,
      body: Container(
        child: Stack(children: [
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            SizedBox(height: 10),
            Expanded(
              child: Padding(
                padding: sidePadding,
                child: FutureBuilder(
                  future: futureRecipes,
                  builder: (BuildContext context, AsyncSnapshot rando) {
                    switch (rando.connectionState) {
                      case ConnectionState.waiting:
                        return Center(
                          child: SizedBox(
                            height: 100.0,
                            width: 100.0,
                            child: CircularProgressIndicator(
                              strokeWidth: 10,
                              valueColor:
                                  AlwaysStoppedAnimation<Color>(Colors.blue),
                            ),
                          ),
                        );
                        break;
                      case ConnectionState.active:
                        print("active");
                        RecipeMapper recipeCheck = rando.data;
                        if (recipeCheck.recipes.isNotEmpty) {
                          return ListView.builder(
                            itemCount: recipeCheck.recipes.length,
                            itemBuilder: (context, index) {
                              return SingleChildScrollView(
                                child: new RecommendTile(
                                  name: recipeCheck.recipes[index].title,
                                  recipeId:
                                      recipeCheck.recipes[index].id.toString(),
                                  imageType:
                                      recipeCheck.recipes[index].imageType,
                                  spoonRating: recipeCheck
                                      .recipes[index].spoonacularScore,
                                ),
                              );
                            },
                          );
                        }
                        return Center(
                          child: SizedBox(
                            height: 100.0,
                            width: 100.0,
                            child: CircularProgressIndicator(
                              strokeWidth: 10,
                              valueColor:
                                  AlwaysStoppedAnimation<Color>(Colors.blue),
                            ),
                          ),
                        );
                      case ConnectionState.done:
                        print("done");
                        RecipeMapper recipesRan = rando.data;
                        if (recipesRan.recipes.isNotEmpty) {
                          return ListView.builder(
                            itemCount: recipesRan.recipes.length,
                            itemBuilder: (context, index) {
                              return SingleChildScrollView(
                                child: new RecommendTile(
                                  name: recipesRan.recipes[index].title,
                                  recipeId:
                                      recipesRan.recipes[index].id.toString(),
                                  imageType:
                                      recipesRan.recipes[index].imageType,
                                  spoonRating: recipesRan
                                      .recipes[index].spoonacularScore,
                                ),
                              );
                            },
                          );
                        }
                        return Center(
                          child: SizedBox(
                            height: 100.0,
                            width: 100.0,
                            child: CircularProgressIndicator(
                              strokeWidth: 10,
                              valueColor:
                                  AlwaysStoppedAnimation<Color>(Colors.blue),
                            ),
                          ),
                        );
                        break;
                      default:
                        return Text("Currently No Recommended Recipes Based "
                            "on Your Preferences");
                    }
                  },
                ),
              ),
            ),
          ]),
        ]),
      ),
    );
  }
}
