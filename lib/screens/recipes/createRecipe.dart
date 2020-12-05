import 'package:flutter/material.dart';
import 'package:ready_set_cook/models/ingredient.dart';
import 'package:ready_set_cook/models/nutrition.dart';
import 'package:ready_set_cook/models/recipe.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:ready_set_cook/screens/recipes/addInstruction.dart';
import 'package:ready_set_cook/services/recipes_database.dart';
import 'package:ready_set_cook/models/recipe.dart';
import 'package:ready_set_cook/shared/constants.dart';
import 'package:ready_set_cook/screens/recipes/addIngredient.dart';
import 'package:ready_set_cook/screens/recipes/addInstruction.dart';

import 'package:uuid/uuid.dart';

class CreateRecipe extends StatefulWidget {
  final Function toggleView;
  CreateRecipe({this.toggleView});

  @override
  _CreateRecipeState createState() => _CreateRecipeState();
}

class _CreateRecipeState extends State<CreateRecipe> {
  RecipesDatabaseService recipeDB;
  final _ingredientKey = GlobalKey<FormState>();
  final _instructionKey = GlobalKey<FormState>();

  String _recipeName = "";
  double _rating = 0;
  int _numRatings = 0;
  String calories = "";
  String protein = "";
  String totalCarbs = "";
  String totalFat = "";
  List<Ingredient> _ingredients = [];
  bool instruction_added = false;
  bool ingredient_added = false;
  String _instruction_error = "";
  String _ingredient_error = "";
  Nutrition nutrition;

  String _ingredientName = "";
  int _quantity = 0;
  String _unit = "";

  final List<String> _instructions = [];
  String instruction = "";

  TextEditingController _controller1 = TextEditingController();
  TextEditingController _controller2 = TextEditingController();
  TextEditingController _controller3 = TextEditingController();
  TextEditingController _controller4 = TextEditingController();
  TextEditingController _controller5 = TextEditingController();
  TextEditingController _controller6 = TextEditingController();
  TextEditingController _controller7 = TextEditingController();
  TextEditingController _controller8 = TextEditingController();

  _createInstruction() {
    instruction_added = true;
    _instructions.add(instruction);
    _controller4.clear();
    setState(() {});
  }

  Future<void> _createRecipe() async {
    // final isValid = _formKey.currentState.validate();
    // if (isValid) {
    nutrition = new Nutrition(
        calories: calories,
        protein: protein,
        totalCarbs: totalCarbs,
        totalFat: totalFat);
    var _recipeId = Uuid().v4();
    recipeDB.addCustomRecipe(new Recipe(
        recipeId: _recipeId,
        name: _recipeName,
        ingredients: _ingredients,
        instructions: _instructions,
        nutrition: nutrition,
        rating: _rating,
        numRatings: _numRatings));
    _controller1.clear();
    _controller2.clear();
    _controller3.clear();
    _controller4.clear();
    _ingredients.clear();
    _instructions.clear();

    _ingredientKey.currentState.save();
    _instructionKey.currentState.save();
    // }
    setState(() {});
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final _uid = FirebaseAuth.instance.currentUser.uid;
    recipeDB = RecipesDatabaseService(uid: _uid);
    _ingredients.add(new Ingredient(name: "Cake", quantity: 5, unit: "g"));
    _ingredients.add(new Ingredient(name: "Fire", quantity: 7, unit: "g"));

    final _tabPages = <Widget>[
      // Ingredients
      Scaffold(
        body: ListView.builder(
            padding: const EdgeInsets.all(0),
            itemCount: _ingredients.length,
            itemBuilder: (context, index) {
              return Text(_ingredients[index].toString());
            }),
        floatingActionButton: FloatingActionButton.extended(
            icon: Icon(Icons.add),
            label: Text("Add"),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => AddIngredientPage()));
            }),
      ),
      // Instructions
      Scaffold(
        body: ListView.builder(
            padding: const EdgeInsets.all(0),
            itemCount: _instructions.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(_instructions[index].toString()),
                tileColor: Colors.red,
              );
            }),
        floatingActionButton: FloatingActionButton.extended(
          icon: Icon(Icons.add),
          label: Text("Add"),
          onPressed: () async {
            dynamic result = await Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => AddInstructionsPage()),
            );
            if (result != null) {
              setState(() {
                _instructions.add(result);
              });
            }
          },
        ),
      ),

      // Nutrition
      Center(
          child: Scaffold(
        body: Container(
          padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
          child: Form(
              child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                SizedBox(height: 20.0),
                TextFormField(
                  controller: _controller5,
                  decoration:
                      textInputDecoration.copyWith(hintText: 'Enter Calories'),
                  onChanged: (val) {
                    setState(() => calories = val);
                  },
                ),
                SizedBox(height: 20.0),
                TextFormField(
                  controller: _controller6,
                  decoration: textInputDecoration.copyWith(
                      hintText: 'Enter Protein Amount'),
                  onChanged: (val) {
                    setState(() => protein = val);
                  },
                ),
                SizedBox(height: 20.0),
                TextFormField(
                  controller: _controller7,
                  decoration: textInputDecoration.copyWith(
                      hintText: 'Enter Total Fats'),
                  onChanged: (val) {
                    setState(() => totalFat = val);
                  },
                ),
                SizedBox(height: 20.0),
                TextFormField(
                  controller: _controller8,
                  decoration: textInputDecoration.copyWith(
                      hintText: 'Enter Total Carbohydrates'),
                  onChanged: (val) {
                    setState(() => totalCarbs = val);
                  },
                ),
              ],
            ),
          )),
        ),
      )),
    ];
    final _tabs = <Tab>[
      const Tab(icon: Icon(Icons.add), text: 'Ingredients'),
      const Tab(icon: Icon(Icons.add), text: 'Instructions'),
      const Tab(icon: Icon(Icons.add), text: 'Nutrients')
    ];
    return DefaultTabController(
      length: _tabs.length,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Create Recipe'),
          backgroundColor: Colors.cyan,
          actions: <Widget>[
            FlatButton(
              textColor: Colors.white,
              child: Text('Done', style: TextStyle(fontSize: 16)),
              onPressed: () {
                if (ingredient_added && instruction_added) {
                  _createRecipe();
                  Navigator.of(context).pop();
                }
                if (!ingredient_added) {
                  setState(() {
                    _ingredient_error = "Please enter an ingredient";
                  });
                }
                if (!instruction_added) {
                  setState(() {
                    _instruction_error = "Please enter an instruction";
                  });
                }
              },
            )
          ],
          bottom: TabBar(
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
