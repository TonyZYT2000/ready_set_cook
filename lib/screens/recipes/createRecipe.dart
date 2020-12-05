import 'package:flutter/material.dart';
import 'package:ready_set_cook/models/ingredient.dart';
import 'package:ready_set_cook/models/nutrition.dart';
import 'package:ready_set_cook/screens/recipes/addIngredient.dart';
import 'package:ready_set_cook/screens/recipes/addInstruction.dart';
import 'package:ready_set_cook/models/recipe.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:ready_set_cook/services/recipes_database.dart';
import 'package:ready_set_cook/models/recipe.dart';
import 'package:ready_set_cook/shared/constants.dart';
import 'package:uuid/uuid.dart';

class CreateRecipe extends StatefulWidget {
  final Function toggleView;
  CreateRecipe({this.toggleView});
  @override
  _CreateRecipeState createState() => _CreateRecipeState();
}

class _CreateRecipeState extends State<CreateRecipe> {
  RecipesDatabaseService recipeDB;
  final _formKey = GlobalKey<FormState>();

  String _recipeName = "";
  double _rating = 0;
  int _numRatings = 0;
  String calories = "";
  String protein = "";
  String totalCarbs = "";
  String totalFat = "";
  List<Ingredient> _ingredients = [];
  List<String> _instructions = [];
  Nutrition nutrition;

  String _ingredientName = "";
  int _quantity = 0;
  String _unit = "";
  String instruction = "";

  TextEditingController _controller1 = TextEditingController();
  TextEditingController _controller2 = TextEditingController();
  TextEditingController _controller3 = TextEditingController();
  TextEditingController _controller4 = TextEditingController();
  TextEditingController _controller5 = TextEditingController();
  TextEditingController _controller6 = TextEditingController();
  TextEditingController _controller7 = TextEditingController();
  TextEditingController _controller8 = TextEditingController();

  Future<void> _createIngredient() async {
    // final isValid = _formKey.currentState.validate();
    // if (isValid) {
    _ingredients.add(new Ingredient(
        nameOfIngredient: _ingredientName,
        quantity: _quantity.toString(),
        unit: _unit));
    _controller1.clear();
    _controller2.clear();
    _controller3.clear();
    // }
    // setState(() {});
  }

  Future<void> _createInstruction() async {
    // final isValid = _formKey.currentState.validate();
    // if (isValid) {
    _instructions.add(instruction);
    _controller4.clear();
    // }
    // setState(() {});
  }

  /*Future<void> _createNutrients() async {
    // final isValid = _formKey.currentState.validate();
    // if (isValid) {
    _nutritions.add(new Nutrition(
        calories: calories,
        protein: protein,
        totalFat: totalFat,
        totalCarbs: totalCarbs));
    _controller5.clear();
    _controller6.clear();
    _controller7.clear();
    _controller8.clear();

    // }
    // setState(() {});
  }*/

  Future<void> _createRecipe() async {
    // final isValid = _formKey.currentState.validate();
    // if (isValid) {
    nutrition = new Nutrition(calories: calories, protein: protein, totalCarbs: totalCarbs, totalFat: totalFat);
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

    _formKey.currentState.save();
    // }
    setState(() {});
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final _uid = FirebaseAuth.instance.currentUser.uid;
    recipeDB = RecipesDatabaseService(uid: _uid);

    final _tabPages = <Widget>[
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
                  controller: _controller1,
                  key: ValueKey("ingredient name"),
                  validator: (value) {
                    if (value.isEmpty) {
                      return "Please enter valid ingredient name";
                    }
                    return null;
                  },
                  decoration: textInputDecoration.copyWith(
                      hintText: 'Enter Ingredient Name'),
                  onChanged: (val) {
                    setState(() => _ingredientName = val);
                  },
                ),
                SizedBox(height: 20.0),
                TextFormField(
                  controller: _controller2,
                  key: ValueKey("quantity"),
                  validator: (value) {
                    if (value.isEmpty) {
                      return "Please enter valid quantity";
                    }
                    return null;
                  },
                  decoration:
                      textInputDecoration.copyWith(hintText: 'Enter Quantity'),
                  onChanged: (val) {
                    setState(() => _quantity = int.parse(val));
                  },
                ),
                SizedBox(height: 20.0),
                TextFormField(
                  controller: _controller3,
                  validator: (value) {
                    if (value.isEmpty) {
                      return "Please enter valid unit";
                    }
                    return null;
                  },
                  decoration:
                      textInputDecoration.copyWith(hintText: 'Enter Unit of Measure'),
                  onChanged: (val) {
                    setState(() => _unit = val);
                  },
                ),
                SizedBox(height: 20.0),
                RaisedButton(
                    color: Colors.blue[400],
                    child: Text(
                      'Add Ingredient',
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: _createIngredient),
              ],
            ),
          )),
        ),
      )),
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
                  controller: _controller4,
                  decoration: textInputDecoration.copyWith(
                      hintText: 'Enter Instruction'),
                  onChanged: (val) {
                    setState(() => instruction = val);
                  },
                ),
                SizedBox(height: 20.0),
                RaisedButton(
                    color: Colors.blue[400],
                    child: Text(
                      'Add Instruction',
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: _createInstruction),
              ],
            ),
          )),
        ),
      )),
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
                _createRecipe();
                Navigator.of(context).pop();
                }
            ),
          ],
          // If `TabController controller` is not provided, then a
          // DefaultTabController ancestor must be provided instead.
          // Another way is to use a self-defined controller, c.f. "Bottom tab
          // bar" example.
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
