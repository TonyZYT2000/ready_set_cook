import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ready_set_cook/screens/recipes/view_recipeIngTile.dart';
import 'package:ready_set_cook/screens/recipes/view_recipeInsTile.dart';
import 'edit_recipe.dart';

class ViewRecipe extends StatefulWidget {
  final Function toggleView;
  String recipeId = "";
  ViewRecipe(this.recipeId, {this.toggleView});
  @override
  _ViewRecipeState createState() => _ViewRecipeState();
}

class _ViewRecipeState extends State<ViewRecipe> {
  String recipeId = "";
  String name = "";
  String quantity = "";
  String unit = "";
  String instruction = "";
  @override
  void initState() {
    super.initState();
    this.recipeId = widget.recipeId;
  }

  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('allRecipes')
            .doc(recipeId)
            .collection("ingredients")
            .snapshots(),
        builder: (ctx, ingredientSnapshot) {
          if (ingredientSnapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          final ingredientDoc = ingredientSnapshot.data.documents;
          return Scaffold(
              appBar: AppBar(title: Text("View Recipe")),
              floatingActionButton: FloatingActionButton.extended(
                  icon: Icon(Icons.edit),
                  label: Text("Edit"),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => EditRecipe()));
                  }),
              body: Container(
                  padding: EdgeInsets.symmetric(vertical: 300),
                  foregroundDecoration: BoxDecoration(
                      image: DecorationImage(
                          scale: 0.9,
                          colorFilter: ColorFilter.mode(
                              Colors.blue.withOpacity(1.0),
                              BlendMode.softLight),
                          alignment: Alignment.topCenter,
                          image:
                              AssetImage("assets/images/chicken breast.jpg"))),
                  child: ListView.builder(
                    itemCount: ingredientDoc.length,
                    itemBuilder: (ctx, index) {
                      if (ingredientDoc[index].data != null) {
                        name = ingredientDoc[index]['name'];
                        quantity = ingredientDoc[index]['quantity'];
                        unit = ingredientDoc[index]['unit'];
                      }
                      return ViewRecipeIngTile(
                          name: name, quantity: quantity, unit: unit);
                    },
                  )));
        });
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('allRecipes')
            .doc(recipeId)
            .collection("instructions")
            .snapshots(),
        builder: (ctx, instructionSnapshot) {
          if (instructionSnapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          final instructionDoc = instructionSnapshot.data.documents;
          return Scaffold(
              appBar: AppBar(title: Text("View Recipe")),
              floatingActionButton: FloatingActionButton.extended(
                  icon: Icon(Icons.edit),
                  label: Text("Edit"),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => EditRecipe()));
                  }),
              body: Container(
                  child: ListView.builder(
                      itemCount: instructionDoc.length,
                      itemBuilder: (ctx, index) {
                        if (instructionDoc[index].data != null) {
                          instruction = instructionDoc[index]['instruction'];
                        }
                        return ViewRecipeInsTile(instruction);
                      })));
        });
  }
}

// @override
// Widget build(BuildContext context) {
//   return Scaffold(
//       floatingActionButton: FloatingActionButton.extended(
//           icon: Icon(Icons.edit),
//           label: Text("Edit"),
//           onPressed: () {
//             Navigator.push(context,
//                 MaterialPageRoute(builder: (context) => EditRecipe()));
//           }),
//       appBar: AppBar(
//         title: Text('Edit Recipe'),
//       ),
//       body: ListView(children: <Widget>[
//         SizedBox(height: 20),
//         Container(
//             child: Column(children: <Widget>[
//           Container(
//             height: 180,
//             width: 240,
//             // decoration: BoxDecoration(
//             //     border: Border.all(color: Colors.blue[200], width: 10),
//             //     borderRadius: BorderRadius.circular(20),
//             //     image: DecorationImage(
//             //         image: AssetImage(image), fit: BoxFit.cover)),
//           ),
//           Container(
//               padding: EdgeInsets.all(35.0),
//               child: Wrap(children: <Widget>[
//                 for (int i = 0; i < ingredient.length; i++)
//                   Table(
//                       border: TableBorder.symmetric(
//                           inside:
//                               BorderSide(width: 3, color: Colors.blue[200]),
//                           outside:
//                               BorderSide(width: 3, color: Colors.blue[200])),
//                       defaultColumnWidth: FixedColumnWidth(150),
//                       children: [
//                         TableRow(children: [
//                           TableCell(
//                               child: Center(
//                                   child: Text(ingredient[i],
//                                       style: TextStyle(
//                                           color: Colors.blueGrey,
//                                           fontSize: 18,
//                                           height: 1.8)))),
//                           TableCell(
//                               child: Center(
//                                   child: Text(quantity[i],
//                                       style: TextStyle(
//                                           color: Colors.blueGrey,
//                                           fontSize: 18,
//                                           height: 1.8))))
//                         ])
//                       ])
//               ]))
//         ]))
//       ]));
// }
