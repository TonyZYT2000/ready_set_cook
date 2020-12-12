import 'dart:async';
import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'recommendTile.dart';
import 'package:ready_set_cook/models/user.dart';
import 'package:ready_set_cook/services/grocery.dart';

// Consts for API
const apiKey = '4b2f81fdb7cd4dcdb1c96fb533073092';
const apiURL = 'https://api.spoonacular.com';
const imageUrl = 'https://spoonacular.com/recipeImages/';

class RecRecipe {
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

  RecRecipe(
      {this.id,
      this.carbs,
      this.fat,
      this.protein,
      this.image,
      this.imageType,
      this.title,
      this.spoonacularScore,
      this.summary});

  RecRecipe.fromMap(Map<String, dynamic> json) {
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
  final List<RecRecipe> recipes;

  RecipeMapper({
    this.recipes,
  });

  factory RecipeMapper.fromMap(Map<String, dynamic> map) {
    List<RecRecipe> recipes = [];
    if (map['recipes'] != null) {
      map['recipes']
          .forEach((recipe) => recipes.add(RecRecipe.fromMap(recipe)));
    }
    return RecipeMapper(
      recipes: recipes,
    );
  }
}

class Recommend extends StatefulWidget {
  @override
  _Recommend createState() => _Recommend();
}

class _Recommend extends State<Recommend> {
  RecipeMapper futureRecipes;
  List<RecRecipe> apiRecipeList = [];

  // Default number of recipes returned is five
  int number = 5;
  // &tags=vegetarian,dessert
  String tags = "";

  // Maps
  void useAPI() async {
    // Tags are separated by commas
    var response = await http
        .get('$apiURL/recipes/random?number=$number&tags=$tags&apiKey=$apiKey');

    if (response.statusCode == 200) {
      Map<String, dynamic> recipesData = jsonDecode(response.body);

      // Return the Recipe List
      setState(() {
        apiRecipeList = RecipeMapper.fromMap(recipesData).recipes;
      });
    } else {
      throw Exception('Failed to load recipes');
    }
  }

  Widget buildList() {
    return apiRecipeList.length != 0
        ? RefreshIndicator(
            child: ListView.builder(
              itemCount: apiRecipeList.length,
              itemBuilder: (context, index) {
                return new RecommendTile(
                  name: apiRecipeList[index].title,
                  recipeId: apiRecipeList[index].id.toString(),
                  imageType: apiRecipeList[index].imageType,
                  spoonRating: apiRecipeList[index].spoonacularScore,
                );
              },
            ),
            onRefresh: getRecipeFromIngredients)
        : Center(
            child: CircularProgressIndicator(),
          );
  }

  // Get current items in storage
  List<String> recipeIds = [];
  List<String> correctIDs = [];
  Future<void> findSimilarRecipes(
      List<String> ingredients, List<String> lowerCase) async {
    final allRecipes = FirebaseFirestore.instance.collection("allRecipes");
    // So, for each doc(recipe) in all recipes
    allRecipes.get().then((recipeId) => recipeId.docs.forEach((element) {
          String recipeId = element.data()["recipeId"];
          if (recipeIds.contains(recipeId) != true) {
            recipeIds.add(recipeId);
          }
        }));

    recipeIds.forEach((id) {
      allRecipes
          .doc(id)
          .collection("ingredients")
          .snapshots()
          .forEach((ingredient) {
        ingredient.docs.forEach((element) {
          String ingredientName = element.data()["name"];
          if (ingredients.contains(ingredientName) == true ||
              lowerCase.contains(ingredientName) == true) {
            correctIDs.add(id.toString());
          }
        });
      });
    });
  }

  Future<void> getRecipes() async {
    setState(() {
      useAPI();
    });
  }

  Future<void> getRecipeFromIngredients() async {
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    getRecipes();
    getRecipeFromIngredients();
  }

  List<String> currentIngredients = [null];
  List<String> lowerCaseIngredients = [null];
  Widget build(BuildContext context) {
    GroceryDatabase current = GroceryDatabase(context);
    current.getGrocerySnap().forEach((item) {
      item.docs.forEach((element) {
        String storageItem = element.data()["name"];
        if (currentIngredients.contains(storageItem) != true) {
          currentIngredients.add(storageItem);
          lowerCaseIngredients.add(storageItem.toLowerCase());
        }
      });
    });
    findSimilarRecipes(currentIngredients, lowerCaseIngredients);
    final _tabPages = <Widget>[
      Center(child: Text("This is Hard")), //buildIngredientList
      // (ingredientList)),
      Center(child: buildList()),
    ];
    final _tabs = <Tab>[
      const Tab(icon: Icon(Icons.backpack), text: 'Based off Storage'),
      const Tab(icon: Icon(Icons.approval), text: 'Based off Diet')
    ];
    return DefaultTabController(
      length: _tabs.length,
      child: Scaffold(
        backgroundColor: Colors.blue[50],
        appBar: AppBar(
          title: TabBar(
            tabs: _tabs,
          ),
        ),
        body: TabBarView(
          children: _tabPages,
        ),
      ),
    );
  }
}
