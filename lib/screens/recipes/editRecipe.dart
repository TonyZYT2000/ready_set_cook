import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ready_set_cook/models/ingredient.dart';
import 'package:ready_set_cook/models/nutrition.dart';
import 'package:ready_set_cook/models/recipe.dart';
import 'package:ready_set_cook/services/recipes_database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:ready_set_cook/screens/recipes/BorderIcon.dart';

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

  TextEditingController nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final ThemeData themeData = Theme.of(context);
    final double padding = 25;
    final sidePadding = EdgeInsets.symmetric(horizontal: padding);
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
                    prefixStyle: TextStyle(fontStyle: FontStyle.italic, color: Colors.white),
              ),
              controller: nameController,
              style: TextStyle(color: Colors.white, fontSize: 20),
              onChanged: (val) {
                setState(() => name = val);
              },
            ),
          ),
          elevation: 0),
      body: Container(
          child: ListView(physics: BouncingScrollPhysics(), children: <Widget>[
        Form(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Container(
              child: Column(children: <Widget>[
            Stack(
              children: [
                (imageUrl == null)
                    ? Image(
                        image: NetworkImage(
                            "https://upload.wikimedia.org/wikipedia/commons/thumb/a/ac/No_image_available.svg/480px-No_image_available.svg.png"))
                    : Image(image: NetworkImage(imageUrl)),
                Positioned(
                    width: size.width,
                    top: padding,
                    child: Padding(
                      padding: sidePadding,
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            GestureDetector(
                                onTap: () async {
                                  if (fav) {
                                    await recipeDB.unFavRecipe(recipeId);
                                    icon = Icons.favorite_border;
                                    setState(() {});
                                  }

                                  if (!fav) {
                                    await recipeDB.favRecipe(recipeId);
                                    icon = Icons.favorite;
                                    setState(() {});
                                  }
                                  fav = !fav;
                                },
                                child: BorderIcon(
                                    child: Icon(
                                  icon,
                                  color: Colors.red,
                                )))
                          ]),
                    )),
              ],
            ),
            SizedBox(height: 15),
            Container(
                padding: EdgeInsets.all(12.0),
                child: Column(children: [
                  Wrap(children: <Widget>[

                    // Editing Ingredients
                    Text(
                      "Ingredients",
                      style: TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                          decoration: TextDecoration.underline),
                    ),
                    SizedBox(height: 50),
                    for (int i = 0; i < (ingredient.length); i++)
                      Table(
                          border: TableBorder.symmetric(
                              inside: BorderSide.none,
                              outside: BorderSide.none),
                          defaultColumnWidth: FixedColumnWidth(180),
                          children: [
                            TableRow(children: [
                              TableCell(
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 8.0),
                                  child: TextFormField(
                  decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.blue,
                        ),),
                  errorBorder: InputBorder.none,
                  disabledBorder: InputBorder.none,
                  hintText: ingredient[i].name,
                  hintStyle:
                      TextStyle(fontStyle: FontStyle.italic, color: Colors.black),
              ),
                                          textAlign: TextAlign.left,
                                          style: TextStyle(
                                              fontSize: 20)),
                ),
                                  ),
                              TableCell(
                                  child: Row(children: [
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 8.0),
                                      child: TextFormField(

                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.blue,
                        ),),
                hintText: ingredient[i].quantity,
                hintStyle:
                      TextStyle(fontStyle: FontStyle.italic, color: Colors.black),
              ),
                                          textAlign: TextAlign.right,
                                          style: TextStyle(
                                              fontSize: 20)),
                  ),
                ),
                Expanded(
                  child:Padding(
                    padding:  EdgeInsets.symmetric(vertical: 8.0),
                                      child: TextFormField(
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.blue,
                        ),),
                hintText: ingredient[i].unit,
                hintStyle:
                      TextStyle(fontStyle: FontStyle.italic, color: Colors.black),
              ),
                                          textAlign: TextAlign.right,
                                          style: TextStyle(
                                              fontSize: 20)),
                  ),
                )
              ])
),
                            ])
                          ]),


                    // Editing Instructions      
                    SizedBox(height: 100),
                    Text(
                      "Instructions",
                      style: TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                          decoration: TextDecoration.underline),
                    ),
                    SizedBox(height: 50),
                    for (int i = 0; i < (instruction.length); i++)
                      Table(
                          border: TableBorder.symmetric(
                              inside: BorderSide.none,
                              outside: BorderSide.none),
                          defaultColumnWidth: FixedColumnWidth(350),
                          children: [
                            TableRow(children: [
                              TableCell(
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(vertical: 10.0),
                                      child: TextFormField(
                                        initialValue: instruction[i],
                                      maxLines: 2,
                               decoration: InputDecoration(
                                 contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 10), 
                                 isDense: true,
                                 border: OutlineInputBorder(),
                  focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.blue,
                        ),),
                                          labelText: "Instruction "+ (i+1).toString(),
              ),
                               style: TextStyle(
                                                fontSize: 20, height: 1.8),
                              ),
                                  )),
                            ])
                          ]),
                    SizedBox(height: 150),

                    // Edit Nutrition
                    Text(
                      "Nutritional Facts (per serving)",
                      style: TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                          decoration: TextDecoration.underline),
                    ),
                    SizedBox(height: 75),
                    Column(
                      children: [

                        // Editing Calories
                        TextFormField(
                                  textAlign: TextAlign.right,
                                     initialValue: nutrition.calories,
                                     style: TextStyle(fontSize:20),
                                     maxLines: 1,
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                         borderRadius: BorderRadius.circular(25.0),
                  borderSide: BorderSide(
                    color: Colors.blue,
                    width: 2.0,
                  ),),

                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25.0),
                  borderSide: BorderSide(
                    color: Colors.grey,
                    width: 2.0,
                  ),
                ),
                        labelText: "Calories: ",
                        labelStyle: TextStyle(fontSize:25),
              ),              
                                              ),
              SizedBox(height:30),

                        TextFormField(
                                  textAlign: TextAlign.right,
                                  initialValue: nutrition.protein,
                                     style: TextStyle(fontSize:20),
                                     maxLines: 1,
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                         borderRadius: BorderRadius.circular(25.0),
                  borderSide: BorderSide(
                    color: Colors.blue,
                    width: 2.0,
                  ),),

                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25.0),
                  borderSide: BorderSide(
                    color: Colors.grey,
                    width: 2.0,
                  ),
                ),
                        labelText: "Protein: ",
                        labelStyle: TextStyle(fontSize:25),
              ),       
                              
                                              ),
               SizedBox(height:30),
                                              TextFormField(
                                  textAlign: TextAlign.right,
                                  initialValue: nutrition.totalCarbs,
                                     style: TextStyle(fontSize:20),
                                     maxLines: 1,
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                         borderRadius: BorderRadius.circular(25.0),
                  borderSide: BorderSide(
                    color: Colors.blue,
                    width: 2.0,
                  ),),

                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25.0),
                  borderSide: BorderSide(
                    color: Colors.grey,
                    width: 2.0,
                  ),
                ),
                        labelText: "Total Carbs: ",
                        labelStyle: TextStyle(fontSize:25),
              ),       
                              
                                              ),

              SizedBox(height:30),

                                              TextFormField(
                                  textAlign: TextAlign.right,
                                  initialValue: nutrition.totalFat,
                                     style: TextStyle(fontSize:20),
                                     maxLines: 1,
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                         borderRadius: BorderRadius.circular(25.0),
                  borderSide: BorderSide(
                    color: Colors.blue,
                    width: 2.0,
                  ),),

                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25.0),
                  borderSide: BorderSide(
                    color: Colors.grey,
                    width: 2.0,
                  ),
                ),
                        labelText: "Total Fat: ",
                        labelStyle: TextStyle(fontSize:25),
              ),              
                                              ),

              SizedBox(height:20),
                      ],
                    ),
                    SizedBox(height: 200),
                  ])
                ]))
          ])),
        )
      ])),
      floatingActionButton: FloatingActionButton.extended(
  backgroundColor: const Color(0xff03dac6),
  foregroundColor: Colors.black,
  onPressed: () {
    // Respond to button press
  },
  icon: Icon(Icons.edit),
  label: Text('Update Recipe'),
),
    );
  }
}
