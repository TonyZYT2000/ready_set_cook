import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:ready_set_cook/models/ingredient.dart';
import 'package:ready_set_cook/models/nutrition.dart';
import 'package:ready_set_cook/models/recipe.dart';
import 'package:ready_set_cook/services/recipes_database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:ready_set_cook/screens/recipes/BorderIcon.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class EditRecipe extends StatefulWidget {
  final List<Ingredient> ingredient;
  final List<String> instruction;
  final Nutrition nutrition;
  final String imageUrl;
  final bool fav;
  final recipeId;
  final name;
  EditRecipe(
      {this.ingredient,
      this.instruction,
      this.nutrition,
      this.imageUrl,
      this.fav,
      this.recipeId,
      this.name});
  @override
  _EditRecipe createState() => _EditRecipe();
}

class _EditRecipe extends State<EditRecipe> {
  // Variables
  List<Ingredient> ingredient;
  List<String> instruction;
  Nutrition nutrition;
  String imageUrl;
  bool fav;
  String recipeId;
  String name;
  String currentName;

  // Dynamic Text Fields
  final _formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final calorieController = TextEditingController();
  final proteinController = TextEditingController();
  final carbController = TextEditingController();
  final fatController = TextEditingController();

  @override
  void initState() {
    super.initState();

    this.recipeId = widget.recipeId;
    this.ingredient = widget.ingredient;
    this.instruction = widget.instruction;
    this.nutrition = widget.nutrition;
    this.imageUrl = widget.imageUrl;
    this.fav = widget.fav;
    this.recipeId = widget.recipeId;
    this.name = widget.name;
    this.currentName = widget.name;
  }

