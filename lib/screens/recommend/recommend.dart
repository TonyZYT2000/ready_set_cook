import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'recommendTile.dart';
import "package:charcode/charcode.dart";

const apiKey = '4b2f81fdb7cd4dcdb1c96fb533073092';
const apiURL = 'https://api.spoonacular.com';
const imageUrl = 'https://spoonacular.com/recipeImages/';

class Recommend extends StatefulWidget {
  @override
  _Recommend createState() => _Recommend();
}

class APIrecipe {
  int id;
  String imageType;
  String title;
  int readyInMinutes;
  int servings;
  String sourceUrl;

  APIrecipe(
      {this.id,
      this.imageType,
      this.title,
      this.readyInMinutes,
      this.servings,
      this.sourceUrl});

  APIrecipe.fromMap(Map<String, dynamic> json) {
    id = json['id'];
    imageType = json['imageType'];
    title = json['title'];
    readyInMinutes = json['readyInMinutes'];
    servings = json['servings'];
    sourceUrl = json['sourceUrl'];
  }
}

class RecipeMapper {
  final List<APIrecipe> meals;
  final double calories;
  final double carbs;
  final double fat;
  final double protein;

  RecipeMapper({
    this.meals,
    this.calories,
    this.carbs,
    this.fat,
    this.protein,
  });

  factory RecipeMapper.fromMap(Map<String, dynamic> map) {
    List<APIrecipe> meals = [];
    if (map['meals'] != null) {
      map['meals'].forEach((meal) => meals.add(APIrecipe.fromMap(meal)));
    }
    return RecipeMapper(
      meals: meals,
      calories: map['nutrients']['calories'],
      carbs: map['nutrients']['carbohydrates'],
      fat: map['nutrients']['fat'],
      protein: map['nutrients']['protein'],
    );
  }
}

Future<RecipeMapper> getRecipesForDay() async {
  final response = await http
      .get('$apiURL/recipes/mealplans/generate?timeFrame=day&apiKey=$apiKey');

  if (response.statusCode == 200) {
    Map<String, dynamic> recipesData = jsonDecode(response.body);
    RecipeMapper recipeList = RecipeMapper.fromMap(recipesData);

    // Basic Check meal
    recipeList.meals.add(APIrecipe.fromMap({
      "id": 1566481,
      "title": "Turkey-Stuffed Portabella Mushrooms",
      "imageType": "jpg",
      "readyInMinutes": 45,
      "servings": 4,
      "sourceUrl":
          "https://spoonacular.com/recipes/turkey-stuffed-portabella-mushrooms-1566481"
    }));

    // Basic Check meal
    recipeList.meals.add(APIrecipe.fromMap({
      "id": 1569707,
      "title": "Kale Bruschetta",
      "imageType": "jpg",
      "readyInMinutes": 45,
      "servings": 4,
      "sourceUrl": "https://spoonacular.com/recipes/kale-bruschetta-1569707"
    }));

    // Return the Recipe List
    return recipeList;
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load recipes');
  }
}

class _Recommend extends State<Recommend> {
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
                  builder: (BuildContext context, AsyncSnapshot recipeCheck) {
                    switch (recipeCheck.connectionState) {
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
                        RecipeMapper recipes = recipeCheck.data;
                        if (recipes.meals.isNotEmpty) {
                          return ListView.builder(
                            itemCount: recipes.meals.length,
                            itemBuilder: (context, index) {
                              return SingleChildScrollView(
                                child: new RecommendTile(
                                  name: recipes.meals[index].title,
                                  recipeId: recipes.meals[index].id.toString(),
                                  imageType: recipes.meals[index].imageType,
                                  rating: 0.0,
                                ),
                              );
                            },
                          );
                        }
                        return Column(children: [
                          new RecommendTile(
                            name: "Peanut Butter And Chocolate Oatmeal",
                            recipeId: 655219.toString(),
                            imageType: "jpg",
                            rating: 3.3,
                          ),
                          new RecommendTile(
                            name: "Lentil Salad With Vegetables",
                            recipeId: 649931.toString(),
                            imageType: "jpg",
                            rating: 4.2,
                          ),
                          new RecommendTile(
                            name: "Asian Noodles",
                            recipeId: 632854.toString(),
                            imageType: "jpg",
                            rating: 4.3,
                          ),
                        ]);
                      case ConnectionState.done:
                        print("done");
                        RecipeMapper recipes = recipeCheck.data;
                        if (recipes.meals.isNotEmpty) {
                          return ListView.builder(
                            itemCount: recipes.meals.length,
                            itemBuilder: (context, index) {
                              return SingleChildScrollView(
                                child: new RecommendTile(
                                  name: recipes.meals[index].title,
                                  recipeId: recipes.meals[index].id.toString(),
                                  imageType: recipes.meals[index].imageType,
                                  rating: 0.0,
                                ),
                              );
                            },
                          );
                        }
                        return Column(children: [
                          new RecommendTile(
                            name: "Peanut Butter And Chocolate Oatmeal",
                            recipeId: 655219.toString(),
                            imageType: "jpg",
                            rating: 3.3,
                          ),
                          new RecommendTile(
                            name: "Lentil Salad With Vegetables",
                            recipeId: 649931.toString(),
                            imageType: "jpg",
                            rating: 4.2,
                          ),
                          new RecommendTile(
                            name: "Asian Noodles",
                            recipeId: 632854.toString(),
                            imageType: "jpg",
                            rating: 4.3,
                          ),
                        ]);
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
