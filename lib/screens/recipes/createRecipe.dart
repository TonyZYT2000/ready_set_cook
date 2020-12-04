import 'package:flutter/material.dart';
import 'package:ready_set_cook/screens/recipes/addIngredient.dart';
import 'package:ready_set_cook/screens/recipes/addInstruction.dart';
import 'package:ready_set_cook/screens/recipes/recipe.dart';

class CreateRecipe extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _tabPages = <Widget>[
      Center(child: AddIngredient()),
      Center(child: AddInstruction()),
    ];
    final _tabs = <Tab>[
      const Tab(icon: Icon(Icons.add), text: 'Add Ingredient'),
      const Tab(icon: Icon(Icons.add), text: 'Add Instruction')
    ];
    return DefaultTabController(
      length: _tabs.length,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Create Recipe'),
          backgroundColor: Colors.cyan,
          actions: <Widget>[
            FlatButton.icon(
              color: Colors.blue[400],
              icon: Icon(Icons.done),
              label: Text('Add Recipe'),
              onPressed: () {
                Recipe();
              },
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
