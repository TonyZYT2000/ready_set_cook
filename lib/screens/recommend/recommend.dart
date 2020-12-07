import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

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
  RecipeMapper({
    this.meals,
  });

  factory RecipeMapper.fromMap(Map<String, dynamic> map) {
    List<APIrecipe> meals = [];
    map['meals'].forEach((mealMap) => meals.add(APIrecipe.fromMap(mealMap)));
    return RecipeMapper(
      meals: meals,
    );
  }
}

class RandomRecipe {
  int id;
  String image;
  String title;
  int readyInMinutes;
  int servings;
  String sourceUrl;

  RandomRecipe(
      {this.id,
      this.image,
      this.title,
      this.readyInMinutes,
      this.servings,
      this.sourceUrl});

  RandomRecipe.fromMap(Map<String, dynamic> json) {
    id = json['id'];
    image = json['imageType'];
    title = json['title'];
    readyInMinutes = json['readyInMinutes'];
    servings = json['servings'];
    sourceUrl = json['sourceUrl'];
  }
}

class RandomRecipeMapper {
  final List<RandomRecipe> recipes;
  RandomRecipeMapper({
    this.recipes,
  });

  factory RandomRecipeMapper.fromMap(Map<String, dynamic> map) {
    List<RandomRecipe> recList = [];
map['recipes'].forEach((recMap) => recList.add(RandomRecipe.fromMap(recMap)));
    return RandomRecipeMapper(
      recipes: recList,
    );
  }
}


Future<RecipeMapper> getRecipesForDay() async {
    final response =
      await http.get('$apiURL/recipes/mealplans/generate?timeFrame=day&apiKey=$apiKey');

  if (response.statusCode == 200) {
      Map<String, dynamic> recipesData = json.decode(response.body);
      RecipeMapper recipeList = RecipeMapper.fromMap(recipesData);
      return recipeList;
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load recipes');
  }
}

Future<RandomRecipeMapper> getRandomRecipes() async {
    final response =
      await http.get('$apiURL/recipes/random?number=4&tags=vegetarian&apiKey=$apiKey');

  if (response.statusCode == 200) {
      Map<String, dynamic> recData = json.decode(response.body);
      RandomRecipeMapper randomList = RandomRecipeMapper.fromMap(recData);
      return randomList;
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load recipes');
  }
}

class Recommend extends StatefulWidget {
  @override
  _Recommend createState() => _Recommend();
}

class _Recommend extends State<Recommend> {

  Widget recommendRecipeBuilder() {
  return FutureBuilder(
    builder: (context, recipeCheck) {
      if (recipeCheck.connectionState == ConnectionState.none &&
          recipeCheck.hasData == null) {
        return Container();
      }
      return ListView.builder(
        itemCount: recipeCheck.data.meals.length,
        itemBuilder: (context, index) {
          RecipeMapper recipes = recipeCheck.data;
          return Column(
            children: <Widget>[
              ListTile(
                title: new Text(recipes.meals[index].title),
              ),
            ],
          );
        },
      );
    },
    future: getRecipesForDay(),
  );
}

  Widget randomRecipeBuilder() {
  return FutureBuilder(
    builder: (context, futureRecipe) {
      if (futureRecipe.connectionState == ConnectionState.none &&
          futureRecipe.hasData == null) {
        return Container();
      }
      return ListView.builder(
        itemCount: futureRecipe.data.recipes.length,
        itemBuilder: (context, index) {
          RandomRecipeMapper randRec = futureRecipe.data;
          return Column(
            children: <Widget>[
              ListTile(
                title: new Text(randRec.recipes[index].title),
              ),
            ],
          );
        },
      );
    },
    future: getRandomRecipes(),
  );
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          recommendRecipeBuilder()
        ],
      )
    );
  }
}