  // Editing image
  File _image = null;
  String _imageUrl = null;
  String _filePath = null;
  final _picker = ImagePicker();
  void getImage() async {
    final pickedFile =
        await _picker.getImage(source: ImageSource.gallery, imageQuality: 50);
    _filePath = pickedFile.path;
    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  // Dynamic Text Fields for Ingredients
  final _ingredientKey = GlobalKey<FormState>();
  List<TextEditingController> _ingredientNameControllers = [];
  List<TextEditingController> _ingredientQuantControllers = [];
  List<TextEditingController> _ingredientUnitControllers = [];

  // Add ingredient Method
  void addIngedredient() {
    String newIngredientName = "Please Enter New Ingredient: ";
    TextEditingController newIngredientNameCont =
        new TextEditingController(text: newIngredientName);
    TextEditingController newIngredientQuant = new TextEditingController();
    TextEditingController newIngredientUnit = new TextEditingController();
    _ingredientNameControllers.add(newIngredientNameCont);
    _ingredientQuantControllers.add(newIngredientQuant);
    _ingredientUnitControllers.add(newIngredientUnit);
    int index = _ingredientNameControllers.length;
    Row(
      children: [
        Expanded(
          flex: 3,
          child: TextFormField(
            controller: _ingredientNameControllers[index - 1],
            decoration: InputDecoration(
              isDense: true,
              border: OutlineInputBorder(),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.blue,
                ),
              ),
              labelText: "Ingredient " + (index).toString(),
            ),
            style: TextStyle(fontSize: 20, height: 1.5),
            onChanged: (val) {
              setState(() => ingredient[index - 1].name = val);
            },
          ),
        ),
        Expanded(
          flex: 2,
          child: TextFormField(
            controller: _ingredientQuantControllers[index - 1],
            decoration: InputDecoration(
              isDense: true,
              border: OutlineInputBorder(),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.blue,
                ),
              ),
              labelText: "Quantity",
            ),
            style: TextStyle(fontSize: 20, height: 1.5),
            onChanged: (val) {
              setState(() => ingredient[index - 1].quantity = val);
            },
          ),
        ),
        Expanded(
          flex: 1,
          child: TextFormField(
            controller: _ingredientUnitControllers[index - 1],
            decoration: InputDecoration(
              isDense: true,
              border: OutlineInputBorder(),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.blue,
                ),
              ),
              labelText: "Unit",
            ),
            style: TextStyle(fontSize: 20, height: 1.5),
            onChanged: (val) {
              setState(() => ingredient[index - 1].unit = val);
            },
          ),
        ),
      ],
    );
  }

  // Dynamic Text Fields for Instructions
  final _instructionKey = GlobalKey<FormState>();
  List<TextEditingController> _instructionControllers = [];

  // Add Instruction Method
  void addInstruction() {
    String newInstruction = "Please Enter New Instruction: ";
    TextEditingController newInstruct =
        new TextEditingController(text: newInstruction);
    TextFormField(
      controller: newInstruct,
      maxLines: 2,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
        isDense: true,
        border: OutlineInputBorder(),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.blue,
          ),
        ),
        hintText: "Please Enter to New Instructions",
      ),
      style: TextStyle(fontSize: 20, height: 1.5),
    );
    setState(() {
      instruction.add(newInstruct.text);
      _instructionControllers.add(newInstruct);
    });
  }

  // Probably Best to Set entire recipe
  // Nutrition
  bool fatChanged = false;
  bool carbChanged = false;
  bool proteinChanged = false;
  bool calorieChanged = false;

  // List
  bool ingredientChanged = false;
  bool instructionChanged = false;

  Future<void> _updateRecipe() async {
    final nutritionDB = FirebaseFirestore.instance
        .collection('allRecipes')
        .doc(this.recipeId)
        .collection("nutrition")
        .doc("1");

    final instructionDB = FirebaseFirestore.instance
        .collection('allRecipes')
        .doc(this.recipeId)
        .collection("instruction");

    if (currentName != name) {
      FirebaseFirestore.instance
          .collection('allRecipes')
          .doc(this.recipeId)
          .update({name: this.name});
    }

    if (fatChanged == true) {
      nutritionDB.update({
        "Total Fat": nutrition.totalFat,
      });
    }

    if (carbChanged == true) {
      nutritionDB.update({
        "Total Carbohydrate": nutrition.totalCarbs,
      });
    }
    if (proteinChanged == true) {
      nutritionDB.update({
        "Protein": nutrition.protein,
      });
    }
    if (calorieChanged == true) {
      nutritionDB.update({
        "Calories": nutrition.calories,
      });
    }

    if (instructionChanged == true) {
      QuerySnapshot snapshot = await instructionDB.get();
      for (int i = 1; i <= instruction.length; i++) {
        if (instructionDB.doc(i.toString()) == null) {
          instructionDB.doc().set({"instruction": instruction[i - 1]});
        } else {
          instructionDB
              .doc(i.toString())
              .update({"instruction": instruction[i - 1]});
        }
      }
    }

    nameController.clear();
    _instructionControllers.clear();
    _ingredientUnitControllers.clear();
    _ingredientQuantControllers.clear();
    _ingredientNameControllers.clear();
    calorieController.clear();
    proteinController.clear();
    carbController.clear();
    fatController.clear();
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    // Nutrition Controller

    final Size size = MediaQuery.of(context).size;
    final ThemeData themeData = Theme.of(context);
    final double padding = 25;
    final user = FirebaseAuth.instance.currentUser;
    final uid = user.uid;
    var recipeDB = RecipesDatabaseService(uid: uid);

    var icon = Icons.favorite_border;
    if (fav) {
      icon = Icons.favorite;
    }
    return Scaffold(
      backgroundColor: Colors.blue[50],
      appBar: AppBar(
        toolbarHeight: 60,
        title: Container(
          child: Form(
            child: TextFormField(
              decoration: InputDecoration(
                contentPadding: EdgeInsets.all(5),
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
                prefixText: 'Enter New Name:   ',
                labelText: currentName,
                labelStyle:
                    TextStyle(fontStyle: FontStyle.italic, color: Colors.white),
                prefixStyle:
                    TextStyle(fontStyle: FontStyle.italic, color: Colors.white),
              ),
              controller: nameController,
              style: TextStyle(color: Colors.white, fontSize: 20),
              onChanged: (val) {
                setState(() => name = val);
              },
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            // Edit Image
            Stack(children: [
              (imageUrl == null)
                  ? Image(
                      image: NetworkImage(
                          "https://upload.wikimedia.org/wikipedia/commons/thumb/a/ac/No_image_available.svg/480px-No_image_available.svg.png"))
                  : Image(image: NetworkImage(imageUrl)),
              Positioned(
                width: size.width,
                top: padding,
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                  child:
                      Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                    GestureDetector(
                        onTap: () async {},
                        child: CircleAvatar(
                          radius: 30,
                          child: Icon(
                            Icons.add_a_photo_rounded,
                            color: Colors.white,
                          ),
                        ))
                  ]),
                ),
              ),
            ]),

            SizedBox(height: 30),
            Column(children: [
              // Edit Ingredients
              Container(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    "Ingredients",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.underline),
                  ),
                ),
              ),

              Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.all(10.0),
                child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: ingredient.length,
                  itemBuilder: (context, index) {
                    _ingredientNameControllers.add(new TextEditingController(
                        text: ingredient[index].name));
                    _ingredientQuantControllers.add(new TextEditingController(
                        text: ingredient[index].quantity));
                    _ingredientUnitControllers.add(new TextEditingController(
                        text: ingredient[index].unit));
                    return Container(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Row(children: [
                          Expanded(
                            flex: 3,
                            child: TextFormField(
                              controller: _ingredientNameControllers[index],
                              decoration: InputDecoration(
                                isDense: true,
                                border: OutlineInputBorder(),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.blue,
                                  ),
                                ),
                                labelText:
                                    "Ingredient " + (index + 1).toString(),
                              ),
                              style: TextStyle(fontSize: 20, height: 1.5),
                              onChanged: (val) {
                                setState(() => ingredient[index].name = val);
                              },
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: TextFormField(
                              controller: _ingredientQuantControllers[index],
                              decoration: InputDecoration(
                                isDense: true,
                                border: OutlineInputBorder(),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.blue,
                                  ),
                                ),
                                labelText: "Quantity",
                              ),
                              style: TextStyle(fontSize: 20, height: 1.5),
                              onChanged: (val) {
                                setState(
                                    () => ingredient[index].quantity = val);
                              },
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: TextFormField(
                              controller: _ingredientUnitControllers[index],
                              decoration: InputDecoration(
                                isDense: true,
                                border: OutlineInputBorder(),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.blue,
                                  ),
                                ),
                                labelText: "Unit",
                              ),
                              style: TextStyle(fontSize: 20, height: 1.5),
                              onChanged: (val) {
                                setState(() => ingredient[index].unit = val);
                              },
                            ),
                          ),
                        ]));
                  },
                ),
              ),
              Container(
                child: CircleAvatar(
                  backgroundColor: Colors.blue,
                  // Add Button Next to instruction
                  child: IconButton(
                    icon: Icon(
                      Icons.add,
                      color: Colors.white,
                      size: 24.0,
                    ),
                    onPressed: addInstruction,
                  ),
                ),
              ),

              // Edit Instructions
              SizedBox(height: 30),
              Container(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    "Instructions",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.underline),
                  ),
                ),
              ),

              Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.all(8.0),
                child: ListView.builder(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: instruction.length,
                  itemBuilder: (context, index) {
                    _instructionControllers.add(
                        new TextEditingController(text: instruction[index]));
                    return Container(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Row(children: [
                        Expanded(
                          child: TextFormField(
                            controller: _instructionControllers[index],
                            maxLines: 2,
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 15, horizontal: 20),
                              isDense: true,
                              border: OutlineInputBorder(),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.blue,
                                ),
                              ),
                              labelText:
                                  "Instruction " + (index + 1).toString(),
                            ),
                            style: TextStyle(fontSize: 20, height: 1.5),
                            onChanged: (val) {
                              instructionChanged = true;
                              setState(() => instruction[index] = val);
                            },
                          ),
                        ),
                      ]),
                    );
                  },
                ),
              ),
              Container(
                child: CircleAvatar(
                  backgroundColor: Colors.blue,
                  // Add Button Next to instruction
                  child: IconButton(
                    icon: Icon(
                      Icons.add,
                      color: Colors.white,
                      size: 24.0,
                    ),
                    onPressed: addInstruction,
                  ),
                ),
              ),

              // Editing Nutrition
              SizedBox(height: 50),
              Container(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    "Nutrition Facts (Per Serving)",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.underline),
                  ),
                ),
              ),
              SizedBox(height: 25),

              Column(
                children: [
                  // Editing Calories
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                    child: TextFormField(
                      textAlign: TextAlign.right,
                      controller: calorieController,
                      style: TextStyle(fontSize: 20),
                      decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25.0),
                          borderSide: BorderSide(
                            color: Colors.blue,
                            width: 2.0,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25.0),
                          borderSide: BorderSide(
                            color: Colors.grey,
                            width: 2.0,
                          ),
                        ),
                        labelText: "Calories: " + nutrition.calories,
                        labelStyle:
                            TextStyle(fontSize: 20, color: Colors.black),
                        hintText: nutrition.calories,
                      ),
                      onChanged: (val) {
                        calorieChanged = true;
                        setState(() => nutrition.calories = val);
                      },
                    ),
                  ),
                  SizedBox(height: 10),

                  // Editing Protein
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                    child: TextFormField(
                      controller: proteinController,
                      textAlign: TextAlign.right,
                      style: TextStyle(fontSize: 20),
                      decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25.0),
                          borderSide: BorderSide(
                            color: Colors.blue,
                            width: 2.0,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25.0),
                          borderSide: BorderSide(
                            color: Colors.grey,
                            width: 2.0,
                          ),
                        ),
                        labelText: "Protein: " + nutrition.protein,
                        labelStyle:
                            TextStyle(fontSize: 20, color: Colors.black),
                        alignLabelWithHint: true,
                        hintText: nutrition.protein,
                      ),
                      onChanged: (val) {
                        proteinChanged = true;
                        setState(() => nutrition.protein = val);
                      },
                    ),
                  ),
                  SizedBox(height: 10),

                  // Editing Carbs
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                    child: TextFormField(
                      controller: carbController,
                      textAlign: TextAlign.right,
                      style: TextStyle(fontSize: 20),
                      decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25.0),
                          borderSide: BorderSide(
                            color: Colors.blue,
                            width: 2.0,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25.0),
                          borderSide: BorderSide(
                            color: Colors.grey,
                            width: 2.0,
                          ),
                        ),
                        labelText: "Total Carbs: " + nutrition.totalCarbs,
                        labelStyle:
                            TextStyle(fontSize: 20, color: Colors.black),
                      ),
                      onChanged: (val) {
                        carbChanged = true;
                        setState(() => nutrition.totalCarbs = val);
                      },
                    ),
                  ),

                  SizedBox(height: 10),

                  // Editing Fats
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                    child: TextFormField(
                      controller: fatController,
                      textAlign: TextAlign.right,
                      style: TextStyle(fontSize: 20),
                      decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25.0),
                          borderSide: BorderSide(
                            color: Colors.blue,
                            width: 2.0,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25.0),
                          borderSide: BorderSide(
                            color: Colors.grey,
                            width: 2.0,
                          ),
                        ),
                        labelText: "Total Fat: " + nutrition.totalFat,
                        labelStyle:
                            TextStyle(fontSize: 20, color: Colors.black),
                      ),
                      onChanged: (val) {
                        fatChanged = true;
                        setState(() => nutrition.totalFat = val);
                      },
                    ),
                  ),
                  SizedBox(height: 50),
                ],
              ),
            ]),
            RaisedButton(
              color: Colors.blue,
              textColor: Colors.white,
              child: Text("Update Recipe"),
              onPressed: () {
                // Respond to button press
                _updateRecipe();
              },
            ),
            SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    ); // End of Scaffold
  } // end build
} // end state
