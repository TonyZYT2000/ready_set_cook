import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'recommendTile.dart';

const apiKey = '88391b173f7a4ae99bf83c54ab1e4381';
const apiURL = 'https://api.spoonacular.com';
const imageUrl = 'https://spoonacular.com/recipeImages/';

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
    map['meals'].forEach((mealMap) => meals.add(APIrecipe.fromMap(mealMap)));
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
    Map<String, dynamic> recipesData = json.decode(response.body);
    RecipeMapper recipeList = RecipeMapper.fromMap(recipesData);
    return recipeList;
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load album');
  }
}

class Recommend extends StatefulWidget {
  @override
  _Recommend createState() => _Recommend();
}

class _Recommend extends State<Recommend> {
  Widget recommendRecipeBuilder() {
    return FutureBuilder(
      future: getRecipesForDay(),
      builder: (context, recipeCheck) {
        if (recipeCheck.hasData != null && recipeCheck.data.meals != null) {
          return ListView.builder(
            itemCount: recipeCheck.data.meals.length,
            itemBuilder: (context, index) {
              RecipeMapper recipes = recipeCheck.data;
              return SingleChildScrollView(
                child: new RecommendTile(
                  name: recipes.meals[index].title,
                  recipeId: recipes.meals[index].id.toString(),
                  imageType: recipes.meals[index].imageType,
                ),
              );
            },
          );
        } else {
          return ListView(children: [
            new RecommendTile(
              name: "Peanut Butter And Chocolate Oatmeal",
              recipeId: 655219.toString(),
              imageType: "jpg",
            ),
            new RecommendTile(
              name: "Lentil Salad With Vegetables",
              recipeId: 649931.toString(),
              imageType: "jpg",
            ),
            new RecommendTile(
              name: "Asian Noodles",
              recipeId: 632854.toString(),
              imageType: "jpg",
            ),
          ]);
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[50],
      body: recommendRecipeBuilder(),
    );
  }
}
